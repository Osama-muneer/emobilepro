import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/sys_doc_d.dart';
import '../../Setting/models/sys_own.dart';
import '../../database/setting_db.dart';

class Counter_Inv_Archive_controller extends GetxController {
  //TODO: Implement HomeController

  var isloading = false.obs;
  bool value = false;
  bool value1 = false;
  // late  DateTime dateFromDays =  DateFormat('dd-MM-yyyy').format(DateTime.now()) as DateTime;
  DateTime dateFromDays1 = DateTime.now();
  String dateFromDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String? SelectFromDays,SelectToDays,SelectDataF_SIID,SelectDataT_SIID,TypeScreen;
  int UPIN_PKID=1;

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
  late List<Sys_Own_Local> SYS_OWN;
  late List<Sys_Doc_D_Local> GET_SYS_DOC;

  String? SelectDataFromBIID='',SelectDataToBIID='',SelectDataFromBPID,SelectDataToBPID,SelectDataFromCTMID,
      SelectDataToCTMID,SelectDataFromCIMID, SelectDataToCIMID, SelectDataFromBINA, SelectDataToBINA,
      SelectDataSINA,SelectBINA,SelectDataSCID,PKID,
      SMDED='',SDDSA='',SONA='',SONE='',SORN='',SOLN='';



  @override
  void onInit() async {
    SelectDataFromBIID = LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
    GET_Sys_Own();
    GET_SYS_DOC_D();
    super.onInit();
  }


  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D() async {
    Get_SYS_DOC_D('BF',11,1).then((data) {
      GET_SYS_DOC = data;
      SDDSA=GET_SYS_DOC.elementAt(0).SDDSA_D.toString();
    });
  }

  void clear() {
    // TODO: implement dispose
    SelectDataF_SIID=null;
    SelectDataT_SIID=null;
    SelectDataFromCTMID=null;
    SelectDataToCTMID=null;
    SelectDataFromBPID=null;
    SelectDataToBPID=null;
    SelectDataFromCIMID=null;
    SelectDataToCIMID=null;
    SelectDataSCID=null;
    SelectDataSCID=null;
    SelectDataFromBIID =LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
    value = false;
    value1 = false;
    SelectFromDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
    SelectToDays =  DateFormat('dd-MM-yyyy').format(DateTime.now());
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }


  //جلب بيانات المنشاة
  Future GET_Sys_Own() async {
    GET_SYS_OWN(1).then((data) {
      SYS_OWN = data;
      SONA=SYS_OWN.elementAt(0).SONA.toString();
      SONE=SYS_OWN.elementAt(0).SONE.toString();
      SORN=SYS_OWN.elementAt(0).SORN.toString();
      SOLN=SYS_OWN.elementAt(0).SOLN.toString();
    });
  }


}
