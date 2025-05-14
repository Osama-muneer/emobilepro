import 'dart:async';
import '../../Operation/models/bil_mov_d.dart';
import '../../Operation/models/bil_mov_m.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/bil_cre_c.dart';
import '../../Widgets/config.dart';
import '../../Widgets/pdf.dart';
import '../../Widgets/pdfpakage.dart';
import '../../database/report_db.dart';
import '../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;

List<Bil_Mov_M_Local> BIF_MOV_M_List = [];
List<Bil_Mov_M_Local> BIF_MOV_M_REP = [];
List<Bil_Mov_M_Local> BIF_MOV_M_REP2 = [];
List<Bil_Mov_M_Local> GET_BCCAM1_REP = [];
List<Bil_Mov_M_Local> GET_BCCAM2_REP = [];
List<Bil_Mov_M_Local> GET_BCCAM3_REP = [];
late List<Bil_Cre_C_Local> BIL_CRE_C_List = [];
List<Bil_Mov_D_Local> Bil_Mov_D = [];
List<Bil_Mov_D_Local> Bil_Mov_D_SUM = [];

class Inv_Rep_Controller extends GetxController {
  //TODO: Implement HomeController
  final formatter = intl.NumberFormat.decimalPattern();
  var isloading = false.obs;
  bool value = false;
  bool value1 = false;
  // late  DateTime dateFromDays =  DateFormat('dd-MM-yyyy').format(DateTime.now()) as DateTime;
  DateTime dateFromDays1 = DateTime.now();
  String dateFromDays = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? SelectFromDays,SelectToDays;
  String? SelectDataFromBIID='',SelectDataToBIID='',SelectDataFromBPID,SelectDataToBPID,
          SelectDataFromBINA, SelectDataToBINA,SelectDataFromMGNO,SelectDataToMGNO,
          SelectDataSCID,PKID,SelectDataFromMINO,SelectDataToMINO,SelectDataBMKID,SelectDataST='1',
      SelectDataST_T='2', SelectDataBMKID_T,SelectDataSCID_T;
  int BMKID=11;
  double SUMBMDNO=0,SUMBMDMT=0;
  List<Bil_Mov_M_Local> Bil_Mov_M = [];


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
      firstDate: DateTime(2022,5),
      lastDate: DateTime(2030),
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
      SelectFromDays =  DateFormat("yyyy-MM-dd").format(picked);
    }
    update();
    refresh();
  }
  Future<void> selectDateToDays(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTimeToDays2,
      firstDate: DateTime(2022, 5),
      lastDate: DateTime(2030),
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
      SelectToDays = DateFormat("yyyy-MM-dd").format(picked);
    }
    update();
    refresh();
  }
  String SDDSA='',SONA='',SONE='',SORN='',SOLN='';
  late TextEditingController  TextEditingSercheController;


  @override
  void onInit() async {
    STMID=='EORD' ||  STMID=='COU'?BMKID=11:(Get.arguments==3 || BMKID==3) ? BMKID=3 : (Get.arguments==1 || BMKID==1) ? BMKID=1 :
    (Get.arguments==101 || BMKID==101)? BMKID=101 :(Get.arguments==102 || BMKID==102) ? BMKID=102  :BMKID=11;
    SelectDataFromBIID = LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
    TextEditingSercheController = TextEditingController();
    SelectDataFromMINO=null;
    SelectDataToMINO=null;
    SelectDataToMGNO=null;
    SelectDataFromMGNO=null;
    GET_SYS_OWN_P();
    GET_BIL_CRE_C_P();
    super.onInit();
  }

  void clearData() {
    // TODO: implement dispose
    SelectDataBMKID=null;
    SelectDataBMKID_T=null;
    SelectDataFromMINO=null;
    SelectDataToMINO=null;
    SelectDataToMGNO=null;
    SelectDataFromMGNO=null;
    SelectDataFromBIID =LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
  //  SelectDataBMKID = '3';
    SelectDataFromBPID=null;
    SelectDataToBPID=null;
    PKID=null;
    SelectDataSCID=null;
    SelectDataSCID_T=null;
    value = false;
    value1 = false;
    SelectFromDays = DateFormat('yyyy-MM-dd').format(DateTime.now());
    SelectToDays =  DateFormat('yyyy-MM-dd').format(DateTime.now());
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

  @override
  void dispose() {
    // TODO: implement dispose
    TextEditingSercheController.dispose();
    super.dispose();
  }

  //جلب بطائق الائتمان
  Future GET_BIL_CRE_C_P() async {
    GET_BIL_CRE_C_APPROVE().then((data) {
      BIL_CRE_C_List = data;
      print('GET_BIL_CRE_C_P');
      print(BIL_CRE_C_List.length);
    });
  }

  Future GET_TotalDetailedItem_REP_P() async {
    isloading.value=true;

    Bil_Mov_M=await GET_TotalDetailedItem_REP2(BMKID,
        SelectDataBMKID=='11' || SelectDataBMKID=='12'?'BIF_MOV_M':'BIL_MOV_M',
        SelectDataBMKID=='11'?'BIF_MOV_D':'BIL_MOV_D',SelectDataBMKID.toString(),
        SelectDataBMKID_T.toString(),
        SelectDataFromBIID.toString(),SelectDataToBIID.toString(),
        SelectFromDays.toString(),SelectToDays.toString(),SelectDataFromMGNO.toString(),
        SelectDataToMGNO.toString(),
        SelectDataFromMINO.toString(),SelectDataToMINO.toString(),PKID.toString(),
        SelectDataSCID.toString(),SelectDataSCID_T.toString(),
        SelectDataST.toString(),SelectDataST_T.toString());

    if(Bil_Mov_M.isEmpty ){
      Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
          backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      isloading.value=false;
    }
    else {
      //  var Bil_Mov_M= await fetchDetailedMovements();
      // generatePdfReport(controller.Bil_Mov_M);

      final pdfFile =  await Pdf.TotalDetailedItemReport_Pdf2(
          BMKID.toString(),
          SelectDataBMKID.toString(),
          SelectDataFromBINA.toString(),
          SelectDataToBINA.toString(),
          SDDSA, SONA,
          SONE,
          SORN,
          SOLN,
          LoginController().SUNA,
          SelectFromDays.toString().substring(0,10),
          SelectToDays.toString().substring(0,10),
          SUMBMDNO,
          SUMBMDMT,
          Bil_Mov_M
      );
      PdfPakage.openFile(pdfFile);
      isloading.value=false;
      update();
    }

  }

  Future Fetch_GET_BIF_REP_PdfData() async {
    isloading.value=true;
    BIF_MOV_M_List=await GET_BIF_REP(
        BMKID==11?'BIF_MOV_M':'BIL_MOV_M',
        BMKID==11?'BIF_MOV_D':'BIL_MOV_D',
        BMKID.toString(),
        SelectDataFromBIID!,
        SelectDataToBIID!,
        SelectFromDays!,
        SelectToDays!,
        SelectDataFromBPID.toString(),
        SelectDataToBPID.toString(),PKID.toString(),
        SelectDataSCID.toString(),
        SelectDataST.toString());
    BIF_MOV_M_REP=await GET_BIF_REP2(
        BMKID==11?'BIF_MOV_M':'BIL_MOV_M',
        BMKID.toString(),
        SelectDataFromBIID!,
        SelectDataToBIID!,
        SelectFromDays!,
        SelectToDays!,
        SelectDataFromBPID.toString(),
        SelectDataToBPID.toString(),PKID.toString(),
        SelectDataSCID.toString(),
        SelectDataST.toString());
    BIF_MOV_M_REP2=await GET_BIF_REP3(
        BMKID==11?'BIF_MOV_M':'BIL_MOV_M',
        BMKID.toString(),
        SelectDataFromBIID!,
        SelectDataToBIID!,
        SelectFromDays!,
        SelectToDays!,
        SelectDataFromBPID.toString(),
        SelectDataToBPID.toString(),PKID.toString(),
        SelectDataSCID.toString(),
        SelectDataST.toString());
    if(BIL_CRE_C_List.length>0){
      if( BIL_CRE_C_List.length==1){
        GET_BCCAM1(
            BMKID==11?'BIF_MOV_M':'BIL_MOV_M',
            BMKID.toString(),
            SelectDataFromBIID!,
            SelectDataToBIID!,
            SelectFromDays!,
            SelectToDays!,
            SelectDataFromBPID.toString(),
            SelectDataToBPID.toString()
            ,BIL_CRE_C_List[0].BCCID.toString(),PKID.toString(),
            SelectDataSCID.toString(),
            SelectDataST.toString()).then((data) {
          GET_BCCAM1_REP = data;
          update();
          Timer(const Duration(milliseconds: 1200), () async {
            SUM_BCCID=GET_BCCAM1_REP.elementAt(0).SUM_BCCAM1;
            print(SUM_BCCID);
            print('SUM_BCCID');
            update();
          });
        });
      }
      else if(BIL_CRE_C_List.length==2){
        GET_BCCAM1_REP=await GET_BCCAM1(
            BMKID==11?'BIF_MOV_M':'BIL_MOV_M',
            BMKID.toString(),
            SelectDataFromBIID!,
            SelectDataToBIID!,
            SelectFromDays!,
            SelectToDays!,
            SelectDataFromBPID.toString(),
            SelectDataToBPID.toString(),
            BIL_CRE_C_List[0].BCCID.toString(),PKID.toString(),
            SelectDataSCID.toString(),
            SelectDataST.toString());
        GET_BCCAM2_REP=await GET_BCCAM2(
            BMKID==11?'BIF_MOV_M':'BIL_MOV_M',
            BMKID.toString(),
            SelectDataFromBIID!,
            SelectDataToBIID!,
            SelectFromDays!,
            SelectToDays!,
            SelectDataFromBPID.toString(),
            SelectDataToBPID.toString(),
            BIL_CRE_C_List[1].BCCID.toString(),PKID.toString(),
            SelectDataSCID.toString(),
            SelectDataST.toString());
        update();
        Timer(const Duration(milliseconds: 1200), () async {
          SUM_BCCID=double.parse(GET_BCCAM1_REP.elementAt(0).SUM_BCCAM1.toString())+double.parse(GET_BCCAM2_REP.elementAt(0).SUM_BCCAM2.toString());
          print(SUM_BCCID);
          print('SUM_BCCID');
          update();
        });
      }
      else{
        GET_BCCAM1_REP=await GET_BCCAM1(
            BMKID==11?'BIF_MOV_M':'BIL_MOV_M',
            BMKID.toString(),
            SelectDataFromBIID!,
            SelectDataToBIID!,
            SelectFromDays!,
            SelectToDays!,
            SelectDataFromBPID.toString(),
            SelectDataToBPID.toString(),
            BIL_CRE_C_List[0].BCCID.toString(),PKID.toString(),
            SelectDataSCID.toString(),
            SelectDataST.toString());
        GET_BCCAM2_REP=await  GET_BCCAM2(
            BMKID==11?'BIF_MOV_M':'BIL_MOV_M',
            BMKID.toString(),
            SelectDataFromBIID!,
            SelectDataToBIID!,
            SelectFromDays!,
            SelectToDays!,
            SelectDataFromBPID.toString(),
            SelectDataToBPID.toString(),
            BIL_CRE_C_List[1].BCCID.toString(),PKID.toString(),
            SelectDataSCID.toString(),
            SelectDataST.toString());
        GET_BCCAM3_REP=await GET_BCCAM3(
            BMKID==11?'BIF_MOV_M':'BIL_MOV_M',
            BMKID.toString(),
            SelectDataFromBIID!,
            SelectDataToBIID!,
            SelectFromDays!,
            SelectToDays!,
            SelectDataFromBPID.toString(),
            SelectDataToBPID.toString(),
            BIL_CRE_C_List[2].BCCID.toString(),PKID.toString(),
            SelectDataSCID.toString(),
            SelectDataST.toString());
        update();
        Timer(const Duration(milliseconds: 1400), () async {
          SUM_BCCID=double.parse(GET_BCCAM1_REP.elementAt(0).SUM_BCCAM1.toString())+double.parse(GET_BCCAM2_REP.elementAt(0).SUM_BCCAM2.toString())
              +double.parse(GET_BCCAM3_REP.elementAt(0).SUM_BCCAM3.toString());
          print(SUM_BCCID);
          print('SUM_BCCID');
          update();
        });
      }
    }else{
      GET_BCCAM1_REP=[];
    }

  }
}


