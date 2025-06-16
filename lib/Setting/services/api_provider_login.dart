import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import '../../Setting/models/con_acc_m.dart';
import '../../Setting/models/bra_inf.dart';
import '../../Setting/models/sys_own.dart';
import '../../Widgets/theme_helper.dart';
import '../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/bra_yea.dart';
import '../../Setting/models/gen_var.dart';
import '../../Setting/models/job_typ.dart';
import '../../Setting/models/sys_com.dart';
import '../../Setting/models/sys_usr.dart';
import '../../Setting/models/sys_usr_p.dart';
import '../../Setting/models/sys_yea.dart';
import '../../Widgets/config.dart';
import '../../database/sync_db.dart';
import '../models/cou_red.dart';
import '../models/syn_tas.dart';

class ApiProviderLogin {
  var params = {
    "STMID_CO_V": STMID,
    "SYDV_NAME_V": LoginController().DeviceName,
    "SYDV_IP_V": '',
    "SYDV_TY_V":  LoginController().SYDV_TY,
    "SYDV_SER_V": LoginController().DeviceID,
    "SYDV_POI_V": "",
    "SYDV_ID_V":LoginController().SYDV_ID,
    "SYDV_NO_V":LoginController().SYDV_NO,
    "SYDV_BRA_V": '',
    "SYDV_LATITUDE_V": "",
    "SYDV_LONGITUDE_V": "",
    "SYDV_APPV_V": LoginController().APPV,
    "SOID_V": "",
    "STID_V": "",
    "TBNA_V": TAB_N,
    "LAN_V": LoginController().LAN,
    "CIID_V":'-1',
    "JTID_V":'-1',
    "BIID_V":'-1',
    "SYID_V":'-1',
    "SUID_V":LoginController().SUID,
    "SUPA_V":LoginController().SUPA,
    "F_ROW_V":'0',
    "T_ROW_V":'0',
    "F_DAT_V":'',
    "T_DAT_V":'',
    "F_GUID_V":'',
    "WH_V1":'',
    "PAR_V":"",
    "JSON_V":"",
    "JSON_V2":"",
    "JSON_V3":""
  };

