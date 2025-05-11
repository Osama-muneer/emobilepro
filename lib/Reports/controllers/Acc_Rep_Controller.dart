import 'dart:async';
import '../../Operation/models/acc_mov_m.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/sys_own.dart';
import '../../database/database.dart';
import '../../database/report_db.dart';
import '../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

List<Acc_Mov_M_Local> ACC_MOV_M_List = [];

class Acc_Rep_Controller extends GetxController {
  //TODO: Implement HomeController
  var isloading = false.obs;
  bool value = false;
  late List<Sys_Own_Local> SYS_OWN;
  DateTime dateFromDays1 = DateTime.now();
  String dateFromDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String? SelectFromDays,SelectToDays;
  String? SelectDataFromBIID='',SelectDataToBIID='', SelectDataFromBINA, SelectDataToBINA,
      SelectBINA,SelectDataSCID,PKID;
  int AMKID=0;

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

  @override
  void onInit() async {
    SelectDataFromBIID = LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
    super.onInit();
  }

  void clear() {
    // TODO: implement dispose
    SelectDataFromBIID =LoginController().BIID.toString();
    SelectDataToBIID = LoginController().BIID.toString();
    PKID=null;
    SelectDataSCID=null;
    value = false;
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
    GET_SYS_OWN(LoginController().BIID).then((data) {
      SYS_OWN = data;
      if(SYS_OWN.isNotEmpty){
        SONA = SYS_OWN.elementAt(0).SONA.toString();
        SONE = SYS_OWN.elementAt(0).SONE.toString();
        SORN = SYS_OWN.elementAt(0).SORN.toString();
        SOLN = SYS_OWN.elementAt(0).SOLN.toString();
      }
    });
  }

  //جلب حركة الحسابات الي pdf
  Future Fetch_GET_ACC_REP_PdfData() async {
    isloading.value=true;
    GET_ACC_REP(
        AMKID.toString(),
        SelectDataFromBIID!,
        SelectDataToBIID!,
        SelectFromDays!,
        SelectToDays!,
        PKID.toString(),
        SelectDataSCID.toString()).then((data) {
        ACC_MOV_M_List = data;
    });
  }
}


