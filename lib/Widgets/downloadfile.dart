import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import '../Setting/controllers/login_controller.dart';
import '../database/invoices_db.dart';
import '../database/sync_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../PrintFile/pdf_perview.dart';
import '../Setting/services/api_provider_login.dart';
import '../database/setting_db.dart';
import 'config.dart';

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

void configloading2(String MES_ERR) {
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

String SLIN=LoginController().LAN==2?'The data has been successfully received':"تم بنجاج استلام";

Future<void> checkFileExists(String path) async {
  final file = File(path);
  if (await file.exists()) {
    print("File exists");
  } else {
    print("File does not exist");
  }
}

Future<void> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    if (await Permission.storage.request().isGranted) {
      // إذن مُعطى
    } else {
      // إذن مرفوض
      throw Exception("Storage permission denied");
    }
  }
}

Future<File?> GetFile(String name,String GetPath) async {
 // await requestStoragePermission();
  var url = "${LoginController().baseApi}/ESAPI/ESINF";
  final appDir = await getApplicationDocumentsDirectory();
  print(appDir.path);
  final file =File('${LoginController().AppPath}Media/$name');
  print("${url}/GetFile");
  var TEST3 = {"typ": "file", "typ2": "${GetPath.replaceAll('/', '//')}"};
  print("${TEST3}/GetFile");
  try {
    var response = await Dio().get(url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(seconds: 7),)
        ,queryParameters: TEST3);
    if (response.statusCode == 200) {
      // تأكد من أن المجلد موجود
      final dir = Directory('${LoginController().AppPath}Media');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      LoginController().SET_P('Image_Type','1');
      await file.writeAsBytes(response.data);
      INSERT_SYN_LOG('GET IMGE','${SLIN} ${LoginController().SOSI}','D');
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
      return file;

    }
    else if (response.statusCode == 207) {
      INSERT_SYN_LOG('GET IMGE',response.data,'D');
      print(' response.statusCode ${response.statusCode}''${response.data}');
      configloading();
      Fluttertoast.showToast(
          msg: "${response.data}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    }
    else {
      INSERT_SYN_LOG('GET IMGE',response.data,'D');
      configloading();
      Fluttertoast.showToast(
          msg: "response error: ${response.statusCode} ${response.data}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      throw Exception("response error: ${response.data}");
    }
  } on DioException catch (e) {
    INSERT_SYN_LOG('GET IMGE',e.toString(),'D');
    configloading();
    Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.red);
    return Future.error("DioError: ${e.message}");
  }
  return null;
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
  EasyLoading.show(status:  '$MES_ERR');
}

Future<void> saveFile(String fileName) async {
  Directory? pathSave = await (getApplicationDocumentsDirectory());
  String path = "${pathSave.path}/$fileName";
  if (path.contains('.pdf')) {
    Get.dialog(
      PdfPerview(
        filePath: path,
      ),
    );
  } else {
    OpenFilex.open(path);
  }
}

Future<File?> GET_IMGE_MAT() async {
  try {
    // التأكد من أن مجلد Media موجود، وإنشاؤه إذا لم يكن موجودًا
    final mediaDir = Directory("${LoginController().AppPath}Media");
    if (!await mediaDir.exists()) {
      await mediaDir.create(recursive: true);
    }

    final userList = await GET_MAT_INF_D_P();
    if (userList.isNotEmpty) {
      print('GetFile_MAT');
      for (var i = 0; i < userList.length; i++) {
        try {
          if (userList[i].MIDPI.toString() != 'null') {
            print("UserList Length: ${userList.length}");
            print("MGNO: ${userList[i].MGNO}");
            print("MINO: ${userList[i].MINO}");
            print("MIDPI: ${userList[i].MIDPI}");

            var url = "${LoginController().baseApi}/ESAPI/ESINF";
            final file = File("${LoginController().AppPath}Media/${userList[i].MGNO}-${userList[i].MINO}.png");
            var params = {
              "typ": "file",
              "typ2": userList[i].MIDPI.toString().replaceAll('/', '//'),
            };

            try {
              var response = await Dio().get(
                url,
                options: Options(
                  responseType: ResponseType.bytes,
                  followRedirects: false,
                  receiveTimeout: const Duration(seconds: 10),
                ),
                queryParameters: params,
              );

              if (response.statusCode == 200) {
                print('GetFile success');
                await file.writeAsBytes(response.data);
                INSERT_SYN_LOG(
                  'GET IMAGE MAT ${userList[i].MGNO}-${userList[i].MINO}',
                  '${SLIN} ${userList[i].MIDPI}', 'D',
                );
                configloading_state("${userList[i].SHORT_NAME}-${userList[i].MIDPI}");
              } else if (response.statusCode == 207) {
                INSERT_SYN_LOG('GET IMAGE MAT', response.data, 'D');
                print('Response code ${response.statusCode}: ${response.data}');
                configloading();
                Fluttertoast.showToast(
                  msg: "${response.data}",
                  toastLength: Toast.LENGTH_LONG,
                  textColor: Colors.white,
                  backgroundColor: Colors.red,
                );
              } else {
                INSERT_SYN_LOG('GET IMAGE MAT', response.data, 'D');
                configloading();
                Fluttertoast.showToast(
                  msg: "response error: ${response.statusCode} ${response.data}",
                  toastLength: Toast.LENGTH_LONG,
                  textColor: Colors.white,
                  backgroundColor: Colors.red,
                );
                throw Exception("response error: ${response.data}");
              }
            } on DioException catch (e) {
              INSERT_SYN_LOG(
                'GET IMAGE MAT ${userList[i].MGNO}-${userList[i].MINO}',
                e.toString(),
                'D',
              );
              configloading();
              Fluttertoast.showToast(
                msg: e.message!,
                toastLength: Toast.LENGTH_LONG,
                textColor: Colors.white,
                backgroundColor: Colors.red,
              );
              return Future.error("DioError: ${e.message}");
            }
          }
          if (userList.length == i + 1) {
            EasyLoading.showSuccess('StringShow_Succ_Account_M'.tr);
          }
        } catch (e) {
          print(e.toString());
          Fluttertoast.showToast(
            msg: "GET IMAGE MAT ${userList[i].MGNO}-${userList[i].MINO} : ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red,
          );
          return Future.error(e);
        }
      }
    } else {
      configloading2("StringNoDataSync".tr);
    }
  } on DioException catch (e) {
    // التعامل مع أخطاء Dio العامة (على مستوى الاتصال مثلاً)
    print("Connection error: ${e.message}");
    Fluttertoast.showToast(
      msg: "فشل الاتصال بالخادم. يرجى التأكد من اتصال الإنترنت والمحاولة مرة أخرى.",
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    return Future.error("DioError: ${e.message}");
  } catch (e) {
    print("General error: $e");
    Fluttertoast.showToast(
      msg: "حدث خطأ أثناء جلب الصورة.",
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    return Future.error(e);
  }
  return null;
}

Future GET_IMAGE_APP() async {
  var  SYS_OWN =await GET_SYS_OWN_SOSI(LoginController().BIID.toString());
    if (SYS_OWN.isNotEmpty) {
      LoginController().SET_P('SOSI',SYS_OWN.elementAt(0).SOSI.toString());
      GetFile("EMobileProSign.png", SYS_OWN.elementAt(0).SOSI.toString());
    }else{
      TAB_N = "SYS_OWN";
      ApiProviderLogin().getAllSYS_OWN();
      await Future.delayed(const Duration(seconds: 2));
      Update_TABLE_ALL('SYS_OWN_TMP');
      DeleteALLData('SYS_OWN',true);
      INSERT_SYN_LOG('SYS_OWN','${SLIN}','D');
      SaveALLData('SYS_OWN');
      await Future.delayed(const Duration(seconds: 2));
      var  SYS_OWN =await GET_SYS_OWN_SOSI(LoginController().BIID.toString());
      if (SYS_OWN.isNotEmpty) {
        LoginController().SET_P('SOSI',SYS_OWN.elementAt(0).SOSI.toString());
        GetFile("EMobileProSign.png", SYS_OWN.elementAt(0).SOSI.toString());
      }
    }

}
