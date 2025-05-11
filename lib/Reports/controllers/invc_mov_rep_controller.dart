import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../../Operation/models/inventory.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../database/report_db.dart';
import '../../database/setting_db.dart';

List<Sto_Mov_D_Local> STO_MOV_D_List = [];

class Invc_Mov_RepController extends GetxController {
  //TODO: Implement HomeController
  var isloading = false.obs;
  bool value = false;
  bool value1 = false;
  bool valueAll = true;
  bool valuePlus = false;
  bool valueEquil = false;
  bool valueMinus = false;
 String SetTypeValue='All';
 // late  DateTime dateFromDays =  DateFormat('dd-MM-yyyy').format(DateTime.now()) as DateTime;
  DateTime dateFromDays1 = DateTime.now();
  String dateFromDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('dd-MM-yyyy').format(DateTime.now());

  String? SelectFromDays,SelectToDays,SelectDataF_SIID,SelectDataT_SIID,SelectDataSNED,TypeScreen
  ,SelectDataFromMGNO,SelectDataToMGNO,SelectDataSMKID;
  int plus=0,countMINO=0,Minus=0,Equil=0,SUM_SMDDF=0;
  double SUM_SMDNO=0.0,SUM_SMDNF=0.0;


  String SelectDataFromBIID='',SelectDataToBIID='',SelectDataFromBINA='',SelectDataToBINA='',SelectDataSINA='',SelectBINA='',
      SMDED='',SDDSA='',SONA='',SONE='',SORN='',SOLN='',P_PR_REP='2';

  late TextEditingController
  FromMGNAController,
      ToMGNAController,
      FromSMMNOController,
      ToSMMNOController,
      TextEditingSercheController;

