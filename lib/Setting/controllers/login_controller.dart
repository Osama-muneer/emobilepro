import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../Setting/models/bra_inf.dart';
import '../../Setting/models/sys_scr.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../Setting/models/config.dart';
import '../../Setting/models/gen_var.dart';
import '../../Setting/models/job_typ.dart';
import '../../Setting/models/sys_usr.dart';
import '../../Setting/models/sys_usr_b.dart';
import '../../Setting/models/sys_usr_p.dart';
import '../../Setting/models/sys_var.dart';
import '../../Setting/models/sys_yea.dart';
import '../../Widgets/config.dart';
import '../../database/setting_db.dart';
import '../../database/sync_db.dart';
import 'package:intl/intl.dart';
import 'package:network_info_plus/network_info_plus.dart';
import '../models/syn_tas.dart';
import '../services/api_provider_login.dart';

class LoginController extends GetxController {
  //TODO: Implement HomeController

  var isloading = false.obs;
  var isloadingHint = false.obs,CON_ACC_M=0;
  bool isloadingRemmberMy = false;
  bool isObscure_O = true;
  bool isObscure_N = true;
  bool isObscure_S = true;
  late FocusNode ipFocus;
  late FocusNode portFocus;
  late FocusNode count_synFocus;
  late FocusNode BIIDFocus;
  late FocusNode JTIDFocus;
  final loginformKey = GlobalKey<FormState>();
  DateTime time = DateTime.now();
  late final TextEditingController usernameController,
      passwordController,
      JTIDController,
      BIIDController,
      SYIDController,
      SYNOController,
      IPSERERController,
      PORTController,
      CountRECODEController,
      SUAP_OController,
      SUAP_NController,
      SUAP_SController;
  String? name = '',
      password = '',
      SelectDataJTID,
      SelectDataJTNA = '',
      SelectDataBINA = '',
      SelectDataSYSD = '',
      SelectDataSYED = '',
      SelectDataSYNA = '',
      SelectDataSUNA = '',
      SYNO_V = '',
      Y,
      E,
      F,
      BIID_ALL = '2',
      CON_ACC_ACT = '2',
      CON_ACC_TYP = '2',
      SOMID = '',
      newPath = '',
      CIID_V,
      SYDV_ID_V = '',
      SYDV_NO_V = '',
      SYN_TAS_GUID = '',
      SYDV_TY_V = 'Android',
      CIID_L;
  int SUPA_V = 0, SYST_V = 2, CHIKE_ALL=0,CHIKE_SYN_USR_TYP=0;
  int? JTID_L, BIID_L, SYID_L;
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusSYID = FocusNode();
  FocusNode myFocusSUPW = FocusNode();
  FocusNode myFocusSUPA = FocusNode();
  FocusNode myFocusSUPAN = FocusNode();
  late List<Bra_Inf_Local> BRA_INF_Data;
  late List<Bra_Inf_Local> GET_BIID_ONE;
  late List<Job_Typ_Local> GET_JTID_ONE;
  late List<Sys_Yea_Local> GET_SYID_ONE;
  late List<Sys_Yea_Local> GET_SYID_DATA;
  late List<Sys_Usr_P_Local> GET_SUNA_DATA;
  late List<Sys_Usr_Local> GET_SYS_USR;
  late List<Sys_Var_Local> SYS_VAR;
  late List<Gen_Var_Local> GEN_VAR;
  late List<Sys_Usr_P_Local> SYS_USR_P;
  late List<Sys_Usr_B_Local> SYS_USR_B;
  late List<Config_Local> GET_CONFIG_DATA;
  late List<Sys_Scr_Local> SYS_SCR;

  static LoginController instance = LoginController._();
  LoginController._();
  factory LoginController() {
    return instance;
  }
  var userDataBox;
  String _deviceMAC = '';
  String mac = '';
  final locale = Get.deviceLocale;
  String deviceName='';
  void configloading(String MESSAGE) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 5000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.grey[300]
      ..indicatorColor = Colors.black
      ..textColor = Colors.black
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = true;
    EasyLoading.showInfo(MESSAGE);
  }

  //دالة جلب  اسم التلفون(mode),serial number
  Future<void> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final info = NetworkInfo();

    String? identifier;
    String? macAddress = '';
    String? wifiBSSID;

    try {
      wifiBSSID = await info.getWifiBSSID(); // This may be used as MAC
      macAddress = wifiBSSID ?? '02:00:00:00:00:00';
    } catch (e) {
      macAddress = 'Error getting the MAC address.';
    }

    _deviceMAC = macAddress.replaceAll(':', '');
    update();

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      identifier = await UniqueIdentifier.serial;
      deviceName = iosDeviceInfo.identifierForVendor!;
      SYDV_TY_V = 'IOS';

      _deviceMAC.isEmpty || _deviceMAC.contains('020000000000')
          ? _deviceMAC = identifier ?? 'UNKNOWN'
          : _deviceMAC = _deviceMAC;

      update();
      SET_P('DeviceName', _deviceMAC);
      SET_P('DeviceID', deviceName);
      SET_P('SYDV_TY', SYDV_TY_V.toString());
    }
    else if (Platform.isAndroid) {
      identifier = await UniqueIdentifier.serial;
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceName = androidDeviceInfo.model.toString();
      SYDV_TY_V = 'Android';

      _deviceMAC.isEmpty || _deviceMAC.contains('020000000000')
          ? _deviceMAC = identifier ?? 'UNKNOWN'
          : _deviceMAC = _deviceMAC;

      update();
      SET_P('DeviceName', deviceName);
      SET_P('DeviceID', _deviceMAC.toUpperCase());
      SET_P('SYDV_TY', SYDV_TY_V.toString());
    } else {
      deviceName = 'Unknown';
    }
    print(deviceName);
    print(SYDV_TY_V.toString());
    print(_deviceMAC.toUpperCase());
    print('_deviceMAC.toUpperCase()');
    UpdateMOB_VAR(2, Platform.isAndroid ? _deviceMAC.toUpperCase() : deviceName.toUpperCase());
  }

  //دالة جلب ip adders
  getIP() async {
    // await Permission.location.request();
    final info = NetworkInfo();
    var hostAddress = await info.getWifiIP();
    SET_P('SYDV_IP',hostAddress.toString());
    return hostAddress.toString();
  }

  @override
  Future<void> onInit() async {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    BIIDController = TextEditingController();
    JTIDController = TextEditingController();
    SYIDController = TextEditingController();
    SYNOController = TextEditingController();
    IPSERERController = TextEditingController();
    PORTController = TextEditingController();
    CountRECODEController = TextEditingController();
    SUAP_OController = TextEditingController();
    SUAP_NController = TextEditingController();
    SUAP_SController = TextEditingController();
    myFocusNode = FocusNode();
    myFocusSYID = FocusNode();
    myFocusSUPW = FocusNode();
    myFocusSUPA = FocusNode();
    myFocusSUPAN = FocusNode();
    ipFocus = FocusNode();
    portFocus = FocusNode();
    count_synFocus = FocusNode();
    BIIDFocus = FocusNode();
    JTIDFocus = FocusNode();
    _addFocusListeners();
    GETMOB_VAR_P(1);
    GETMOB_VAR_P(2);
    GETMOB_VAR_P(3);
    GETMOB_VAR_P(4);
    GETMOB_VAR_P(5);
    APPVersion();
    getIP();
    if(CHIKE_ALL == 1){
      SelectDataJTID=LoginController().JTID.toString();
      BIIDController.text=LoginController().BIID.toString();
      SYIDController.text=LoginController().SYID.toString();
      SYNOController.text=LoginController().SYNO_V.toString();
      usernameController.text=LoginController().SUID.toString();
      Get_Bra_InfData();
      GET_SYID_Data();
      GET_SUNA();
      CONV_P(passwordController.text);
      CHIKE_USER_PAS();
      myFocusSUPW.requestFocus();
    }else{
      GET_JTID_ONEData();
    }
    GET_ACC_ACT_TYP();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    JTIDController.dispose();
    BIIDController.dispose();
    SYIDController.dispose();
    IPSERERController.dispose();
    PORTController.dispose();
    CountRECODEController.dispose();
    SYNOController.dispose();
    SUAP_OController.dispose();
    SUAP_NController.dispose();
    SUAP_SController.dispose();
    myFocusNode.dispose();
    myFocusSYID.dispose();
    myFocusSUPW.dispose();
    myFocusSUPA.dispose();
    myFocusSUPAN.dispose();
    ipFocus.dispose();
    portFocus.dispose();
    count_synFocus.dispose();
    BIIDFocus.dispose();
    JTIDFocus.dispose();
    super.dispose();
  }

  void _addFocusListeners() {
    ipFocus.addListener(update);
    portFocus.addListener(update);
    count_synFocus.addListener(update);
    BIIDFocus.addListener(update);
    myFocusNode.addListener(update);
    myFocusSYID.addListener(update);
    myFocusSUPW.addListener(update);
    JTIDFocus.addListener(update);
  }

  Future<void> initHive() async {
    await Hive.initFlutter();
    userDataBox = await Hive.openBox('userData');
  }

  String? validatePassword(String value) {
    if (value.trim().isEmpty) {
      isloading(true);
      return 'StringvalidatePassword'.tr;
    }
    return null;
  }

  String? validateBIID(String value) {
    if (value.trim().isEmpty) {
      return 'StringvalidateBIID'.tr;
    }
    return null;
  }

  String? validateSYID(String value) {
    if (value.trim().isEmpty) {
      return 'StringvalidateSYID'.tr;
    }
    return null;
  }

  String? validateUsername(String value) {
    if (value.trim().isEmpty) {
      return 'StringvalidateUsername'.tr;
    }
    return null;
  }