  late var params2 = {
    "STMID_CO_V": STMID,
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
    "SOID_V":SOID_V,
    "STID_V":"",
    "TBNA_V":TAB_N,
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

  var TEST = {
    "typ": "ver",
  };

  var TEST2 = {
    "typ": "upd",
  };

  var TEST3 = {
    "typ": "img",
    "typ2": "D:\\ELITEPRO\\PICTURES\\SIGN.JPG",
  };

  String SLIN=LoginController().LAN==2?'The data has been successfully received/updated':"تم بنجاج استلام/تحديث البيانات";

  late List<Gen_Var_Local> GEN_VAR;
  late List<Sys_Own_Local> SYS_OWN;

  Future GET_SYS_VER() async {
    GET_GEN_VAR_ACC('UPD').then((data) {
      GEN_VAR = data;
      if (GEN_VAR.isNotEmpty) {
        LoginController().SET_N_P('SYS_VER',int.parse(GEN_VAR.elementAt(0).VAL.toString()));
      }
    });
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

  void Socket_IP(String IP,int Port) async {
    Socket.connect(IP, Port, timeout: const Duration(seconds: 10)).then((socket) async {
      print("Success");
      TEST_API();
      //getImge();
      LoginController().SET_B_P('InstallData',false);
      socket.destroy();
    }).catchError((error){
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
      print("Exception on Socket "+error.toString());
    });
  }

  void Socket_IP_Conn(String IP,int Port) async {
    Socket.connect(IP, Port, timeout: const Duration(seconds: 10)).then((socket) async {
      print("Success");
      LoginController().SET_B_P('InstallData',false);
      TEST_API_CONN();
      // await Future.delayed(const Duration(seconds: 1));
      // TAB_N = "SYN_TAS";
      // ApiProviderLogin().GetAllSYN_TAS();
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "GEN_VAR";
      ApiProviderLogin().getAllGEN_VAR();
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "JOB_TYP";
      ApiProviderLogin().getAllJOB_TYP();
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "BRA_INF";
      ApiProviderLogin().getAllBRA_INF();
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "BRA_YEA";
      ApiProviderLogin().getAllBRA_YEA();
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "SYS_YEA";
      ApiProviderLogin().getAllSYS_YEA();
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "SYS_USR_P";
      ApiProviderLogin().getAllSYS_USR_P();
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "SYS_USR";
      ApiProviderLogin().getAllSYS_USR();
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "CON_ACC_M";
      ApiProviderLogin().getAllCON_ACC_M();
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "SYS_COM";
      ApiProviderLogin().getAllSYS_COM();
      LoginController().SET_N_P('experimentalcopy',0);
      socket.destroy();
    }).catchError((error){
      Get.snackbar('StringCHK_Err_Con'.tr,'StringCHK_Con'.tr,
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
      print("Exception on Socket "+error.toString());
    });
  }

  void Socket_IP_Connect(String IP,int Port) async {
    Socket.connect(IP, Port, timeout: const Duration(seconds: 8)).then((socket) async {
      print("Success");
      LoginController().SET_B_P('InstallData',false);
      await Future.delayed(const Duration(seconds: 1));
      // TAB_N = "SYS_OWN";
      // ApiProviderLogin().getAllSYS_OWN();
      // await Future.delayed(const Duration(seconds: 2));
      // GET_SOSI();
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "SYS_COM";
      ApiProviderLogin().getAllSYS_COM();
      socket.destroy();
    }).catchError((error){
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
      print("Exception on Socket "+error.toString());
    });
  }

  void Socket_Connect_SYN_TAS() async {
    Socket.connect(LoginController().IP, int.parse(LoginController().PORT), timeout: const Duration(seconds: 8)).then((socket) async {
      print("Success");
      await Future.delayed(const Duration(seconds: 1));
      TAB_N = "SYN_TAS";
      ApiProviderLogin().GetAllSYN_TAS();
      // socket.destroy();
    }).catchError((error){
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
      print("Exception on Socket "+error.toString());
    });
  }

  //TEST API
  Future<dynamic> TEST_API() async {
    var url = "${LoginController().baseApi}/ESAPI/ESINF";
    print(url);
    print("${TEST2}/TEST_API");
    try {
      var response = await Dio().get(url, queryParameters: TEST);
      if (response.statusCode == 200) {
        LoginController().SET_P('API_VER',response.data);
        await Future.delayed(const Duration(seconds: 2));
        var response2 = await Dio().get(url, queryParameters: TEST2);
        if (response2.statusCode == 200) {
          print('SYS_VAR');
          print(response2.data.toString());
          if(response2.data.toString().length>10){
            configloading();
            Fluttertoast.showToast(
                msg: "${response.data}",
                toastLength: Toast.LENGTH_LONG,
                textColor: Colors.white,
                backgroundColor: Colors.red);
          }else{
            LoginController().SET_N_P('SYS_VER',int.parse(response2.data));
          }
        }
        await Future.delayed(const Duration(seconds: 2));
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
          ..userInteractions = true
          ..dismissOnTap = false;
        EasyLoading.showSuccess('StringSuccesTest'.tr);
        Get.snackbar('StringSuccesTest'.tr, 'String_CHK_Test'.tr,
            backgroundColor: Colors.green,
            icon: const Icon(Icons.done,color:Colors.white),
            colorText:Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
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

  Future<dynamic> TEST_API_CONN() async {
    var url = "${LoginController().baseApi}/ESAPI/ESINF";
    print(url);
    print("${TEST2}/TEST_API");
    try {
      var response = await Dio().get(url, queryParameters: TEST);
      final uriOne = Uri.parse(url);
      if (response.statusCode == 200) {
        LoginController().SET_P('API_VER',response.data);
        await Future.delayed(const Duration(seconds: 2));
        var response2 = await Dio().get(url, queryParameters: TEST2);
        if (response2.statusCode == 200) {
          print('SYS_VAR');
          print(response2.data);
          LoginController().SET_N_P('SYS_VER',int.parse(response2.data));
        }
      } else if (response.statusCode == 207) {
        print(' response.statusCode ${response.statusCode}''${response.data}');
        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("DioError: ${e.message}");
    }
  }

  //يبانات الانشطة
  Future<dynamic> getAllJOB_TYP() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("${url}/JOB_TYP");
    print("${params}/JOB_TYP");
    try {
      //  var response = await Dio().get(url);
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');

        return (response.data)['result'].map((data) {
          SaveJOB_TYP(Job_Typ_Local.fromMap(data));
        }).toList();
      } else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        print(' response.statusCode ${response.statusCode}''${response.data}');
        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      INSERT_SYN_LOG(TAB_N,e.toString(),'D');
      configloading();
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("DioError: ${e.message}");
    }
  }

  //يبانات
  Future<dynamic> GetAllSYN_TAS() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("$url/SYN_TAS");
    try {
      var response = await Dio().get(url, queryParameters: params2);
      if (response.statusCode == 200 ) {
        List<dynamic> arr = response.data['result'];
        print('SaveSYN_TAS');
        return (response.data)['result'].map((data) {
          SaveSYN_TAS(Syn_Tas_Local.fromMap(data));
        }).toList();
      }
      else if (response.statusCode == 207) {
        print(' response.statusCode ${response.statusCode}''${response.data}');
        // LoginController().Timer_Strat==1?
        // ThemeHelper().ShowToastW(response.data.toString()):false;
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        // controller.CheckSync(false);
      }
      else {
        // LoginController().Timer_Strat==1?
        // ThemeHelper().ShowToastW(response.data.toString()):false;
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        // controller.CheckSync(false);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      // LoginController().Timer_Strat==1?
      // ThemeHelper().ShowToastW(e.error.toString()):false;
      INSERT_SYN_LOG(TAB_N,e.error,'D');
      // controller.CheckSync(false);
      return Future.error("DioError");
      return Future.error("DioError: ${e.error}");
    }
  }

  //متغيرات التطبيق
  Future<dynamic> getAllGEN_VAR() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("${url}/GEN_VAR");
    try {
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        return (response.data)['result'].map((data) {
          INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');
          SaveGEN_VAR_ACC(Gen_Var_Local.fromMap(data));
          GET_SYS_VER();
        }).toList();
      } else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        print(' response.statusCode ${response.statusCode}''${response.data}');
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      INSERT_SYN_LOG(TAB_N,e.toString(),'D');

      configloading();
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("DioError: ${e.message}");
    }
  }

  //بيانات الفروع
  Future<dynamic> getAllBRA_INF() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("${url}/BRA_INF");
    try {
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');

        return (response.data)['result'].map((data) {
          SaveBRA_INF_ACC(Bra_Inf_Local.fromMap(data));
        }).toList();
      } else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        print(' response.statusCode ${response.statusCode}''${response.data}');
        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      INSERT_SYN_LOG(TAB_N,e.toString(),'D');

      configloading();
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("DioError: ${e.message}");
    }
  }

  //صلاحيات
  Future<dynamic> getAllBRA_YEA() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("${url}/BRA_YEA");
    try {
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');

        return (response.data)['result'].map((data) {
          SaveBRA_YEA_ACC(Bra_Yea_Local.fromMap(data));
        }).toList();
      }else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        print(' response.statusCode ${response.statusCode}''${response.data}');
        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      INSERT_SYN_LOG(TAB_N,e.toString(),'D');

      configloading();
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("response error: ${e.message}");
    }
  }

