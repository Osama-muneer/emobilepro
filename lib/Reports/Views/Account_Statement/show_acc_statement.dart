import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import '../../../Reports/Views/Account_Statement/show_data_offline.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Setting/models/acc_sta_d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../Reports/Views/Account_Statement/show_data_datagrid.dart';
import '../../../Reports/controllers/Account_Statement_Controller.dart';
import '../../../Widgets/colors.dart';
import 'package:http/http.dart' as http;
import '../../../Widgets/pdf.dart';
import '../../../Widgets/pdfpakage.dart';
import '../../../Widgets/theme_helper.dart';


class Show_Acc_Statement extends StatefulWidget {
  @override
  State<Show_Acc_Statement> createState() => _Show_Acc_StatementState();
}

class _Show_Acc_StatementState extends State<Show_Acc_Statement> {
  final Account_Statement_Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if(controller.isTablet==true){
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
        return true; // السماح بالرجوع
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.MainColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.TYPY==2?'StringAccount_Statement_Online'.tr:
              controller.TYPY==3?'StringACC_COS_STA'.tr:
              controller.TYPY==4?'StringACC_STA_H'.tr:'StringAccount_Statement'.tr,
                  style: ThemeHelper().buildTextStyle(context, Colors.white,'M'),
                ),
                    Text(controller.SelectTYPE_CUR=='1'?'${controller.AANAController.text}-(${controller.SCNA.toString()})':
                    '${controller.AANAController.text}-(${'StringAll'.tr})',
                      style: ThemeHelper().buildTextStyle(context, Colors.white,'S'),
                    ),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.rotate_left),
              onPressed: () {
                if(controller.isTablet==false){
                  controller.isTablet=true;
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                }else{
                  controller.isTablet=false;
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: IconButton(icon: const Icon(Icons.picture_as_pdf),
                  onPressed: () async{
                 //   Open_File(fileName:'ELITE.jpg');
                    if(controller.UPPR==1){
                      EasyLoading.instance
                        ..displayDuration = const Duration(milliseconds: 2000)
                        ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                        ..loadingStyle = EasyLoadingStyle.custom
                        ..indicatorSize = 50.0
                        ..radius = 10.0
                        ..progressColor = Colors.white
                        ..backgroundColor = Colors.green
                        ..indicatorColor = Colors.white
                        ..textColor = Colors.white
                        ..maskColor = Colors.blue.withOpacity(0.5)
                        ..userInteractions = true
                        ..dismissOnTap = false;
                      EasyLoading.show();
      
                      setState(() {
                      // controller.GET_ACC_STA_D_P();
                    });
                      print('controller.SSNA');
                      print(controller.SSNA.toString());
                    Timer( Duration(seconds: ACC_STA_DDataList.length>=1000 ?7 :3), () async{
                      final pdfFile = await Pdf.Account_Statement_Pdf(
                          controller.TYPY.toString(),
                          controller.AANOController.text,
                          controller.AANAController.text,
                          controller.SelectFromDays.toString(),
                          controller.SelectToDays.toString(),
                          controller.SelectTYPE_CUR=='1'? controller.SCNA.toString():'StringAll'.tr,
                          controller.SelectDataFromBIID.toString(),
                          controller.SelectDataToBIID.toString(),
                          controller.BCTL.toString(),
                          controller.AAAD.toString(),
                          controller.SONA.toString(),
                          controller.SONE.toString(),
                          controller.SORN.toString(),
                          controller.SOLN.toString(),
                          controller.SelectDataSSID.toString(),
                          LoginController().SUNA,
                          controller.SSNA.toString(),
                          controller.SDDDA.toString(),
                          controller.SDDSA.toString(),
                          controller.AMBAL.toString(),
                          controller.AMBALN.toString(),
                          ACC_STA_DDataList,
                          controller.BAL_ACC_D);
                      EasyLoading.dismiss();
                      PdfPakage.openFile(pdfFile);
                    });
                    }else{
                      Get.snackbar('StringAcc_Statement_UPPR'.tr, 'String_CHK_Acc_Statement_UPPR'.tr,
                          backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                          colorText:Colors.white,
                          isDismissible: true,
                          dismissDirection: DismissDirection.horizontal,
                          forwardAnimationCurve: Curves.easeOutBack);
                    }
                  }),
            ),
          ],
        ),
        body: GetBuilder<Account_Statement_Controller>(
            init: Account_Statement_Controller(),
            builder: ((value) =>SafeArea(
              child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
              StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                return Expanded(
                    child: controller.TYPY==2?Show_Statment_offline():Show_Acc_Statment());
              }),
              Card(
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("StringCurrent_Balance".tr,
                            style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                          Text(controller.AMBAL.toString(),
                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                        ],
                      ),
                      Text(controller.AMBALN.toString()=='null'?'':controller.AMBALN.toString(),
                        textAlign: TextAlign.center,
                        style:  ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                      controller.TYPY==2?const Divider(color: Colors.black):Container(),
                      controller.TYPY==2 && StteingController().SHOW_ALTER_REP==false?
                      Text("Stringdetails_Sto_Num".tr,
                        style:  TextStyle(
                          color: Colors.red,
                          fontSize: height*0.02,
                        ),):Container(),
                      controller.TYPY==2?
                      Text("${'StringlastSync'.tr} :${controller.LastBAL_ACC_M}   ",
                        style:  TextStyle(
                          color: Colors.red,
                          fontSize: height*0.02,
                        ),):Container(),
                    ],
                  ),
                ),
              ),
                        ],
                      ),
            )))
      ),
    );
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


  Future  Open_File({String? fileName}) async {
    final file = await  GetFile('$fileName');
    if (file == null) return null;

    print('path:${file.path}');

    await OpenFilex.open(file.path);
  }

  var TEST3 = {
    "typ": "file",
    "typ2": "D:\\ELITEPRO\\PICTURES\\SIGN.jpg",
  };


  Future<File?> GetFile(String name) async {
    var url = "${LoginController().baseApi}/ESAPI/ESINF";

    final appStorage = await getApplicationDocumentsDirectory();
    final file =File('${appStorage.path}/$name');
    print("${url}/GetFile");
    print("${TEST3}/GetFile");
    try {
      var response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: const Duration(seconds: 2),)
          ,queryParameters: TEST3);
      if (response.statusCode == 200) {
        print('GetFile');
       // final raf= file.openSync(mode: FileMode.write);
      //  raf.writeFromSync(response.data);
       await file.writeAsBytes(response.data);
      //  print(file);
      //  await raf.close();
        return file;
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
        configloading();
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode} ${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
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

  Future<File> downloadFile( String filename) async {
    var url = "${LoginController().baseApi}/ESAPI/ESINF";
    var request = await http.get(Uri.parse(url));
    var bytes = request.bodyBytes;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}

