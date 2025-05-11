import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../database/sync_db.dart';
import '../services/syncronize.dart';
import 'login_controller.dart';

class Sync_To_ServerController extends GetxController {

  bool value = false;
  String? SelectDataBMKID,SelectDataST,SelectFromDays,SelectToDays;

  DateTime dateFromDays1 = DateTime.now();
  String dateFromDays = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String TAB_M = '',TAB_D = '',ColmunST='',ColmunKID='',ColmunDate='',Count='0';
  var isloading = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SelectDataST='2';
    SelectDataBMKID='1';
    GET_GET_COUNT_MOV_P();
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
      GET_GET_COUNT_MOV_P();
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
        SelectToDays =  DateFormat("yyyy-MM-dd").format(picked);
      GET_GET_COUNT_MOV_P();
    }
    update();
    refresh();
  }



  Future GET_GET_COUNT_MOV_P() async {
    if(SelectDataBMKID=='1' || SelectDataBMKID=='3' || SelectDataBMKID=='4'
        || SelectDataBMKID=='5' || SelectDataBMKID=='7' || SelectDataBMKID=='10' ){
      TAB_M='BIL_MOV_M' ;
      TAB_D='BIL_MOV_D' ;
      ColmunDate='BMMDOR';
      ColmunST='BMMST';
      ColmunKID='BMKID';
    }
    else if(SelectDataBMKID=='11'){
      TAB_M='BIF_MOV_M' ;
      TAB_D='BIF_MOV_D' ;
      ColmunDate='BMMDOR';
      ColmunST='BMMST';
      ColmunKID='BMKID';
    }
    else{
      TAB_M='ACC_MOV_M' ;
      TAB_D='ACC_MOV_M' ;
      ColmunST='AMMST';
      ColmunDate='AMMDOR';
      ColmunKID='AMKID';
    }

    GET_COUNT(TAB_M,ColmunKID,SelectDataBMKID,ColmunST,SelectDataST,ColmunDate,
        SelectFromDays,SelectToDays).then((data) {
      if(data.isNull) {
        Count='0';
      }else{
        Count=data.toString();
        update();
      }
      update();
    });


  }

  void configloading(String MES_ERR) {
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
    EasyLoading.showError(MES_ERR);
  }

  Socket_IP_Connect() async {
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
      EasyLoading.show(status: 'StringWeAreSync'.tr);
      Socket.connect(LoginController().IP, int.parse(LoginController().PORT), timeout: const Duration(seconds: 2))
          .then((socket) async {
        print("Success");
        if(SelectDataBMKID=='1' || SelectDataBMKID=='3' || SelectDataBMKID=='4'
            || SelectDataBMKID=='5' || SelectDataBMKID=='7' || SelectDataBMKID=='10' || SelectDataBMKID=='11'){
          SyncBIL_MOV_D();
        }
        else{
          SyncACC_MOV_D();
        }
        socket.destroy();
      }).catchError((error) {
        Get.snackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        configloading("StrinError_Sync".tr);
        print("Exception on Socket $error");
      });
    }


  Future SyncACC_MOV_D() async {
    INSERT_SYN_LOG('ACC_MOV_M','تم الدخول الى ارسال السندات','U');
    await SyncronizationData().FetchACC_MOV_DData('ByDate',SelectDataBMKID=='1001'?'1':SelectDataBMKID.toString(),
        '0',SelectDataST,SelectFromDays,SelectToDays).then((listD) async {
      if (listD.isNotEmpty && listD.length>0) {
        await SyncronizationData().SyncACC_MOV_DToSystem('ByDate', SelectDataBMKID=='1001'?'1':SelectDataBMKID.toString(), '',listD,true,SelectDataST,SelectFromDays,SelectToDays);
        print('SyncACC_MOV_D');
      }
      else{
        configloading("StringNoDataSync".tr);
      }
    });
  }
  //فواتير
  Future SyncBIL_MOV_D() async {
    INSERT_SYN_LOG('BIL_MOV_D','تم الدخول الى ارسال الفواتير','U');
    await SyncronizationData().fetchAll_BIL_D('ByDate',int.parse(SelectDataBMKID.toString()),
        '',SelectDataST,SelectFromDays,SelectToDays).then((listBIL_MOV_D) async {
      print(int.parse(SelectDataBMKID.toString()));
      print('GetBMKID');
      if (listBIL_MOV_D.isNotEmpty ) {
        print(listBIL_MOV_D.length);
        await SyncronizationData().SyncBIL_MOV_DToSystem('ByDate',int.parse(SelectDataBMKID.toString()),'0',listBIL_MOV_D,
            SelectDataBMKID == '11' || SelectDataBMKID == '12' ? 'BIF_MOV_D' : 'BIL_MOV_D',true,
            int.parse(SelectDataST.toString()),SelectFromDays,SelectToDays);
      }else{
        configloading("StringNoDataSync".tr);
      }
    });
  }

}