  //بيانات السنة
  Future<dynamic> getAllSYS_YEA() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("${url}/SYS_YEA");
    try {
      // var response = await Dio().get(url);
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');

        return (response.data)['result'].map((data) {
          SaveSYS_YEA_ACC(Sys_Yea_Local.fromMap(data));
        }).toList();
      } else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      INSERT_SYN_LOG(TAB_N,e.toString(),'D');

      configloading();
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("DioError: ${e.message}");
    }
  }

  // المستخدمين
  Future<dynamic> getAllSYS_USR() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("${url}/SYS_USR");
    try {
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');

        return (response.data)['result'].map((data) {
          SaveSYS_USR_ACC(Sys_Usr_Local.fromMap(data));
        }).toList();
      } else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        print("${response.data}");
        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        print("${response.data}");
        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      INSERT_SYN_LOG(TAB_N,e.toString(),'D');
      print("${e.toString()}");
      configloading();
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("DioError: ${e.message}");
    }
  }

  Future<dynamic> getAllSYS_USR_P() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("${url}/SYS_USR_P");
    try {
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');
        return (response.data)['result'].map((data) {
          SaveSYS_USR_P(Sys_Usr_P_Local.fromMap(data));
        }).toList();
      } else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      INSERT_SYN_LOG(TAB_N,e.toString(),'D');

      configloading();
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("DioError: ${e.message}");
    }
  }

  //بيانات الشركة
  Future<dynamic> getAllSYS_COM() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("${url}/SYS_COM");
    try {
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');

        Get.snackbar('StringSuccesCheck'.tr, 'String_CHK_SuccesCheck'.tr,
            backgroundColor: Colors.green,
            icon: const Icon(Icons.done,color:Colors.white),
            colorText:Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
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
          ..userInteractions = true
          ..dismissOnTap = false;
        EasyLoading.showSuccess('StringSuccesCheck'.tr);
        return (response.data)['result'].map((data) {
          SaveSYS_COM(Sys_Com_Local.fromMap(data));
        }).toList();
      } else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      INSERT_SYN_LOG(TAB_N,e.toString(),'D');

      configloading();
      Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("DioError: ${e.message}");
    }
  }

  //بيانات المنشاة
  Future<dynamic> getAllSYS_OWN() async {
    var url = "${LoginController().API}/ESAPI/ESGET";
    print("$url/SYS_OWN");
    try {
      var response = await Dio().get(url,queryParameters: params2);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');

        return (response.data)['result'].map((data)  {
          SaveSYS_OWN(Sys_Own_Local.fromMap(data));
        }).toList();
      }else if (response.statusCode == 207) {
        print(' response.statusCode ${response.statusCode}''${response.data}');
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG(TAB_N,response.data,'D');

      }
      else {
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      INSERT_SYN_LOG(TAB_N,e.message,'D');

      return Future.error("response error: ${e.message}");
    }
  }

  // المستخدمين
  Future<dynamic> getAllSYS_USR2() async {
    var url = "${LoginController().API}/ESAPI/ESGET";
    print("$url/SYS_USR");
    try {
      var response = await Dio().get(url,queryParameters: params2);
      if (response.statusCode == 200 ) {
        return (response.data)['result'].map((data)  {
          SaveCHINGSYS_USR(Sys_Usr_Local.fromMap(data));
        }).toList();
      }else if (response.statusCode == 207) {
        print(' response.statusCode ${response.statusCode}''${response.data}');
        ThemeHelper().ShowToastW(response.data.toString());
        INSERT_SYN_LOG(TAB_N,response.data,'D');
      }
      else {
        ThemeHelper().ShowToastW(response.data.toString());
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      ThemeHelper().ShowToastW(e.error.toString());
      INSERT_SYN_LOG(TAB_N,e.error,'D');
      return Future.error("response error: ${e.error}");
    }
  }

  //التحكم بالوصول
  Future<dynamic> getAllCON_ACC_M() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("${url}/CON_ACC_M");
    try {
      var response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        INSERT_SYN_LOG(TAB_N,'${SLIN} ${arr.length}','D');

        return (response.data)['result'].map((data) {
          SaveCON_ACC_M_ACC(Con_Acc_M_Local.fromMap(data));
        }).toList();
      } else if (response.statusCode == 207) {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        print(' response.statusCode ${response.statusCode}''${response.data}');
        configloading();
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        INSERT_SYN_LOG(TAB_N,response.data,'D');

        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      INSERT_SYN_LOG(TAB_N,e.toString(),'D');

      configloading();
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return Future.error("DioError: ${e.message}");
    }
  }

  ////القراءات
  Future<dynamic> getAllCOU_RED_M() async {
    var url = "${LoginController().API}/ESAPI/ESGET";
    print('${url}/COU_RED_M');
    try {
      var response = await Dio().get(url,queryParameters: params2);
      if (response.statusCode == 200) {
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
          ..userInteractions = true
          ..dismissOnTap = false;
        EasyLoading.showSuccess('StringSuccessfullySync'.tr);
        List<dynamic> arr = response.data['result'];
        return (response.data)['result'].map((data) {
          SaveCOU_RED_M(Cou_Red_Local.fromMap(data));
        }).toList();
      }else if (response.statusCode == 207) {
        print(' response.statusCode ${response.statusCode}''${response.data}');
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      else {
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioError catch (e) {
      ThemeHelper().ShowToastW(e.error.toString());
      return Future.error("response error: ${e.message}");
    }
  }

}