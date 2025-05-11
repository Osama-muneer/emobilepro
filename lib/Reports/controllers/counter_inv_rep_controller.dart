import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import '../../Operation/models/bil_mov_m.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/bil_cre_c.dart';
import '../../database/report_db.dart';

List<Bil_Mov_M_Local> BIF_MOV_M_List = [];
List<Bil_Mov_M_Local> BIF_MOV_M_REP = [];
List<Bil_Mov_M_Local> BIF_MOV_M_REP2 = [];
List<Bil_Mov_M_Local> GET_BCCAM1_REP = [];
List<Bil_Mov_M_Local> GET_BCCAM2_REP = [];
List<Bil_Mov_M_Local> GET_BCCAM3_REP = [];
List<Bil_Cre_C_Local> BIL_CRE_C_List = [];
class Counter_Inv_Rep_Controller extends GetxController {
  //TODO: Implement HomeController
  var isloadingHint = false.obs;
  var isloading = false.obs;
  bool value = false;
  bool value1 = false;
  bool valueAll = true;
  bool valuePlus = false;
  bool valueEquil = false;
  bool valueMinus = false;
 String SetTypeValue='All',t='0';
 // late  DateTime dateFromDays =  DateFormat('dd-MM-yyyy').format(DateTime.now()) as DateTime;
  DateTime dateFromDays1 = DateTime.now();
  String dateFromDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String? SelectFromDays,SelectToDays,SelectDataF_SIID,SelectDataT_SIID,SelectDataSNED,TypeScreen;
  String? SelectDataFromBIID='',SelectDataToBIID='',SelectDataFromBPID,SelectDataToBPID,SelectDataFromCTMID,
      SelectDataToCTMID,SelectDataFromCIMID, SelectDataToCIMID, SelectDataFromBINA, SelectDataToBINA,
      SelectDataSINA,SelectBINA,SelectDataSCID,PKID;
  int plus=0,countMINO=0,Minus=0,Equil=0,SUM_SMDDF=0,UPIN_PKID=1;
  double SUM_SMDNO=0.0,SUM_SMDNF=0.0;
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
      SelectFromDays =  DateFormat("dd-MM-yyyy").format(picked);
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
      SelectToDays = DateFormat("dd-MM-yyyy").format(picked);
    }
    update();
    refresh();
  }

  String SMDED='',SDDSA='',SONA='',SONE='',SORN='',SOLN='';
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  var dbHelper;

  late TextEditingController
      FromMGNOController,
      ToMGNOController,
      FromMGNAController,
      ToMGNAController,
      FromSMMNOController,
      ToSMMNOController,
      MINAController,
      MINOController,
      TYPEController;


  int? type;
  String Type="";
  late FocusNode myFocusNode;
  late FocusNode myFocus;


  @override
  void onInit() async {
    SelectDataFromBIID = LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
    FromMGNOController = TextEditingController();
    ToMGNOController = TextEditingController();
    MINOController = TextEditingController();
    FromMGNAController = TextEditingController();
    ToMGNAController = TextEditingController();
    FromSMMNOController = TextEditingController();
    ToSMMNOController = TextEditingController();
    MINAController = TextEditingController();
    TYPEController = TextEditingController();
    myFocusNode = FocusNode();
    myFocus = FocusNode();
    GET_BIL_CRE_C_P();
  //  GET_Sys_Own();
  //  USE_SMDED_P();
   // GET_SYS_DOC_D();
    super.onInit();
  }


  //
  // //جلب تذلبل المستندات
  // Future GET_SYS_DOC_D() async {
  //   Get_SYS_DOC_D(17,1).then((data) {
  //     GET_SYS_DOC = data;
  //     SDDSA=GET_SYS_DOC.elementAt(0).SDDSA_D.toString();
  //   });
  // }

  void clear() {
    // TODO: implement dispose
    FromMGNOController.text='';
    ToMGNOController.text='';
    FromMGNAController.text='';
    ToMGNAController.text='';
    FromSMMNOController.text='';
    ToSMMNOController.text='';
    SelectDataF_SIID=null;
    SelectDataT_SIID=null;
    SelectDataFromBIID =LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
    SelectDataFromCTMID=null;
    SelectDataToCTMID=null;
    SelectDataFromBPID=null;
    SelectDataToBPID=null;
    SelectDataFromCIMID=null;
    SelectDataToCIMID=null;
    value = false;
    value1 = false;
    valueAll = true;
    valuePlus = false;
    valueEquil = false;
    valueMinus = false;
    SelectFromDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
    SelectToDays =  DateFormat('dd-MM-yyyy').format(DateTime.now());
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    FromMGNOController.dispose();
    ToMGNOController.dispose();
    FromMGNAController.dispose();
    ToMGNAController.dispose();
    FromSMMNOController.dispose();
    ToSMMNOController.dispose();
    MINOController.dispose();
    MINAController.dispose();
    TYPEController.dispose();
    super.dispose();
  }


  //جلب بطائق الائتمان
  Future GET_BIL_CRE_C_P() async {
    GET_BIL_CRE_C_APPROVE_REP().then((data) {
      BIL_CRE_C_List = data;
    });
  }

  //جلب حركة جرد مخزني الي pdf
  Future<void> Fetch_GET_BIF_REP_PdfData() async {
    isloading.value = true;
    try {
      // استدعاء التقارير الرئيسية
      BIF_MOV_M_List = await GET_COUNTER_BIF_REP(
        SelectDataFromBIID!,
        SelectDataToBIID!,
        SelectFromDays!,
        SelectToDays!,
        SelectDataFromCTMID.toString(),
        SelectDataToCTMID.toString(),
        SelectDataFromBPID.toString(),
        SelectDataToBPID.toString(),
        SelectDataFromCIMID.toString(),
        SelectDataToCIMID.toString(),
      );

      BIF_MOV_M_REP = await GET_COUNTER_BIF_REP2(
        SelectDataFromBIID!,
        SelectDataToBIID!,
        SelectFromDays!,
        SelectToDays!,
        SelectDataFromCTMID.toString(),
        SelectDataToCTMID.toString(),
        SelectDataFromBPID.toString(),
        SelectDataToBPID.toString(),
        SelectDataFromCIMID.toString(),
        SelectDataToCIMID.toString(),
      );

      BIF_MOV_M_REP2 = await GET_COUNTER_BIF_REP3(
        SelectDataFromBIID!,
        SelectDataToBIID!,
        SelectFromDays!,
        SelectToDays!,
        SelectDataFromCTMID.toString(),
        SelectDataToCTMID.toString(),
        SelectDataFromBPID.toString(),
        SelectDataToBPID.toString(),
        SelectDataFromCIMID.toString(),
        SelectDataToCIMID.toString(),
      );

      // التعامل مع بيانات قائمة BIL_CRE_C_List
      if (BIL_CRE_C_List.length == 1) {
        GET_BCCAM1_REP = await GET_COUNTER_BCCAM1(
          SelectDataFromBIID!,
          SelectDataToBIID!,
          SelectFromDays!,
          SelectToDays!,
          SelectDataFromCTMID.toString(),
          SelectDataToCTMID.toString(),
          SelectDataFromBPID.toString(),
          SelectDataToBPID.toString(),
          SelectDataFromCIMID.toString(),
          SelectDataToCIMID.toString(),
          BIL_CRE_C_List[0].BCCID.toString(),
        );
        update();
        if (GET_BCCAM1_REP.isNotEmpty) {
          // تأخير قبل حساب المجموع
          await Future.delayed(const Duration(milliseconds: 1200));
          SUM_BCCID = GET_BCCAM1_REP.first.SUM_BCCAM1;
          print('SUM_BCCID: $SUM_BCCID');
          update();
        }
      } else if (BIL_CRE_C_List.length == 2) {
        GET_BCCAM1_REP = await GET_COUNTER_BCCAM1(
          SelectDataFromBIID!,
          SelectDataToBIID!,
          SelectFromDays!,
          SelectToDays!,
          SelectDataFromCTMID.toString(),
          SelectDataToCTMID.toString(),
          SelectDataFromBPID.toString(),
          SelectDataToBPID.toString(),
          SelectDataFromCIMID.toString(),
          SelectDataToCIMID.toString(),
          BIL_CRE_C_List[0].BCCID.toString(),
        );
        GET_BCCAM2_REP = await GET_COUNTER_BCCAM2(
          SelectDataFromBIID!,
          SelectDataToBIID!,
          SelectFromDays!,
          SelectToDays!,
          SelectDataFromCTMID.toString(),
          SelectDataToCTMID.toString(),
          SelectDataFromBPID.toString(),
          SelectDataToBPID.toString(),
          SelectDataFromCIMID.toString(),
          SelectDataToCIMID.toString(),
          BIL_CRE_C_List[1].BCCID.toString(),
        );
        update();
        await Future.delayed(const Duration(milliseconds: 1200));
        // التحقق من وجود عناصر لتفادي RangeError
        if (GET_BCCAM1_REP.isNotEmpty && GET_BCCAM2_REP.isNotEmpty) {
          SUM_BCCID = double.parse(GET_BCCAM1_REP.first.SUM_BCCAM1.toString()) +
              double.parse(GET_BCCAM2_REP.first.SUM_BCCAM2.toString());
          print('SUM_BCCID: $SUM_BCCID');
          update();
        }
      } else if (BIL_CRE_C_List.length >= 3) {
        GET_BCCAM1_REP = await GET_COUNTER_BCCAM1(
          SelectDataFromBIID!,
          SelectDataToBIID!,
          SelectFromDays!,
          SelectToDays!,
          SelectDataFromCTMID.toString(),
          SelectDataToCTMID.toString(),
          SelectDataFromBPID.toString(),
          SelectDataToBPID.toString(),
          SelectDataFromCIMID.toString(),
          SelectDataToCIMID.toString(),
          BIL_CRE_C_List[0].BCCID.toString(),
        );
        GET_BCCAM2_REP = await GET_COUNTER_BCCAM2(
          SelectDataFromBIID!,
          SelectDataToBIID!,
          SelectFromDays!,
          SelectToDays!,
          SelectDataFromCTMID.toString(),
          SelectDataToCTMID.toString(),
          SelectDataFromBPID.toString(),
          SelectDataToBPID.toString(),
          SelectDataFromCIMID.toString(),
          SelectDataToCIMID.toString(),
          BIL_CRE_C_List[1].BCCID.toString(),
        );
        GET_BCCAM3_REP = await GET_COUNTER_BCCAM3(
          SelectDataFromBIID!,
          SelectDataToBIID!,
          SelectFromDays!,
          SelectToDays!,
          SelectDataFromCTMID.toString(),
          SelectDataToCTMID.toString(),
          SelectDataFromBPID.toString(),
          SelectDataToBPID.toString(),
          SelectDataFromCIMID.toString(),
          SelectDataToCIMID.toString(),
          BIL_CRE_C_List[2].BCCID.toString(),
        );
        update();
        await Future.delayed(const Duration(milliseconds: 1400));
        if (GET_BCCAM1_REP.isNotEmpty &&
            GET_BCCAM2_REP.isNotEmpty &&
            GET_BCCAM3_REP.isNotEmpty) {
          SUM_BCCID = double.parse(GET_BCCAM1_REP.first.SUM_BCCAM1.toString()) +
              double.parse(GET_BCCAM2_REP.first.SUM_BCCAM2.toString()) +
              double.parse(GET_BCCAM3_REP.first.SUM_BCCAM3.toString());
          print('SUM_BCCID: $SUM_BCCID');
          update();
        }
      }
    } catch (e, s) {
      print('Error in Fetch_GET_BIF_REP_PdfData: $e\n$s');
    } finally {
      isloading.value = false;
    }
  }


}
