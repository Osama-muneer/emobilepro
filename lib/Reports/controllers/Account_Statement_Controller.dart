import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../../Reports/Views/Account_Statement/show_acc_statement.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/acc_acc.dart';
import '../../Setting/models/acc_sta_d.dart';
import '../../Setting/models/acc_sta_m.dart';
import '../../Setting/models/bal_acc_d.dart';
import '../../Setting/models/sys_scr.dart';
import 'package:intl/intl.dart' as intl;
import '../../Setting/models/sys_yea.dart';
import '../../Setting/models/usr_pri.dart';
import '../../Widgets/config.dart';
import '../../database/invoices_db.dart';
import '../../database/report_db.dart';
import '../../database/setting_db.dart';
import '../../database/sync_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


class Account_Statement_Controller extends GetxController {
  //TODO: Implement HomeController
  RxBool loading = false.obs;
  bool isloadingRemmberMy = false;
  bool value = false,V_SUN_ACC=false;
  bool value1 = false;
  bool PRI_MAT = false;
  bool PRI_MAT2 = false;
  bool PRI_BIL_NOT = false;
  bool NOT_INC_LAS = false;
  bool VIE_BY_LOC_CUR = true;
  bool EQ_V = false,isTablet = false;
  var uuid = const Uuid(),GUID,GUIDC;
  var accountNumber = ''.obs,customerName = ''.obs,AANO = ''.obs,GUID_C = ''.obs,BCTL_C = ''.obs,
  BCAD_C = ''.obs;
  var TYPY_V = ''.obs;
  var SLIN=LoginController().LAN==2?'The data has been successfully received/updated':"تم بنجاج استلام/تحديث البيانات";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final DateTime startOfYear2;
  late final String formattedDate;
  late List<Sys_Scr_Local> SYS_SCR = [];
  late List<Sys_Scr_Local> SYS_SCR2 = [];
  late List<Usr_Pri_Local> PRIVLAGE_L = [];
  late List<Acc_Acc_Local> Acc_Acc_List = [];
  late List<Acc_Sta_D_Local> ACC_STA_D_PRINT = [];
  final formatter = intl.NumberFormat.decimalPattern();
  String? SelectDataFromBIID,SelectDataToBIID,SelectDataACNO_F,SelectDataACNO_T,
      SelectDataSSID="208",SelectDataSCID,
      SelectFromDays,SelectToDays,SCNA,SelectDataAANO,SelectDataAANO_T,SelectDataAANO2,
      SelectDataAANO2_T,SelectFromYear,SelectToYear,SelectTYPE_CUR='1',SCSY='',BCTL='',
      AMBALN='',AAAD='',  SONA = '', SONE = '', SORN = '',SOLN='',SSNA='كشف حساب',SDDDA='',
      SDDSA='',LastBAL_ACC_M='',BCMO='';
  DateTime dateFromDays1 = DateTime.now();
  DateTime dateFromYear1 = DateTime.now();
  final now = DateTime.now();
  final formatter2 = DateFormat('dd-MM-yyyy');
  String dateFromDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String dateFromYear = DateFormat('yyyy').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  int? COUNT_MINO=0,UPIN=1,UPCH=1,UPQR=1,UPDL=1,UPPR=1,UPIN2=1,UPCH2=1,UPQR2=1,UPDL2=1,UPPR2=1,SYID_F,SYID_T,
      COUNT_ACC_STA_M=0,ROWN1_ACC_STA_M=0,COUNT_ACC_STA_D=0,arrlength=-1,arrlengthM=-1,TYPY=1,totalBAL_ACC_M=-1,
      YEAR_Y=1;
  late List<Sys_Yea_Local> SYS_YEA;
  late List<Bal_Acc_D_Local> BAL_ACC_D;
  //late List<Acc_Sta_D_Local> ACC_STA_D_PRINT;
  double? SUMAMDMD=0,AMBAL=0,SUMASDLB=0,SUMASDCB;
  late TextEditingController
      AANOController,
      AANAController,
      TextEditingSercheController;


