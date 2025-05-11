import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/acc_acc.dart';
import '../../Setting/models/acc_sta_d.dart';
import '../../Setting/models/acc_sta_m.dart';
import '../../Setting/models/bal_acc_c.dart';
import '../../Setting/models/bal_acc_d.dart';
import '../../Setting/models/bra_inf.dart';
import '../../Setting/models/syn_ord.dart';
import '../../Setting/models/sys_cur.dart';
import '../../Setting/models/sys_doc_d.dart';
import '../../Setting/models/sys_own.dart';
import '../../Setting/models/sys_scr.dart';
import '../../Setting/models/sys_yea.dart';
import '../../Setting/models/usr_pri.dart';
import '../../Widgets/config.dart';
import '../../database/invoices_db.dart';
import '../../database/setting_db.dart';
import '../../database/sync_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


class Reports_Controller extends GetxController {
  //TODO: Implement HomeController
  RxBool loading = false.obs;
  bool isloadingRemmberMy = false;
  bool value = false;
  bool value1 = false;
  bool BRA_COL = false;
  bool N_C_I = true;
  bool PRI_BIL_NOT = false;
  bool VIW_BP = false;
  bool VIW_L_D = false;
  bool VIW_AD = false;
  bool VIW_L_MD = false;
  bool HI_B = false;
  var uuid = const Uuid(),GUID,GUIDC;
  var SLIN=LoginController().LAN==2?'The data has been successfully received/updated':"تم بنجاج استلام/تحديث البيانات";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late List<Bra_Inf_Local> BRA_INF;
  late List<Sys_Scr_Local> SYS_SCR = [];
  late List<Sys_Scr_Local> SYS_SCR2 = [];
  late List<Acc_Acc_Local> Acc_Acc_List = [];
  late List<Acc_Sta_D_Local> ACC_STA_D_PRINT = [];
  String? SelectDataFromBIID,SelectDataToBIID,SelectDataACNO_F,SelectDataACNO_T,SelectDataSSID="208",SelectDataSCID,
      SelectFromDays,SelectToDays,SelectFromInsertDate,SelectToInsertDate,SCNA,SelectDataAANO,SelectDataAANO2,
      SelectFromYear,SelectToYear,SelectGET_BRA_T='1',SCSY='',BCTL='',AANO_F,AANO_T,SelectDataBCTID,BCTID_F,BCTID_T,
      SelectDataBCTID2,SCID_F,SCID_T,AGID_F,AGID_T,ST_F='1',ST_T='4',AMMST_T='5',AC_V_B='2', AMBALN='',AAAD='',
      SONA = '', SONE = '', SORN = '',SOLN='',SSNA='كشف حساب',SDDDA='',SDDSA='',SOSI='',
      LastBAL_ACC_M='',BCMO='',SelectDataCWID,SelectDataCWID2,SelectDataCTID,SelectDataCTID2,BAID2_T,BAID2_F,
      BAID_F,BAID_T,BDID_F,BDID_T,BDID2_F,BDID2_T,CON3_F='>=',CON3_T='<=',R_TY='2',REP_DIR='2',R_TYP='1',SRTY='AC',
      BCID_F,BCID_F2,BCID_T,BCID_T2,BIID_F,BIID_F2,BIID_T,BIID_T2,BITID_F,BITID2_F,BITID_T,BITID2_T,AC_T='1',AATY='3',
      AC_BAL2='1',REP_GRO='0',REP_GRO2='0',R_TY3;
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
      YEAR_Y=1,SRID,SRSE=1;
  late List<Usr_Pri_Local> USR_PRI;
  late List<Usr_Pri_Local> PRIVLAGE_USR;
  late List<Sys_Yea_Local> SYS_YEA;
  late List<Acc_Sta_M_Local> COUNT_ACC_M;
  late List<Acc_Sta_D_Local> COUNT_ACC_D;
  late List<Acc_Sta_M_Local> ACC_STA_M;
  late List<Sys_Doc_D_Local> GET_SYS_DOC;
  late List<Bal_Acc_C_Local> BIL_ACC_C;
  late List<Bal_Acc_D_Local> BAL_ACC_D;
  late List<SYN_ORD_Local> SYN_ORD;
  late List<Sys_Cur_Local> SYS_CUR;
  //late List<Acc_Sta_D_Local> ACC_STA_D_PRINT;
  late List<Sys_Own_Local> SYS_OWN;
  double? SUMAMDMD=0,AMBAL=0,SUMASDLB=0,SUMASDCB;
  late TextEditingController AANOController, AANAController, AM_FController, AM_TController, TextEditingSercheController;

