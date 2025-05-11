import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import '../../Operation/models/bif_cou_c.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/bil_cre_c.dart';
import '../../Setting/models/sys_own.dart';
import '../../database/report_db.dart';
import '../../database/setting_db.dart';

List<Bif_Cou_C_Local> BIF_COU_C_List = [];
List<Bif_Cou_C_Local> COUNT_BMMID_P_List = [];
List<Bif_Cou_C_Local> BIF_COU_C_List_SUM = [];
late List<Bil_Cre_C_Local> BIL_CRE_C_List2 = [];

class Approving_rep_controller extends GetxController {
  //جلب عدد الفواتير
  Future GET_COUNT_BIF_COU_C_P() async {
    GET_COUNT_BIF_COU_C().then((data) {
      COUNT_BMMID_P_List  = data;}
    );
  }
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
  late List<Sys_Own_Local> SYS_OWN;
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
  double SUM_SMDNO=0.0,SUM_SMDNF=0.0,SUMBCMRO=0.0,SUMBCMRN=0.0,SUMBCMAMSUM=0.0,SUMBCMTA=0.0;
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
    GET_SYS_OWN_P();
    GET_BIL_CRE_C_P();
    super.onInit();
  }

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
      BIL_CRE_C_List2 = data;
    });
  }


  //جلب بيانات المنشاة
  Future GET_SYS_OWN_P() async {
    GET_SYS_OWN(LoginController().BIID).then((data) {
      SYS_OWN = data;
      if (SYS_OWN.isNotEmpty) {
        SONA = SYS_OWN.elementAt(0).SONA.toString();
        SONE = SYS_OWN.elementAt(0).SONE.toString();
        SORN = SYS_OWN.elementAt(0).SORN.toString();
        SOLN = SYS_OWN.elementAt(0).SOLN.toString();
      }
    });
  }


  //جلب حركة جرد مخزني الي pdf
  Future Fetch_GET_BIF_REP_PdfData() async {
    isloading.value=true;
    BIF_COU_C_List=await GET_BIF_COU_REP(
        SelectDataFromBIID!,
        SelectDataToBIID!,
        SelectFromDays!,
        SelectToDays!,
        SelectDataFromCTMID.toString(),
        SelectDataToCTMID.toString(),
        SelectDataFromBPID.toString(),
        SelectDataToBPID.toString(),
        SelectDataFromCIMID.toString(),
        SelectDataToCIMID.toString());

    BIF_COU_C_List_SUM=await GET_BIF_COU_REP_SUM(
        SelectDataFromBIID!,
        SelectDataToBIID!,
        SelectFromDays!,
        SelectToDays!,
        SelectDataFromCTMID.toString(),
        SelectDataToCTMID.toString(),
        SelectDataFromBPID.toString(),
        SelectDataToBPID.toString(),
        SelectDataFromCIMID.toString(),
        SelectDataToCIMID.toString());
      if( BIF_COU_C_List_SUM.isNotEmpty ){
        SUMBCMRO=double.parse(BIF_COU_C_List_SUM.elementAt(0).SUMBCMRO.toString());
        SUMBCMRN=double.parse(BIF_COU_C_List_SUM.elementAt(0).SUMBCMRN.toString());
        SUMBCMAMSUM=double.parse(BIF_COU_C_List_SUM.elementAt(0).SUMBCMAMSUM.toString());
        SUMBCMTA=double.parse(BIF_COU_C_List_SUM.elementAt(0).SUMBCMTA.toString());
        print(BIF_COU_C_List.length);
        print('sql122222222');
      }

  }
}