//دالة لجلب اول نشاط عند الدخول
  Future GET_JTID_ONEData() async {
    GET_JTID_ONE= await Get_Job_Typ_One();
    if (GET_JTID_ONE.isNotEmpty) {
      SelectDataJTID = GET_JTID_ONE.elementAt(0).JTID.toString();
      JTIDController.text = GET_JTID_ONE.elementAt(0).JTID.toString();
      SelectDataJTNA = GET_JTID_ONE.elementAt(0).JTNA.toString();
      await GET_BIID_ONEData();
      update();
      await GET_CIID();
      await USE_BIID_ALL();
      await GET_ACC_ACT_TYP();
      myFocusNode.requestFocus();
    }

  }

//دالة لجلب اول فرع عند الدخول
  Future GET_BIID_ONEData() async {
    await Get_Bra_Inf_One(int.parse(SelectDataJTID.toString())).then((data) {
      BRA_INF_Data = data;
      if (BRA_INF_Data.isNotEmpty) {
        BIIDController.text = BRA_INF_Data.elementAt(0).BIID.toString();
        SelectDataBINA = BRA_INF_Data.elementAt(0).BINA_D.toString();
        isloadingHint(true);
        update();
        GET_SYID_ONEData();
      }
    });
  }

//دالة لجلب السنة الفاعلة عند الدخول
  Future GET_SYID_ONEData() async {
    await Get_SYS_YEA_ONE(SelectDataJTID.toString(), BIIDController.text).then((data) {
      if (data.isNotEmpty) {
        GET_SYID_ONE = data;
        SYIDController.text = GET_SYID_ONE.elementAt(0).SYID.toString();
        SYNOController.text = GET_SYID_ONE.elementAt(0).SYNO.toString();
        SYNO_V = GET_SYID_ONE.elementAt(0).SYNO.toString();
        SelectDataSYSD = GET_SYID_ONE.elementAt(0).SYSD.toString().substring(0, 11);
        SelectDataSYED = GET_SYID_ONE.elementAt(0).SYED.toString().substring(0, 11);
        SelectDataSYNA = '($SelectDataSYED)-($SelectDataSYSD)';
        isloadingHint(true);
        update();
      }
    });
  }

//جلب رقم العميل CIID
  Future GET_CIID() async {
    await GET_GEN_VAR_ACC('CIID').then((data) {
      GEN_VAR = data;
      if (GEN_VAR.isNotEmpty) {
        CIID_V = GEN_VAR.elementAt(0).VAL.toString();
      }
    });
  }