  void onInit() async {
    (Get.arguments==1003 || SRID==1003) ? SRID=1003
    : (Get.arguments==1004 || SRID==1004) ? SRID=1004
    : (Get.arguments==1010 || SRID==1010) ? SRID=1010
    : (Get.arguments==1008 || SRID==1008) ? SRID=1008
    : (Get.arguments==1016 || SRID==1016) ? SRID=1016
    : (Get.arguments==1018 || SRID==1018) ? SRID=1018
    : (Get.arguments==1023 || SRID==1023) ? SRID=1023
    : (Get.arguments==1025 || SRID==1025) ? SRID=1025
        : SRID=1003;

    AANOController=TextEditingController();
    AANAController=TextEditingController();
    AM_FController=TextEditingController();
    AM_TController=TextEditingController();
    TextEditingSercheController=TextEditingController();
    GET_SYS_REP_P();
    GET_Sys_Own();
    GET_SYS_DOC_D();
    LoginController().BIID_STA_F != '0' ? SelectDataFromBIID = LoginController().BIID_STA_F.toString() : GET_BRA_INF_ONE_P();
    LoginController().BIID_STA_T != '0' ? SelectDataToBIID = LoginController().BIID_STA_T.toString() : GET_BRA_INF_ONE_P();
    SelectFromYear= LoginController().SYNO.toString();
    SelectToYear= LoginController().SYNO.toString();
    SYID_F= LoginController().SYID;
    SYID_T= LoginController().SYID;
    SelectGET_BRA_T='1';
    GET_SYS_CUR_ONE_P();
    final startOfYear = DateTime(now.year, 1, 1);
    dateFromDays = formatter2.format(startOfYear).toString().split(" ")[0];

  }

  void dispose() {
    // TODO: implement dispose
    AANAController.dispose();
    AANAController.dispose();
    AM_FController.dispose();
    AM_TController.dispose();
    TextEditingSercheController.dispose();
  }


  Future GET_SYS_REP_P() async {
    GET_SYS_REP(SRID.toString()).then((data) {
      if(data.isNotEmpty){
        SRTY=data.elementAt(0).SRTY;
        SRSE=data.elementAt(0).SRSE;
      }else {
        SRTY='AC';SRSE=1;
      }
      GET_PRIVLAGE();
    });
  }


  //صلاحيات
  Future GET_PRIVLAGE() async {
    PRIVLAGE(LoginController().SUID,SRTY=='AC' && SRSE==1?224:SRTY=='AC' && SRSE==2?223:SRTY=='AC' && SRSE==3?222:
    SRTY=='BO' && SRSE==1?674:SRTY=='BO' && SRSE==2?673:SRTY=='BO' && SRSE==3?672:12).then((data) {
      PRIVLAGE_USR = data;
      if(PRIVLAGE_USR.isNotEmpty){
        UPIN=PRIVLAGE_USR.elementAt(0).UPIN;
        UPCH=PRIVLAGE_USR.elementAt(0).UPCH;
        UPDL=PRIVLAGE_USR.elementAt(0).UPDL;
        UPPR=PRIVLAGE_USR.elementAt(0).UPPR;
        UPQR=PRIVLAGE_USR.elementAt(0).UPQR;
      }else {
        UPIN=2;UPCH=2;UPDL=2;UPPR=2;UPQR=2;
      }
    });
  }


