import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/controllers/setting_controller.dart';
import 'package:intl/intl.dart' as intl;
import '../Widgets/config.dart';
import 'file_helper.dart';

class SimplePdf {


  static Future<pw.Font> loadRiyalFont() async {
    // 1. قراءة الملف من المجلد assets عن طريق FileHelper
    final Uint8List fontData = await FileHelper.getFileFromAssets('Assets/fonts/NewRiyal-Regular.ttf');
    // 2. تحويله إلى ByteData ثم إنشاء كائن pw.Font
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  // static Future<pw.MemoryImage> getSaudiRiyalImage() async {
  //   final ByteData bytes = await rootBundle.load(ImageSaudi_Riyal);
  //   final Uint8List imageData = bytes.buffer.asUint8List();
  //   return pw.MemoryImage(imageData);
  // }

  // Future<pw.Widget> buildImageWidget({double width = 15, double height = 14}) async {
  //   final image = await getSaudiRiyalImage();
  //   return pw.Image(
  //     image,
  //     width: width,
  //     height: height,
  //   );
  // }

  static Future<pw.MemoryImage> loadImage() async {
    final imageByteData = await rootBundle.load(ImagePathPDF);
    final imagefile = File(SignPicture);

    Uint8List imageBytes;

    if (LoginController().SOSI == 'null' ||
        LoginController().SOSI == '0' ||
        LoginController().SOSI.isEmpty ||
        LoginController().Image_Type == '2') {
      imageBytes = imageByteData.buffer.asUint8List(
          imageByteData.offsetInBytes,
          imageByteData.lengthInBytes
      );
    } else {
      imageBytes = imagefile.readAsBytesSync();
    }

    return pw.MemoryImage(imageBytes);
  }



  static pw.Widget text(String data, pw.Font ttf,
      {double fontSize = 8,
        PdfColor color = PdfColors.black,
        pw.TextAlign? align}) {

    String reverseMultipliedNumbers(String input) {
      final exp = RegExp(r'(\d+)(\s*\*\s*\d+)+');

      return input.replaceAllMapped(exp, (match) {
        // التقطنا كامل التسلسل مثل 6*12*30
        final full = match.group(0)!;

        // نفصل الأرقام وننظف الفراغات
        final parts = full.split('*').map((e) => e.trim()).toList();

        // نقلبهم
        final reversed = parts.reversed.join('*');

        return reversed;
      });
    }

    // String fixRtlNumbers(String input) {
    //   return input.replaceAllMapped(RegExp(r'(\d+)\s*\*\s*(\d+)'), (match) {
    //     final part1 = match.group(1);
    //     final part2 = match.group(2);
    //     return '$part2*$part1'; // عكس الرقمين مع الحفاظ على الرمز نفسه
    //   });
    // }

    // عكس الرقم والرمز داخل النص
    data = reverseMultipliedNumbers(data);

    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Text(
        data,
        textAlign: align ?? pw.TextAlign.center,
        style: pw.TextStyle(
          font: ttf,
          fontSize: fontSize,
          fontWeight: pw.FontWeight.bold,
          height: 1.2,
          color: color,
        ),
      ),
    );
  }




  static pw.SizedBox spaceH({double height = 2}) => pw.SizedBox(height: height);
  static pw.SizedBox spaceW({double width = 2}) => pw.SizedBox(width: width);

