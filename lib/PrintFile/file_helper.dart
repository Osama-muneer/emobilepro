import 'dart:convert';
import 'dart:io';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as im;
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../Core/Services/shareService.dart';
import '../Setting/controllers/setting_controller.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/models/AppPrinterDevice.dart';
import '../Widgets/config.dart';
import '../database/setting_db.dart';
import 'pdf_perview.dart';
import 'share_mode.dart';

class FileHelper {
  static final BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  static BluetoothDevice? _device;

  static Future<String> save(List<int> bytes, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (e, stack) {
      _showErrorToast(e, stack);
      return 'null';
    }
  }

  static Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = await save(bytes, fileName);
    if (path.contains('.pdf')) {
      Get.dialog(PdfPerview(filePath: path));
    } else {
      OpenFilex.open(path);
    }
  }

  static Future<Uint8List> getFileFromAssets(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  static Future<String> convertPdfToBase64(String filePath) async {
    try {
      final file = File(filePath);
      return base64Encode(await file.readAsBytes());
    } catch (e) {
      print("Error converting PDF to Base64: $e");
      return '';
    }
  }

  static Future<void> share({
    required ShareMode mode,
    required List<int> bytes,
    required String fileName,
    required int BMMID,
    String? msg,
  })
  async {
    try {
      final path = await save(bytes, fileName);
      switch (mode) {
        case ShareMode.view:
          await saveAndLaunchFile(bytes, fileName);
          break;
        case ShareMode.extract:
          if (Get.isBottomSheetOpen!) Get.back();
          Get.toNamed("/exportedInvoices");
          break;
        case ShareMode.share:
         // final xFile = XFile(path, mimeType: 'application/pdf');// Convert String path to XFile
         // await Share.shareXFiles([xFile], text: msg ?? '');
        //  final result = await Share.shareXFiles([XFile(path)]);
         // print('🔹 after shareXFiles: $result');
          sharePdf(path);
          // await Share.shareXFiles([path], mimeTypes: ['application/pdf'], text: msg ?? '');
          break;
        case ShareMode.print:
          final copies = StteingController().NUMBER_COPIES_REP;
          await printToAll(path, copies);
          break;
        case ShareMode.sendBase64:
          final base64Pdf = await convertPdfToBase64(path);
          if (base64Pdf.isNotEmpty) {
            LoginController().SET_P('base64Pdf', base64Pdf);
            LoginController().SET_P('fileName', fileName);
          }
          break;
      }
    } catch (e, stack) {
      _showErrorToast(e, stack);
    }
  }

  /// يحول الصفحة الأولى من ملف PDF إلى صورة PNG ويعيد بايتاتها
  static Future<Uint8List?> _pdfPageToPngBytes(String pdfPath) async {
    final pdf = PdfImageRenderer(path: pdfPath);
    await pdf.open();
    await pdf.openPage(pageIndex: 0);
    final size = await pdf.getPageSize(pageIndex: 0);

    final rendered = await pdf.renderPage(
      pageIndex: 0,
      x: 0,
      y: 0,
      width: size.width.toInt(),
      height: size.height.toInt(),
      scale: 2.5,
    );
    await pdf.close();

    if (rendered == null) return null;
    final decoded = im.decodeImage(rendered);
    if (decoded == null) return null;

    return Uint8List.fromList(im.encodePng(decoded));
  }

  /// يولّد List<int> من أوامر ESC/POS لطباعة الصورة + قص الورق
  static Future<List<int>> _generateEscPosBytesFromPng(Uint8List pngBytes) async {
    // نحمّل ملف التعريف المناسب (PaperSize 58mm مثال)
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    // فك ترميز الـ PNG
    final img = im.decodeImage(pngBytes)!;

    // تجميع الأوامر
    var bytes = <int>[];
    bytes += generator.imageRaster(img);
    bytes += generator.cut();
    return bytes;
  }

  /// دالة للطباعة عبر USB
  static Future<void> _printUsbPage(AppPrinterDevice device,String pdfPath, int copies) async {
    // — تحويل PDF → PNG
    final pdfImg = await _pdfPageToPngBytes(pdfPath);
    if (pdfImg == null) throw Exception('فشل في تحويل PDF إلى صورة');

    // — توليد أوامر ESC/POS
    final escBytes = await _generateEscPosBytesFromPng(pdfImg);

    // — إنشاء الموصل باستخدام المُنشئ المسماة Android
    final connector = UsbPrinterConnector.Android(
      vendorId: device.vendorId.toString(),
      productId: device.productId.toString(),
    );

    // — اتصال
    await connector.connect(
        UsbPrinterInput(
      name:device.deviceName,
      vendorId:  device.vendorId,
      productId: device.productId.toString(),
    ));

    // — إرسال الأوامر
    for (var i = 0; i < copies; i++) {
      await connector.send(escBytes);            // ← هنا نستخدم send() وليس printRaw :contentReference[oaicite:3]{index=3}
    }

    // — فصل الاتصال
    await connector.disconnect();
  }

  /// دالة للطباعة عبر الشبكة (TCP/IP)
  static Future<void> _printNetwork(AppPrinterDevice device,String pdfPath, int copies) async {
    // 1) تحويل PDF → PNG → ESC/POS bytes
    final png = await _pdfPageToPngBytes(pdfPath);
    if (png == null) throw Exception('فشل في تحويل PDF إلى صورة');
    final escBytes = await _generateEscPosBytesFromPng(png);

    // 2) لكل نسخة: افتح Socket وأرسل البيانات
    for (var i = 0; i < copies; i++) {
      final socket = await Socket.connect(device.address, int.parse(device.port.toString()));
      socket.add(escBytes);
      await socket.flush();
      await socket.close();
    }
  }

  // 3) إعادة استخدام دوال تحويل PDF إلى صور
  static Future<void> _renderAndPrintPdfViaBluetooth(String path) async {
    final pdf = PdfImageRenderer(path: path);
    await pdf.open();

    int pageIndex = 0;
    await pdf.openPage(pageIndex: pageIndex);
    final size = await pdf.getPageSize(pageIndex: pageIndex);
    double imageCutFactor = 50;
    double currentCut = 0;

    int countImage = (size.height / imageCutFactor).ceil();

    for (int i = 0; i < countImage; i++) {
      if (currentCut > size.height) break;

      Uint8List? img = await pdf.renderPage(
        pageIndex: pageIndex,
        x: 0,
        y: currentCut.toInt(),
        width: size.width,
        height: imageCutFactor.toInt(),
        scale: 2.5,
      );

      if (img != null) {
        final decodedImg = im.decodeImage(img);
        if (decodedImg != null) {
          final tempDir = await getTemporaryDirectory();
          final tempImagePath = '${tempDir.path}/temp_image.png';
          await File(tempImagePath).writeAsBytes(im.encodePng(decodedImg));
          await bluetooth.printImage(tempImagePath);
        }
      }

      currentCut += imageCutFactor;
    }

    await pdf.close();
  }
  static Future<void> _renderAndPrintPdfViaBluetooth4(String path) async {
    try {
      final pdf = PdfImageRenderer(path: path);
      await pdf.open();

      const int pageIndex = 0;
      await pdf.openPage(pageIndex: pageIndex);
      final size = await pdf.getPageSize(pageIndex: pageIndex);

      // نرسم كامل الصفحة كصورة واحدة عالية الدقة
      final Uint8List? img = await pdf.renderPage(
        pageIndex: pageIndex,
        x: 0,
        y: 0,
        width: size.width,
        height: size.height,
        scale: 2.5,
      );

      if (img != null) {
        final decodedImg = im.decodeImage(img);
        if (decodedImg != null) {
          final tempDir = await getTemporaryDirectory();
          final tempImagePath = '${tempDir.path}/full_page.png';

          await File(tempImagePath).writeAsBytes(im.encodePng(decodedImg));

          // طباعة الصورة
          await bluetooth.printImage(tempImagePath);
          await Future.delayed(const Duration(milliseconds: 500)); // تأخير بسيط
        } else {
          _showToast("فشل في تحليل الصورة", success: false);
        }
      } else {
        _showToast("لم يتمكن من تحويل PDF إلى صورة", success: false);
      }

      await pdf.close();
    } catch (e, st) {
      printLongText('Error _renderAndPrintPdfViaBluetooth: $e');
      _showErrorToast(e, st);
    }
  }
  static Future<void> _renderAndPrintPdfViaBluetooth3(String path) async {
    try {
      final pdf = PdfImageRenderer(path: path);
      await pdf.open();

      const pageIndex = 0;
      await pdf.openPage(pageIndex: pageIndex);
      final size = await pdf.getPageSize(pageIndex: pageIndex);

      final Uint8List? img = await pdf.renderPage(
        pageIndex: pageIndex,
        x: 0,
        y: 0,
        width: size.width,
        height: size.height,
        scale: 2.5,
      );

      if (img != null) {
        final fullImage = im.decodeImage(img);
        if (fullImage == null) {
          _showToast("فشل في تحليل الصورة", success: false);
          return;
        }

        const int sliceHeight = 300; // يمكنك زيادتها حسب قدرة الطابعة
        int y = 0;
        int sliceIndex = 0;

        while (y < fullImage.height) {
          int height = (y + sliceHeight > fullImage.height)
              ? fullImage.height - y
              : sliceHeight;

          final slice = im.copyCrop(fullImage, 0, y, fullImage.width, height);

          final tempDir = await getTemporaryDirectory();
          final tempImagePath = '${tempDir.path}/slice_$sliceIndex.png';
          await File(tempImagePath).writeAsBytes(im.encodePng(slice));
          await bluetooth.printImage(tempImagePath);
          await Future.delayed(const Duration(milliseconds: 300));

          y += sliceHeight;
          sliceIndex++;
        }

        _showToast("تمت الطباعة بنجاح!", success: true);
      } else {
        _showToast("لم يتمكن من تحويل PDF إلى صورة", success: false);
      }

      await pdf.close();
    } catch (e, st) {
      printLongText('Error _renderAndPrintPdfViaBluetooth: $e');
      _showErrorToast(e, st);
    }
  }


  static Future<void> printToAll(String pdfPath, int copies) async {
    final printers = await loadPrinters();
    print('printToAll');
    // print(printers.elementAt(0).deviceName);
    // print(printers.elementAt(0).address);
    if (printers.isEmpty) {
      _showToast('لا توجد طابعات مسجلة', success: false);
      return;
    }

    for (var device in printers) {
      print(device.address);
      print(device.deviceName);
      print(printers.length);
      print('printers.length');
      switch (device.typePrinter) {
        case 'bluetooth':
          await _bluetoothPrint(device, pdfPath, copies);
          break;
        case 'usb':
          await _printUsbPage(device, pdfPath, copies);
          break;
        case 'network':
          await _printNetwork(device, pdfPath, copies);
          break;
        default:
          _showToast('نوع الطابعة غير مدعوم: ${device.typePrinter}', success: false);
      }
    }
  }

  static Future<BluetoothDevice?> getDevice() async {
    try {
      final devices = await bluetooth.getBondedDevices();
      for (var device in devices) {
        if (device.address == StteingController().Printer_Name) {
          _device = device;
          break;
        }
      }
      return _device;
    } catch (e) {
      _showToast(e.toString());
      return null;
    }
  }

  static Future<void> _bluetoothPrint(AppPrinterDevice device, String path, int copies) async {
    try {
      print(device.address);
      print(device.deviceName);
      print(path);
      print(copies);
      print('printers.length55');

      // التأكد من أن الاتصال غير مفعل فقط، ثم الاتصال
      bool isConn = await bluetooth.isConnected ?? false;

      if (!isConn) {
        final bonded = await bluetooth.getBondedDevices();
        print(bonded.map((d) => d.address));  // طباعة جميع العناوين في الكونسول
        print(device.address);  // طباعة جميع العناوين في الكونسول
        final found = bonded.firstWhereOrNull((d) => d.address == device.address);
        print(found);

        if (found == null) {
          _showToast('طابعة Bluetooth غير متصلة: ${device.deviceName}', success: false);
          return;
        }

        try {
          await bluetooth.connect(found);
          await Future.delayed(const Duration(milliseconds: 500));
        } catch (error) {
          print('Connection error: $error');
          Fluttertoast.showToast(
              msg: error.toString(),
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent
          );
          return;
        }
      }

      for (int copy = 0; copy < copies; copy++) {
        await _renderAndPrintPdfViaBluetooth(path);
        await Future.delayed(const Duration(milliseconds: 500));
      }

      _showToast("تمت الطباعة بنجاح!", success: true);
    } catch (e, st) {
      printLongText('Error bluetoothPrint $e');
      _showErrorToast(e, st);
    } finally {
      if (await bluetooth.isConnected ?? false) {
        await bluetooth.disconnect();
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }

  static void _showErrorToast(Object e, StackTrace stack) {
    print("Error: $e\n$stack");
    Fluttertoast.showToast(
      msg: "Error: $e",
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      backgroundColor: Colors.redAccent,
    );
  }

  static void _showToast(String msg, {bool success = false}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      backgroundColor: success ? Colors.green : Colors.redAccent,
    );
  }

}