  //جلب بيانات المنشاة
  Future GET_Sys_Own() async {
    GET_SYS_OWN(LoginController().BIID).then((data) {
      SYS_OWN = data;
      if(SYS_OWN.isNotEmpty){
        SONA = SYS_OWN.elementAt(0).SONA.toString();
        SONE = SYS_OWN.elementAt(0).SONE.toString();
        SORN = SYS_OWN.elementAt(0).SORN.toString();
        SOLN = SYS_OWN.elementAt(0).SOLN.toString();
        SOSI = SYS_OWN.elementAt(0).SOSI.toString();
      }
    });
  }


  Future GET_BRA_INF_ONE_P() async {
    GET_BRA_ONE(2).then((data) {
      BRA_INF = data;
      if(BRA_INF.isNotEmpty){
        SelectDataFromBIID=BRA_INF.elementAt(0).BIID.toString();
        SelectDataToBIID=BRA_INF.elementAt(0).BIID.toString();
      }
      update();
    });
  }

  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D() async {
    Get_SYS_DOC_D(SRTY!,202, LoginController().BIID).then((data) {
      GET_SYS_DOC = data;
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
    });
  }


  //جلب العمله عند الدخول
  Future GET_SYS_CUR_ONE_P() async {
    GET_SYS_CUR_ONE_SALE().then((data) {
      SYS_CUR = data;
      if(SYS_CUR.isNotEmpty){
        SelectDataSCID=SYS_CUR.elementAt(0).SCID.toString();
        SCNA=SYS_CUR.elementAt(0).SCNA_D.toString();
        SCSY=SYS_CUR.elementAt(0).SCSY!;
      }
      update();
    });
  }


  void clear() {
    // TODO: implement dispose
    SelectDataFromBIID= LoginController().BIID.toString();
    SelectDataToBIID= LoginController().BIID.toString();
    SelectDataACNO_F=null;
    SelectDataACNO_T=null;
    AANAController.clear();
    AANOController.clear();
    SelectGET_BRA_T='1';
    SelectDataSCID=null;
    SelectDataAANO=null;
    SelectDataAANO2=null;
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
     BRA_COL = false;
     PRI_BIL_NOT = false;
     VIW_L_D = false;
     N_C_I = true;
     VIW_AD = false;
     VIW_L_MD = false;
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

  Future<void> Get_FromInsertDate(BuildContext context) async {
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
      SelectFromInsertDate =  DateFormat("dd-MM-yyyy").format(picked);
    }
    update();
  }

  Future<void> Get_ToInsertDate(BuildContext context) async {
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
      SelectToInsertDate = DateFormat("dd-MM-yyyy").format(picked);
    }
    update();
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


  Future<void> openPdfFromServer(String name,String GetPath) async {
    var url = "${LoginController().baseApi}/ESAPI/ESINF";
    final file =File('${LoginController().AppPath}Media/$name');
    print("${url}/GetFile");
    var TEST3 = {"typ": "file", "typ2": "${GetPath.replaceAll('/', '//')}"};
    print("${TEST3}/GetFile");
    try {
      // Download the PDF file from the server
      var response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: const Duration(seconds: 7),)
          ,queryParameters: TEST3);
      // final response = await http.get(Uri.parse(pdfUrl));

      // Get the temporary directory on the device
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/EMobileProSign.png';

