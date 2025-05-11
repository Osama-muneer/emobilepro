import 'dart:io';
import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Setting/models/qr_inf.dart';
import '../../Setting/models/sys_com.dart';
import '../../Setting/models/sys_var.dart';
import '../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';
import '../models/AppPrinterDevice.dart';
import '../../Widgets/config.dart';
import 'dart:typed_data';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class StteingController extends GetxController {
  //TODO: Implement HomeController
 // bool connected = false;
  static StteingController get to => Get.find();
  RxBool connected = false.obs;
  var defaultPrinterType = PrinterType.bluetooth;
  var _isBle = false;
  var _reconnect = false;
  var _isConnected = false.obs;
  var printers = <AppPrinterDevice>[];// Observable for connection status
  var printerManager = PrinterManager.instance;
  var devices = <AppPrinterDevice>[].obs; // Observable list for devices
  StreamSubscription<PrinterDevice>? _subscription;
  StreamSubscription<BTStatus>? _subscriptionBtStatus;
  StreamSubscription<USBStatus>? _subscriptionUsbStatus;
  BTStatus _currentStatus = BTStatus.none;
  USBStatus _currentUsbStatus = USBStatus.none; // Only supports on Android
  List<int>? pendingTask;
  String _ipAddress = '';
  String _port = '9100';

  // Controllers for IP and Port input fields
  final _ipController = TextEditingController();
  final _portController = TextEditingController();
  AppPrinterDevice? selectedPrinter;

  late TextEditingController
  DEFAULTSNNOController, topMarginController , bottomMarginController ,
   leftMarginController, rightMarginController, fontSizeController, PrintController,Number_CopController;
  late FocusNode topMarginFocus;
  late FocusNode bottomMarginFocus;
  late FocusNode leftMarginFocus;
  late FocusNode rightMarginFocus ;
  late FocusNode fontSizeFocus;
  late FocusNode copiesFocus;
  late List<Sys_Com_Local> Sys_Com_List = [];
  late List<Qr_Inf_Local> QR_INF = [];
  static StteingController instance = StteingController._();
  String?  USING_TAX_SALES,PRINT_INV='1',Use_Multi_Stores_BO='2',Use_Multi_Stores_BI='2';
  StteingController._();
  int? QIID;
  int currentIndex =0;

  factory StteingController() {
    return instance;
  }

  RxnString errorText = RxnString(null);
  late final StteingDataBox;
  late List<Sys_Var_Local> SYS_VAR;
  @override
  void onInit() async {
    PrintController = TextEditingController();
    DEFAULTSNNOController = TextEditingController();
    topMarginController = TextEditingController();
    bottomMarginController = TextEditingController();
    leftMarginController = TextEditingController();
    rightMarginController = TextEditingController();
    fontSizeController = TextEditingController();
    Number_CopController = TextEditingController();
    topMarginFocus = FocusNode();
    bottomMarginFocus = FocusNode();
    leftMarginFocus = FocusNode();
    rightMarginFocus = FocusNode();
    fontSizeFocus = FocusNode();
    copiesFocus = FocusNode();
    PrintController.text=Printer;
    topMarginController.text=TOP_MARGIN.toString();
    bottomMarginController.text=BOTTOM_MARGIN.toString();
    leftMarginController.text=LEFT_MARGIN.toString();
    rightMarginController.text=RIGHT_MARGIN.toString();
    fontSizeController.text=FONT_SIZE_PDF.toString();
    Number_CopController.text=NUMBER_COPIES_REP.toString();
    _addFocusListeners();
    GET_PRINT_INV_P();
    getAll();
    GET_QR_INF_P();
    GET_Use_Multi_Stores();
    GET_Use_Multi_Stores_BI();
    GETMOB_VAR_P(21);
    GETMOB_VAR_P(22);
    //
    // if (Platform.isWindows) defaultPrinterType = PrinterType.usb;
    // _portController.text = _port;
    // scan();
    // // Subscribe to Bluetooth status changes
    // _subscriptionBtStatus = printerManager.stateBluetooth.listen((status) {
    //   // log(' ----------------- status bt $status ------------------ ');
    //   _currentStatus = status;
    //   _isConnected.value = (status == BTStatus.connected);
    //
    //   if (status == BTStatus.connected && pendingTask != null) {
    //     Future.delayed(const Duration(milliseconds: 1000), () {
    //       printerManager.send(type: PrinterType.bluetooth, bytes: pendingTask ?? []);
    //       pendingTask = null;
    //     });
    //   }
    // });
    //
    // // USB status subscription (only for Android)
    // _subscriptionUsbStatus = printerManager.stateUSB.listen((status) {
    //   // log(' ----------------- status usb $status ------------------ ');
    //   _currentUsbStatus = status;
    //
    //   if (Platform.isAndroid && status == USBStatus.connected && pendingTask != null) {
    //     Future.delayed(const Duration(milliseconds: 1000), () {
    //       printerManager.send(type: PrinterType.usb, bytes: pendingTask ?? []);
    //       pendingTask = null;
    //     });
    //   }
    // });

    //getImage();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    PrintController.dispose();
    DEFAULTSNNOController.dispose();
    topMarginController.dispose();
    bottomMarginController.dispose();
    leftMarginController.dispose();
    rightMarginController.dispose();
    fontSizeController.dispose();
    Number_CopController.dispose();
    topMarginFocus.dispose();
    bottomMarginFocus.dispose();
    leftMarginFocus.dispose();
    rightMarginFocus.dispose();
    fontSizeFocus.dispose();
    copiesFocus.dispose();
    _subscription?.cancel();
    _subscriptionBtStatus?.cancel();
    _subscriptionUsbStatus?.cancel();
    _portController.dispose();
    _ipController.dispose();
   super.dispose();
  }

  void _addFocusListeners() {
    topMarginFocus.addListener(update);
    bottomMarginFocus.addListener(update);
    leftMarginFocus.addListener(update);
    rightMarginFocus.addListener(update);
    fontSizeFocus.addListener(update);
    copiesFocus.addListener(update);
  }

  Future<void> initHive() async {
    await Hive.initFlutter();
    StteingDataBox = await Hive.openBox('userData');
  }

  void initPrinter() async{
    // مثال: اختر USB على ويندوز، وبلوتوث على أندرويد/آي أو إس
    if (Platform.isWindows) {
      defaultPrinterType = PrinterType.usb;
    } else {
      defaultPrinterType = PrinterType.bluetooth;
    }
    _portController.text = _port;
    await scan();

    // فقط على أندرويد وآي أو إس اشترك في البلوتوث
    if (!Platform.isWindows) {
      _subscriptionBtStatus = printerManager.stateBluetooth.listen((status) {
        _currentStatus = status;
        _isConnected.value = (status == BTStatus.connected);
        if (status == BTStatus.connected && pendingTask != null) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            printerManager.send(
              type: PrinterType.bluetooth,
              bytes: pendingTask!,
            );
            pendingTask = null;
          });
        }
      });
    }

    // USB متاح على أندرويد وويندوز
    _subscriptionUsbStatus = printerManager.stateUSB.listen((status) {
      _currentUsbStatus = status;
      if ((Platform.isAndroid || Platform.isWindows)
          && status == USBStatus.connected
          && pendingTask != null) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          printerManager.send(
            type: PrinterType.usb,
            bytes: pendingTask!,
          );
          pendingTask = null;
        });
      }
    });
  }

  Future<bool> _requestBluetoothPermissions() async {
    // أولًا صلاحية الموقع (Android 10+)
    await Permission.location.request();
    // ثم صلاحيات البلوتوث الحديثة
    final statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
    ].request();
    return statuses.values.every((s) => s.isGranted);
  }


  Future UPDATEMOB_VAR_P(int GETMVID,int GETVALUE) async {
    UpdateMOB_VAR(GETMVID,GETVALUE);
  }

  int UseSignature=0;
  int ShowSignatureAlert=0;


  Future GETMOB_VAR_P(int GETMVID) async {
    var MVVL=await GETMOB_VAR(GETMVID);
    if(MVVL.isNotEmpty){
      if(GETMVID==21){
        UseSignature=int.parse(MVVL.elementAt(0).MVVL.toString());
        SET_B_P('UseSignatureValue',UseSignature==0?false:true);
        update();
      }
      else if(GETMVID==22){
        ShowSignatureAlert=int.parse(MVVL.elementAt(0).MVVL.toString());
        SET_B_P('ShowSignatureAlertValue',ShowSignatureAlert==0?false:true);
        update();
      }
      update();
    }else{

    }
  }

  Future Get_Printers() async {
     printers=await loadPrinters();
    update();
  }

  //تعدد المخازن في فاتورة المبيعات
  Future GET_Use_Multi_Stores() async {
   await GET_SYS_VAR(508).then((data) {
      if (data.isNotEmpty) {
        Use_Multi_Stores_BO = data.elementAt(0).SVVL;
        update();
      }else{
        SET_B_P('MULTI_STORES_BO',false);
        Use_Multi_Stores_BO='2';
      }
      print('Use_Multi_Stores_BO');
      print(Use_Multi_Stores_BO);
    });
   update();
  }

  Future GET_Use_Multi_Stores_BI() async {
   await GET_SYS_VAR(509).then((data) {
      if (data.isNotEmpty) {
        Use_Multi_Stores_BI = data.elementAt(0).SVVL;
        update();
      }else{
        SET_B_P('MULTI_STORES_BI',false);
        Use_Multi_Stores_BI='2';
      }
      print('Use_Multi_Stores_BI');
      print(Use_Multi_Stores_BI);
    });
   update();
  }

  //اظهار البيانات +البحث
  GET_QR_INF_P() {
    GET_QR_INF().then((data) {
        QR_INF = data;
        update();
      });
  }

  //جلب رقم الحركة
  Future GET_QIID_P() async {
    GET_QIID().then((data) {
      QR_INF = data;
      if (QR_INF.isNotEmpty) {
        QIID = QR_INF.elementAt(0).QIID;
        update();
        print("QIID");
        print(QIID);
      }
    });
    update();
  }


  getAll() {
    GetSysCom().then((data) {
      Sys_Com_List = data;
    });
  }

  //طباعة رصيد العميل بعد كل فاتوره
  Future GET_PRINT_INV_P() async {
   await GET_SYS_VAR(668).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        PRINT_INV = SYS_VAR.elementAt(0).SVVL.toString();
        if( SYS_VAR.elementAt(0).SVVL=='1'){
          StteingController().SET_B_P('Print_Balance',false);
          update();
        }
        print('PRINT_INV');
        print(PRINT_INV);
      }else{
        PRINT_INV='1';
      }
      print('PRINT_INV');
      print(PRINT_INV);
    });
  }
  String? validateDefault_SNNO(String value) {
    errorText.value = null;
    try {
      if (value.trim().isEmpty) {
        errorText.value = 'StringDefault_SNNO_ISNULL'.tr;
        return 'StringDefault_SNNO_ISNULL'.tr;
        // }else if (value.contains('..')) {
        //   errorText.value = StringDefault_SNNO_NUM;
        //   return StringDefault_SNNO_NUM;
      } else if (double.parse(value.trim()) < 0) {
        errorText.value = 'StringDefault_SNNO_NUM'.tr;
        return 'StringDefault_SNNO_NUM'.tr;
      } else {
        SET_D_P('Default_SNNO',double.parse(DEFAULTSNNOController.text));
        errorText.value = null;
        return null;
      }
    }catch (e) {
      errorText.value = 'StringErrorDefault_SNNO_NUM'.tr;
      print("error1${e.toString()}");
    }
    return null;
  }


  void SET_P(String GETTYPE,String GET_V) async {
    return StteingDataBox.put(GETTYPE, GET_V);
  }

  void SET_B_P(String GETTYPE,bool GET_V) async {
    return StteingDataBox.put(GETTYPE, GET_V);
  }

  void SET_N_P(String GETTYPE,int GET_V) async {
    return StteingDataBox.put(GETTYPE, GET_V);
  }

  void SET_D_P(String GETTYPE,double GET_V) async {
    return StteingDataBox.put(GETTYPE, GET_V);
  }

  bool get isSwitchCollectionOfItems => StteingDataBox.get('isSwitchCollectionOfItems',defaultValue: true);
  bool get isSwitchShowMesMat => StteingDataBox.get('isSwitchShowMesMat',defaultValue: false);
  bool get isShow_Mat_No_SNNO => StteingDataBox.get('isShow_Mat_No_SNNO',defaultValue: true);
  bool get isSave_Automatic => StteingDataBox.get('isSave_Automatic',defaultValue: false);
  bool get isShow_SNNO_OR_DEF => StteingDataBox.get('isShow_SNNO_OR_DEF',defaultValue: true);
  double get Default_SNNO => StteingDataBox.get('Default_SNNO',defaultValue: 1.0);
  int get Type_Serach => StteingDataBox.get('Type_Serach',defaultValue: 1);
  String get Type_Inventory => StteingDataBox.get('Type_Inventory',defaultValue: '2');
  String get Type_Inventory_Name => StteingDataBox.get('Type_Inventory_Name',defaultValue: 'StringInventory_Insert'.tr);
  String get SalesScreenTemplate => StteingDataBox.get('SalesScreenTemplate',defaultValue: 'StringR_TYP1'.tr);
  bool get isActivateInteractionScreens => StteingDataBox.get('isActivateInteractionScreens',defaultValue: true);
  bool get isActivateAutoMoveSync => StteingDataBox.get('isActivateAutoMoveSync',defaultValue: true);
  bool get isSwitchBrcode => StteingDataBox.get('isSwitchBrcode',defaultValue:STMID=='INVC'?true:false);
  bool get isPrint => StteingDataBox.get('isPrint',defaultValue: STMID=='EORD'?false:true);
  String get Printer_Name => StteingDataBox.get('Printer_Name',defaultValue: '');
  String get Printer => StteingDataBox.get('Printer',defaultValue: '');
  bool get UPIN_USING_TAX_SALES => StteingDataBox.get('UPIN_USING_TAX_SALES',defaultValue: true);
  bool get Save_Sync_Invo => StteingDataBox.get('Save_Sy_Invo',defaultValue: true);
  String get Size_Font => StteingDataBox.get('Size_Font',defaultValue: 'S');
  String get Size_Font_Name => StteingDataBox.get('Size_Font_Name',defaultValue: 'صغير');
  String get Thermal_printer_paper_size => StteingDataBox.get('Thermal_printer_paper_size',defaultValue: '58');
  String get Thermal_printer_paper_size_Name => StteingDataBox.get('Thermal_printer_paper_size_Name',defaultValue: '58 mm حراري');
  String get Image => StteingDataBox.get('Image');
  String get TYPE_SHOW_DATA => StteingDataBox.get('TYPE_SHOW_DATA',defaultValue: '1');
  bool get isSwitchUse_Gro => StteingDataBox.get('isSwitchUse_Gro',defaultValue: false);
  bool get isSwitchSend_SMS => StteingDataBox.get('isSwitchSend_SMS',defaultValue: false);
  bool get isSwitchSend_PDF => StteingDataBox.get('isSwitchSend_PDF',defaultValue: false);
  bool get Show_MINO => StteingDataBox.get('Show_MINO',defaultValue: false);
  bool get Show_BMDID => StteingDataBox.get('Show_BMDID',defaultValue: false);
  bool get Print_Balance => StteingDataBox.get('Print_Balance',defaultValue: false);
  bool get Type_Print => StteingDataBox.get('Type_Print',defaultValue: false);
  bool get Print_Image => StteingDataBox.get('Print_Image',defaultValue: true);
  int get Type_Model => StteingDataBox.get('Type_Model',defaultValue: 1);
  int get TypeSalesTemplate => StteingDataBox.get('TypeSalesTemplate',defaultValue: 1);
  String get Type_Model_Name => StteingDataBox.get('Type_Model_Name',defaultValue: 'النموذج الاول');
  bool get Show_Inv_Pay => StteingDataBox.get('Show_Inv_Pay',defaultValue: true);
  bool get isShow_Notification => StteingDataBox.get('isShow_Notification',defaultValue: true);
  bool get Print_Balance_Pay => StteingDataBox.get('Print_Balance_Pay',defaultValue: false);
  bool get Install_BDID => StteingDataBox.get('Install_BDID',defaultValue: false);
  int get Standard_Form => StteingDataBox.get('Standard_Form',defaultValue: 1);
  bool get SHOW_TAB => StteingDataBox.get('SHOW_TAB',defaultValue: false);
  String get Standard_Form_Name => StteingDataBox.get('Standard_Form_Name',defaultValue: 'النموذج الاول');
  bool get PRINT_AD => StteingDataBox.get('PRINT_AD',defaultValue: false);
  bool get MULTI_STORES_BO => StteingDataBox.get('MULTI_STORES_BO',defaultValue: false);
  bool get MULTI_STORES_BI => StteingDataBox.get('MULTI_STORES_BI',defaultValue: false);
  bool get SHOW_ALTER_REP => StteingDataBox.get('SHOW_ALTER_REP',defaultValue: false);
  double get TOP_MARGIN => StteingDataBox.get('TOP_MARGIN',defaultValue: 2.5);
  double get BOTTOM_MARGIN => StteingDataBox.get('BOTTOM_MARGIN',defaultValue: 2.5);
  double get LEFT_MARGIN => StteingDataBox.get('LEFT_MARGIN',defaultValue: 2.5);
  double get RIGHT_MARGIN => StteingDataBox.get('RIGHT_MARGIN',defaultValue: 2.5);
  double get FONT_SIZE_PDF => StteingDataBox.get('FONT_SIZE_PDF',defaultValue: 9.0);
  bool get PRINT_BALANCE => StteingDataBox.get('PRINT_BALANCE',defaultValue: false);
  bool get PRINT_BALANCE_ALERT => StteingDataBox.get('PRINT_BALANCE_ALERT',defaultValue: false);
  bool get DOCUMENT_B => StteingDataBox.get('PRINT_BALANCE',defaultValue: false);
  bool get INSTALL_DOCUMENT_B => StteingDataBox.get('INSTALL_DOCUMENT_B',defaultValue: false);
  bool get INSTALL_DOCUMENT_V => StteingDataBox.get('INSTALL_DOCUMENT_B',defaultValue: false);
  bool get SHOW_BRCODE_SAVE => StteingDataBox.get('SHOW_BRCODE_SAVE',defaultValue:false);
  bool get UseSignatureValue => StteingDataBox.get('UseSignatureValue',defaultValue:false);
  bool get ShowSignatureAlertValue => StteingDataBox.get('ShowSignatureAlertValue',defaultValue:false);
  bool get WAT_ACT => StteingDataBox.get('WAT_ACT',defaultValue:false);
  bool get USE_WAT_ALERT => StteingDataBox.get('USE_WAT_ALERT',defaultValue:false);
  bool get isPrint_VOU => StteingDataBox.get('isPrint_VOU',defaultValue: false);
  bool get SHOW_ITEM => StteingDataBox.get('SHOW_ITEM',defaultValue: false);
  bool get SHOW_ITEM_C => StteingDataBox.get('SHOW_ITEM_C',defaultValue: false);
  bool get SHOW_REP_HEADER => StteingDataBox.get('SHOW_REP_HEADER',defaultValue: true);
  bool get REPEAT_REP_HEADER => StteingDataBox.get('REPEAT_REP_HEADER',defaultValue: true);
  bool get REPEAT_SIN_FOOTER => StteingDataBox.get('REPEAT_SIN_FOOTER',defaultValue: false);
  bool get ALR_CUS_DEBT_SAL => StteingDataBox.get('ALR_CUS_DEBT_SAL',defaultValue: false);
  int get NUMBER_COPIES_REP => StteingDataBox.get('NUMBER_COPIES_REP',defaultValue: 1);
  int get Type_Model_A4 => StteingDataBox.get('Type_Model_A4',defaultValue: 1);
  bool get print_tax => StteingDataBox.get('print_tax',defaultValue: false);

  Future<int> logout() async {
    return await StteingDataBox.clear();
  }


  Future<void> scanDevices() async {
    try {
      // استخدم API ثابت أو كائن:
      // var ble = FlutterBluePlus;           // للـ API الثابت
      final FlutterBluePlus ble = FlutterBluePlus(); // لإنشاء كائن

      // ابدأ المسح
      await FlutterBluePlus.startScan(timeout: Duration(seconds: 4));

      // استمع لنتائج المسح واحفظ الأجهزة
      final seen = <String>{};
      FlutterBluePlus.scanResults.listen((results) {
        for (var result in results) {
          var id = result.device.id.id;
          if (seen.add(id)) {
            devices.add(AppPrinterDevice(
              deviceName: result.device.name.isEmpty ? 'Unknown' : result.device.name,
              address: id,
              isBle: true,
              vendorId: '',
              productId: id,
              typePrinter: getTypePrinterString(defaultPrinterType),
            ));
          }
        }
        update();
      });

      // انتظر انتهاء المهلة ثم أوقف المسح
      await Future.delayed(Duration(seconds: 4));
      await FlutterBluePlus.stopScan();
    } catch (e) {
      print('Error scanning for devices: $e');
    }
  }

  // Method to scan devices according to PrinterType
  Future<void> scan() async {
    if (!await _requestBluetoothPermissions()) {
    // أظهر رسالة للمستخدم أن الأذونات مطلوبة
    return;
    }

    devices.clear();
    if(defaultPrinterType == PrinterType.bluetooth){
      // scanDevices();
    }
    try {
      _subscription = printerManager.discovery(type: defaultPrinterType, isBle: _isBle).listen((device) {
        if(!devices.contains(AppPrinterDevice(
          deviceName: device.name ?? '',
          address: device.address,
          isBle: false,
          vendorId: device.vendorId,
          productId: device.productId,
          typePrinter: getTypePrinterString(defaultPrinterType),
        ))){
          devices.add(AppPrinterDevice(
            deviceName: device.name ?? '',
            address: device.address,
            isBle: false,
            vendorId: device.vendorId,
            productId: device.productId,
            typePrinter: getTypePrinterString(defaultPrinterType),
          ));
          update();
        }
        // Update the UI
      });
    } catch (e) {
      print(e);
    }
    // for _isBle
    try {
      _subscription = printerManager.discovery(type: defaultPrinterType, isBle: true).listen((device) {
        if(!devices.contains(AppPrinterDevice(
          deviceName: device.name ?? '',
          address: device.address,
          isBle: true,
          vendorId: device.vendorId,
          productId: device.productId,
          typePrinter: getTypePrinterString(defaultPrinterType),
        ))){
          devices.add(AppPrinterDevice(
            deviceName: device.name ?? '',
            address: device.address,
            isBle: true,
            vendorId: device.vendorId,
            productId: device.productId,
            typePrinter: getTypePrinterString(defaultPrinterType),
          ));
          update();
        }
        // Update the UI
      });
    } catch (e) {
      print(e);
    }
  }

  void setPort(String value) {
    if (value.isEmpty) value = '9100';
    _port = value;
    var device = AppPrinterDevice(
      deviceName: value,
      address: _ipAddress,
      port: _port,
      typePrinter: getTypePrinterString(PrinterType.network),
      state: false,
    );
    selectDevice(device);
  }

  void setIpAddress(String value) {
    _ipAddress = value;
    var device = AppPrinterDevice(
      deviceName: value,
      address: _ipAddress,
      port: _port,
      typePrinter: getTypePrinterString(PrinterType.network),
      state: false,
    );
    selectDevice(device);
  }

  void selectDevice(AppPrinterDevice device) async {
    if (selectedPrinter != null) {
      if ((device.address != selectedPrinter?.address) || (device.typePrinter == PrinterType.usb && selectedPrinter?.vendorId != device.vendorId)) {
        await printerManager.disconnect(type: getTypePrinter(selectedPrinter?.typePrinter));
      }
    }
    selectedPrinter = device;
    // connectToPrinter(device);
    update(); // Update the UI
  }

  Future<void> connectToPrinter(AppPrinterDevice device) async {
    selectedPrinter = device;
    await printerManager.connect(
      type: getTypePrinter(selectedPrinter?.typePrinter),
      model: BluetoothPrinterInput(
        name: selectedPrinter?.deviceName,
        address: selectedPrinter?.address ?? '',
        isBle: selectedPrinter?.isBle ?? false,
      ),
    );
    _isConnected.value = true;
  }

  Future<void> disconnectPrinter() async {
    if (selectedPrinter != null) {
      await printerManager.disconnect(type: getTypePrinter(selectedPrinter?.typePrinter));
      _isConnected.value = false;
    }
  }

  Future<Uint8List> generateInvoiceTest() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Invoice', style: pw.TextStyle(fontSize: 30)),
                pw.SizedBox(height: 20),
                pw.Text('Date: ${DateTime.now().toLocal()}'),
                pw.SizedBox(height: 20),
                pw.Text('Item 1: \$100.00'),
                pw.Text('Item 2: \$50.00'),
                pw.SizedBox(height: 20),
                pw.Text('Total: \$150.00', style: pw.TextStyle(fontSize: 20)),
              ],
            ),
          ); // Center
        },
      ),
    );

    return pdf.save();
  }
  Future<void> printTestTicket() async {
    if (selectedPrinter == null) return;

    List<int> bytes = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);

    // Add test print content
    bytes += generator.setGlobalCodeTable('CP1252');
    bytes += generator.text('Test Print', styles: const PosStyles(align: PosAlign.center));
    await printEscPos(bytes, generator,selectedPrinter);
    print("done..");
  }

  Future<void> printEscPos(List<int> bytes, Generator generator,AppPrinterDevice? printer) async {

    if (printer == null) return;

    switch (printer.typePrinter) {
      case 'usb':
        bytes += generator.feed(2);
        bytes += generator.cut();
        await printerManager.connect(
          type: PrinterType.usb,
          model: UsbPrinterInput(
            name: printer.deviceName,
            productId: printer.productId,
            vendorId: printer.vendorId,
          ),
        );
        pendingTask = null;
        break;
      case 'bluetooth':
        bytes += generator.feed(2);
        bytes += generator.cut();
        await printerManager.connect(
          type: PrinterType.bluetooth,
          model: BluetoothPrinterInput(
            name: printer.deviceName,
            address: printer.address ?? '',
            isBle: printer.isBle ?? false,
          ),
        );
        pendingTask = null;
        break;
      case 'network':
      case 'PrinterType.network':
        bytes += generator.feed(2);
        bytes += generator.cut();
        await printerManager.connect(
          type: PrinterType.network,
          model: TcpPrinterInput(ipAddress: printer.address ?? ''),
        );
        break;
      default:
    }
    //  if (printer.typePrinter == 'bluetooth' && Platform.isAndroid) {
    //   if (_currentStatus == BTStatus.connected) {
    //     printerManager.send(type: PrinterType.bluetooth, bytes: bytes);
    //     pendingTask = null;
    //   }
    // } else {
    //   printerManager.send(type: getTypePrinter(printer.typePrinter), bytes: bytes);
    // }
    try {
      printerManager.send(type: getTypePrinter(printer.typePrinter), bytes: bytes);
    } catch (e) {
      print(e);
    }
  }

  PrinterType getTypePrinter(String? typePrinter) {
    switch (typePrinter) {
      case 'usb':
        return PrinterType.usb;
      case 'bluetooth':
        return PrinterType.bluetooth;
      case 'network':
        return PrinterType.network;
      default:
        return GetPlatform.isDesktop ? PrinterType.network :PrinterType.bluetooth; // Default type
    }
  }

  String getTypePrinterString(PrinterType? typePrinter) {
    switch (typePrinter) {
      case PrinterType.usb:
        return 'usb';
      case PrinterType.bluetooth:
        return  'bluetooth';
      case PrinterType.network:
        return 'network';
      default:
        return 'bluetooth'; // Default type
    }
  }

}