  static pw.Widget buildHeader(Type,pw.Font font,GetPKNA,controller,image){

    // دالة مساعدة لبناء النص
    pw.Widget buildText(String text, double fontSize) {
      return SimplePdf.text(
        text,
        font,
        fontSize: fontSize,
        color: PdfColors.black,
      );
    }

    // دالة مساعدة للحصول على نوع المستند
    String _getDocumentType() {
      if (controller.SVVL_TAX != '2') {
        switch (controller.BMKID) {
          case 4:
          case 12:
            return ' ${'StringSimplifiedTaxInvoiceeR'.tr}-$GetPKNA';
          case 7:
            return '${'StringQuotation_R'.tr}-$GetPKNA';
          case 10:
            return '${'StringCustomer_Requests_R'.tr}-$GetPKNA';
          default:
            return ' ${'StringSimplifiedTaxInvoicee'.tr}-$GetPKNA';
        }
      }
      else {
        switch (controller.BMKID) {
          case 3:
            return '${'StringSalesInvoices'.tr}-$GetPKNA';
          case 7:
            return (LoginController().CIID == '2') ? '${'StringQuotation_R'.tr}' : '${'StringQuotation_R'.tr}-$GetPKNA';
          case 10:
            return '${'StringCustomer_Requests_R'.tr}-$GetPKNA';
          case 1:
            return '${'StringPurchases_Invoices'.tr}-$GetPKNA';
          case 5:
            return '${'StringService_Bills'.tr}-$GetPKNA';
          case 4:
            return '${'StringBIL_MOV_OUT_R'.tr}-$GetPKNA';
          case 12:
            return ' ${'StringBIF_MOV_MOR'.tr}-$GetPKNA';
          default:
            return '${'StringPOSInvoice'.tr}-$GetPKNA';
        }
      }
    }

    String _getDocumentType2() {
      switch (controller.BMKID) {
        case 4:
        case 12:
          return 'StringTAX_REU'.tr;
        case 7:
          return '${'StringQuotation_R'.tr} - $GetPKNA';
        case 10:
          return '${'StringCustomer_Requests_R'.tr} - $GetPKNA';
        default:
          return '${'String_Tax_Invoice'.tr}';
      }
    }

    String _getInvoiceTitle() {
      switch (controller.BMKID) {
        case 3:
          return 'StringSale_Invoices'.tr;
        case 1:
          return 'StringPurchases_Invoices'.tr;
        case 4:
          return 'StringReturn_Sale_Invoices'.tr;
        case 7:
          return 'StringQuotations'.tr;
        case 10:
          return 'StringCustomer_Requests'.tr;
        case 12:
          return 'StringReturn_Sale_Invoices_POS'.tr;
        case 5:
          return 'StringService_Bills'.tr;
        default:
          return STMID == 'COU'
              ? 'StringCounterSalePosting_REP'.tr
              : 'StringPOS'.tr;
      }
    }

    // دالة مساعدة لبناء العمود الأيسر
    pw.Widget _buildLeftColumn() {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildText(controller.SONE, 13),
            buildText(controller.SOLN, 11),
            buildText(controller.SVVL_TAX != '2' ? '${'StringTaxnumber2'.tr} ${controller.SOTX}' : '', 10),
          ],
        ),
      );
    }

    // دالة مساعدة لبناء العمود المركزي
    pw.Widget _buildCenterColumn(String GetPKNA, ImageProvider image) {
      return Expanded(
        child: Column(
          children: [
            Container(width: 50.w, child: Image(image)),
          ],
        ),
      );
    }

    // دالة مساعدة لبناء العمود الأيمن
    pw.Widget _buildRightColumn() {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildText(controller.SONA, 13),
            buildText(controller.SORN, 11),
            buildText(' ${'StringAddress2'.tr}  ${controller.SOAD}', 10),
          ],
        ),
      );
    }


    return StteingController().SHOW_REP_HEADER==true?pw.Table(
      columnWidths: {
        0: const  pw.FlexColumnWidth(60),
        1: const  pw.FlexColumnWidth(60),
        2: const  pw.FlexColumnWidth(60),
      },
      border: pw.TableBorder.all(),
      children: [
        // عنوان الجدول
        pw.TableRow(
          children: [
            pw.Column(children:[
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: <pw.Widget>[
                  _buildLeftColumn(),
                  _buildCenterColumn(GetPKNA.toString(), image),
                  _buildRightColumn(),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Expanded(
                    child: pw.Divider(
                      color: PdfColors.grey,
                      thickness: 1,
                    ),
                  ),
                  pw.Container(
                    margin: const pw.EdgeInsets.symmetric(horizontal: 10),
                    padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey, width: 1),
                      borderRadius: pw.BorderRadius.circular(5),
                      color: PdfColors.white,
                    ),
                    child: buildText(Type==1?_getDocumentType2():Type==3?_getInvoiceTitle() : _getDocumentType(),15)
                    ),
                  pw.Expanded(
                    child: pw.Divider(
                      color: PdfColors.grey,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
            ]),
          ],
        ),
      ],
    ):pw.Container();
  }

  static pw.Widget buildFooter(context,pw.Font font,SDDSA){

    return  pw.Column(children: [
      if (StteingController().REPEAT_SIN_FOOTER==true)  Container(
        padding: pw.EdgeInsets.all(3),
        child: SimplePdf.text(SDDSA,
          font,
          fontSize: 12,
          align: TextAlign.center,
          color: PdfColors.black,
        ),
      ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SimplePdf.text(
              'StrinUser'.tr + ' ${LoginController().SUNA}',
              font,
              fontSize: 9,
              color: PdfColors.black,
            ),
            Text('Page ${context.pageNumber}  of ${context.pagesCount}',
                style: const TextStyle(fontSize: 9)),
            SimplePdf.text(
              'StringDateofPrinting'.tr + ': ' + '${intl.DateFormat('dd-MM-yyyy HH:m').format(DateTime.now())}',
              font,
              fontSize: 9,
              color: PdfColors.black,
            ),
          ])
        ]);
  }

  static pw.Widget buildFooter_SIN(pw.Font font,SDDDA,SDDSA){

    return  Table(border: TableBorder.all(), children: [
      TableRow(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 2, left: 2),
            /// height: 630,
            child: Column(children: [
              Container(
                padding: pw.EdgeInsets.all(4),
                child: SimplePdf.text(
                  SDDDA,
                  font,
                  fontSize: 11,
                  align: TextAlign.center,
                  color: PdfColors.black,
                ),
              ),
              SizedBox(height: 2),
              Divider(height: 1),
              if (StteingController().REPEAT_SIN_FOOTER==false)  Container(
                padding: pw.EdgeInsets.all(3),
                child: SimplePdf.text(SDDSA,
                  font,
                  fontSize: 12,
                  align: TextAlign.center,
                  color: PdfColors.black,
                ),
              ),
              SizedBox(height: 2),
            ]),
          ),
        ],
      ),
    ]);
  }

  static pw.Widget buildSignature(pw.Font font,Uint8List? signature){
    return  signature.isNull || signature!.isEmpty?
    Container():
    Row(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          SizedBox(height: 3),
          pw.Image(pw.MemoryImage(signature,),
            width: 100,height: 100,),
          SimplePdf.text("StringSignature".tr, font, fontSize: 10),
        ]);
  }

  static Widget buildBalanceSection(item,controller,pw.Font font,FontSize) {
    bool showUnBalance = StteingController().PRINT_BALANCE
        ? (StteingController().PRINT_BALANCE_ALERT ? controller.PRINT_BALANCE_ALR : true)
        : false;
    String totalAmount=showUnBalance? controller.formatter.format([4, 11, 12].contains(item.BMKID)
        ? item.BMMMT! - controller.BACBA! - controller.SUMBAL :
    (item.BMMMT! + controller.BACBA! + controller.SUMBAL) - item.BMMCP!).toString():
    controller.formatter.format([4, 11, 12].contains(item.BMKID)
        ? item.BMMMT! - controller.BACBA! :
    (item.BMMMT! + controller.BACBA!)  - item.BMMCP!).toString();
    print('StteingController().Print_Balance');
    print(StteingController().Print_Balance);
    print(StteingController().Print_Balance);
    print(controller.Print_Balance);

    bool isBalancePrintable() {
      return StteingController().Print_Balance == true &&
          item.BMKID != 1 &&
          item.PKID == 3 &&
          item.BCID != 'null';
    }

    bool shouldShowBMMCPWithReturn() {
      return item.BMMCP.toString() != 'null' &&
          item.BMMCP! > 0 &&
          item.BMMTC! > 0 &&
          ((controller.BMKID == 11 && controller.PRINT_PAY_RET == '1') ||
              ((controller.BMKID == 3 || controller.BMKID == 5) && controller.PRINT_PAY == '1'));
    }

    bool shouldShowBMMCP() {
      return item.BMMCP.toString() != 'null' &&
          item.BMMCP! > 0 &&
          ((controller.BMKID == 11 && controller.PRINT_PAY_RET == '1') ||
              ((controller.BMKID == 3 || controller.BMKID == 5) && controller.PRINT_PAY == '1'));
    }

    print('PRINT_BALANCE_ALR');
    print(controller.PRINT_BALANCE_ALR);



    String getBalanceText() {
      if (shouldShowBMMCPWithReturn()) {
        return
          showUnBalance?
            " ${'StringUn_Balance'.tr}: ${controller.formatter.format(controller.SUMBAL).toString()}"
            " ${'StringLast_Balance_Print'.tr} ${controller.formatter.format(controller.BACBA).toString()}"
            " ${'StringAmount_Print'.tr} ${controller.formatter.format(item.BMMMT).toString()}"
            " ${'StringTotal_Am_Print'.tr} ${totalAmount.toString()}"
            " ${'StringBMMCP'.tr} ${controller.formatter.format(item.BMMCP).toString()}"
            " ${'StringReturn_Am'.tr} ${controller.formatter.format(item.BMMTC).toString()}":

              " ${'StringLast_Balance_Print'.tr} ${controller.formatter.format(controller.BACBA).toString()}"
              " ${'StringAmount_Print'.tr} ${controller.formatter.format(item.BMMMT).toString()}"
              " ${'StringTotal_Am_Print'.tr} ${totalAmount.toString()}"
              " ${'StringBMMCP'.tr} ${controller.formatter.format(item.BMMCP).toString()}"
              " ${'StringReturn_Am'.tr} ${controller.formatter.format(item.BMMTC).toString()}";
      } else if (shouldShowBMMCP()) {
        return
          showUnBalance?
          " ${'StringUn_Balance'.tr}: ${controller.formatter.format(controller.SUMBAL).toString()}"
          " ${'StringLast_Balance_Print'.tr} ${controller.formatter.format(controller.BACBA).toString()}"
          " ${'StringAmount_Print'.tr} ${controller.formatter.format(item.BMMMT).toString()}"
          " ${'StringBMMCP'.tr} ${controller.formatter.format(item.BMMCP).toString()}"
          " ${'StringTotal_Am_Print'.tr} ${totalAmount.toString()}" :

          " ${'StringLast_Balance_Print'.tr} ${controller.formatter.format(controller.BACBA).toString()}"
          " ${'StringAmount_Print'.tr} ${controller.formatter.format(item.BMMMT).toString()}"
          " ${'StringBMMCP'.tr} ${controller.formatter.format(item.BMMCP).toString()}"
          " ${'StringTotal_Am_Print'.tr} ${totalAmount.toString()}";

      } else {
        return
          showUnBalance?
            " ${'StringUn_Balance'.tr}: ${controller.formatter.format(controller.SUMBAL).toString()}"
            " ${'StringLast_Balance_Print'.tr} ${controller.formatter.format(controller.BACBA).toString()}"
            " ${'StringAmount_Print'.tr} ${controller.formatter.format(item.BMMMT).toString()}"
            " ${'StringTotal_Am_Print'.tr} ${totalAmount.toString()}":

              " ${'StringLast_Balance_Print'.tr} ${controller.formatter.format(controller.BACBA).toString()}"
              " ${'StringAmount_Print'.tr} ${controller.formatter.format(item.BMMMT).toString()}"
              " ${'StringTotal_Am_Print'.tr} ${totalAmount.toString()}"
        ;
      }
    }

    return isBalancePrintable()
        ? Column(
      children: [
        SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SimplePdf.text(
              getBalanceText(),
              font,
              fontSize:FontSize,
              align: TextAlign.center,
              color: PdfColors.black,
            )
          ],
        ),
      ],
    )
        : shouldShowBMMCP()
        ? SimplePdf.text(
         item.BMMTC! > 0
          ? " ${'StringBMMCP'.tr} ${controller.formatter.format(item.BMMCP).toString()}"
          " ${'StringReturn_Am'.tr} ${controller.formatter.format(item.BMMTC).toString()}"
          : " ${'StringBMMCP'.tr} ${controller.formatter.format(item.BMMCP).toString()}",
      font,
      fontSize: FontSize,
      align: TextAlign.center,
      color: PdfColors.black,
    )
        : SizedBox(height: 0);
  }

}