      // Save the PDF file to the temporary directory
      final file = File(filePath);
      await file.writeAsBytes(response.data);
      var b = await File(filePath).exists();
      if(b==true){
        print('true');
      }
      else{
        print('false');
      }
print({tempDir.path});
print(filePath);
print('filePath');
      // Open the PDF file using the default PDF viewer app
      OpenFilex.open(filePath);
    } catch (e) {
      print('Error opening PDF file: $e');
    }
  }

  //okk
  Future<void> openPdfFile(String filename) async {
    print('${LoginController().AppPath}Media/$filename');
    print('filePath');
    String pdfFilePath = '${LoginController().AppPath}Media/$filename';
    // try {
      // افتح ملف PDF باستخدام تطبيق عرض PDF الافتراضي
      OpenFilex.open(pdfFilePath);
    // } catch (e) {
    //   print('خطأ في فتح ملف PDF: $e');
    // }
  }

  Future<void> openPdfFromDevice() async {
    try {
      // اختيار ملف PDF من جوال المستخدم
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        String? filePath = result.files.single.path;

        // فتح ملف PDF باستخدام تطبيق عرض PDF الافتراضي
        OpenFilex.open(filePath!);
      }
    } catch (e) {
      print('خطأ في فتح ملف PDF: $e');
    }
  }