  void onInit() async {
    super.onInit();
    AANOController=TextEditingController();
    AANAController=TextEditingController();
    TextEditingSercheController=TextEditingController();
    if (Get.arguments is int) {
      int argumentType = Get.arguments as int;
      if (argumentType == 2 || TYPY == 2) {
        TYPY = 2;
      } else if (argumentType == 3 || TYPY == 3) {
        TYPY = 3;
      } else if (argumentType == 4 || TYPY == 4) {
        TYPY = 4;
      } else {
        TYPY = 1;
      }
    }
    else if (Get.arguments is Map<String, dynamic>) {
      TYPY = 1;
      final args = Get.arguments as Map<String, dynamic>;
      customerName.value = args['AANA']?.toString() ?? '';
      AANO.value = args['AANO']?.toString() ?? '';
      GUID_C.value = args['GUID_C']?.toString() ?? '';
      BCTL_C.value = args['BCTL']?.toString() ?? '';
      BCAD_C.value = args['BCAD']?.toString() ?? '';

      SelectDataAANO = AANO.value;
      SelectDataAANO2 = customerName.value;
      AANOController.text = AANO.value;
      AANAController.text = customerName.value;
      GUIDC = GUID_C.value;
      BCTL = BCTL_C.value;
      AAAD = BCAD_C.value;

      print(SelectDataAANO);
      print(SelectDataAANO2);
      print(AANAController.text);
      print(BCTL);
      print(AAAD);
    }

    // بقية الأكواد
    await GET_TYPE_ACCOUNT_P2();
    await GET_TYPE_ACCOUNT_P();
    await GET_PRIVLAGE();
    await GET_SYS_OWN_P();
    await GET_SYS_DOC_D();
    await GET_SYS_YEA_P();
    await GET_SYN_ORD_P();
    await GET_Account_Statement_Previous_Years();


    LoginController().BIID_STA_F != '0'
        ? SelectDataFromBIID = LoginController().BIID_STA_F.toString()
        : GET_BRA_INF_ONE_P();
    LoginController().BIID_STA_T != '0'
        ? SelectDataToBIID = LoginController().BIID_STA_T.toString()
        : GET_BRA_INF_ONE_P();

    SelectFromYear = LoginController().SYNO.toString();
    SelectToYear = LoginController().SYNO.toString();
    SYID_F = LoginController().SYID;
    SYID_T = LoginController().SYID;
    SelectTYPE_CUR = '1';

    await GET_SYS_CUR_ONE_P();
    final startOfYear = DateTime(now.year, 1, 1);
    dateFromDays = formatter2.format(startOfYear).split(" ")[0];


    update();
    await deleteACC_STA_D();
    await deleteACC_STA_M();
    // تحديد بداية السنة
    startOfYear2 = DateTime(DateTime.now().year, 1, 1);
    // تنسيق التاريخ
    formattedDate = DateFormat('dd-MM-yyyy').format(startOfYear2);
    SelectFromDays=formattedDate.toString();

    if ( TYPY == 4) {
      SelectDataSSID = '203';
      SSNA = 'StringACC_STA_H'.tr;
      query_Acc_Acc(LoginController().BIID.toString(),'203');
      await GET_PRIVLAGE();
      update();
    }
    update();
  }