  static const MaterialColor buttonTextColor = const MaterialColor(
      0xFFEF5350,
    const <int, Color>{
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


  @override
  void onInit() async {
    SelectDataFromBIID = LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
    FromMGNAController = TextEditingController();
    ToMGNAController = TextEditingController();
    FromSMMNOController = TextEditingController();
    ToSMMNOController = TextEditingController();
    TextEditingSercheController = TextEditingController();
    GET_SYS_OWN_P();
    USE_SMDED_P();
    GET_SYS_DOC_D(17);
    Print_Price_Inventory_REP();
    super.onInit();
  }

  void clearData() {
    // TODO: implement dispose
    FromMGNAController.text='';
    ToMGNAController.text='';
    FromSMMNOController.text='';
    ToSMMNOController.text='';
    SelectDataSMKID=null;
    SelectDataF_SIID=null;
    SelectDataT_SIID=null;
    SelectDataFromMGNO=null;
    SelectDataToMGNO=null;
    SelectDataFromBIID =LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
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
    FromMGNAController.dispose();
    ToMGNAController.dispose();
    FromSMMNOController.dispose();
    ToSMMNOController.dispose();
    TextEditingSercheController.dispose();
    super.dispose();
  }



  //جلب حركة جرد مخزني الي pdf
  Future FetchGet_Inv_Mov_RepPdfData(SMKID) async {
    STO_MOV_D_List=await Get_Inv_Tra_Mov_Rep(SMKID,SelectDataFromBIID,SelectDataToBIID,SelectFromDays!,
        SelectToDays!,SelectDataFromMGNO.toString(),SelectDataToMGNO.toString(),SetTypeValue,
        FromSMMNOController.text,ToSMMNOController.text,SelectDataF_SIID==null?SelectDataF_SIID='':SelectDataF_SIID!
        ,SelectDataT_SIID==null?SelectDataT_SIID='':SelectDataT_SIID!);

    Get_SUM_ITEM(SMKID,SelectDataFromBIID,SelectDataToBIID,SelectFromDays!,
        SelectToDays!,SelectDataFromMGNO.toString(),SelectDataToMGNO.toString(),SetTypeValue,
        FromSMMNOController.text,ToSMMNOController.text,SelectDataF_SIID==null?SelectDataF_SIID='':SelectDataF_SIID!
        ,SelectDataT_SIID==null?SelectDataT_SIID='':SelectDataT_SIID!).then((data) {
      countMINO= COUNTMINO_ITEM!;
      Minus= Minus_ITEM!;
      Equil= Equil_ITEM!;
      plus= PLUS_ITEM!;
      SUM_SMDDF= SUM_SMDDF_ITEM!;
    });

    GET_SUMSMDNF(SMKID,SelectDataFromBIID,SelectDataToBIID,SelectFromDays!,
        SelectToDays!,SelectDataFromMGNO.toString(),SelectDataToMGNO.toString(),SetTypeValue,
        FromSMMNOController.text,ToSMMNOController.text,SelectDataF_SIID==null?SelectDataF_SIID='':SelectDataF_SIID!
        ,SelectDataT_SIID==null?SelectDataT_SIID='':SelectDataT_SIID!).then((data) {
      SUM_SMDNO=data.elementAt(0).SUM!;
      SUM_SMDNF=data.elementAt(0).SUMSMDFN!;
    });
  }


 // تقرير الاصناف المطابقه-الاصناف الزائده-الاصناف الناقصة
  Future FetchGET_Equ_Min_Plus_ITEM_RepPdfData(String TYP_REP) async {
    STO_MOV_D_List=await GET_Equ_Min_Plus_ITEM(TYP_REP);
  }


  Future FetchGet_Mat_Mov_RepPdfData() async {
    Get_Mat_Mov_Rep(SelectDataFromBIID,SelectDataToBIID,SelectFromDays!,
        SelectToDays!,SelectDataFromMGNO.toString(),SelectDataToMGNO.toString(),SetTypeValue,
        FromSMMNOController.text,ToSMMNOController.text,SelectDataF_SIID==null?SelectDataF_SIID='':SelectDataF_SIID!
        ,SelectDataT_SIID==null?SelectDataT_SIID='':SelectDataT_SIID!).then((data) {
          if(data.isNotEmpty){
            STO_MOV_D_List = data;
          }
    });
    Get_SUM_MAT(SelectDataFromBIID,SelectDataToBIID,SelectFromDays!,
        SelectToDays!,SelectDataFromMGNO.toString(),SelectDataToMGNO.toString(),SetTypeValue,
        FromSMMNOController.text,ToSMMNOController.text,SelectDataF_SIID==null?SelectDataF_SIID='':SelectDataF_SIID!
        ,SelectDataT_SIID==null?SelectDataT_SIID='':SelectDataT_SIID!).then((data) {
      countMINO= COUNTMINO_ITEM!;
    });

    GET_SUMSMDNF_MAT(SelectDataFromBIID,SelectDataToBIID,SelectFromDays!,
        SelectToDays!,SelectDataFromMGNO.toString(),SelectDataToMGNO.toString(),SetTypeValue,
        FromSMMNOController.text,ToSMMNOController.text,SelectDataF_SIID==null?SelectDataF_SIID='':SelectDataF_SIID!
        ,SelectDataT_SIID==null?SelectDataT_SIID='':SelectDataT_SIID!).then((data) {
      SUM_SMDNO=data.elementAt(0).SUM!;
    });
  }

  //طباعة السعر في تقارير الحركه المخزنيه
  Future Print_Price_Inventory_REP() async {
    var SYS_VAR=await GET_SYS_VAR(985);
      if (SYS_VAR.isNotEmpty) {
        P_PR_REP =  SYS_VAR.elementAt(0).SVVL.toString();
      } else {
        P_PR_REP = '2';
      }
  }


  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D(GETSDID) async {
    var  GET_SYS_DOC=await Get_SYS_DOC_D('ST',GETSDID,LoginController().BIID);
    if (GET_SYS_DOC.isNotEmpty) {
      SDDSA=GET_SYS_DOC.elementAt(0).SDDSA_D.toString();}
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

//جلب صلاحية استخدام تاريخ الانتهاء
  Future USE_SMDED_P() async {
    var SYS_VAR= await GET_SYS_VAR(976);
      SMDED= SYS_VAR.elementAt(0).SVVL.toString();
      if(SMDED=='2'){
        SelectDataSNED==null;
      }
  }

}