Future openfile(url,fileName) async{
  print("/file.path");
  openPdfFromServer("EMobileProSign.png", SYS_OWN.elementAt(0).SOSI.toString());
}

  Future<File?> GetFile(String name,String GetPath) async {
    var url = "${LoginController().baseApi}/ESAPI/ESINF";
    final file =File('${LoginController().AppPath}Media/$name');
    print("url: ${url}");
    var TEST3 = {"typ": "file", "typ2": "${GetPath.replaceAll('/', '//')}"};
    print("${TEST3}/GetFile");
      var response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: const Duration(seconds: 7),)
          ,queryParameters: TEST3);
      final raf =file.openSync(mode: FileMode.write);
      print("${raf}/raf");
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
  }


  Future<dynamic> TEST_API() async {
    var url = "${LoginController().baseApi}/ESAPI/ESINF";
    print(url);
    try {
      GUID = uuid.v4().toString().toUpperCase();
      PAR_V="[SUID{${LoginController().SUID}}]"
          "[BIID_F{$SelectDataFromBIID}][BIID_T{$SelectDataToBIID}][ACNO_F1{$SelectDataACNO_F}][ACNO_T1{$SelectDataACNO_T}]"
          "[TO_D{$SelectFromDays}]FROM_D{$SelectToDays}][FROM_DA{$SelectFromInsertDate}]TO_DA{$SelectToInsertDate}]"
          "[BRA_T{$SelectGET_BRA_T}][AC_T{$AC_T}][AATY{$AATY}][ID_F{$BCID_F}][ID_T{$BCID_T}][ID_F2{$BIID_F}][ID_T2{$BIID_T}]"
          "[AANO{$AANO_F}][AANO_T{$AANO_T}][BCTID{$BCTID_F}][BCTID_T{$BCTID_T}][BITID{$BITID_F}][BITID_T{$BITID_T}]"
          "[SCID{$SCID_F}][SCID_T{$SCID_T}][AGID{$AGID_F}][AGID_T{$AGID_F}][BCST{$ST_F}][BCST_T{$ST_T}]"
          "[AMMST{$AMMST_T}][AC_BAL{$AC_V_B}][AC_BAL2{$AC_BAL2}][CWID{$SelectDataCWID}][CTID{$SelectDataCTID}]"
          "[BAID{$BAID_F}][BAID_T{$BAID_T}][BDID{$BDID_F}][BDID_T{$BDID_T}][CON_3{$CON3_F}][AM_F{$AM_FController}]"
          "[CON_4{$CON3_T}][AM_T{$AM_TController}][BRA_COL{$BRA_COL}][N_C_I{$N_C_I}][BIL_N_A{$PRI_BIL_NOT}][VIW_BP{$VIW_BP}]"
          "[VIW_L_D{$VIW_L_D}][VIW_AD{$VIW_AD}][VIW_L_MD{$VIW_L_MD}][HI_B{$HI_B}]"
          "[REP_GRO{$REP_GRO}][REP_GRO2{$REP_GRO2}][R_TY{$R_TY}][R_TY3{$R_TY3}][R_T{$REP_DIR}][R_TYP_N{$R_TYP}]";

      var PAR = {
        "typ": "run_pro",
        "typ2": "D:\\ES_TOOLS\\ORANT\\AR\\BIN\\ifrun60.EXE",
        "typ3": "run",
        "typ4": "d:\\ELITEPRO",
        "typ5": "MODULE=D:\\ELITEPRO\\FORMS\\NEW_FOR.fmx<> P_LAN=1<> P_BIID=1<> P_JTID=1<> P_SYID=1<> P_SUAC=1<> P_US='1'<> P_CON_STR='ELITE'<> P_COS=1<> P_WH=521.000<> P_WW=1025.000<> P_SYS_NAM='WAM'<> P_SYS_PATH='D:\\ELITEPRO'<> P_COS352=2<> P_STO_NUM=2<> P_WORK_ID=1<>  P_SYS_TYP='1'<> P_OPEN_Y=2<> P_ECO_STA=1<> P_CIID=1<> P_ST='1'<> P_SYSD='31-12-2017'<> P_SYED='31-12-2023'<> P_SYSD2='31-12-2017'<> P_SYED2='31-12-2023'<> P_SYAC='O'<> P_SYST='1'<> P_CURRENT_FORM='MAIN_ACC'<> P_OFF_LINE='0'<> P_STO_TYP='1'<> P_FON_NAM='Times New Roman'<> P_STO_CUR='1'<>  P_FON_SIZ='10'<> P_STO_COS='1'<> P_GRO_ACC='1'<> P_COS353='1'<> P_BRA_TYP='2'<>  P_SIID='221'<> P_SYS_DIR='D:\\ELITEPRO\\FORMS'<> P_DOT_N='2'<> P_CH_UN1='1'<>  P_CH_UN2='2'<> P_REG_S='1'<> P_OR_PATH='D:\\ES_TOOLS\\ORANT\\AR'<> P_PRO_NAM='PR'<>  P_VER_N='4'<> P_FAS='1'<> P_SCREEN='1'<> P_OPENSCREEN='1'<> P_FAV='1'<>  P_THEM='A'<> P_UPD_N='445'<> P_AE='PRINT'<> P_AE2='1003'<> P_IS_APP=1<> P_SOMID_APP=${LoginController().SYDV_ID}<>  P_AE_ALL=$PAR_V",
      };
      print("${PAR}/TEST_API");
      print("${PAR_V}");
      var response = await Dio().get(url, queryParameters: PAR);
      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 10));
        print('111');
        var url = "${LoginController().baseApi}/ESAPI/ESINF";
        final file =File("${LoginController().AppPath}Media/11.pdf");
        print("${url}/GetFile");
        var TEST3 = {"typ": "file", "typ2": "D:\\ELITEPRO\\ES_TMP\\11.pdf"};
        print("${TEST3}/GetFile");
        try {
          var response = await Dio().get(url, options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: const Duration(seconds: 10),),
              queryParameters: TEST3);
          if (response.statusCode == 200) {
            print(response.data);
            print('GetFile');

            await file.writeAsBytes(response.data);
            openPdfFile('11.pdf');
            //saveFile('1111.pdf');
            //return file;
          }
        } on DioException catch (e) {
          return Future.error("DioError: ${e.message}");
        }
        // saveFile('');
        // await OpenFile.open(url);
      } else if (response.statusCode == 207) {
        print(' response.statusCode ${response.statusCode}''${response.data}');
        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }else {
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      Get.snackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("DioError: ${e.message}");
    }
  }

  void Socket_IP(String IP,int Port) async {
    Socket.connect(IP, Port, timeout: const Duration(seconds: 30)).then((socket) async {
      print("Success connect");
      GUID = uuid.v4();
      PAR_V="[SUID{${LoginController().SUID}}]"
          "[BIID2_F{$SelectDataFromBIID}][BIID2_T{$SelectDataToBIID}][TO_D{$SelectFromDays}][BRA_COL{2}]"
          "[ACNO_F{1}][ACNO_T{101}][SCID_F{1}][SCID_T{1}]";
      F_GUID_V = GUID;
      print(PAR_V);
      print('طلب كشف حساب رئيسي');
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