  void dispose() {
    super.dispose();
    // TODO: implement dispose
    AANAController.dispose();
    AANAController.dispose();
    TextEditingSercheController.dispose();
    if(isTablet==true){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  //صلاحيات الكمية المخزنية
  Future GET_PRIVLAGE() async {
    PRIVLAGE_L=await PRIVLAGE(LoginController().SUID,TYPY==3?489:SelectDataSSID!=null?
    int.parse(SelectDataSSID.toString()):202);
    if(PRIVLAGE_L.isNotEmpty){
      UPIN=PRIVLAGE_L.elementAt(0).UPIN;
      UPCH=PRIVLAGE_L.elementAt(0).UPCH;
      UPDL=PRIVLAGE_L.elementAt(0).UPDL;
      UPPR=PRIVLAGE_L.elementAt(0).UPPR;
      UPQR=PRIVLAGE_L.elementAt(0).UPQR;
      update();
      print(UPIN);
      print(UPPR);
      print(UPCH);
      print(UPQR);
      print('UPQR');

    }else {
      UPIN=2;UPCH=2;UPDL=2;UPPR=2;UPQR=2;
    }
  }

  //جلب العمله عند الدخول
  Future GET_SYS_CUR_ONE_P() async {
    var SYS_CUR=await GET_SYS_CUR_ONE_SALE();
    if(SYS_CUR.isNotEmpty){
      SelectDataSCID=SYS_CUR.elementAt(0).SCID.toString();
      SCNA=SYS_CUR.elementAt(0).SCNA_D.toString();
      SCSY=SYS_CUR.elementAt(0).SCSY!;
    }
    update();
  }

  //PDF
  Future GET_ACC_STA_D_P() async {
    ACC_STA_D_PRINT=await GET_ACC_Statement(GUID);
  }

  //كشف حساب سنوات سابقه
  Future GET_Account_Statement_Previous_Years() async {
    var data=await PRIVLAGE(LoginController().SUID,522);
      if(data.isNotEmpty) {
        YEAR_Y = data.elementAt(0).UPIN;
      }else {
        YEAR_Y=1;
      }
  }

  Future GET_SYN_ORD_P() async {
    var SYN_ORD=await GET_SYN_ORD('BAL_ACC_D');
      if (SYN_ORD.isNotEmpty) {
        LastBAL_ACC_M = SYN_ORD.elementAt(0).SOLD.toString();
      }
  }


  Future GET_BRA_INF_ONE_P() async {
    var BRA_INF=await GET_BRA_ONE(2);
      if(BRA_INF.isNotEmpty){
        SelectDataFromBIID=BRA_INF.elementAt(0).BIID.toString();
        SelectDataToBIID=BRA_INF.elementAt(0).BIID.toString();
      }
      update();
  }

  //جلب بيانات المنشاة
  Future GET_SYS_OWN_P() async {
    var SYS_OWN=await GET_SYS_OWN(LoginController().BIID);
    if (SYS_OWN.isNotEmpty) {
      SONA=SYS_OWN.elementAt(0).SONA.toString();
      SONE=SYS_OWN.elementAt(0).SONE.toString();
      SORN=SYS_OWN.elementAt(0).SORN.toString();
      SOLN=SYS_OWN.elementAt(0).SOLN.toString();
    }
  }

  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D() async {
    var  GET_SYS_DOC=await Get_SYS_DOC_D('AC',201, LoginController().BIID);
      if (GET_SYS_DOC.isNotEmpty) {
        if (GET_SYS_DOC.elementAt(0).SDDST1 == 1 &&
            GET_SYS_DOC.elementAt(0).SDDDA_D.toString().isNotEmpty) {
          SDDDA = GET_SYS_DOC.elementAt(0).SDDDA_D.toString();
          SDDDA != 'null' ? SDDDA = SDDDA : SDDDA = '';
        } else {
          SDDDA = '';
        }
        if (GET_SYS_DOC.elementAt(0).SDDST2 == 1 &&
            GET_SYS_DOC.elementAt(0).SDDSA_D.toString().isNotEmpty) {
          SDDSA = GET_SYS_DOC.elementAt(0).SDDSA_D.toString();
          SDDSA != 'null' ? SDDSA = SDDSA : SDDSA = '';
        } else {
          SDDSA = '';
        }
      }
  }

  Future GET_TYPE_ACCOUNT_P() async {
    SYS_SCR=await  GET_SYS_SCR('A.SSID IN (208,206,207)');
      if(SYS_SCR2.isNotEmpty){
        SelectDataSSID="202";
      }else{
        if(SYS_SCR.isNotEmpty) {
          SelectDataSSID = SYS_SCR.elementAt(0).SSID.toString();
        }else{
          SelectDataSSID = "208";
        }
      }
      update();

  }

  Future GET_TYPE_ACCOUNT_P2() async {
    SYS_SCR2=await GET_SYS_SCR('A.SSID=202');
      if(SYS_SCR2.isNotEmpty){
        SelectDataSSID="202";
      }
      update();
  }


  void clear() {
    // TODO: implement dispose
    SelectDataFromBIID= LoginController().BIID.toString();
    SelectDataToBIID= LoginController().BIID.toString();
    SelectDataACNO_F=null;
    SelectDataACNO_T=null;
    AANAController.clear();
    AANOController.clear();
    SelectTYPE_CUR='1';
    SelectDataSCID=null;
    SelectDataAANO=null;
    SelectDataAANO2=null;
    SelectDataAANO_T=null;
    SelectDataAANO2_T=null;
    final startOfYear = DateTime(now.year, 1, 1);
    dateFromDays = formatter2.format(startOfYear).toString().split(" ")[0];
   // dateFromDays = DateFormat('dd-MM-yyyy').format(dateFromDays1.subtract(const Duration(days:150))).toString().split(" ")[0];
    SelectToDays =  DateFormat('dd-MM-yyyy').format(DateTime.now());
    SelectFromYear= LoginController().SYNO.toString();
    SelectToYear= LoginController().SYNO.toString();
    SYID_F= LoginController().SYID;
    SYID_T= LoginController().SYID;
    SelectDataSCID=null;
     value = false;
     value1 = false;
     PRI_MAT = false;
     PRI_BIL_NOT = false;
     VIE_BY_LOC_CUR = true;
     EQ_V = false;
    update();
  }

  static const MaterialColor buttonTextColor = MaterialColor(
    0xFFEF5350,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFF44336),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  Future<void> selectDateFromDays(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:  dateFromDays1,
      firstDate: DateTime(2000,5),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return   Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      SelectFromDays =  DateFormat("dd-MM-yyyy").format(picked);
    }
    update();
  }

  Future<void> selectDateToDays(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTimeToDays2,
      firstDate: DateTime(2000, 5),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return   Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      SelectToDays = DateFormat("dd-MM-yyyy").format(picked);
    }
    update();
  }

