import 'dart:io';
import '../../../Setting/Views/Sync/show_syn_log.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dimensions.dart';
import '../../../Widgets/downloadfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../Widgets/header_widget.dart';

class Setting_Home_View extends StatefulWidget {
  @override
  State<Setting_Home_View> createState() => _Setting_Home_ViewState();
}

class _Setting_Home_ViewState extends State<Setting_Home_View> {

  final StteingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle:  STMID=='MOB'?false:true,
        backgroundColor: AppColors.MainColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Stringsetting'.tr,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.sync,color: Colors.black,size:  Dimensions.width30,),
                  title:  Text('StringSync'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    if (LoginController().experimentalcopy == 1) {
                      Get.defaultDialog(
                        title: 'StringMestitle'.tr,
                        middleText: 'Stringexperimentalcopy'.tr,
                        backgroundColor: Colors.white,
                        radius: 40,
                        textCancel: 'StringOK'.tr,
                        cancelTextColor: Colors.blueAccent,
                      );
                    } else {
                      Get.toNamed('/Sync');
                    }
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.settings,color: Colors.black,size:  Dimensions.width30,),
                  title:  Text('StringSettings_APP'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    Get.toNamed('/Setting');
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.zoom_out_outlined,color: Colors.black,size:  Dimensions.width30,),
                  title:  Text('StringAboutUs'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    Get.toNamed('/AboutUs',arguments: 101);
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.share,color: Colors.black,size:  Dimensions.width30,),
                  title:  Text('StringShareApp'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    Share.share(
                        'https://play.google.com/store/apps/details?id=com.elitesoftsys.emobilepro');
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.language, size:  Dimensions.width30, color: Colors.black),
                  title: Text('StringChinglan'.tr,
                    style: TextStyle(fontSize: Dimensions.fonText, color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    buildShowDialogLang(context);
                    // Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                  },
                ),
              ),
            ),
            STMID=='EORD'?Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.download,color: Colors.black,size:  Dimensions.width30,),
                  title:  Text('StringGET_IMAGE_MAT'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    if (LoginController().experimentalcopy == 1) {
                      Get.defaultDialog(
                        title: 'StringMestitle'.tr,
                        middleText: 'Stringexperimentalcopy'.tr,
                        backgroundColor: Colors.white,
                        radius: 40,
                        textCancel: 'StringOK'.tr,
                        cancelTextColor: Colors.blueAccent,
                      );
                    } else {
                      EasyLoading.instance
                        ..displayDuration = const Duration(milliseconds: 2000)
                        ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                        ..loadingStyle = EasyLoadingStyle.custom
                        ..indicatorSize = 55.0
                        ..radius = 10.0
                        ..progressColor = Colors.white
                        ..backgroundColor = Colors.green
                        ..indicatorColor = Colors.white
                        ..textColor = Colors.white
                        ..maskColor = Colors.blue.withOpacity(0.5)
                        ..userInteractions = false
                        ..dismissOnTap = false;
                      EasyLoading.show();
                        Socket.connect(LoginController().IP,int.parse(LoginController().PORT), timeout: const Duration(seconds: 5)).then((socket) async {
                          print("Success");
                          GET_IMGE_MAT();
                          socket.destroy();
                        }).catchError((error) {
                          print("Exception on Socket $error");
                          configloading();
                          Fluttertoast.showToast(
                              msg: error.toString(),
                              toastLength: Toast.LENGTH_LONG,
                              textColor: Colors.white,
                              backgroundColor: Colors.redAccent);
                        });
                    }
                  },
                ),
              ),
            ):
            Container(),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.archive_outlined,color: Colors.black,size:  Dimensions.width30,),
                  title:  Text('StrinSyncArchive'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    if (LoginController().experimentalcopy == 1) {
                      Get.defaultDialog(
                        title: 'StringMestitle'.tr,
                        middleText: 'Stringexperimentalcopy'.tr,
                        backgroundColor: Colors.white,
                        radius: 40,
                        textCancel: 'StringOK'.tr,
                        cancelTextColor: Colors.blueAccent,
                      );
                    } else {
                      Get.to(() => Show_Syn_Log());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