//جلب صلاحية العمل على الفروع باستخدام قاعدة بيانات مستقله لكل فرع
  Future USE_BIID_ALL() async {
    await GET_GEN_VAR_ACC('BIID_TYP').then((data) {
      GEN_VAR = data;
      if (GEN_VAR.isNotEmpty) {
        BIID_ALL = GEN_VAR.elementAt(0).VAL.toString();
      }
    });
  }

  //ميزة التجكم بالوصول
  Future GET_ACC_ACT_TYP() async {
    GEN_VAR= await GET_GEN_VAR('CON_ACC_ACT');
    if (GEN_VAR.isNotEmpty) {
      CON_ACC_ACT = GEN_VAR.elementAt(0).VAL.toString();
    }else{
      CON_ACC_ACT='2';
    }
    GEN_VAR= await GET_GEN_VAR('CON_ACC_TYP');
    if (GEN_VAR.isNotEmpty) {
      CON_ACC_TYP = GEN_VAR.elementAt(0).VAL.toString();
    }
    GEN_VAR= await GET_GEN_VAR('SOMID');
    if (GEN_VAR.isNotEmpty) {
      SOMID = GEN_VAR.elementAt(0).VAL.toString();
    }
  }

  //جلب الفروع واسم الفرع
  Future Get_Bra_InfData() async {
    BRA_INF_Data= await Get_Bra_Inf(int.parse(SelectDataJTID.toString()),int.parse(BIIDController.text));
    if (BRA_INF_Data.isNotEmpty) {
      SelectDataBINA = BRA_INF_Data.elementAt(0).BINA_D.toString();
      BIIDController.text = BRA_INF_Data.elementAt(0).BIID.toString();
      isloadingHint(true);
      update();
      await CHIKE_USER_PAS();
    } else {
      SelectDataBINA = '';
      isloadingHint(false);
      update();
    }
  }

  //جلب اسم السنة
  Future GET_SYID_Data() async {
    GET_SYID_ONE=  await Get_SYS_YEA(1, JTIDController.text, BIIDController.text,SYNOController.text.toString());

    if (GET_SYID_ONE.isNotEmpty) {
      SYIDController.text = GET_SYID_ONE.elementAt(0).SYID.toString();
      SYNO_V = GET_SYID_ONE.elementAt(0).SYNO.toString();
      SelectDataSYSD = GET_SYID_ONE.elementAt(0).SYSD.toString().substring(0, 11);
      SelectDataSYED = GET_SYID_ONE.elementAt(0).SYED.toString().substring(0, 11);
      SelectDataSYNA = '($SelectDataSYED)-($SelectDataSYSD)';
      isloadingHint(true);
      update();
      await CHIKE_USER_PAS();
    }
    else {
      GET_SYID_ONE=  await Get_SYS_YEA(2, JTIDController.text, BIIDController.text,
          SYNOController.text.toString());

      if (GET_SYID_ONE.isNotEmpty) {
        SYIDController.text = GET_SYID_ONE.elementAt(0).SYID.toString();
        SYNO_V = GET_SYID_ONE.elementAt(0).SYNO.toString();
        SelectDataSYSD =
            GET_SYID_ONE.elementAt(0).SYSD.toString().substring(0, 11);
        SelectDataSYED =
            GET_SYID_ONE.elementAt(0).SYED.toString().substring(0, 11);
        SelectDataSYNA = '($SelectDataSYED)-($SelectDataSYSD)';
        isloadingHint(true);
        update();
        await CHIKE_USER_PAS();
      } else {
        SelectDataSYNA = '';
        isloadingHint(false);
        update();
      }

      SelectDataSYNA = '';
      isloadingHint(false);
      update();
    }

  }

  //جلب اسم المستخدم
  Future GET_SUNA() async {
    GET_SUNA_DATA=  await Get_SUNA(1,int.parse(SelectDataJTID.toString()),
        int.parse(BIIDController.text), usernameController.text);
    if (GET_SUNA_DATA.isNotEmpty) {
      SelectDataSUNA = GET_SUNA_DATA.elementAt(0).SUNA_D.toString();
      isloadingHint(true);
      update();
    }
    else {
      await Get_SUNA(2,int.parse(SelectDataJTID.toString()),
          int.parse(BIIDController.text), usernameController.text).then((data) {
        if (data.isNotEmpty) {
          GET_SUNA_DATA = data;
          SelectDataSUNA = GET_SUNA_DATA.elementAt(0).SUNA_D.toString();
          isloadingHint(true);
          update();
        }
        else {
          SelectDataSUNA = '';
          isloadingHint(false);
          update();
        }
      });
    }
  }

  //تغيير الارقام من عربي الى انجليزي
  String arabicToEnglish(String number) {
    var arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    var englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    for (var i = 0; i < arabicDigits.length; i++) {
      number = number.replaceAll(arabicDigits[i], englishDigits[i]);
    }
    return number;
  }

  //فك تشفير كلمة المرور
  Future CONV_P(String F_PAS) async {
    String ara= arabicToEnglish(F_PAS);
    print(F_PAS);
    print(ara);
    print('arabicToEnglish');
    int X;
    SUPA_V = 0;
    X = (F_PAS.length) + 1;
    for (int i = 1; i < X; i++) {
      print(
          ' ASCII value of ${ara[i - 1]} is ${SUPA_V = (SUPA_V + ara.codeUnitAt(i - 1)) * (i + 1)}');
    }
    print(' ASCII value of ${ara} is ${(SUPA_V)}');
  }


  Future UPDATEMOB_VAR_P(int CountRECODE) async {
    if(CountRECODE<50 || CountRECODE.isNull){
      CountRECODE=150;
    }
    else if(CountRECODE>500){
      CountRECODE=500;
    }
    UpdateMOB_VAR(1,CountRECODE);
  }

  // جلب عدد السجلات للمزامنه
  Future GETMOB_VAR_P(int GETMVID) async {
    var MVVL=await GETMOB_VAR(GETMVID);
    if(MVVL.isNotEmpty){
      if(GETMVID==1){
        MVVL.elementAt(0).MVVL.toString()=='null'?
        CountRECODEController.text='150'
            : CountRECODEController.text=MVVL.elementAt(0).MVVL.toString();
      }
      else if(GETMVID==2){
        print(MVVL.elementAt(0).MVVL.toString());
        print('MVVL.toString()');
        if(MVVL.elementAt(0).MVVL.toString()=='null'){
          getDeviceInfo();
        }
        else{
          print(MVVL.elementAt(0).MVVL.toString());
          print('MVVL.toString()jj');
          SET_P('DeviceID',MVVL.elementAt(0).MVVL.toString());
        }
      }
      else if(GETMVID==3) {
        print(MVVL.elementAt(0).MVVL.toString());
        print('MVVL.toString()SUID');
        if (MVVL.elementAt(0).MVVL.toString() != 'null') {
          SET_P('SUID', MVVL.elementAt(0).MVVL.toString());
        }
      }
      else if(GETMVID==4) {
        print(MVVL.elementAt(0).MVVL.toString());
        print('MVVL.toString()SYDV_ID');
        if (MVVL.elementAt(0).MVVL.toString() != 'null') {
          SET_P('SYDV_ID', MVVL.elementAt(0).MVVL.toString());
        }
      }
      else if(GETMVID==5) {
        print(MVVL.elementAt(0).MVVL.toString());
        print('MVVL.toString()SYDV_NO');
        if (MVVL.elementAt(0).MVVL.toString() != 'null') {
          SET_P('SYDV_NO', MVVL.elementAt(0).MVVL.toString());
        }
      }
    }
    else{
      if(GETMVID==1){
        CountRECODEController.text='150';
      }else if(GETMVID==2){
        getDeviceInfo();
      }
    }
  }


  //التحكم بالوصول
  Future<dynamic> GET_CON_ACC_M_P() async {
    var ERR_TYP_N=1,MSG_O_V='ERROR';
    if(CON_ACC_ACT=='1'){
      CON_ACC_M= await GET_CON_ACC_M(STMID: STMID,CIID: CIID,JTID:SelectDataJTID.toString(),
          BIID:BIID_ALL=='2'?'0':BIID.toString(),SUID: usernameController.text,SOMSN: DeviceID.toString(),SOMID: SOMID);
      print('CON_ACC_M');
      print(CON_ACC_M);
      if(CON_ACC_M<1 && CON_ACC_TYP=='1'){
        ERR_TYP_N=2;
        MSG_O_V='المستخدم او الجهاز الذي يريد الوصول للنظام ليس ضمن القائمة البيضاء .. لايمكن المتابعة';
        return (ERR_TYP_N,MSG_O_V);
      }
      else if(CON_ACC_M<1 && CON_ACC_TYP=='2'){
        ERR_TYP_N=2;
        MSG_O_V='المستخدم او الجهاز الذي يريد الوصول للنظام ضمن القائمه السوداء .. لايمكن المتابعة';
        return (ERR_TYP_N,MSG_O_V);
      }
      else{
        ERR_TYP_N=1;
        MSG_O_V='';
        return (ERR_TYP_N,MSG_O_V);
      }
    }else{
      ERR_TYP_N=1;
      MSG_O_V='';
      return (ERR_TYP_N,MSG_O_V);
    }
  }

  //التحقق من كلمة المرور والمستخدم
  Future CHIKE_USER_PAS() async {
    SYS_USR_P= await CHK_USR_PAW(1, usernameController.text, SUPA_V.toString(),
        int.parse(JTIDController.text), int.parse(BIIDController.text),SYNOController.text.toString());
    if (SYS_USR_P.isEmpty) {
      SYS_USR_P=await CHK_USR_PAW(2,usernameController.text, SUPA_V.toString(),
          int.parse(JTIDController.text), int.parse(BIIDController.text),SYNOController.text.toString());
      if (SYS_USR_P.isEmpty) {
        SYS_USR_P=await  CHK_USR_PAW(3,usernameController.text, SUPA_V.toString(),
            int.parse(JTIDController.text), int.parse(BIIDController.text),SYNOController.text.toString());
      }
    }
  }

  Future GET_CONFIG_P() async {
    GET_CONFIG(int.parse(SelectDataJTID.toString()), int.parse(SYIDController.text),
        int.parse(BIIDController.text), CIID_V.toString()).then((data) {
      if (data.isEmpty) {
        Config_Local e = Config_Local(
            JTID: int.parse(SelectDataJTID.toString()),
            BIID: int.parse(BIIDController.text),
            SYID: int.parse(SYIDController.text),
            CIID: CIID_V.toString(),
            DATEI: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
            CHIKE_ALL: 0,
            STMID: STMID,
            SYDV_NAME: deviceName,
            SYDV_TY: SYDV_TY_V,
            SYDV_SER: _deviceMAC,
            SYDV_APPV: SYDV_APPV,
            SYST: 2);
        SaveCONFIG(e);
        JTID_L = int.parse(SelectDataJTID.toString());
        SYID_L = int.parse(SYIDController.text);
        BIID_L = int.parse(BIIDController.text);
        CIID_L = CIID_V.toString();
        SYST_V = 2;
        CHIKE_ALL = 0;
      } else {
        GET_CONFIG_DATA = data;
        JTID_L = GET_CONFIG_DATA.elementAt(0).JTID;
        SYID_L = GET_CONFIG_DATA.elementAt(0).SYID;
        BIID_L = GET_CONFIG_DATA.elementAt(0).BIID;
        CIID_L = GET_CONFIG_DATA.elementAt(0).CIID.toString();
        SYST_V = GET_CONFIG_DATA.elementAt(0).SYST!;
        CHIKE_ALL = GET_CONFIG_DATA.elementAt(0).CHIKE_ALL!;
      }
    });
  }

  bool isValuePresent(String values, int valueToCheck) {
    // تحويل القيمة إلى سلسلة بالشكل المناسب
    String valueStr = '<$valueToCheck>';
    // التحقق مما إذا كانت القيمة موجودة في السلسلة
    return values.contains(valueStr);

  }

  //التحقق من النشاط او الفرع او السنه لم تتغيير
  Future CHIKE_BRA() async {
    if (CHIKE_ALL == 0) {
      print('CHIKE_ALL');
      SET_N_P('CHIKE_ALL_MAIN',0);
      configloading('StringSureBIID'.tr);
    }
  }

  //التحقق من المستخدم
  Future CHIKE_SYN_USR_TYP_P() async {
    GET_GEN_VAR('SYN_USR_TYP').then((data) {
      GEN_VAR = data;
      if (GEN_VAR.isNotEmpty) {
        print(CHIKE_SYN_USR_TYP);
        print('CHIKE_SYN_USR_TYP1');
        // اختبار القيم
        if(isValuePresent(GEN_VAR.elementAt(0).VAL.toString(), int.parse(SUID)) ){
          CHIKE_SYN_USR_TYP=1;
          print(CHIKE_SYN_USR_TYP);
          print('CHIKE_SYN_USR_TYP2');
        }
        else{
          print(int.parse(usernameController.text));
          print(int.parse(SUID));
          print('int.parse(SUID)');
          print(CHIKE_SYN_USR_TYP);
          print('CHIKE_SYN_USR_TYP3');
          if(int.parse(usernameController.text)!=int.parse(SUID)){
            CHIKE_SYN_USR_TYP=0;
            SET_N_P('CHIKE_ALL_MAIN',0);
          }else{
            CHIKE_SYN_USR_TYP=1;
          }
        }
        print(CHIKE_SYN_USR_TYP);
        print('CHIKE_SYN_USR_TYP4');
      }
      else{
        CHIKE_SYN_USR_TYP=1;
        print(CHIKE_SYN_USR_TYP);
        print('CHIKE_SYN_USR_TYP5');
      }
      print(CHIKE_ALL);
      print(CHIKE_SYN_USR_TYP);
      print('CHIKE_SYN_USR_TYP6');
      CHIKE_SYN_USR_TYP=CHIKE_ALL == 0 ?  0 : CHIKE_SYN_USR_TYP;
      print(CHIKE_SYN_USR_TYP);
      print('CHIKE_SYN_USR_TYP7');
    });
  }


  //زر الدخول
  Login() async {
    var ERR_TYP=1,MSG_V='';
    GET_CONFIG_P();
    CHIKE_SYN_USR_TYP_P();
    (ERR_TYP,MSG_V)=await GET_CON_ACC_M_P();
    // if ((usernameController.text == '123456' &&
    //     passwordController.text == '123456') ||
    //     (usernameController.text == '654321' &&
    //         passwordController.text == '654321')) {
    //   LoginController().SET_N_P('experimentalcopy',1);
    //   usernameController.text == '123456' && passwordController.text == '123456'
    //       ? LoginController().SET_N_P('experimentalcopyType',1)
    //       : LoginController().SET_N_P('experimentalcopyType',2);
    //   update();
    //   Get.offAllNamed('/Home');
    //   SET_B_P('RemmberMy',isloadingRemmberMy);
    //   SET_P('JTNA',SelectDataJTNA.toString());
    //   SET_P('BINA',SelectDataBINA.toString());
    // }
   // else {
      bool isValidate = loginformKey.currentState!.validate();
      if (isValidate == false) {
        isloading(false);
      } else {
        try {
          isloading.value = true;
          await Future.delayed(const Duration(seconds: 1));
          update();
          print('SYS_VER');
          print(SYS_VER);
          if (SYS_VER <= 447) {
            Get.snackbar('StringMestitle'.tr, 'StringCHK_SYS_VER'.tr,
                backgroundColor: Colors.red,
                icon: const Icon(Icons.error, color: Colors.white),
                colorText: Colors.white,
                isDismissible: true,
                dismissDirection: DismissDirection.horizontal,
                forwardAnimationCurve: Curves.easeOutBack);
            isloading.value = false;
            update();
          }
          else if (double.parse(API_VER) < 0) {
            Get.snackbar('StringMestitle'.tr, 'StringCHK_API_VER'.tr,
                backgroundColor: Colors.red,
                icon: const Icon(Icons.error, color: Colors.white),
                colorText: Colors.white,
                isDismissible: true,
                dismissDirection: DismissDirection.horizontal,
                forwardAnimationCurve: Curves.easeOutBack);
            isloading.value = false;
            update();
          }
          else if (BRA_INF_Data.isEmpty) {
            Get.snackbar('StringErrorBIID'.tr, 'StringCHK_BIID'.tr,
                backgroundColor: Colors.red,
                icon: const Icon(Icons.error, color: Colors.white),
                colorText: Colors.white,
                isDismissible: true,
                dismissDirection: DismissDirection.horizontal,
                forwardAnimationCurve: Curves.easeOutBack);
            isloading.value = false;
            update();
          }
          else if (GET_SYID_ONE.isEmpty) {
            Get.snackbar('StringErrorSYID'.tr, 'StringCHK_SYID'.tr,
                backgroundColor: Colors.red,
                icon: const Icon(Icons.error, color: Colors.white),
                colorText: Colors.white,
                isDismissible: true,
                dismissDirection: DismissDirection.horizontal,
                forwardAnimationCurve: Curves.easeOutBack);
            isloading.value = false;
            update();
          }
          else if (SYS_USR_P.isEmpty) {
            Get.snackbar('StringError_USER_PASS'.tr, 'StringCHK_USER_PASS'.tr,
                backgroundColor: Colors.red,
                icon: const Icon(Icons.error, color: Colors.white),
                colorText: Colors.white,
                isDismissible: true,
                dismissDirection: DismissDirection.horizontal,
                forwardAnimationCurve: Curves.easeOutBack);
            // await Future
            isloading.value = false;
            update();
          }
          else if (CON_ACC_ACT=='1' && ERR_TYP==2) {
            Get.snackbar('خطأ', MSG_V,
                backgroundColor: Colors.red,
                icon: const Icon(Icons.error, color: Colors.white),
                colorText: Colors.white,
                isDismissible: true,
                dismissDirection: DismissDirection.horizontal,
                forwardAnimationCurve: Curves.easeOutBack);
            // await Future
            isloading.value = false;
            update();
          }
          else {
            UpdateMOB_VAR_CONFIG();
            CHIKE_BRA();
            SET_P('CIID',CIID_V.toString());
            SET_P('BIID_ALL',BIID_ALL.toString());
            SET_N_P('JTID',int.parse(SelectDataJTID.toString()));
            SET_N_P('BIID',int.parse(BIIDController.text));
            SET_N_P('SYID',int.parse(SYIDController.text));
            SET_P('SYNO',SYNO_V.toString());
            SET_P('SUID',usernameController.text);
            UpdateMOB_VAR(3,usernameController.text);
            SET_P('SUNA',SelectDataSUNA.toString());
            SET_P('SUPA',SUPA_V.toString());
            SET_P('API',baseApi == 'http://192.168.0.0:5000' ? API : baseApi);
            SET_P('USERDB','ACC${SelectDataJTID}_${BIIDController.text}_${SYIDController.text}');
            SET_P('APPV',SYDV_APPV);
            SET_P('JTNA',SelectDataJTNA.toString());
            SET_P('BINA',SelectDataBINA.toString());
            SET_B_P('RemmberMy',isloadingRemmberMy);
            SET_B_P('value_Cus',false);
            loginformKey.currentState!.save;
            isloading.value = true;
            update();
            UpdateMOB_VAR_SYID(int.parse(SYIDController.text));
            if ((CHIKE_ALL == 0 && SYST_V == 2) || CHIKE_SYN_USR_TYP==0) {
              CHIKE_SYN_USR_TYP==0 && (CHIKE_ALL != 0 && SYST_V != 2) ? configloading('StringSureSUID'.tr):false;
              Get.toNamed('/Sync');
              if (ChkLogin == 0) {
                SET_N_P('BIID_SALE',0);
                SET_N_P('SIID_SALE',0);
                SET_N_P('SCID_SALE',0);
                SET_N_P('PKID_SALE',0);
                SET_D_P('SCEX_SALE',0);
                SET_P('SCSY_SALE','0');
                SET_N_P('SCSFL_SALE',0);
                SET_N_P('BIID_Voucher',0);
                SET_N_P('SCID_Voucher',0);
                SET_N_P('ACID_Voucher',0);
                SET_N_P('ABID_Voucher',0);
                SET_N_P('BCCID_Voucher',0);
                SET_N_P('PKID_Voucher',0);
                SET_N_P('SCSFL_Voucher',0);
                SET_D_P('SCEX_Voucher',0);
                SET_P('SCSY_Voucher','0');
                SET_P('BIID_STA_F','0');
                SET_P('BIID_STA_T','0');
                SET_N_P('BIID_Cus',0);
                SET_N_P('BCTID_Cus',0);
                SET_N_P('ATTID_Cus',0);
                SET_N_P('BCPR_Cus',0);
                SET_N_P('PKID_Cus',0);
                SET_N_P('BAID_Cus',0);
                SET_P('CWID_Cus','0');
                SET_P('CTID_Cus','0');
                DeleteALLDataTMP('SYN_ORD');
                configloading('StringFrist_Login'.tr);
                SET_N_P('ChkLogin',1);
              }
            }
            else {
              LoginController().SET_N_P('CHIKE_ALL_MAIN',1);
              Get.offAllNamed('/Home');
            }
          }
        } finally {
          isloading(false);
        }
      }
   // }
  }


  void SET_P(String GETTYPE,String GET_V) async {
    return userDataBox.put(GETTYPE, GET_V);
  }

  void SET_B_P(String GETTYPE,bool GET_V) async {
    return userDataBox.put(GETTYPE, GET_V);
  }

  void SET_N_P(String GETTYPE,int GET_V) async {
    return userDataBox.put(GETTYPE, GET_V);
  }

  void SET_D_P(String GETTYPE,double GET_V) async {
    return userDataBox.put(GETTYPE, GET_V);
  }


  int get BIID_SALE => userDataBox.get('BIID_SALE', defaultValue: 0);
  int get SIID_SALE => userDataBox.get('SIID_SALE', defaultValue: 0);
  int get PKID_SALE => userDataBox.get('PKID_SALE', defaultValue: 0);
  int get SCID_SALE => userDataBox.get('SCID_SALE', defaultValue: 0);
  double get SCEX_SALE => userDataBox.get('SCEX_SALE', defaultValue: 1.0);
  String get SCSY_SALE => userDataBox.get('SCSY_SALE', defaultValue: '0');
  String get SYN_USR_TYP => userDataBox.get('SYN_USR_TYP', defaultValue: '<1>');
  int get SCSFL_SALE => userDataBox.get('SCSFL_SALE', defaultValue: 2);
  int get ACID_SALE => userDataBox.get('ACID_SALE', defaultValue: 0);
  int get ABID_SALE => userDataBox.get('ABID_SALE', defaultValue: 0);
  int get BCCID_SALE => userDataBox.get('BCCID_SALE', defaultValue: 0);
  int get BDID_SALE => userDataBox.get('BDID_SALE', defaultValue: 0);
  int get BPPR => userDataBox.get('BPPR', defaultValue: 1);
  String get RSID => userDataBox.get('RSID',defaultValue:'');
  String get ACNO_SALE => userDataBox.get('ACNO_SALE',defaultValue:'0');
  String get ACNO_VOU => userDataBox.get('ACNO_VOU',defaultValue:'0');


  //السنداااااااااات

  int get BIID_Voucher => userDataBox.get('BIID_Voucher', defaultValue: 0);
  int get ACID_Voucher => userDataBox.get('ACID_Voucher', defaultValue: 0);
  int get ABID_Voucher => userDataBox.get('ABID_Voucher', defaultValue: 0);
  int get BCCID_Voucher => userDataBox.get('BCCID_Voucher', defaultValue: 0);
  int get PKID_Voucher => userDataBox.get('PKID_Voucher', defaultValue: 0);
  int get SCID_Voucher => userDataBox.get('SCID_Voucher', defaultValue: 0);
  double get SCEX_Voucher => userDataBox.get('SCEX_Voucher', defaultValue: 0.0);
  String get SCSY_Voucher => userDataBox.get('SCSY_Voucher', defaultValue: '0');
  int get SCSFL_Voucher => userDataBox.get('SCSFL_Voucher', defaultValue: 2);
  //السنداااااااااات

  //العملاء


  int get BIID_Cus => userDataBox.get('BIID_Cus', defaultValue: 0);
  int get BCTID_Cus => userDataBox.get('BCTID_Cus', defaultValue: 0);
  int get ATTID_Cus => userDataBox.get('ATTID_Cus', defaultValue: 0);
  int get BDID_Cus => userDataBox.get('BDID_Cus', defaultValue: 0);
  String get CWID_Cus => userDataBox.get('CWID_Cus', defaultValue: '0');
  String get CTID_Cus => userDataBox.get('CTID_Cus', defaultValue: '0');
  int get BAID_Cus => userDataBox.get('BAID_Cus', defaultValue: 0);
  int get BCPR_Cus => userDataBox.get('BCPR_Cus', defaultValue: 0);
  int get PKID_Cus => userDataBox.get('PKID_Cus', defaultValue: 0);
  bool get value_Cus => userDataBox.get('value_Cus', defaultValue: false);
  bool get InstallAddAfterSaving => userDataBox.get('InstallAddAfterSaving', defaultValue: false);
  //العملاء

  String get BIID_STA_F => userDataBox.get('BIID_STA_F', defaultValue: '0');
  String get BIID_STA_T => userDataBox.get('BIID_STA_T', defaultValue: '0');

  bool get isTaskScheduled => userDataBox.get('isSyncTaskScheduled', defaultValue: false);
  int get experimentalcopy => userDataBox.get('experimentalcopy', defaultValue: 0);
  int get Chkexperimentalcopy => userDataBox.get('Chkexperimentalcopy', defaultValue: 0);
  int get experimentalcopyType => userDataBox.get('experimentalcopyType', defaultValue: 1);
  int get ChkLogin => userDataBox.get('ChkLogin', defaultValue: 0);
  int get JTID => userDataBox.get('JTID', defaultValue: -1);
  int get BIID => userDataBox.get('BIID', defaultValue: -1);
  int get SYID => userDataBox.get('SYID', defaultValue: -1);
  String get SYNO => userDataBox.get('SYNO');
  int get Timer_Strat => userDataBox.get('Timer_Strat', defaultValue: 2);
  int get CHIKE_ALL_MAIN => userDataBox.get('CHIKE_ALL_MAIN', defaultValue: 0);
  String get SUID => userDataBox.get('SUID', defaultValue: '');
  String get DeviceID => userDataBox.get('DeviceID',defaultValue: '0');
  String get DeviceName => userDataBox.get('DeviceName',defaultValue: ' ');
  String get SYDV_IP => userDataBox.get('SYDV_IP', defaultValue: IP);
  String get SUNA => userDataBox.get('SUNA', defaultValue: '');
  String get SUPA => userDataBox.get('SUPA', defaultValue: '');
  int get LAN => userDataBox.get('LAN', defaultValue: 0);
  String get APPV => userDataBox.get('APPV', defaultValue: SYDV_APPV);
  String get CIID => userDataBox.get('CIID', defaultValue: '-1');
  String get SYDV_NO => userDataBox.get('SYDV_NO', defaultValue: '');
  String get SYDV_ID => userDataBox.get('SYDV_ID', defaultValue: '');
  String get SYDV_TY => userDataBox.get('SYDV_TY', defaultValue: SYDV_TY_V);
  String get API => userDataBox.get('API', defaultValue: '');
  String get baseApi => userDataBox.get('baseApi', defaultValue: 'http://$StringIP:$StringPort');
  String get IP => userDataBox.get('IP', defaultValue: '$StringIP');
  String get PORT => userDataBox.get('PORT', defaultValue: '5000');
  String get BIID_ALL_V => userDataBox.get('BIID_ALL', defaultValue: BIID_ALL);
  String get JTNA => userDataBox.get('JTNA', defaultValue: SelectDataJTNA);
  String get BINA => userDataBox.get('BINA', defaultValue: SelectDataBINA);
  bool get RemmberMy => userDataBox.get('RemmberMy', defaultValue: false);
  String get USERDB => userDataBox.get('USERDB', defaultValue: 'ACC${SelectDataJTID}-${BIIDController.text}-${SYIDController.text}');
  bool get InstallData => userDataBox.get('InstallData', defaultValue: false);
  String get BIID_V => userDataBox.get('BIID_V', defaultValue: BIID.toString());
  String get SCID_V => userDataBox.get('SCID_V',defaultValue: '1');
  String get AppPath => userDataBox.get('AppPath',defaultValue: '');
  String get SIID_V => userDataBox.get('SIID_V');
  int get BMMID => userDataBox.get('BMMID');
  String get Printer_Name => userDataBox.get('Printer_Name');
  String? get PKID1 => userDataBox.get('PKID1');
  String get SOSI => userDataBox.get('SOSI',defaultValue:'0');
  String get PKID2 => userDataBox.get('PKID2');
  String get SSDA => userDataBox.get('SSDA', defaultValue: 'فاتورة مبيعات عدادات');
  String get SSDE => userDataBox.get('SSDE', defaultValue: 'Counter Sales Invoice');
  String get SSDA2 => userDataBox.get('SSDA2', defaultValue: 'ترحيل مبيعات العدادات');
  String get SSDE2 => userDataBox.get('SSDE2', defaultValue: 'Counter Sale Posting/Approving');
  int get BMMDN_LIST => userDataBox.get('BMMDN_LIST', defaultValue: 0);
  String get BPID_V => userDataBox.get('BPID_V',defaultValue: 'null');
  int get SYS_VER => userDataBox.get('SYS_VER', defaultValue: 442);
  String get API_VER => userDataBox.get('API_VER', defaultValue: '2');
  int get TIMER_POST => userDataBox.get('TIMER_POST', defaultValue: 0);
  String get Return_Type => userDataBox.get('Return_Type', defaultValue: '1');
  String get Image_Type => userDataBox.get('Image_Type', defaultValue: '1');
  bool get Service_isRunning => userDataBox.get('Service_isRunning', defaultValue: false);
  int get BCST_LIST => userDataBox.get('BCST_LIST', defaultValue: 0);
  String get BIIDL_N => userDataBox.get('BIIDL_N', defaultValue: '0');
  String get SCHEMA_V => userDataBox.get('SCHEMA_V', defaultValue: 'ACC1_0');
  int get TTID_N => userDataBox.get('TTID_N', defaultValue: 1);
  String get USE_VAT_N => userDataBox.get('USE_VAT_N', defaultValue: '2');
  int get USE_E_INV_N => userDataBox.get('USE_E_INV_N', defaultValue: 2);
  int get USE_FAT_P_N => userDataBox.get('USE_FAT_P_N', defaultValue: 2);
  String get USE_FAT_P_D => userDataBox.get('USE_FAT_P_D', defaultValue: 'null');
  int get USE_FAT_S_N => userDataBox.get('USE_FAT_S_N', defaultValue: 2);
  String get USE_FAT_S_D => userDataBox.get('USE_FAT_S_D', defaultValue: 'null');
  String get DAT_TIM_FRM_V => userDataBox.get('DAT_TIM_FRM_V', defaultValue: 'yyyy-MM-dd HH:mm:ss');
  String get DAT_FRM_V => userDataBox.get('DAT_FRM_V', defaultValue: 'yyyy-MM-dd');
  String get TIM_FRM_V => userDataBox.get('TIM_FRM_V', defaultValue:'HH:mm:ss');
  String get SIGN_N => userDataBox.get('SIGN_N', defaultValue: '2');
  String get GET_VAR_P => userDataBox.get('GET_VAR_P', defaultValue: '');
  String get SOMGU => userDataBox.get('SOMGU', defaultValue: '');
  int get SSID_N => userDataBox.get('SSID_N', defaultValue: 601);
  int get SCSFL_TX => userDataBox.get('SCSFL_TX', defaultValue: 3);
  int get crossAxisCountMAT_INF => userDataBox.get('crossAxisCountMAT_INF', defaultValue: 2);

  String get CTMID_V => userDataBox.get('CTMID_V');
  String get BCNA_V => userDataBox.get('BCNA', defaultValue: '');
  String get BCCID_V => userDataBox.get('BCCID', defaultValue: '');
  String get BCCNA_V => userDataBox.get('BCCNA', defaultValue: '');
  String get BCID_V => userDataBox.get('BCID', defaultValue: '');
  String get AANO_V => userDataBox.get('AANO', defaultValue: '');
  String get GUIDC_V => userDataBox.get('GUIDC', defaultValue: '');
  String get CTMTY_V => userDataBox.get('CTMTY_V');
  String get PKID_COU => userDataBox.get('PKID_COU');
  String get INF1 => userDataBox.get('INF1',defaultValue: '');
  String get USE_WS => userDataBox.get('USE_WS',defaultValue: '2');
  String get IS_WA_DELAY_TIM => userDataBox.get('IS_WA_DELAY_TIM',defaultValue: '2');
  String get MAI_COU => userDataBox.get('MAI_COU',defaultValue: '1');
  String get MS_T => userDataBox.get('MS_T',defaultValue: 'Elite');
  String get ADD_DET_MESSAGE => userDataBox.get('ADD_DET_MESSAGE',defaultValue: '1');
  String get COM_NAM_MESS => userDataBox.get('COM_NAM_MESS',defaultValue: 'ايليت');
  String get ADD_ITEM_MESS => userDataBox.get('ADD_ITEM_MESS',defaultValue: '2');
  String get ITEM_MESS_INCLUDE => userDataBox.get('ITEM_MESS_INCLUDE',defaultValue: '');
  String get isWhatsAppAccountVerified => userDataBox.get('isWhatsAppAccountVerified',defaultValue: '2');
  String get CON_SAV_N => userDataBox.get('CON_SAV_N',defaultValue: '2');
  String get base64Pdf => userDataBox.get('base64Pdf',defaultValue: '');
  String get fileName => userDataBox.get('fileName',defaultValue: '');
  String get TYPE_DOC => userDataBox.get('TYPE_DOC',defaultValue: '');
  String get CONVERT_FILE_TO_IMAGE => userDataBox.get('CONVERT_FILE_TO_IMAGE',defaultValue: '2');
  String get SNED_IMAGE_DOC => userDataBox.get('SNED_IMAGE_DOC',defaultValue: '2');
  bool get IncludeAdditionalSyncing => userDataBox.get('IncludeAdditionalSyncing',defaultValue: false);

  Future<void> APPVersion() async {
    // Get the directory based on the platform
    Directory directory;

    // Use the application's documents directory for both platforms
    final appDocDir = await getApplicationDocumentsDirectory();
    directory = Directory('${appDocDir.path}/Media');

    // Log the application documents directory for debugging
    print('appDocDir: ${appDocDir.path}');
    print('Media directory: ${directory.path}');

    // Create the directory if it does not exist
    await directory.create(recursive: true);

    // Check for the existence of the .nomedia file
    final nomediaFile = File('${directory.path}/.nomedia');
    if (!await nomediaFile.exists()) {
      // If the file does not exist, set the app path accordingly
      SET_P('AppPath','${directory.path}/');
      print('AppPath111'); // Example log
    } else {
      // If the file exists, set the alternative app path
      SET_P('AppPath','${directory.path}/');
      print('AppPath222'); // Example log
    }

    // Log the existence of the .nomedia file
    print('Does .nomedia exist? ${await nomediaFile.exists()}');
    print('AppPath set to: ${directory.path}');
  }


  Future<void> save_path(bool type) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final externalDocsDir = Directory('/storage/emulated/0/Documents/ELITEPRO');

      String appPath = appDocDir.path;
      String acc = type == false
          ? '${LoginController().JTID}_${LoginController().BIID}_${LoginController().SYID}'
          : '';

      // مجلد النسخ الاحتياطي داخل التطبيق
      final internalBackupDir = Directory("$appPath/DataBase");
      if (!(await internalBackupDir.exists())) {
        await internalBackupDir.create(recursive: true);
      }

      // حاول إنشاء مجلد ELITEPRO في Documents الخارجي
      bool docsAvailable = true;
      try {
        if (!(await externalDocsDir.exists())) {
          await externalDocsDir.create(recursive: true);
        }
      } catch (e) {
        docsAvailable = false;
        print('⚠️ غير قادر على إنشاء مجلد Documents: $e');
      }

      // بناء اسم الملف
      final now = DateTime.now();
      final formattedDate = DateFormat('dd-MM-yyyy HH-mm').format(now);
      final formattedTime = DateFormat('HH:mm:ss').format(now);

      String fileName = formattedDate;
      switch (STMID) {
        case 'EORD':
          fileName += "_ELITEORD$acc.db";
          break;
        case 'COU':
          fileName += "_ESCOU$acc.db";
          break;
        case 'INVC':
          fileName += "_ESINVC$acc.db";
          break;
        default:
          fileName += "_ELITEPRO$acc.db";
      }

      final sourceFile = File('$appPath/$DBNAME');
      final internalBackupPath = "${internalBackupDir.path}/$fileName";
      String? externalBackupPath;
      if (docsAvailable) {
        externalBackupPath = "${externalDocsDir.path}/$fileName";
      }

      // 🔄 نسخ الملف داخلياً (دائم)
      await sourceFile.copy(internalBackupPath);
      print('✅ Backup created at: $internalBackupPath');

      // 🔄 حاول نسخ الملف إلى Documents الخارجي؛ إذا فشل فلا يوقف العملية
      if (externalBackupPath != null) {
        try {
          await sourceFile.copy(externalBackupPath);
          print('✅ Backup also saved to Documents: $externalBackupPath');
        } catch (e) {
          print('⚠️ فشل النسخ إلى Documents: $e');
        }
      }

      // ✅ حفظ معلومات النسخة في الجدول
      await insertBackupInfo('نسخة احتياطية',externalBackupPath.toString()=='null'? internalBackupPath :
      externalBackupPath.toString(), formattedDate, formattedTime);

      if (type) {
        Fluttertoast.showToast(
          msg: '✅ تم حفظ النسخة الاحتياطية بنجاح!',
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.green,
        );

        Get.defaultDialog(
          title: 'StringMestitle'.tr,
          middleText: 'StringShareBK'.tr,
          backgroundColor: Colors.white,
          radius: 40,
          textCancel: 'StringNo'.tr,
          cancelTextColor: Colors.red,
          textConfirm: 'StringYes'.tr,
          confirmTextColor: Colors.white,
          onConfirm: () async {
            final xFile = XFile(internalBackupPath, mimeType: 'application/db');
            await Share.shareXFiles([xFile]);
            Get.back();
          },
        );
      }
    } catch (e) {
      print('❌ Error creating backup: $e');
      Get.snackbar(
        'خطأ',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }


  Future<void> save_path2(bool type) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final externalDir = Directory('/storage/emulated/0/Documents'); // 📂 مسار مستندات الهاتف

      String appPath = appDocDir.path;
      String documentsPath = externalDir.path;

      File sourceFile = File('$appPath/$DBNAME');
      String acc = type == false
          ? '${LoginController().JTID}_${LoginController().BIID}_${LoginController().SYID}'
          : '';

      Directory targetDirectory = Directory("$appPath/DataBase");
        Directory documentsDirectory = Directory("$documentsPath/ELITEPRO"); // مجلد النسخ الاحتياطي في مستندات الهاتف

      if (!(await targetDirectory.exists())) {
        await targetDirectory.create(recursive: true);
      }
      if (!(await documentsDirectory.exists())) {
        await documentsDirectory.create(recursive: true);
      }

      final DateTime now = DateTime.now();
      final String formattedDate = DateFormat('dd-MM-yyyy HH-mm').format(now);
      final String formattedTime = DateFormat('HH:mm:ss').format(now);

      String fileName = "${formattedDate}";
      if (STMID == 'EORD') {
        fileName += "_ELITEORD$acc.db";
      }
      else if (STMID == 'COU') {
        fileName += "_ESCOU$acc.db";
      }
      else if (STMID == 'INVC') {
        fileName += "_ESINVC$acc.db";
      }
      else {
        fileName += "_ELITEPRO$acc.db";
      }

      // 🔄 نسخ الملف في مكانين
      String backupPathApp = "${targetDirectory.path}/$fileName";
        String backupPathDocs = "${documentsDirectory.path}/$fileName";

      await sourceFile.copy(backupPathApp);
        await sourceFile.copy(backupPathDocs);

      // ✅ حفظ معلومات النسخة في الجدول
      await insertBackupInfo('نسخة احتياطية', backupPathApp, formattedDate, formattedTime);

      //await showBackupNotification(backupPathDocs);

      print('✅ Backup created at: $backupPathApp');
      // print('📁 Backup also saved to Documents: $backupPathDocs');

      if (type) {
        Fluttertoast.showToast(
          msg: '✅ تم حفظ النسخة الاحتياطية بنجاح!',
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.green,
        );

        Get.defaultDialog(
          title: 'StringMestitle'.tr,
          middleText: "${'StringShareBK'.tr}",
          backgroundColor: Colors.white,
          radius: 40,
          textCancel: 'StringNo'.tr,
          cancelTextColor: Colors.red,
          textConfirm: 'StringYes'.tr,
          confirmTextColor: Colors.white,
          onConfirm: () async {
            final xFile = XFile(backupPathApp, mimeType: 'application/pdf');
            await Share.shareXFiles([xFile]);
            // await Share.shareFiles([backupPathApp], mimeTypes: ['application/pdf']);
            Get.back();
          },
        );
      }

    } catch (e) {
      print('❌ Error creating backup: $e');
      Get.snackbar('خطأ', e.toString(),
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  // Future<void> save_path11(bool Type) async {
  //   try {
  //     // Retrieve the application's document directory for both iOS and Android
  //     final appDocDir = await getApplicationDocumentsDirectory();
  //     String appPath = appDocDir.path;
  //
  //     // Define source and target directories/files
  //     File sourceFile = File('$appPath/${DBNAME}');
  //     String ACC = Type == false
  //         ? '${LoginController().JTID}_${LoginController().BIID}_${LoginController().SYID}'
  //         : '';
  //     Directory targetDirectory = Directory("$appPath/DataBase");
  //
  //     // Create the target directory if it doesn't exist
  //     if (!(await targetDirectory.exists())) {
  //       print("Directory does not exist, creating...");
  //       await targetDirectory.create(recursive: true);
  //     }
  //
  //     // Define the new backup file name based on STMID and date
  //     final DateTime time = DateTime.now();
  //     String newPath = '';
  //     if (STMID == 'EORD') {
  //       newPath = "${targetDirectory.path}/${time.day}-${time.month}-${time.year} ELITEORD$ACC.db";
  //     } else if (STMID == 'COU') {
  //       newPath = "${targetDirectory.path}/${time.day}-${time.month}-${time.year} ESCOU$ACC.db";
  //     } else if (STMID == 'INVC') {
  //       newPath = "${targetDirectory.path}/${time.day}-${time.month}-${time.year} ESINVC$ACC.db";
  //     } else {
  //       newPath = "${targetDirectory.path}/${time.day}-${time.month}-${time.year} ELITEPRO$ACC.db";
  //     }
  //
  //     // Copy the source database file to the new path
  //     await sourceFile.copy(newPath);
  //     print('Backup created at: $newPath');
  //
  //     // Show toast message if Type is true
  //     if (Type == true) {
  //       Fluttertoast.showToast(
  //         msg: 'StringBKMES'.tr,
  //         toastLength: Toast.LENGTH_LONG,
  //         textColor: Colors.white,
  //         backgroundColor: Colors.green,
  //       );
  //
  //       // Show confirmation dialog with sharing option
  //       Get.defaultDialog(
  //         title: 'StringMestitle'.tr,
  //         middleText: "${'StringShareBK'.tr}",
  //         backgroundColor: Colors.white,
  //         radius: 40,
  //         textCancel: 'StringNo'.tr,
  //         cancelTextColor: Colors.red,
  //         textConfirm: 'StringYes'.tr,
  //         confirmTextColor: Colors.white,
  //         onConfirm: () async {
  //           await Share.shareFiles([newPath], mimeTypes: ['application/pdf'], text: '');
  //           Get.back();
  //         },
  //       );
  //     }
  //
  //     // Log paths for debugging
  //     print('AppPath: $appPath');
  //     print('Backup Path: $newPath');
  //   } catch (e) {
  //     // Handle and log any errors
  //     print('Error creating backup: ${e.toString()}');
  //     Get.snackbar('ERROR', e.toString());
  //   }
  // }

  Future<void> importDataBaseFile(int Type) async {
    try {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;

      bool? clearedTemp = await FilePicker.platform.clearTemporaryFiles();
      print("Temporary files cleared: $clearedTemp");

      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.extension == 'db') {
          // Get the application's documents directory
          final appDocDir = await getApplicationDocumentsDirectory();
          String recoveryPath = "${appDocDir.path}/$DBNAME";

          print("Selected file path: ${file.path}");
          print("Recovery path: $recoveryPath");

          // Copy the selected file to the recovery path
          String selectedFilePath = file.path!;
          File selectedFile = File(selectedFilePath);
          await selectedFile.copy(recoveryPath);

          print('Database restored successfully to $recoveryPath');
          Fluttertoast.showToast(
            msg: 'StringSecc_Restore_DB'.tr,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            backgroundColor: Colors.green,
          );

          LoginController().SET_N_P('CHIKE_ALL_MAIN',1);

          // Navigate after a short delay
          if (Type == 1) {
            Timer(const Duration(seconds: 3), () async {
              Get.offAllNamed('/login');
              GET_JTID_ONEData();
              LoginController().SET_B_P('RemmberMy',false);
            });
          } else {
            Timer(const Duration(seconds: 3), () async {
              Get.toNamed('/login');
              GET_JTID_ONEData();
            });
          }
        } else {
          Get.defaultDialog(
            title: file.name,
            middleText: 'StringErr_Restore_DB'.tr,
            backgroundColor: Colors.white,
            radius: 40,
            textCancel: 'OK',
            cancelTextColor: Colors.red,
          );
        }
      } else {
        print("No file selected.");

      }
    } catch (e) {
      print('Error restoring database: ${e.toString()}');
      Get.snackbar('Error', 'Failed to restore the database: ${e.toString()}');
    }
  }

  late List<Syn_Tas_Local> SYN_TAS_List;

  //دالة التحقق من السنه الماليه 1
  GET_SYN_TAS_F_P() {
    GET_SYN_TAS('SYN_TAS',0).then((data) {
      SYN_TAS_List = data;
      if (SYN_TAS_List.isNotEmpty) {
        SYN_TAS_GUID = SYN_TAS_List.elementAt(0).GUID.toString();
        print(SYN_TAS_GUID);
        print('SYN_TAS_GUID');
      }
    });
  }