  //دالة لجلب السنة
  Future GET_SYS_YEA_P() async {
    GET_SYS_YEA().then((data) {
      if (data.isNotEmpty) {
        SYS_YEA = data;
        update();
      }});
  }

  void configloading(){
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.redAccent
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    EasyLoading.showError("StringShow_Err_Connent".tr);
  }

  Future GET_COUNT_ACC_M_P(String GETGUID) async {
   var COUNT_ACC_M=await GET_ACOUNT_ACC_M(GETGUID);
      if (COUNT_ACC_M.isNotEmpty) {
        COUNT_ACC_STA_M = COUNT_ACC_M.elementAt(0).COU;
        ROWN1_ACC_STA_M = COUNT_ACC_M.elementAt(0).ROWN1;
      }
      else{
        COUNT_ACC_STA_M=0;
        ROWN1_ACC_STA_M=0;
      }
  }


  Future GET_ACC_STA_M_P(String GETGUID) async {
    var ACC_STA_M=await GET_ACC_STA_M(GETGUID);
      if (ACC_STA_M.isNotEmpty) {
        AMBAL = ACC_STA_M.elementAt(0).AMBAL;
        AMBALN = ACC_STA_M.elementAt(0).AMBALN;
      }else{
        AMBAL=0;
      }
  }


  Future GET_BIL_ACC_M_P(String GETAANO,String GETGUID,String TYPESCID,String GETSCID) async {
    var BIL_ACC_C=await GET_BIL_ACC_M(GETAANO,GETGUID,TYPESCID,GETSCID);
      if (BIL_ACC_C.isNotEmpty) {
        AMBAL = double.parse(BIL_ACC_C.elementAt(0).BACBA);
        AMBALN = BIL_ACC_C.elementAt(0).BACBAR1;
        update();
      }else{
        AMBAL=0;
        AMBALN='';
      }
  }

