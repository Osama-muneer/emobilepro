import 'package:flutter/services.dart';

import '../../Operation/models/acc_mov_m.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../database/report_db.dart';
import '../../database/setting_db.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:intl/intl.dart';

List<Acc_Mov_M_Local> ACC_MOV_M_PDF = [];
List<Acc_Mov_M_Local> ACC_MOV_M_SUM_PDF = [];
class Accounts_ArchiveController extends GetxController {
  //TODO: Implement HomeController
  var isloading = false.obs;
  bool value = false,isTablet=false,value1 = false;
 String SDDSA='',SONA='',SONE='',SORN='',SOLN='', SDDDA = '',AANA='',TYPE_T='1',TYPE_ORD2='1';
 // late  DateTime dateFromDays =  DateFormat('dd-MM-yyyy').format(DateTime.now()) as DateTime;
  DateTime dateFromDays1 = DateTime.now();
  final formatter = intl.NumberFormat.decimalPattern();
  String dateFromDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String? SelectFromDays,SelectToDays,SelectFromDays2,SelectToDays2,
      SelectFromDATEI,SelectToDATEI;
  String? SelectDataFromBIID='',SelectDataToBIID='',SelectDataBMKID,
       SelectDataFromBINA, SelectDataToBINA,SelectDataAANO,SelectDataAANA, SelectBINA,SelectDataSCID,PKID;
  late TextEditingController TextEditingSercheController;
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
      SelectFromDays2 =  DateFormat('dd-MM-yyyy').format(picked);
      SelectFromDays =  DateFormat('yyyy-MM-dd').format(picked);;
    }
    update();
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
      SelectToDays2 = DateFormat("dd-MM-yyyy").format(picked);
      SelectToDays = DateFormat('yyyy-MM-dd').format(picked);
    }
    update();
  }
  Future<void> selectDateFromDATEI(BuildContext context) async {
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
      SelectFromDATEI =  DateFormat("dd-MM-yyyy").format(picked);
    }
    update();
  }
  Future<void> selectDateToDATEI(BuildContext context) async {
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
      SelectToDATEI = DateFormat("dd-MM-yyyy").format(picked);
    }
    update();
  }

  @override
  void onInit() async {
    SelectDataFromBIID = LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
    TextEditingSercheController = TextEditingController();
    GET_SYS_OWN_P();
    GET_SYS_DOC_D();
    SelectFromDays = DateFormat('yyyy-MM-dd').format(DateTime.now());
    SelectToDays =  DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.onInit();
  }

  void clear() {
    // TODO: implement dispose
    AANA='';
    SelectFromDATEI=null;
    SelectToDATEI=null;
    SelectDataSCID=null;
    SelectDataSCID=null;
    SelectDataSCID=null;
    SelectDataAANO=null;
    SelectDataAANA=null;
    SelectDataFromBIID =LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
    value = false;
    value1 = false;
    SelectFromDays2 = DateFormat('dd-MM-yyyy').format(DateTime.now());
    SelectFromDays = DateFormat('yyyy-MM-dd').format(DateTime.now());
    SelectToDays2 =  DateFormat('dd-MM-yyyy').format(DateTime.now());
    SelectToDays =  DateFormat('yyyy-MM-dd').format(DateTime.now());
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    TextEditingSercheController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    print(isTablet);
    print('onClose');
    if(isTablet==true){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    super.onClose();
  }

  void getExit(){
    if(isTablet==true){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }


  Future GET_ACC_MOV_REP_P() async {
    ACC_MOV_M_PDF=await GET_ACC_MOV_REP(SelectDataFromBIID!,SelectDataToBIID!,SelectFromDays!,
        SelectToDays!, SelectDataSCID.toString(),PKID.toString(),AANA,
        SelectFromDATEI.toString(),SelectToDATEI.toString(),TYPE_T,TYPE_ORD2);
    ACC_MOV_M_SUM_PDF =await GET_ACC_MOV_SUM_REP(SelectDataFromBIID!,SelectDataToBIID!,SelectFromDays!,
        SelectToDays!, SelectDataSCID.toString(),PKID.toString(),AANA,
        SelectFromDATEI.toString(),SelectToDATEI.toString());
  }

  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D() async {
    var  GET_SYS_DOC=await Get_SYS_DOC_D('AC',11,LoginController().BIID);
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
}