//دالة التحقق من السنه الماليه 2
  GET_SYN_TAS_P(bool Type) async {
    print('ST---1 GUID');
    Update_TABLE_ALL('SYN_TAS_TMP');
    save_path(false);
    await Future.delayed(const Duration(seconds: 1));
    if(SYN_TAS_List.isNotEmpty){
      print('ST---2 GUID');
      GET_SYN_TAS('SYN_TAS_TMP',0).then((data){
        if (data.isNotEmpty ) {
          for (var i = 0; i < SYN_TAS_List.length; i++) {
            print(SYN_TAS_List.elementAt(0).GUID);
            print('data.elementAt(0).GUID');
            if(SYN_TAS_List.elementAt(0).GUID!=data.elementAt(0).GUID){
              SaveALLData('SYN_TAS');
            }}}
      });
      print('ST---3 GUID');
    }
    else{
      print('ST---4 GUID');
      SaveALLData('SYN_TAS');
    }
    await Future.delayed(const Duration(seconds: 1));
    print('ST---5 GUID');
    GET_SYN_ORDDelete();
    GET_SYN_TAS('SYN_TAS',1).then((date)  async {
      if(date.isNotEmpty){
        var decodedJson = json.decode('''{${date.elementAt(0).STDE.toString()}}''');
        print('decodedJson');
        print(decodedJson);
        print('ST---6 GUID');
        var result = decodedJson['Result'];
        var CIID_OLDValue = result['CIID_OLD'];
        var JTID_OLDValue = result['JTID_OLD'];
        var BIID_OLDValue = result['BIID_OLD'];
        var SYID_OLDValue = result['SYID_OLD'];
        var CIID_NEWValue = result['CIID_NEW'];
        var JTID_NEWValue = result['JTID_NEW'];
        var BIID_NEWValue = result['BIID_NEW'];
        var SYID_NEWValue = result['SYID_NEW'];
        print(CIID_OLDValue);
        print(JTID_OLDValue);
        print(BIID_OLDValue);
        print(SYID_OLDValue);
        print(CIID_NEWValue);
        print(JTID_NEWValue);
        print(BIID_NEWValue);
        print(SYID_NEWValue);
        if(SYID_NEWValue!=SYID_OLDValue){
          UpdateMOB_VAR_SYID(SYID_NEWValue);
          UPDATESYIDAll(SYID_NEWValue);
          UPDATESYIDROWID('SYN_ORD',SYID_NEWValue);
          INSERT_CONFIG(SYID_NEWValue);
          UpdateCONFIG('CHIKE_ALL','0');
          UpdateCONFIG('SYST','2');
          update();
          await Future.delayed(const Duration(seconds: 2));
          Get.snackbar('StringMestitle'.tr, 'StringNewFiscalYear'.tr,
              backgroundColor: Colors.red,
              icon: const Icon(Icons.error, color: Colors.white),
              colorText: Colors.white,
              isDismissible: true,
              dismissDirection: DismissDirection.horizontal,
              forwardAnimationCurve: Curves.easeOutBack);
          SET_B_P('RemmberMy',false);
          Type==true?
          Get.offAllNamed('/login'):false;
          ApiProviderLogin().Socket_IP_Conn(LoginController().IP,int.parse(LoginController().PORT));
        }
      }
      else{
        EasyLoading.instance
          ..displayDuration = const Duration(milliseconds: 2000)
          ..indicatorType = EasyLoadingIndicatorType.fadingCircle
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorSize = 45.0
          ..radius = 10.0
          ..progressColor = Colors.white
          ..backgroundColor = Colors.green
          ..indicatorColor = Colors.white
          ..textColor = Colors.white
          ..maskColor = Colors.blue.withOpacity(0.5)
          ..userInteractions = true
          ..dismissOnTap = false;
        EasyLoading.showError('StringNoData'.tr);
      }
    });
  }

}