  Future GET_BIL_ACC_D_P(String GETAANO,String TYPESCID,String GETSCID) async {
    BAL_ACC_D=await GET_BIL_ACC_D(GETAANO,TYPESCID,GETSCID,NOT_INC_LAS,SelectDataSSID.toString());
  }

  void Socket_IP(String IP,int Port) async {
    // final service = FlutterBackgroundService();
    // service.invoke("stopService");
    Socket.connect(IP, Port, timeout: const Duration(seconds: 30)).then((socket) async {
      print("Success connect");
      GUID = uuid.v4();
      PAR_V="[AANO{${TYPY==3?SelectDataACNO_F:SelectDataAANO}}][AAMST{2}][BIID_F{$SelectDataFromBIID}][BIID_T{$SelectDataToBIID}]"
          "[SCID_F{${SelectDataSCID==null?'':SelectDataSCID}}][SCID_T{${SelectDataSCID==null?'':SelectDataSCID}}]"
          "[ACNO_F{${TYPY==3?SelectDataAANO==null?'':SelectDataAANO:SelectDataACNO_F==null?'':SelectDataACNO_F}}]"
          "[ACNO_T{${TYPY==3?SelectDataAANO_T==null?'':SelectDataAANO_T:SelectDataACNO_T==null?'':SelectDataACNO_T}}]"
          "[FROM_D{$SelectFromDays}][TO_D{$SelectToDays}][SUID{${LoginController().SUID}}]"
          "[PRI_MAT{${PRI_MAT==true ?1:2}}][PRI_MAT2{${PRI_MAT2==true ?1:2}}]"
          "[EQ_V{${EQ_V==true ?1:2}}][PRI_BIL_NOT{${PRI_BIL_NOT==true ?1:2}}][TOT_BIL_SET{2}]"
          "[VIEW_EQ_AM{${VIE_BY_LOC_CUR==true ?1:2}}][CUR{$SelectTYPE_CUR}][CAR_INF{2}][REP_DIR{2}]"
          "[SYID_F{$SYID_F}][SYID_T{$SYID_T}][NOT_INC_LAS{${NOT_INC_LAS==true ?1:2}}][PRI_BAL{2}]"
          "[PRI_BAL_N{1}][INC_STO_PAY{2}][YEAR_Y{$YEAR_Y}][STA_ARC{0}][LAN{${LoginController().LAN}}][SUN_ACC{${V_SUN_ACC==true ?1:2}}]"
          "[SYID{${LoginController().SYID}}][OFFLINE{0}][CHK_PRI{0}][STA_TYP{${TYPY==3?'COS':SelectDataSSID=='203'?'MAIN':'ACC'}}]";
      F_GUID_V = GUID;
      print(PAR_V);
      print('طلب كشف حساب رئيسي');
      //جلب الجدول الرئيسي
      GETALLACC_STA_M();

      configloading_state('StringShow_State_Account_M'.tr);
      AwaitSyncM();

      socket.destroy();
    }).catchError((error){
      print("Exception on Socket 2"+ error.toString());
      Get.snackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
     // Get.to(() => Show_Acc_Statement());
     // EasyLoading.dismiss();
      configloading();
      Fluttertoast.showToast(
          msg: "${error.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    });
  }

  var CheckSync=true.obs;
  var CheckSyncD=true.obs;

  void configloading_Succ(String MES_ERR,String lang) {
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
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.showSuccess("$MES_ERR..${lang}");
      }

  void configloading_state(String MES_ERR) {
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
      ..userInteractions = false
      ..dismissOnTap = false;
    INSERT_SYN_LOG(TAB_N,SLIN,'U');
    EasyLoading.show(status:  '$MES_ERR');
      }

  AwaitSyncM() async{
    print('طلب كشف حساب AwaitSyncM');
    for (var i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 500));{
        if(CheckSync==true){
          if(arrlengthM!=-1){
            // جلب عدد السجلات للتاكد من وصول بيانات والانتقال الى طلب الجدول الفرعي
            GET_COUNT_ACC_M_P(GUID);
            await Future.delayed(const Duration(seconds: 1));
            print(COUNT_ACC_STA_M);
            print('COUNT_ACC_STA_M');
            if(COUNT_ACC_STA_M!=0){
              print('طلب كشف حساب فرعي');
              GETALLACC_STA_D();
              AwaitSyncD();
              i=100;
              print(i);
            }
            else{
              Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.error,color:Colors.white),
                  colorText:Colors.white,
                  isDismissible: true,
                  dismissDirection: DismissDirection.horizontal,
                  forwardAnimationCurve: Curves.easeOutBack);
              EasyLoading.dismiss();
            }
          }
          else{
            print(i);
            print('i');
            if(i==100){
              Get.snackbar('StringDatafetchfailed'.tr, 'StringCHK_Err_Con_ACC'.tr,
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.error,color:Colors.white),
                  colorText:Colors.white,
                  isDismissible: true,
                  dismissDirection: DismissDirection.horizontal,
                  forwardAnimationCurve: Curves.easeOutBack);
              EasyLoading.dismiss();
              print(' لم يتم استقبال البيانات رئيسي');
              update();
            }
          }
        }
        else{
          i=100;
          update();
        }
      }
    }
  }

  AwaitSyncD() async{
    for (var i = 0; i <= 240; i++) {
      await Future.delayed(const Duration(milliseconds: 500));{
        if(CheckSyncD==true){
          if(arrlength!=-1 && arrlength!=0){
            GoShow_Acc();
            i=240;
            print(i);
            print(arrlength);
            print('تم استلام الفرعي');
          }
          else if(arrlength==0){
            i=240;
            print(i);
            print('AwaitSyncD=0');
            Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                backgroundColor: Colors.red,
                icon: const Icon(Icons.error,color:Colors.white),
                colorText:Colors.white,
                isDismissible: true,
                dismissDirection: DismissDirection.horizontal,
                forwardAnimationCurve: Curves.easeOutBack);
            EasyLoading.dismiss();
          } else{
            print(i);
            if(i==240){
              Get.snackbar('StringDatafetchfailed'.tr, 'StringCHK_Err_Con_ACC'.tr,
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.error,color:Colors.white),
                  colorText:Colors.white,
                  isDismissible: true,
                  dismissDirection: DismissDirection.horizontal,
                  forwardAnimationCurve: Curves.easeOutBack);
              EasyLoading.dismiss();
              print('لايوجد بيانات');
              update();
            }
          }
        }
        else{
          i=240;
          update();
        }
      }
    }
  }

  GoShow_Acc(){
    GET_ACC_STA_M_P(GUID);
    Timer( Duration(seconds: ROWN1_ACC_STA_M!>=500? 10 : 3 ), () async{
      configloading_Succ('StringShow_Succ_Account_D'.tr,arrlength.toString());
      LoginController().SET_P('BIID_STA_F',SelectDataFromBIID.toString());
      LoginController().SET_P('BIID_STA_T',SelectDataToBIID.toString());
      Get.to(() => Show_Acc_Statement());
      PAR_V="";
    });
  }

  //كشف حساب
  Future<dynamic> GETALLACC_STA_M() async {
    late var params = {
      "STMID_CO_V": "MOB",
      "SYDV_NAME_V": LoginController().DeviceName,
      "SYDV_IP_V": LoginController().IP,
      "SYDV_TY_V":  LoginController().SYDV_TY,
      "SYDV_SER_V": LoginController().DeviceID,
      "SYDV_POI_V":"",
      "SYDV_ID_V":LoginController().SYDV_ID,
      "SYDV_NO_V":LoginController().SYDV_NO,
      "SYDV_BRA_V":1,
      "SYDV_LATITUDE_V":"",
      "SYDV_LONGITUDE_V":"",
      "SYDV_APPV_V":LoginController().APPV,
      "SOID_V":SelectDataSSID=="208"?"ACC_STA_MC":SelectDataSSID=="206"?"ACC_STA_MS":"ACC_STA_MI",
      "STID_V":"",
      "TBNA_V":'ACC_STA_M',
      "LAN_V":LoginController().LAN,
      "CIID_V":LoginController().CIID,
      "JTID_V":LoginController().JTID,
      "BIID_V":LoginController().BIID,
      "SYID_V":LoginController().SYID,
      "SUID_V":LoginController().SUID,
      "SUPA_V":LoginController().SUPA,
      "F_ROW_V":'0',
      "T_ROW_V":'0',
      "F_DAT_V": '',
      "T_DAT_V": '',
      "F_GUID_V":F_GUID_V,
      "WH_V1":'',
      "PAR_V":"",
      "JSON_V":PAR_V,
      "JSON_V2":"",
      "JSON_V3":""
    };
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("$url/ACC_STA_M");
    print("$params/ACC_STA_M");
    try {
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        arrlengthM=arr.length;
        print(arr.length);
        printLongText(response.data.toString());
        print('arr.lengthACC_STA_M');
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');
        return (response.data)['result'].map((data) {
          SaveACC_STA_M(Acc_Sta_M_Local.fromMap(data));
        }).toList();
      }
      else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        CheckSync(false);
      }
      else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        CheckSync(false);
        throw Exception("response error: ${response.data}");
      }
      // statusCode=response.statusCode.toString();
      // print('statusCode222');
      // print(response.statusCode);
      // print(statusCode);
    } on DioException catch (e) {
      configloading();
      Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      INSERT_SYN_LOG(TAB_N,e.message,'D');
      CheckSync(false);
      return Future.error("DioError: ${e.message}");
    }
  }

  Future<dynamic> GETALLACC_STA_D() async {
    late var params = {
      "STMID_CO_V": "MOB",
      "SYDV_NAME_V": LoginController().DeviceName,
      "SYDV_IP_V": LoginController().IP,
      "SYDV_TY_V":  LoginController().SYDV_TY,
      "SYDV_SER_V": LoginController().DeviceID,
      "SYDV_POI_V":"",
      "SYDV_ID_V":LoginController().SYDV_ID,
      "SYDV_NO_V":LoginController().SYDV_NO,
      "SYDV_BRA_V":1,
      "SYDV_LATITUDE_V":"",
      "SYDV_LONGITUDE_V":"",
      "SYDV_APPV_V":LoginController().APPV,
      "SOID_V":SelectDataSSID=="208"?"ACC_STA_DC":SelectDataSSID=="206"?"ACC_STA_DS":"ACC_STA_DI",
      "STID_V":"",
      "TBNA_V":'ACC_STA_D',
      "LAN_V":LoginController().LAN,
      "CIID_V":LoginController().CIID,
      "JTID_V":LoginController().JTID,
      "BIID_V":LoginController().BIID,
      "SYID_V":LoginController().SYID,
      "SUID_V":LoginController().SUID,
      "SUPA_V":LoginController().SUPA,
      "F_ROW_V":'0',
      "T_ROW_V":'0',
      "F_DAT_V": '',
      "T_DAT_V": '',
      "F_GUID_V":F_GUID_V,
      "WH_V1":'',
      "PAR_V":"",
      "JSON_V":PAR_V,
      "JSON_V2":"",
      "JSON_V3":""
    };
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("$url/ACC_STA_D");
    print("$params/ACC_STA_D");
    try {
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        arrlength=arr.length;
        print(arr.length);
        print(response.data);
        print('arr.length');
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');
        ACC_STA_DDataList.clear();
        return (response.data)['result'].map((data) {
          ACC_STA_DDataList.add(Acc_Sta_D_Local.fromMap(data));
          // SaveACC_STA_D(Acc_Sta_D_Local.fromMap(data));
        }).toList();
      }
      else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        CheckSyncD(false);
      } else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        CheckSyncD(false);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      configloading();
      Fluttertoast.showToast(
          msg: " خطأ في IP او PORT${e.message}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      INSERT_SYN_LOG(TAB_N,e.message,'D');
      CheckSyncD(false);
      return Future.error("DioError: ${e.message}");
    }
  }

}
