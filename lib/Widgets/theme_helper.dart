import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share_plus/share_plus.dart';
import '../Setting/Views/Home/fast_acc_usr_view.dart';
import '../Setting/controllers/home_controller.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/controllers/setting_controller.dart';
import '../Setting/models/acc_cas.dart';
import '../Setting/models/acc_cos.dart';
import '../Setting/models/acc_mov_k.dart';
import '../Setting/models/acc_usr.dart';
import '../Setting/models/bil_cre_c.dart';
import '../Setting/models/bil_cus.dart';
import '../Setting/models/bil_mov_k.dart';
import '../Setting/models/bil_poi.dart';
import '../Setting/models/bil_poi_u.dart';
import '../Setting/models/bra_inf.dart';
import '../Setting/models/bra_yea.dart';
import '../Setting/models/cos_usr.dart';
import '../Setting/models/gro_usr.dart';
import '../Setting/models/job_typ.dart';
import '../Setting/models/mat_gro.dart';
import '../Setting/models/mat_inf.dart';
import '../Setting/models/mat_pri.dart';
import '../Setting/models/mat_uni.dart';
import '../Setting/models/mat_uni_b.dart';
import '../Setting/models/mat_uni_c.dart';
import '../Setting/models/model_image.dart';
import '../Setting/models/pay_kin.dart';
import '../Setting/models/sto_inf.dart';
import '../Setting/models/sto_num.dart';
import '../Setting/models/sto_usr.dart';
import '../Setting/models/sys_com.dart';
import '../Setting/models/sys_cur.dart';
import '../Setting/models/sys_doc_d.dart';
import '../Setting/models/sys_own.dart';
import '../Setting/models/sys_usr.dart';
import '../Setting/models/sys_usr_b.dart';
import '../Setting/models/sys_usr_p.dart';
import '../Setting/models/sys_var.dart';
import '../Setting/models/sys_yea.dart';
import '../Setting/models/usr_pri.dart';
import '../Setting/services/api_provider_login.dart';
import '../Setting/services/syncronize.dart';
import '../database/setting_db.dart';
import '../database/sync_db.dart';
import 'colors.dart';
import 'config.dart';
import 'dart:ui' as UI;
import 'dimensions.dart';

class ThemeHelper {
  String? SelectDataStatus;
  final List<Map> josnStatus = [
    {"id": "1", "name": "نهائي"},
    {"id": "2", "name": "غير نهائي "},
  ];




  Color ColorWhite = const Color(0xffffffff);
  final controller = Get.put(LoginController());
  // final controller2=Get.put(AddEditTransferController());

  Text buildText(BuildContext context ,Textname,Color color,TypeSize ) {
    double height = MediaQuery.of(context).size.height;
    double L=StteingController().Size_Font=='L'? 0.024 * height : StteingController().Size_Font=='M' ? 0.022 * height : 0.019 * height ;
    double M=StteingController().Size_Font=='L'? 0.02 * height : StteingController().Size_Font=='M' ? 0.018 * height: 0.015 * height ;
    double S=StteingController().Size_Font=='L'? 0.017 * height : StteingController().Size_Font=='M' ? 0.015 * height: 0.012 * height ;
    return Text('${Textname}'.tr,
        style:  TextStyle(
            fontFamily: 'Hacen',
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: TypeSize=='L'? L : TypeSize=='M' ? M : S));
  }

  TextStyle buildTextStyle(BuildContext context ,Color color,TypeSize ) {
    double height = MediaQuery.of(context).size.height;
    double L=StteingController().Size_Font=='L'? 0.024 * height : StteingController().Size_Font=='M' ? 0.022 * height: 0.019 * height ;
    double M=StteingController().Size_Font=='L'? 0.02 * height : StteingController().Size_Font=='M' ? 0.018 * height: 0.015 * height ;
    double S=StteingController().Size_Font=='L'? 0.017 * height : StteingController().Size_Font=='M' ? 0.015 * height: 0.012 * height ;
    double S2=StteingController().Size_Font=='L'? 0.012 * height : StteingController().Size_Font=='M' ? 0.01 * height: 0.01 * height ;
    return   TextStyle(
        fontFamily: 'Hacen',
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: TypeSize=='L'? L : TypeSize=='M' ? M :TypeSize=='S'?S: S2);
  }


  bool isNumeric(String str) {
    if (str == 'null') {
      return false;
    }
    return double.tryParse(str) != null;
  }

  Future<bool?> ShowToastW(String response) {
    return Fluttertoast.showToast(
        msg: "${response}",
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.red);
  }


  Widget circularProgress() {
    const alwaysStoppedAnimationCircularProgress = Colors.red;
    const backgroundColorCircularProgress = Colors.white;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 10.0),
      child: const CircularProgressIndicator(
        valueColor:
        AlwaysStoppedAnimation(alwaysStoppedAnimationCircularProgress),
        backgroundColor: backgroundColorCircularProgress,
      ),
    );
  }

  InputDecoration textInputDecoration(
      String lableText, String hintText, Widget icons,FocusNode focusNode) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      prefixIcon: icons,
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      //labelStyle: const TextStyle(color: Colors.black),
      labelStyle: TextStyle(
        color: focusNode.hasFocus ? Colors.red : Colors.grey, // تغيير لون النص بناءً على التركيز
      ),
      //fontFamily: 'Hacen',
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(100.0),
      ),
      // focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(100.0),
      //     borderSide: BorderSide(color: Colors.grey.shade400)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  InputDecoration textInputDecorationPassword(
      String lableText, String hintText, Widget icons, Widget iconsPassowrd,FocusNode focusNode) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      prefixIcon: icons,
      suffixIcon: iconsPassowrd,
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      labelStyle: TextStyle(
        color: focusNode.hasFocus ? Colors.red : Colors.grey, // تغيير لون النص بناءً على التركيز
      ),
      //fontFamily: 'Hacen',
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(100.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration buttonBoxDecoration(BuildContext context,
      [String color1 = "", String color2 = ""]) {
    Color c1 = AppColors.MainColor;
    Color c2 = AppColors.MainColor;
    if (color1.isEmpty == false) {
      c1 = HexColor(color1);
    }
    if (color2.isEmpty == false) {
      c2 = HexColor(color2);
    }

    return BoxDecoration(
      boxShadow: const [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: WidgetStateProperty.all(const Size(50, 50)),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  UI.TextDirection direction = UI.TextDirection.rtl;

  void Socket_IP_CHING_PASS(String IP,int Port) async {
    Socket.connect(IP, Port, timeout: const Duration(seconds: 10)).then((socket) async {
      print("Success");
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
      EasyLoading.show();
      //UpdateSYS_USR(controller.SUAP_OController.text);
      await Future.delayed(const Duration(seconds: 1));
      await SyncronizationData().SyncSYS_USR(controller.SUAP_NController.text);
      socket.destroy();
    }).catchError((error){
      Get.snackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      ApiProviderLogin().configloading();
      Fluttertoast.showToast(
          msg: "${error.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      print("Exception on Socket "+error.toString());
    });
  }


  Future<dynamic> buildShowChing_pass() {
    return Get.defaultDialog(
      title: "StringChing_Pass".tr,
      content: GetBuilder<LoginController>(
          init: LoginController(),
          builder: ((controller) => Column(
            children: [
              TextFormField(
                controller: controller.SUAP_OController,
                autofocus: true,
                obscureText: controller.isObscure_O,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.go,
                onChanged: (v) {
                  controller.CONV_P(v.toString());
                },
                onFieldSubmitted: (String value) {
                  controller.myFocusSUPA.requestFocus();
                },
                decoration:  InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  icon:  IconButton(
                    icon: Icon(
                      controller.isObscure_O
                          ? Icons.visibility
                          : Icons.visibility_off,
                      //  size: Dimensions.iconSize35,
                      color: AppColors.IconColor,
                    ),
                    onPressed: () {
                      controller.isObscure_O = ! controller.isObscure_O;
                      controller.update();
                    },
                  ),
                  label: Text('StringOLD_PAS'.tr),
                ),
              ),
              TextFormField(
                controller: controller.SUAP_NController,
                obscureText: controller.isObscure_N,
                keyboardType: TextInputType.number,
                focusNode: controller.myFocusSUPA,
                textInputAction: TextInputAction.go,
                onFieldSubmitted: (String value) {
                  controller.myFocusSUPAN.requestFocus();
                },
                decoration:  InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  icon:  IconButton(
                    icon: Icon(
                      controller.isObscure_N
                          ? Icons.visibility
                          : Icons.visibility_off,
                      //  size: Dimensions.iconSize35,
                      color: AppColors.IconColor,
                    ),
                    onPressed: () {
                      controller.isObscure_N = ! controller.isObscure_N;
                      controller.update();
                    },
                  ),
                  label: Text('StringNEW_PAS'.tr),
                ),
              ),
              TextFormField(
                controller: controller.SUAP_SController,
                obscureText: controller.isObscure_S,
                keyboardType: TextInputType.number,
                focusNode: controller.myFocusSUPAN,
                textInputAction: TextInputAction.go,
                decoration:  InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  icon:  IconButton(
                    icon: Icon(
                      controller.isObscure_S
                          ? Icons.visibility
                          : Icons.visibility_off,
                      //  size: Dimensions.iconSize35,
                      color: AppColors.IconColor,
                    ),
                    onPressed: () {
                      controller.isObscure_S = ! controller.isObscure_S;
                      controller.update();
                    },
                  ),
                  label: Text('StringNEW_PAS1'.tr),
                ),
              ),
              SizedBox(height: Dimensions.height10),
              MaterialButton(
                onPressed: () async {
                  print(int.parse(LoginController().SUPA));
                  print('LoginController().SUPA');
                  if(controller.SUAP_OController.text.isEmpty) {
                    ShowToastW('StringCHK_OLD_PAS'.tr);
                  }
                  else if(controller.SUAP_NController.text.isEmpty) {
                    ShowToastW('StringCHK_NEW_PAS'.tr);
                  }
                  else if(controller.SUAP_SController.text.isEmpty) {
                    ShowToastW('StringCHK_NEW_PAS1'.tr);
                  }
                  else if(controller.SUPA_V!=int.parse(LoginController().SUPA)) {
                    ShowToastW('StringOLD_PAS_ERR'.tr);
                  }
                  else if(controller.SUAP_SController.text!=controller.SUAP_NController.text){
                    ShowToastW('StringNEW_PAS_ERR'.tr);
                  }
                  else{
                    Socket_IP_CHING_PASS(LoginController().IP,int.parse(LoginController().PORT));
                  }
                },
                child: Container(
                  height: Dimensions.height40,
                  // width: 330.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.MainColor,
                      borderRadius: BorderRadius.circular(Dimensions.height35)),
                  child: Text(
                    'StringSave'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.fonText,
                    ),
                  ),
                ),
              ),
            ],
          ))),
      backgroundColor: Colors.white,
      radius: 30,
      barrierDismissible: true,
    );
  }

  Future<dynamic> buildShowDialogIP(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Get.defaultDialog(
        title: 'StringSettingLogin'.tr,
        content: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IP address row
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 0.2, // تحديد عرض النص
                      child: Text(
                        'IP :',
                        style: TextStyle(
                          fontSize: 0.02 * height,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.IPSERERController,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.02 * height,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Port number row
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 0.2, // تحديد عرض النص
                      child: Text(
                        'Port :',
                        style: TextStyle(
                          fontSize: 0.02 * height,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.PORTController,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.02 * height,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Number of records row
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 0.2, // تحديد عرض النص
                      child: Text(
                        'StrinCount_RECODE'.tr,
                        style: TextStyle(
                          fontSize: 0.02 * height,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.CountRECODEController,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.02 * height,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                          border: UnderlineInputBorder(),
                        ),
                        onChanged: (v){
                          v.isEmpty?v='150':v=v;
                          int value =(int.parse(v));
                          controller.UPDATEMOB_VAR_P(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        radius: MediaQuery.of(context).size.width * 0.05,
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(Dimensions.height20),
                              side: const BorderSide(color: Colors.black45))),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.only(
                              left: Dimensions.height25,
                              right: Dimensions.height25)),
                    ),
                    child: Text(
                      "Test",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: Dimensions.fonText,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      // if (!await checkConnection()) {
                      //   Get.snackbar(StringCHK_Int_Tit, StringCHK_Int_Mes,
                      //       backgroundColor: Colors.red,
                      //       icon: Icon(Icons.wifi_off,color:Colors.white),
                      //       colorText:Colors.white,
                      //       isDismissible: true,
                      //       dismissDirection: DismissDirection.horizontal,
                      //       forwardAnimationCurve: Curves.easeOutBack);
                      // }
                      // else {
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
                      EasyLoading.show(status: 'StringShow_Connent'.tr);
                      StringIP = LoginController().IPSERERController.text;
                      StringPort = LoginController().PORTController.text;
                      controller.update();
                      print(StringIP);
                      print(StringPort);
                      LoginController().SET_P('baseApi','http://$StringIP:$StringPort');
                      LoginController().SET_P('API','http://$StringIP:$StringPort');
                      LoginController().SET_P('IP',controller.IPSERERController.text);
                      LoginController().SET_P('PORT',controller.PORTController.text);
                      controller.update();
                      // GetFile("EMobileProSign.png");
                      ApiProviderLogin().Socket_IP(
                          controller.IPSERERController.text,
                          int.parse(controller.PORTController.text));
                      // ApiProviderLogin().TEST_API();
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(Dimensions.height20),
                              side: const BorderSide(color: Colors.black45))),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.only(
                              left: Dimensions.height25,
                              right: Dimensions.height25)),
                    ),
                    child: Text(
                      "Connect",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: Dimensions.fonText,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
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
                      EasyLoading.show(status: 'StringShow_Connent'.tr);
                      StringIP = LoginController().IPSERERController.text;
                      StringPort = LoginController().PORTController.text;
                      controller.update();
                      print(StringIP);
                      print(StringPort);
                      LoginController().SET_P('baseApi','http://$StringIP:$StringPort');
                      LoginController().SET_P('API','http://$StringIP:$StringPort');
                      LoginController().SET_P('IP',controller.IPSERERController.text);
                      LoginController().SET_P('PORT',controller.PORTController.text);
                      controller.update();
                      ApiProviderLogin().Socket_IP_Connect(
                          controller.IPSERERController.text,
                          int.parse(controller.PORTController.text));
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(Dimensions.height20),
                              side: const BorderSide(color: Colors.black45))),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.only(
                              left: Dimensions.height25,
                              right: Dimensions.height25)),
                    ),
                    child: Text(
                      "Exit",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: Dimensions.fonText,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
          ),
        ]
      // barrierDismissible: false,
    );
  }

  void showCustomBottomSheet(BuildContext context,type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        final viewInsets = mediaQuery.viewInsets;
        final screenHeight = mediaQuery.size.height;
        final screenWidth = mediaQuery.size.width;

        return StatefulBuilder(
          builder: (context, setState) {
            return GetBuilder<LoginController>(
                builder: ((value) =>Padding(
                  padding: EdgeInsets.only(bottom: viewInsets.bottom),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: mediaQuery.size.height * 0.77,
                      minHeight: mediaQuery.size.height * 0.5,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05, // 5% من العرض
                        vertical: screenHeight * 0.02, // 2% من الارتفاع
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.06,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  iconSize: screenHeight * 0.03,
                                  icon: const Icon(Icons.close),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                Text(
                                  'StringSettingLogin'.tr,
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.028, // ~24px على شاشة 800px
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Expanded(
                            child: NotificationListener<ScrollUpdateNotification>(
                              onNotification: (notification) {
                                // التمرير التلقائي عند الحاجة
                                if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                                  FocusScope.of(context).unfocus();
                                }
                                return true;
                              },
                              child: ListView(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                children: [
                                  _buildDeviceInfoSection(context),
                                  SizedBox(height: screenHeight * 0.015),
                                  _buildServerSection(context),
                                  SizedBox(height: screenHeight * 0.015),
                                  // Instructions
                                  Column(
                                    children: [
                                      _buildBulletPoint(
                                          'StrinThetitlemustnotcontainspaces'.tr,
                                          screenHeight),
                                      // SizedBox(height: screenHeight * 0.01),
                                      // _buildBulletPoint(
                                      //     'Strinchangingtheaddress'.tr,
                                      //     screenHeight),
                                    ],
                                  ),
                                  SizedBox(height: mediaQuery.size.height * 0.02),
                                  TextFormField(
                                    controller: controller.CountRECODEController,
                                    focusNode: controller.count_synFocus,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText:'StrinCount_Sync'.tr,
                                      hintText: '150',
                                      labelStyle: TextStyle(
                                        color: controller.count_synFocus.hasFocus ? Colors.red : Colors.grey, // تغيير لون النص بناءً على التركيز
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.red, width: 1.5), // لون الحدود عند التركيز
                                      ),
                                      contentPadding: EdgeInsets.all(mediaQuery.size.width * 0.03),
                                    ),
                                    onChanged: (v){
                                      v.isEmpty?v='150':v=v;
                                      int value =(int.parse(v));
                                      controller.UPDATEMOB_VAR_P(value);
                                    },
                                  ),
                                  // SizedBox(height: mediaQuery.size.height * 0.02),
                                  // _buildFingerprintSwitch(),
                                  SizedBox(height: screenHeight * 0.026),
                                  _buildSaveButton(context,type),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
          },
        );
      },
    );
  }

  Widget _buildBulletPoint(String text, double screenHeight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('•', style: TextStyle(fontSize: screenHeight * 0.02,color: Colors.red,)),
        SizedBox(width: screenHeight * 0.01),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenHeight * 0.016,
              color: Colors.red,
              //   height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceInfoSection(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'StrinDevice_Information'.tr,
          style: TextStyle(
            fontSize: mediaQuery.size.height * 0.02,
            color: Colors.black87,
            //  fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: mediaQuery.size.height * 0.07,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${LoginController().DeviceID.toString()}',
                  style: TextStyle(
                    fontSize:LoginController().DeviceID.toString().length<=32?
                    mediaQuery.size.height * 0.018:mediaQuery.size.height * 0.014,
                    fontFamily: 'monospace',
                    color: Colors.grey[700],
                  ),
                ),
              ),
              IconButton(
                icon:  Icon(Icons.content_copy, size: mediaQuery.size.height * 0.025),
                color: AppColors.IconColor,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: LoginController().DeviceID.toString()));
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //     content: Text('تم نسخ الرمز إلى الحافظة'),
                  //     duration: Duration(seconds: 1),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServerSection(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'StringServerAddress'.tr,
            style: TextStyle(
              fontSize: mediaQuery.size.height * 0.02,
              color: Colors.black,
              // fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: mediaQuery.size.height * 0.02),
          TextFormField(
            controller: controller.IPSERERController,
            focusNode: controller.ipFocus,
            decoration: InputDecoration(
              hintText: '192.186.0.0',
              labelText:'StringAddress'.tr,
              labelStyle: TextStyle(
                color: controller.ipFocus.hasFocus ? Colors.red : Colors.grey, // تغيير لون النص بناءً على التركيز
              ),
              //  focusedLabelStyle: TextStyle(color: Colors.red),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red, width: 1.5), // لون الحدود عند التركيز
              ),
              contentPadding: EdgeInsets.all(mediaQuery.size.width * 0.03),
            ),
          ),
          SizedBox(height: mediaQuery.size.height * 0.01),
          TextFormField(
            controller: controller.PORTController,
            focusNode: controller.portFocus,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText:'StringPort'.tr,
              hintText: '5000',
              labelStyle: TextStyle(
                color: controller.portFocus.hasFocus ? Colors.red : Colors.grey, // تغيير لون النص بناءً على التركيز
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red, width: 1.5), // لون الحدود عند التركيز
              ),
              contentPadding: EdgeInsets.all(mediaQuery.size.width * 0.03),
            ),
          ),
        ]
    );
  }

  Widget _buildSaveButton(BuildContext context,type) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: mediaQuery.size.height * 0.063,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
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
              EasyLoading.show(status: 'StringShow_Connent'.tr);
              controller.getIP();
              StringIP = controller.IPSERERController.text;
              StringPort = controller.PORTController.text;
              controller.update();
              print(StringIP);
              print(StringPort);
              LoginController().SET_P('IP',controller.IPSERERController.text);
              LoginController().SET_P('PORT',controller.PORTController.text);
              LoginController().SET_P('baseApi','http://$StringIP:$StringPort');
              LoginController().SET_P('API','http://$StringIP:$StringPort');
              LoginController().SET_P('IP',controller.IPSERERController.text);
              LoginController().SET_P('PORT',controller.PORTController.text);
              UpdateMOB_VAR(8,controller.IPSERERController.text);
              UpdateMOB_VAR(9,controller.PORTController.text);
              UpdateMOB_VAR(10,'http://$StringIP:$StringPort');
              controller.update();
              if(type==1){
                ApiProviderLogin().Socket_IP_Conn(controller.IPSERERController.text,int.parse(controller.PORTController.text));
              }else{
                ApiProviderLogin().Socket_IP_Connect(
                    controller.IPSERERController.text,
                    int.parse(controller.PORTController.text));
              }
            },
            child: Text(
              'StringConnect'.tr,
              style: TextStyle(
                fontSize: mediaQuery.size.width * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: mediaQuery.size.height * 0.010,),
        SizedBox(
          width: double.infinity,
          height: mediaQuery.size.height * 0.063,
          child: OutlinedButton.icon(
            // icon: Icon(Icons.refresh, color: Colors.red[800]),
            label: Text('StringTest'.tr,
                style: TextStyle(color: Colors.red[800], fontSize: mediaQuery.size.width * 0.04,)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              side: BorderSide(color: Colors.red[800]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed:() {
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
              EasyLoading.show(status: 'StringShow_Connent'.tr);
              controller.getIP();
              StringIP = controller.IPSERERController.text;
              StringPort = controller.PORTController.text;
              print(StringIP);
              print(StringPort);
              controller.update();
              LoginController().SET_P('baseApi','http://$StringIP:$StringPort');
              LoginController().SET_P('API','http://$StringIP:$StringPort');
              LoginController().SET_P('IP',controller.IPSERERController.text);
              LoginController().SET_P('PORT',controller.PORTController.text);
              UpdateMOB_VAR(8,controller.IPSERERController.text);
              UpdateMOB_VAR(9,controller.PORTController.text);
              UpdateMOB_VAR(10,'http://$StringIP:$StringPort');
              controller.update();
              ApiProviderLogin().Socket_IP(controller.IPSERERController.text,int.parse(controller.PORTController.text));
              // ApiProviderLogin().TEST_API();
            },
          ),
        ),
      ],
    );
  }


  final List locale = [
    {'name': 'Lan_Arabic'.tr, 'locale': const Locale('ar')},
    {'name': 'Lan_English'.tr, 'locale': const Locale('en')},
  ];

  updatelanguage(Locale locale, LoginController controller) {
    // 1. إغلاق الشاشة الحالية
    Navigator.pop(Get.context!);

    // 2. تحديث اللغة في GetX
    Get.updateLocale(locale);

    // 3. تحديث حالة الـ Controller
    controller.update();

    // 4. إعادة بناء الشاشة السابقة (اختياري)
    Get.forceAppUpdate();
  }


  void showCustomBottomSheetLan(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GetBuilder<LoginController>(
        init: LoginController(),
        builder: ((controller) => Container(
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'SettingLan'.tr,
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: locale.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    return RadioListTile<int>(
                      title: Text(
                        locale[index]['name'],
                        style: TextStyle(
                          fontSize: screenHeight * 0.020,
                        ),
                      ),
                      value: index,
                      groupValue: controller.LAN == 1 ? 0 : 1, // التصحيح هنا
                      activeColor: Colors.red,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        final newLan = locale[index]['locale'].toString() == 'ar' ? 1 : 2;
                        controller.SET_N_P('LAN', newLan);
                        controller.update(); // إضافة تحديث الحالة
                        updatelanguage(locale[index]['locale'], controller);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  GetBuilder<HomeController> buildDrawer(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(
        builder: ((value) => Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.MainColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 1.0],
                    colors: [
                      AppColors.MainColor,
                      AppColors.MainColor,
                    ],
                  ),
                ),
                child: LoginController().SOSI!='0'?
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 65,
                  child: CircleAvatar(
                    radius: 65,
                    child: ClipOval(
                        child: Image.file(File(SignPicture),
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            LoginController().SET_P('Image_Type','2');
                            return Image.asset(ImagePathPDF,
                              fit: BoxFit.cover,
                            );
                          },
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height,
                          width:  MediaQuery.of(context).size.width,)
                    ),
                  ),
                ):
                Container(),
              ),
              Container(
                child: Column(
                  children: [
                    if(LoginController().experimentalcopy != 1 )
                      ListTile(
                        leading: Icon(
                          Icons.sync,
                          size: 0.026 * height,
                          color: Colors.black,
                        ),
                        title: ThemeHelper().buildText(context,'StringSync', Colors.black,'M'),
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
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
                        },
                      ),
                    ListTile(
                      leading: Icon(Icons.settings,
                          size: 0.026 * height, color: Colors.black),
                      title: ThemeHelper().buildText(context,'StringSettings_APP', Colors.black,'M'),
                      onTap: () {
                        Get.toNamed('/Setting');
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                      },
                    ),
                    if(LoginController().experimentalcopy != 1 )
                      ListTile(
                        leading: Icon(Icons.assignment_returned_sharp,
                            size: 0.026 * height, color: Colors.black),
                        title: ThemeHelper().buildText(context,'StringAboutApp', Colors.black,'M'),
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
                            // Navigator.push( context, MaterialPageRoute(builder: (context) => HeplCenter()),);
                            //  LoginController().save_path();
                            LoginController().save_path(true);

                            //buildShowDialogBK(context);
                            // HeplCenter();
                          }
                        },
                      ),
                    if(LoginController().experimentalcopy != 1 )
                      ListTile(
                        leading:
                        Icon(Icons.update, size: 0.026 * height, color: Colors.black),
                        title: ThemeHelper().buildText(context,'StringRestoreDB', Colors.black,'M'),
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
                            buildShowDialogimportDataBase(context,1);
                          }
                        },
                      ),
                    ListTile(
                      leading: Icon(Icons.zoom_out_outlined,
                          size: 0.026 * height, color: Colors.black),
                      title: ThemeHelper().buildText(context,'StringAboutUs', Colors.black,'M'),
                      onTap: () {
                        //buildAlert(context).show();
                        Get.toNamed('/AboutUs');

                        // Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                      },
                    ),
                    if(LoginController().experimentalcopy != 1 )
                      ListTile(
                        leading: Icon(Icons.wifi_tethering_outlined,
                            size: 0.026 * height, color: Colors.black),
                        title: ThemeHelper().buildText(context,'StringSettingLogin', Colors.black,'M'),
                        onTap: () async {
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
                            print(LoginController().IP);
                            print(LoginController().PORT);
                            controller.IPSERERController.text = LoginController().IP;
                            controller.PORTController.text = LoginController().PORT;
                            await controller.GETMOB_VAR_P(1);
                            showCustomBottomSheet(context,2);
                            // buildShowDialogIP(context);
                          }
                          // Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                        },
                      ),
                    if(LoginController().experimentalcopy != 1 )
                      ListTile(
                        leading: Icon(Icons.closed_caption, size: 0.026 * height, color: Colors.black),
                        title: ThemeHelper().buildText(context,'StringCloseFiscalYear', Colors.black,'M'),
                        onTap: () async {
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
                              ..indicatorSize = 45.0
                              ..radius = 10.0
                              ..progressColor = Colors.white
                              ..backgroundColor = Colors.green
                              ..indicatorColor = Colors.white
                              ..textColor = Colors.white
                              ..maskColor = Colors.blue.withOpacity(0.5)
                              ..userInteractions = false
                              ..dismissOnTap = false;
                            EasyLoading.show(status: 'StringShow_Connent'.tr);
                            controller.update();
                            ApiProviderLogin().Socket_Connect_SYN_TAS();
                            await Future.delayed(const Duration(seconds: 10));
                            controller.GET_SYN_TAS_F_P();
                            await Future.delayed(const Duration(seconds: 10));
                            controller.GET_SYN_TAS_P(true);
                          }
                          // Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                        },
                      ),
                    if(LoginController().experimentalcopy != 1 && STMID=='MOB')
                      ListTile(
                        leading: Icon(Icons.password, size: 0.026 * height, color: Colors.black),
                        title: ThemeHelper().buildText(context,'StringChing_Pass', Colors.black,'M'),
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
                            buildShowChing_pass();
                          }
                          // Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                        },
                      ),
                    ListTile(
                      leading: Icon(Icons.language,
                          size: 0.026 * height, color: Colors.black),
                      title: ThemeHelper().buildText(context,'StringChinglan', Colors.black,'M'),
                      onTap: () {
                        showCustomBottomSheetLan(context);
                        // buildShowDialogLang(context);
                        // Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                      },
                    ),
                    if(LoginController().experimentalcopy != 1 && STMID=='MOB')
                      ListTile(
                        leading: Icon(Icons.screenshot_monitor,
                            size: 0.026 * height, color: Colors.black),
                        title: ThemeHelper().buildText(context,'StringSCR_FAS_ACC', Colors.black,'M'),
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
                            UpdateFAS_ACC_USR__FAUST2();
                            Get.to(() => FAS_ACC_USR_View());
                          }
                        },
                      ),
                    // ListTile(
                    //   leading: Icon(Icons.data_array,
                    //       size: 0.026 * height, color: Colors.black),
                    //   title: ThemeHelper().buildText(context,'قاعدة البيانات', Colors.black,'M'),
                    //   onTap: () {
                    //     Get.to(() => CHIK_DB_View());
                    //
                    //   },
                    // ),
                    ListTile(
                      leading:
                      Icon(Icons.share, size: 0.026 * height, color: Colors.black),
                      title: ThemeHelper().buildText(context,'StringShareApp', Colors.black,'M'),
                      onTap: () {
                        Share.share(ShareApp);
                        //
                      },
                    ),
                    // ListTile(
                    //   leading: Icon(Icons.logout_rounded,
                    //       size: 0.026 * height, color: Colors.black),
                    //   title: ThemeHelper().buildText(context,'StringLogout', Colors.black,'M'),
                    //   onTap: () {
                    //     buildShowDialog(context);
                    //   },
                    // ),
                    Text('v ${SYDV_APPV_APP}',style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                  ],
                ),
              ),
              Container(
                color: LoginController().Service_isRunning==true?Colors.green[400]:Colors.red[400],
                // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: LoginController().Service_isRunning==true?Text('Services is Running'):Text('Services is Stoping'),
              )
            ],
          ),
        )));
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return Get.defaultDialog(
      title: 'StringMestitle'.tr,
      middleText: 'StringMesLogOut'.tr,
      backgroundColor: Colors.white,
      radius: 40,
      textCancel: 'StringNo'.tr,
      cancelTextColor: Colors.red,
      textConfirm: 'StringYes'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () async {
        LoginController().SET_B_P('RemmberMy',false);
        print(LoginController().RemmberMy);
        print('LoginController().RemmberMy');
        Navigator.of(context).pop(false);
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          LoginController().SET_B_P('RemmberMy',false);
          Navigator.of(context).pop();
          await Future.delayed(const Duration(milliseconds: 100));
          exit(0);
        }
      },
      // barrierDismissible: false,
    );
  }

  Future<dynamic> buildShowDialogBK(BuildContext context) {
    return Get.defaultDialog(
      title: DBNAME,
      middleText: "${'StringBKMES'.tr} ",
      backgroundColor: Colors.white,
      radius: 40,
      textCancel: 'StringOK'.tr,
      cancelTextColor: Colors.blueAccent,
      onCancel: () {
        Navigator.of(context).pop(false);
        LoginController().save_path(true);
      },
      // barrierDismissible: false,
    );
  }

  Future<dynamic> buildShowDialogimportDataBase(BuildContext context,int Type) {
    return Get.defaultDialog(
      title: 'StringMestitle'.tr,
      middleText: 'StringMes_Restore_DB'.tr,
      backgroundColor: Colors.white,
      radius: 40,
      textCancel: 'StringNo'.tr,
      cancelTextColor: Colors.red,
      textConfirm: 'StringYes'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () async {
        var status = await Permission.manageExternalStorage.request();
        if (status.isGranted) {
          controller.importDataBaseFile(1);
        }
        else if (status.isPermanentlyDenied) {
          openAppSettings();
        }
        Navigator.of(context).pop(false);
        LoginController().importDataBaseFile(Type);
      },
      // barrierDismissible: false,
    );
  }

  Container buildContainerforHome(
      double height,
      String imageName,
      BuildContext context,
      String ScreenName,
      String RoutesName,
      double texthigh,
      ) {
    return Container(
      height: 500,
      child: Stack(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage(imageName), fit: BoxFit.contain),
              borderRadius: BorderRadius.circular(height * .1),
            ),
          ),
          Positioned(
              bottom: Dimensions.height55,
              right: Dimensions.height30,
              child: Text(
                ScreenName,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:  Dimensions.fonText),
              )),
        ],
      ),
    );
  }

  static String getimages(String name) {
    return '${ImagePath}' + name;
  }
  //  header auto data ---------------------------------------------------------

  static const List<String> images_header_auto = [
    "EliteCom.jpg",
    "ElitePro.jpg",
    "EliteLite.jpg",
    "Creative.jpg",
    "EliteApps.jpg",
    "Einventory.jpg",
    "EStation.jpg"
  ];

  static List<ModelImage> getModelImage() {
    final List<ModelImage> items = [];
    for (int i = 0; i < images_header_auto.length; i++) {
      ModelImage obj = new ModelImage();
      obj.image = images_header_auto[i];
      items.add(obj);
    }
    return items;
  }

  AppBar MainAppBar(String TitleName) {
    return AppBar(
      automaticallyImplyLeading: TYPEPHONE=="IOS"?true: STMID=='EORD'?false:true,
      centerTitle:  STMID=='EORD'?true:false,
      backgroundColor: AppColors.MainColor,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        TitleName,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }



  InputDecoration InputDecorationDropDown(
      String labelText, {
        Widget? suffixIcon, // خاصية اختياريّة للأيقونة
        Color? suffixIconColor, // خاصية اختياريّة لتحديد لون الأيقونة
        FocusNode? focusNode, // خاصية اختياريّة لتحديد لون الأيقونة
      }) {
    return InputDecoration(
      isDense: true,
      labelText: labelText,
      labelStyle: TextStyle(
        color: (focusNode != null && focusNode.hasFocus)
            ? Colors.red
            : Colors.grey.shade500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.height15),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.width15),
          borderSide: BorderSide(color:(focusNode != null && focusNode.hasFocus)
              ? Colors.red
              : Colors.grey.shade500,)),
      suffixIcon: suffixIcon ??
          (suffixIconColor != null
              ? Icon(
            Icons.clear, // أو أي أيقونة أخرى حسب الحاجة
            color: suffixIconColor,
          ) : null),
    );
  }


  saveData() async {
    if(LoginController().Chkexperimentalcopy==0) {
      LoginController().SET_P('SUID','1');
      LoginController().SET_P('SUNA','مسؤول النظام');
      LoginController().SET_P('JTNA','ايليت سوفت');
      LoginController().SET_P('BINA','المركز الرئيسي');
      LoginController().SET_P('SUPA','123456');
      LoginController().SET_P('APPV',SYDV_APPV);
      Sys_Com_Local SYS_COM = Sys_Com_Local(SCID: 1,
          SCNA: 'ايليت سوفت',
          SCNE: 'ELITE SOFT',
          CWID: '1',
          CTID: '1',
          SCTL: '+967-1-261652',
          SCMO: '777753527 , 777712471',
          SCAD: 'Main Center: Yemen - Sanaa City',
          SCWE: 'Www.Sys-es.com',
          SCEM: 'Info@Sys-es.com , Muner.otail@Gmail.com',
          SCIN: 'Www.Sys-es.com - Email: Info@Sys-es.com  - Facebook: /EliteSoftsys',
          SCFA: 'https://www.facebook.com/EliteSoftsys/',
          SCTW: 'https://www.Twitter.com/EliteSoft.sys/',
          SCIS: 'https://www.Instegram.com/EliteSoft.sys/',
          SCWA: '+967-777712471',
          SCQQ: '2309014872');
      Sys_Own_Local SYS_OWN = Sys_Own_Local(SOID: 1,
          SONA: 'شركة ايليت سوفت',
          SONE: 'ELITE SOFT',
          SORN: 'للانظمة وتقنية المعلومات',
          SOLN: 'For System and IT',
          BIID: 1,
          SOAD: 'صنعاء - شارع حده - جولة المصباحي',
          SOTX: '1000006215430',
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Job_Typ_Local JOB_TYP = Job_Typ_Local(JTID: 1, JTNA: 'ايليت سوفت',JTNE: 'ELITE SOFT', JTST: 1);
      Sys_Var_Local SYS_VAR2 = Sys_Var_Local(
          SVID: 726,
          SVVL:  LoginController().experimentalcopyType==1?'15':'0',
          SVNA: 'نسبه الضريبة',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR4 = Sys_Var_Local(
          SVID: 604, SVVL: '2', SVNA: 'فصل تسلسل حركات الفواتير النقد عن الاجل-مبيعات فوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR6 = Sys_Var_Local(
          SVID: 711, SVVL: '1', SVNA: 'آلية ترقيم تسلسل حركة الفواتير الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR7 = Sys_Var_Local(
          SVID: 712, SVVL: '1', SVNA: 'الفتره الزمنيه التي يتم خلالها تصفير مسلسل الحركات والبدء بترقيم جديد -1- للفواتير الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR8 = Sys_Var_Local(
          SVID: 739,
          SVVL: '1',
          SVNA: 'عنداستخدام ضريبةالمبيعات فإن سعر البيع في الفاتوره يكون',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR9 = Sys_Var_Local(
          SVID: 5041, SVVL: '50', SVNA: 'اكبر قيمه لحقل الكميه في الفاتوره ولا يمكن تجاوزه-للاصناف المخزنيه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR10 = Sys_Var_Local(
          SVID: 5042, SVVL: '5000000', SVNA: 'اكبر قيمه لحقل الكميه في الفاتوره ولا يمكن تجاوزه-للاصناف المخزنيه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR11 = Sys_Var_Local(
          SVID: 723, SVVL: '1', SVNA: 'اكبر قيمه لحقل الكميه في الفاتوره ولا يمكن تجاوزه-للاصناف المخزنيه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      //متغيرات السندات
      Sys_Var_Local SYS_VAR12 = Sys_Var_Local(
          SVID: 362, SVVL: '2', SVNA: 'تاريخ ادخال الحركات المحاسبيه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR13 = Sys_Var_Local(
          SVID: 365, SVVL: '1', SVNA: 'عند تكرار ادخال نفس الحساب في الحركه المحاسبيه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR14 = Sys_Var_Local(
          SVID: 382, SVVL: 'عليكم من الحساب', SVNA: 'البيان الافتراضي عند ادخال سندات الصرف-صندوق',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR15 = Sys_Var_Local(
          SVID: 396, SVVL: 'عليكم من الحساب', SVNA: 'البيان الافتراضي عند ادخال سندات صرف حوالة',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR16 = Sys_Var_Local(
          SVID: 395, SVVL: 'واصل لكم من الحساب', SVNA: 'البيان الافتراضي عند ادخال سندات قبض حوالة',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR17 = Sys_Var_Local(
          SVID: 379, SVVL: '1', SVNA: 'اظهار وصف )بدل فاقد( عند اعادة طباعة السند/الحركه المحاسبيه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      //متفيرات المبيعات
      Sys_Var_Local SYS_VAR1 = Sys_Var_Local(
          SVID: 701,
          SVVL: LoginController().experimentalcopyType==1?'5':'2',
          SVNA: 'احتساب ضريبة مبيعات في المبيعات الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR5 = Sys_Var_Local(
          SVID: 706, SVVL: '1', SVNA: 'عند بيع الصنف بسعر اقل من سعر التكلفه في المبيعات الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR3 = Sys_Var_Local(
          SVID: 601, SVVL: '2', SVNA: 'فصل تسلسل حركات الفواتير النقد عن الاجل-مبيعات فوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR18 = Sys_Var_Local(
          SVID: 702, SVVL: '1', SVNA: 'الية طباعة فواتير المبيعات الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR19 = Sys_Var_Local(
          SVID: 718, SVVL: '1', SVNA: 'الية طباعة مردود فواتير المبيعات الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR20 = Sys_Var_Local(
          SVID: 652, SVVL: '1', SVNA: 'الية طباعة الفواتير',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR21 = Sys_Var_Local(
          SVID: 657, SVVL: '1', SVNA: 'النموذج المعتمد لتقرير فاتورة مبيعات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR22 = Sys_Var_Local(
          SVID: 658, SVVL: '1', SVNA: 'النموذج المعتمد لتقرير فاتورة مشتريات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR23 = Sys_Var_Local(
          SVID: 704, SVVL: '1', SVNA: 'النموذج المعتمد لتقرير فاتورة مبيعات فوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR24 = Sys_Var_Local(
          SVID: 659, SVVL: LoginController().experimentalcopyType==1?'5':'2',
          SVNA: 'احتساب ضريبة مبيعات في الفواتير',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR25 = Sys_Var_Local(
          SVID: 660, SVVL: LoginController().experimentalcopyType==1?'5':'2',
          SVNA: 'احتساب ضريبة مشتريات في الفواتير',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR26 = Sys_Var_Local(
          SVID: 751, SVVL: '15',
          SVNA: 'نسبة الضريبه في فاتورة المبيعات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR27 = Sys_Var_Local(
          SVID: 752, SVVL: '15',
          SVNA: 'نسبة الضريبه في فاتورة المشتريات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR28 = Sys_Var_Local(
          SVID: 726, SVVL: '15',
          SVNA: 'نسبة الضريبه في فاتورة المبيعات الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR29 = Sys_Var_Local(
          SVID: 755, SVVL: LoginController().experimentalcopyType==1?'1':'2',
          SVNA: 'اظهار الرقم الضريبي عند طباعة الفاتوره',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR30 = Sys_Var_Local(
          SVID: 727, SVVL: LoginController().experimentalcopyType==1?'1':'2',
          SVNA: 'اظهار الرقم الضريبي عند طباعة الفاتوره',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR31 = Sys_Var_Local(
          SVID: 654, SVVL: '2',
          SVNA: 'تاريخ ادخال حركات الفواتير',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR32 = Sys_Var_Local(
          SVID: 655, SVVL: '3',
          SVNA: 'تسلسل/ترقيم حركات الفواتير',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR33 = Sys_Var_Local(
          SVID: 703, SVVL: '1',
          SVNA: 'عند تكرار ادخال نفس الصنف في فاتورة المبيعات الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR34 = Sys_Var_Local(
          SVID: 656, SVVL: '1',
          SVNA: 'عند تكرار ادخال نفس الصنف في الفاتوره',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR35 = Sys_Var_Local(
          SVID: 663, SVVL: '1',
          SVNA: 'عند بيع الصنف بسعر اقل من سعر التكلفه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR36 = Sys_Var_Local(
          SVID: 664, SVVL: '1',
          SVNA: 'عند بيع الصنف منتهي تاريخ صلاحيته',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR37 = Sys_Var_Local(
          SVID: 739, SVVL: '1',
          SVNA: 'عنداستخدام ضريبةالمبيعات فإن سعر البيع في الفاتوره يكون',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR38 = Sys_Var_Local(
          SVID: 772, SVVL: '3',
          SVNA: 'عنداستخدام ضريبةالمبيعات فإن سعر البيع في الفاتوره يكون',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR39 = Sys_Var_Local(
          SVID: 773, SVVL: '3',
          SVNA: 'عنداستخدام ضريبة المبيعات فإن سعر البيع في فاتورةالخدمات يكون',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR40 = Sys_Var_Local(
          SVID: 771, SVVL: '3',
          SVNA: 'عنداستخدام ضريبةالمشتريات فإن سعر الشراء في الفاتوره يكون',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR41 = Sys_Var_Local(
          SVID: 740, SVVL: '2',
          SVNA: 'استخدام ميزة عدم تجاوز اقل سعر بيع في المبيعات.',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR42 = Sys_Var_Local(
          SVID: 776, SVVL: '2',
          SVNA: 'استخدام ميزة عدم تجاوز اقل سعر بيع في المبيعات الخدميه.',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR43 = Sys_Var_Local(
          SVID: 774, SVVL: '2',
          SVNA: 'استخدام ميزة عدم تجاوز اقل سعر بيع في المبيعات.',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR44 = Sys_Var_Local(
          SVID: 775, SVVL: '2',
          SVNA: 'استخدام ميزة عدم تجاوز اكبر سعر بيع في المبيعات.',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR45 = Sys_Var_Local(
          SVID: 777, SVVL: '2',
          SVNA: 'استخدام ميزة عدم تجاوز اكبر سعر بيع في المبيعات الخدميه.',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR46 = Sys_Var_Local(
          SVID: 741, SVVL: '2',
          SVNA: 'استخدام ميزة عدم تجاوز اكبر سعر بيع في المبيعات.',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR47 = Sys_Var_Local(
          SVID: 669, SVVL: '1',
          SVNA: 'آلية ترقيم تسلسل حركات فواتير المبيعات/المردود',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR48 = Sys_Var_Local(
          SVID: 767, SVVL: '2',
          SVNA: 'في فاتوره المبيعات يتم اظهار الاصناف التي',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR49 = Sys_Var_Local(
          SVID: 719, SVVL: '1',
          SVNA: 'في فاتورة المبيعات الفوريه يتم اظهار الاصناف التي',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR50 = Sys_Var_Local(
          SVID: 436, SVVL: '2',
          SVNA: 'استخدام تاريخ/موعد التسليم في فاتورة المبيعات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR51 = Sys_Var_Local(
          SVID: 435, SVVL: '2',
          SVNA: 'استخدام تاريخ/موعد التسليم في فاتورة المشتريات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR52 = Sys_Var_Local(
          SVID: 437, SVVL: '2',
          SVNA: 'استخدام تاريخ/موعد التسليم في فاتورة الخدمات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR53 = Sys_Var_Local(
          SVID: 438, SVVL: '2',
          SVNA: 'استخدام تاريخ/موعد التسليم في فاتورة المبيعات الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR54 = Sys_Var_Local(
          SVID: 502, SVVL: '2',
          SVNA: 'فصل تسلسل حركات الفواتير النقد عن الاجل',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR55 = Sys_Var_Local(
          SVID: 602, SVVL: '1',
          SVNA: 'السماح باعطاء كميات مجانيه في المبيعات الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR56 = Sys_Var_Local(
          SVID: 514, SVVL: '1',
          SVNA: 'السماح باعطاء كميات مجانيه في المبيعات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR57 = Sys_Var_Local(
          SVID: 603, SVVL: '1',
          SVNA: 'السماح باعطاء تخفيض في المبيعات الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR58 = Sys_Var_Local(
          SVID: 515, SVVL: '1',
          SVNA: 'السماح باعطاء تخفيض في الفواتير',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR59 = Sys_Var_Local(
          SVID: 516, SVVL: '1',
          SVNA: 'السماح بتعديل سعر البيع',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR60 = Sys_Var_Local(
          SVID: 604, SVVL: '1',
          SVNA: 'السماح بتعديل سعر البيع في المبيعات الفوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR61 = Sys_Var_Local(
          SVID: 533, SVVL: '2',
          SVNA: 'اظهار تاريخ الاستحقاق في فاتورة المبيعات الاجل',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR62 = Sys_Var_Local(
          SVID: 534, SVVL: '2',
          SVNA: 'اظهار تاريخ الاستحقاق في فاتورة المشريات الاجل',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR63 = Sys_Var_Local(
          SVID: 538, SVVL: '2',
          SVNA: 'اظهار تاريخ الانتهاء في فاتورة المبيعات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR64 = Sys_Var_Local(
          SVID: 539, SVVL: '2',
          SVNA: 'اظهار تاريخ الانتهاء في فاتورة المشتريات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR65 = Sys_Var_Local(
          SVID: 537, SVVL: '2',
          SVNA: 'اظهار تاريخ آخر سداد في فاتورة المبيعات الاجل',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR66 = Sys_Var_Local(
          SVID: 692, SVVL: '1',
          SVNA: 'ضرورة تحديد المندوب/الموزع عند ادخال فاتورة مبيعات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR67 = Sys_Var_Local(
          SVID: 691, SVVL: '1',
          SVNA: 'ضرورة تحديد المندوب/الموزع عند ادخال فاتورة مشتريات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR68 = Sys_Var_Local(
          SVID: 693, SVVL: '1',
          SVNA: 'ضرورة تحديد المختص/الجهه عند ادخال فاتورة خدمات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR69 = Sys_Var_Local(
          SVID: 737, SVVL: '1',
          SVNA: 'ضرورة تحديد المندوب/الموزع في الفاتوره.',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR70 = Sys_Var_Local(
          SVID: 5032, SVVL: '2',
          SVNA: 'في فاتورة المبيعات عند استخدام الضريبه فأن الية احتساب الخصم:',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR71 = Sys_Var_Local(
          SVID: 5041, SVVL: '50',
          SVNA: 'اكبر قيمه لحقل الكميه في الفاتوره ولا يمكن تجاوزه-للاصناف المخزنيه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR72 = Sys_Var_Local(
          SVID: 5043, SVVL: '100',
          SVNA: 'اكبر قيمه لحقل الكميه في الفاتوره ولا يمكن تجاوزه-للاصناف الخدميه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR73 = Sys_Var_Local(
          SVID: 5042, SVVL: '500000',
          SVNA: 'اكبر قيمه لحقل السعر في الفاتوره ولا يمكن تجاوزه-للاصناف المخزنيه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR74 = Sys_Var_Local(
          SVID: 5044, SVVL: '500000',
          SVNA: 'اكبر قيمه لحقل السعر في الفاتوره ولا يمكن تجاوزه-للاصناف الخدميه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR75 = Sys_Var_Local(
          SVID: 403, SVVL: '1',
          SVNA: 'في فاتورة المبيعات يكون التأثير المحاسبي للحساب على الفروع بـ',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR76 = Sys_Var_Local(
          SVID: 402, SVVL: '1',
          SVNA: 'في فاتورة المبيعات يكون التأثير المحاسبي للحساب على الفروع بـ',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR77 = Sys_Var_Local(
          SVID: 404, SVVL: '1',
          SVNA: 'في فاتورة الخدمات يكون التأثير المحاسبي للحساب على الفروع بـ',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR78 = Sys_Var_Local(
          SVID: 405, SVVL: '1',
          SVNA: 'في فاتورة المبيعات الفوريه يكون التأثير المحاسبي للحساب على الفروع بـ',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR79 = Sys_Var_Local(
          SVID: 506, SVVL: '2',
          SVNA: 'استخدام مراكز تكلفه في فاتورة المبيعات',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR80 = Sys_Var_Local(
          SVID: 431, SVVL: '1',
          SVNA: 'في فاتورة المبيعات الكميه المجانيه للمنتج/الخدمه تكون:',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR81 = Sys_Var_Local(
          SVID: 430, SVVL: '1',
          SVNA: 'في فاتورة المشتريات , الكميه المجانيه للمنتج/الخدمه تكون:',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR82 = Sys_Var_Local(
          SVID: 432, SVVL: '1',
          SVNA: 'في فاتورة الخدمات الكميه المجانيه للمنتج/الخدمه تكون:',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR83 = Sys_Var_Local(
          SVID: 433, SVVL: '1',
          SVNA: 'في فاتورة المبيعات الفوريه الكميه المجانيه للمنتج/الخدمه تكون:',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR84 = Sys_Var_Local(
          SVID: 717, SVVL: '1',
          SVNA: 'يجب التحقق من توفر الكميه المباعه للصنف عند ادخال فاتورة مبيعات فوريه',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Var_Local SYS_VAR85 = Sys_Var_Local(
          SVID: 952, SVVL: '1',
          SVNA: 'عملة تقييم المخزون',JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');


      Usr_Pri_Local USR_PRI1 = Usr_Pri_Local(PRID: 2263,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI2 = Usr_Pri_Local(PRID: 2203,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI3 = Usr_Pri_Local(PRID: 2203,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI4 = Usr_Pri_Local(PRID: 1293,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI5 = Usr_Pri_Local(PRID: 750,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI6 = Usr_Pri_Local(PRID: 2227,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI7 = Usr_Pri_Local(PRID: 2240,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI8 = Usr_Pri_Local(PRID: 2264,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI9 = Usr_Pri_Local(PRID: 601,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI10 = Usr_Pri_Local(PRID: 901,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI11 = Usr_Pri_Local(PRID: 611,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI12 = Usr_Pri_Local(PRID: 621,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI13 = Usr_Pri_Local(PRID: 2272,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI14 = Usr_Pri_Local(PRID: 2207,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI15 = Usr_Pri_Local(PRID: 732,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI16 = Usr_Pri_Local(PRID: 1022,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI17 = Usr_Pri_Local(PRID: 733,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI18 = Usr_Pri_Local(PRID: 606,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI19 = Usr_Pri_Local(PRID: 2213,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI20 = Usr_Pri_Local(PRID: 2240,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI21 = Usr_Pri_Local(PRID: 615,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI22 = Usr_Pri_Local(PRID: 627,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI23 = Usr_Pri_Local(PRID: 906,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI24 = Usr_Pri_Local(PRID: 2276,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI25 = Usr_Pri_Local(PRID: 628,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI26 = Usr_Pri_Local(PRID: 616,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI27 = Usr_Pri_Local(PRID: 617,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI28 = Usr_Pri_Local(PRID: 629,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI29 = Usr_Pri_Local(PRID: 2277,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI30 = Usr_Pri_Local(PRID: 610,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI31 = Usr_Pri_Local(PRID: 2211,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI32 = Usr_Pri_Local(PRID: 2201,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI33 = Usr_Pri_Local(PRID: 622,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI34 = Usr_Pri_Local(PRID: 602,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI35 = Usr_Pri_Local(PRID: 605,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI36 = Usr_Pri_Local(PRID: 625,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI37 = Usr_Pri_Local(PRID: 2204,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI38 = Usr_Pri_Local(PRID: 640,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI39 = Usr_Pri_Local(PRID: 908,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI40 = Usr_Pri_Local(PRID: 635,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI41 = Usr_Pri_Local(PRID: 2352,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI42 = Usr_Pri_Local(PRID: 664,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI43 = Usr_Pri_Local(PRID: 604,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI44 = Usr_Pri_Local(PRID: 904,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI45 = Usr_Pri_Local(PRID: 624,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI46 = Usr_Pri_Local(PRID: 2203,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI47 = Usr_Pri_Local(PRID: 1293,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI48 = Usr_Pri_Local(PRID: 603,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI49 = Usr_Pri_Local(PRID: 623,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI50 = Usr_Pri_Local(PRID: 2202,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI51 = Usr_Pri_Local(PRID: 2227,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI52 = Usr_Pri_Local(PRID: 71,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI53 = Usr_Pri_Local(PRID: 102,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI54 = Usr_Pri_Local(PRID: 103,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI55 = Usr_Pri_Local(PRID: 901,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI56 = Usr_Pri_Local(PRID: 601,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI57 = Usr_Pri_Local(PRID: 621,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI58 = Usr_Pri_Local(PRID: 2207,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI59 = Usr_Pri_Local(PRID: 2272,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI60 = Usr_Pri_Local(PRID: 102,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI61 = Usr_Pri_Local(PRID: 103,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI62 = Usr_Pri_Local(PRID: 202,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI63 = Usr_Pri_Local(PRID: 91,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI64 = Usr_Pri_Local(PRID: 611,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Usr_Pri_Local USR_PRI65 = Usr_Pri_Local(PRID: 111,
          SUID: '1',
          UPIN: 1,
          UPCH: 1,
          UPQR: 1,
          UPDL: 1,
          UPPR: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');


      Bra_Inf_Local BRA_INF = Bra_Inf_Local(
          BIID: 1, JTID: 1, BINA: 'المركز الرئيسي',BINE: 'The main center', BIST: 1,JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Yea_Local SYS_YEA = Sys_Yea_Local(SYID: 1,
        SYSD: '01-01-2023 00:00:00',
        SYED: '31-12-2024 00:00:00',
        SYOD: '01-01-2023 00:00:00',
        SYST: 1,
        SYAC: 'O',
        SYNO: '2023',
      );
      Sys_Usr_Local SYS_USR = Sys_Usr_Local(SUID: '1',
          SUNA: 'مسؤول النظام',
          SUNE: 'Admin',
          SUPA: '429324',
          SULA: 1,
          SUST: 1,
          BIID: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Usr_P_Local SYS_USR_P = Sys_Usr_P_Local(SUID: '1',
        SUNA: 'مسؤول النظام',
        SUNE: 'Admin',
        SUPA: '429324',
        SULA: 1,
        SUST: 1,
        BIID: 1,
      );
      Sys_Usr_B_Local SYS_USR_B = Sys_Usr_B_Local(SUID: '1',
          BIID: 1,
          SUBST: 1,
          SUBIN: 1,
          SUBPR: 1,
          SUBAP: 1,
          SUAP: '1',
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Bra_Yea_Local BRA_YEA = Bra_Yea_Local(JTID: 1, BIID: 1, SYID: 1, BYST: 1,JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sto_Inf_Local STO_INF = Sto_Inf_Local(
          SIID: 1, SINA: 'المخزن الرئيسي',SINE: 'The main store', SIST: 1, BIID: 1,JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sto_Usr_Local STO_USR = Sto_Usr_Local(SIID: 1,
          SUID: '1',
          SUIN: 1,
          SUOU: 1,
          SUAM: 1,
          SUCH: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Uni_Local MAT_UNI1 = Mat_Uni_Local(MUID: 1, MUNA: 'كرتون',MUNE: 'unit1' ,MUST: 1,JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Uni_Local MAT_UNI2 = Mat_Uni_Local(MUID: 2, MUNA: 'حبه',MUNE: 'unit1' ,MUST: 1,JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Gro_Local MAT_GRO = Mat_Gro_Local(MGNO: '01',
          MGNA: 'مجموعه1',
          MGNE: 'group1',
          MGTY: 2,
          MOID: 1,
          MGKI: 1,
          MGST: 1,
          MGFN: 0,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Gro_Usr_Local GRO_USR = Gro_Usr_Local(MGNO: '01',
          SUID: '1',
          GUIN: 1,
          GUAM: 1,
          GUCH: 1,
          GUOU: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2'
      );
      Mat_Inf_Local MAT_INF1 = Mat_Inf_Local(MGNO: '01',
          MINO: '1',
          MINA: 'صنف1',
          MINE: 'Item1',
          MUIDP: 1,
          MUIDS: 2,
          MIST: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Inf_Local MAT_INF2 = Mat_Inf_Local(MGNO: '01',
          MINO: '2',
          MINA: 'صنف2',
          MINE: 'Item2',
          MUIDP: 1,
          MUIDS: 2,
          MIST: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Inf_Local MAT_INF3 = Mat_Inf_Local(MGNO: '01',
          MINO: '3',
          MINA: 'صنف3',
          MINE: 'Item3',
          MUIDP: 1,
          MUIDS: 2,
          MIST: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Inf_Local MAT_INF4 = Mat_Inf_Local(MGNO: '01',
          MINO: '4',
          MINA: 'صنف4',
          MINE: 'Item4',
          MUIDP: 1,
          MUIDS: 2,
          MIST: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Inf_Local MAT_INF5 = Mat_Inf_Local(MGNO: '01',
          MINO: '5',
          MINA: 'صنف5',
          MINE: 'Item5',
          MUIDP: 1,
          MUIDS: 2,
          MIST: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Inf_Local MAT_INF6 = Mat_Inf_Local(MGNO: '01',
          MINO: '6',
          MINA: 'صنف6',
          MINE: 'Item6',
          MUIDP: 1,
          MUIDS: 2,
          MIST: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Inf_Local MAT_INF7 = Mat_Inf_Local(MGNO: '01',
          MINO: '7',
          MINA: 'صنف7',
          MINE: 'Item7',
          MUIDP: 1,
          MUIDS: 2,
          MIST: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Uni_C_Local MAT_UNI_C1 = Mat_Uni_C_Local(MUCID: 1,
          MGNO: '01',
          MINO: '1',
          MUID: 1,
          MUCNA: 'كرتون',
          MUCNE: 'Liter',
          MUCBC: '01-1-1',
          MUCNO: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Uni_C_Local MAT_UNI_C2 = Mat_Uni_C_Local(MUCID: 2,
          MGNO: '01',
          MINO: '2',
          MUID: 1,
          MUCNA: 'لتر',
          MUCNE: 'Liter',
          MUCBC: '01-2-1',
          MUCNO: 2,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Uni_C_Local MAT_UNI_C3 = Mat_Uni_C_Local(MUCID: 3,
          MGNO: '01',
          MINO: '3',
          MUID: 1,
          MUCNA: 'لتر',
          MUCNE: 'Liter',
          MUCBC: '01-3-1',
          MUCNO: 3,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Uni_C_Local MAT_UNI_C4 = Mat_Uni_C_Local(MUCID: 4,
          MGNO: '01',
          MINO: '4',
          MUID: 1,
          MUCNA: 'لتر',
          MUCNE: 'Liter',
          MUCBC: '01-4-1',
          MUCNO: 4,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Uni_B_Local MAT_UNI_B1 = Mat_Uni_B_Local(
          MGNO: '01',
          MINO: '1',
          MUID: 1,
          MUCBC: '01-1-1',
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Uni_B_Local MAT_UNI_B2 = Mat_Uni_B_Local(
          MGNO: '01',
          MINO: '2',
          MUID: 1,
          MUCBC: '01-2-1',
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Uni_B_Local MAT_UNI_B3 = Mat_Uni_B_Local(
          MGNO: '01',
          MINO: '3',
          MUID: 1,
          MUCBC: '01-3-1',
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Uni_B_Local MAT_UNI_B4 = Mat_Uni_B_Local(
          MGNO: '01',
          MINO: '4',
          MUID: 1,
          MUCBC: '01-4-1',
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sto_Num_Local STO_NUM1 = Sto_Num_Local(SIID: 1,
          MGNO: '01',
          MINO: '1',
          MUID: 1,
          SNED: '01/01/2900',
          SNNO: 5,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sto_Num_Local STO_NUM2 = Sto_Num_Local(SIID: 1,
          MGNO: '01',
          MINO: '2',
          MUID: 1,
          SNED: '01/01/2900',
          SNNO: 10,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sto_Num_Local STO_NUM3 = Sto_Num_Local(SIID: 1,
          MGNO: '01',
          MINO: '3',
          MUID: 1,
          SNED: '01/01/2900',
          SNNO: 20,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sto_Num_Local STO_NUM4 = Sto_Num_Local(SIID: 1,
          MGNO: '01',
          MINO: '4',
          MUID: 1,
          SNED: '01/01/2900',
          SNNO: 30,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Pri_Local MAT_PRI1 = Mat_Pri_Local(
          SCID: 1,
          MGNO: '01',
          MINO: '1',
          MUID: 1,
          BIID: 1,
          MPS1: 2,
          MPCO: 1500,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Pri_Local MAT_PRI2 = Mat_Pri_Local(SCID: 1,
          MGNO: '01',
          MINO: '2',
          MUID: 1,
          BIID: 1,
          MPS1: 3,
          MPCO: 2500,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Pri_Local MAT_PRI3 = Mat_Pri_Local(SCID: 1,
          MGNO: '01',
          MINO: '3',
          MUID: 1,
          BIID: 1,
          MPS1: 4,
          MPCO: 3500,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Pri_Local MAT_PRI4 = Mat_Pri_Local(SCID: 1,
          MGNO: '01',
          MINO: '4',
          MUID: 1,
          BIID: 1,
          MPS1: 5,
          MPCO: 4500,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Pri_Local MAT_PRI5 = Mat_Pri_Local(
          SCID: 2,
          MGNO: '01',
          MINO: '1',
          MUID: 1,
          BIID: 1,
          MPS1: 600,
          MPCO: 1500,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Pri_Local MAT_PRI6 = Mat_Pri_Local(
          SCID: 2,
          MGNO: '01',
          MINO: '2',
          MUID: 1,
          BIID: 1,
          MPS1: 600,
          MPCO: 2500,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Pri_Local MAT_PRI7 = Mat_Pri_Local(SCID: 1,
          MGNO: '01',
          MINO: '3',
          MUID: 1,
          BIID: 1,
          MPS1: 500,
          MPCO: 3500,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Mat_Pri_Local MAT_PRI8 = Mat_Pri_Local(SCID: 1,
          MGNO: '01',
          MINO: '4',
          MUID: 1,
          BIID: 1,
          MPS1: 350,
          MPCO: 4500,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2');
      Sys_Doc_D_Local SYS_DOC_D = Sys_Doc_D_Local(STID: 'BF',
          SDID: 11,
          BIID: 1,
          JTID_L: 1,
          BIID_L: 1,
          SYID_L: 1,
          CIID_L: '-2',
          SDDDA:'يمنع المردود',
          SDDST1:1,
          SDDSA: "المختص                                                                       الحسابات                                                             الاداره"
              ".............                                                       ...............                                                              .............");
      Bil_Poi_Local BIL_POI1 = Bil_Poi_Local(
        BPID: 1,
        BPNA: 'نقطة بيع1',
        BPNE: 'selling point',
        BIID: 1,
        BPST: 1,
        AANO: '128010001',
        SIID:1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Poi_U_Local BIL_POI_U = Bil_Poi_U_Local(
        BPID: 1,
        BPUUS:'1',
        BPUST:1,
        BPUTY:1,
        SIID:1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );

      Sys_Cur_Local SYS_CUR1 = Sys_Cur_Local(
        SCID: 1,
        SCNA: 'ريال سعودي',
        SCNE: 'Ryal Suadi',
        SCEX: 157.643,
        SCHR: 200,
        SCLR: 150,
        SCSF: 'هللة',
        SCST: 1,
        SCSY: 'SAR',
        SCSFL:2,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Sys_Cur_Local SYS_CUR2 = Sys_Cur_Local(
        SCID: 2,
        SCNA: 'ريال يمني',
        SCNE: 'Ryal Yemen',
        SCEX: 1,
        SCHR: 1,
        SCLR: 1,
        SCSF: 'فلس',
        SCST: 1,
        SCSY: 'YE',
        SCSFL:2,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Pay_Kin_Local PAY_KIN1 = Pay_Kin_Local(
        PKID:1,
        PKNA: 'نقداً',
        PKNE: 'Cash',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Pay_Kin_Local PAY_KIN2 = Pay_Kin_Local(
        PKID:2,
        PKNA: 'شيك',
        PKNE: 'Cheque',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Pay_Kin_Local PAY_KIN3 = Pay_Kin_Local(
        PKID:3,
        PKNA: 'اجل',
        PKNE: 'Delayed',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Pay_Kin_Local PAY_KIN4 = Pay_Kin_Local(
        PKID:4,
        PKNA: 'نقدا واجل',
        PKNE: 'Cash/Delayed',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Pay_Kin_Local PAY_KIN5 = Pay_Kin_Local(
        PKID:8,
        PKNA: 'بطاقه ائتمان',
        PKNE: 'Credit Card',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Cus_Local BIL_CUS1 = Bil_Cus_Local(
        BCID:1,
        BCNA: 'عميل 1',
        BCNE: 'Customer 1',
        AANO: '122010001',
        BCST: 1,
        BCTY: 2,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Cus_Local BIL_CUS2 = Bil_Cus_Local(
        BCID:2,
        BCNA: 'عميل 2',
        BCNE: 'Customer 2',
        AANO: '122010002',
        BCST: 1,
        BCTY: 2,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Cus_Local BIL_CUS3 = Bil_Cus_Local(
        BCID:3,
        BCNA: 'عميل 3',
        BCNE: 'Customer 3',
        AANO: '122010003',
        BCST: 1,
        BCTY: 2,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Cus_Local BIL_CUS4 = Bil_Cus_Local(
        BCID:4,
        BCNA: 'عميل 4',
        BCNE: 'Customer 4',
        AANO: '122010004',
        BCST: 1,
        BCTY: 2,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Cre_C_Local BIL_CRE_C1 = Bil_Cre_C_Local(
        BCCID:1,
        BCCNA: 'ماستر كارد',
        BCCNE: 'Master Card',
        AANO: '121050001',
        BCCST: 1,
        BIID: 1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Cre_C_Local BIL_CRE_C2 = Bil_Cre_C_Local(
        BCCID:2,
        BCCNA: 'فيزا كارد',
        BCCNE: 'Visa Card',
        AANO: '121050002',
        BCCST: 1,
        BIID: 1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Usr_Local ACC_USR1 = Acc_Usr_Local(
        AANO: '122010001',
        SUID: '1',
        AUIN: 1,
        AUDL: 1,
        AUOU: 1,
        AUPR: 1,
        AUOT: 1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Usr_Local ACC_USR2 = Acc_Usr_Local(
        AANO: '122010002',
        SUID: '1',
        AUIN: 1,
        AUDL: 1,
        AUOU: 1,
        AUPR: 1,
        AUOT: 1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Usr_Local ACC_USR3 = Acc_Usr_Local(
        AANO: '122010003',
        SUID: '1',
        AUIN: 1,
        AUDL: 1,
        AUOU: 1,
        AUPR: 1,
        AUOT: 1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Usr_Local ACC_USR4 = Acc_Usr_Local(
        AANO: '122010004',
        SUID: '1',
        AUIN: 1,
        AUDL: 1,
        AUOU: 1,
        AUPR: 1,
        AUOT: 1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Usr_Local ACC_USR5 = Acc_Usr_Local(
        AANO: '121050001',
        SUID: '1',
        AUIN: 1,
        AUDL: 1,
        AUOU: 1,
        AUPR: 1,
        AUOT: 1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Usr_Local ACC_USR6 = Acc_Usr_Local(
        AANO: '121050002',
        SUID: '1',
        AUIN: 1,
        AUDL: 1,
        AUOU: 1,
        AUPR: 1,
        AUOT: 1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Cas_Local ACC_CAS = Acc_Cas_Local(
        ACID: 1,
        ACNA: 'الصندوق الرئيسي',
        ACNE: 'Petty cash',
        AANO: '121010001',
        ACST: 1,
        BIID: 1,
        ACTY: 2,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Cos_Local ACC_COS = Acc_Cos_Local(
        ACNO: '1',
        ACNA: 'مركز تكلفه1',
        ACNE: 'cost center',
        ACST: 1,
        ACTY: 2,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Cos_Usr_Local COS_USR = Cos_Usr_Local(
        ACNO: '1',
        SUID: '1',
        CUST: 1,
        CUOU: 1,
        CUPR: 1,
        CUDL: 1,
        CUOT: 1,
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Mov_K_Local BIL_MOV_K = Bil_Mov_K_Local(
        BMKID: 1,
        BMKNA: 'فاتورة مشتريات',
        SUID: '1',
        BMKST: 1,
        STID: 'BI',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Mov_K_Local BIL_MOV_K2 = Bil_Mov_K_Local(
        BMKID: 3,
        BMKNA: 'فاتورة مبيعات',
        SUID: '1',
        BMKST: 1,
        STID: 'BO',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Mov_K_Local BIL_MOV_K3 = Bil_Mov_K_Local(
        BMKID: 4,
        BMKNA: 'مردود فاتورة مبيعات',
        SUID: '1',
        BMKST: 1,
        STID: 'BO',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Mov_K_Local BIL_MOV_K4 = Bil_Mov_K_Local(
        BMKID: 5,
        BMKNA: 'فاتورة خدمات',
        SUID: '1',
        BMKST: 1,
        STID: 'BO',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Mov_K_Local BIL_MOV_K5 = Bil_Mov_K_Local(
        BMKID: 11,
        BMKNA: 'فاتورة مبيعات فوريه',
        SUID: '1',
        BMKST: 1,
        STID: 'BF',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Bil_Mov_K_Local BIL_MOV_K6 = Bil_Mov_K_Local(
        BMKID: 12,
        BMKNA: 'فاتورة مردود مبيعات فوريه',
        SUID: '1',
        BMKST: 1,
        STID: 'BF',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Mov_K_Local ACC_MOV_K = Acc_Mov_K_Local(
        AMKID: 1,
        AMKNA: 'سند قبض',
        SUID: '1',
        AMKST: 1,
        STID: 'AC',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Mov_K_Local ACC_MOV_K2 = Acc_Mov_K_Local(
        AMKID: 2,
        AMKNA: 'سند صرف',
        SUID: '1',
        AMKST: 1,
        STID: 'AC',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      Acc_Mov_K_Local ACC_MOV_K3 = Acc_Mov_K_Local(
        AMKID: 15,
        AMKNA: 'قيد يوميه',
        SUID: '1',
        AMKST: 1,
        STID: 'AC',
        JTID_L: 1,
        BIID_L: 1,
        SYID_L: 1,
        CIID_L: '-2',
      );
      await SaveBackupData(BIL_MOV_K.toMap(),'BIL_MOV_K');
      await SaveBackupData(BIL_MOV_K2.toMap(),'BIL_MOV_K');
      await SaveBackupData(BIL_MOV_K3.toMap(),'BIL_MOV_K');
      await SaveBackupData(BIL_MOV_K4.toMap(),'BIL_MOV_K');
      await SaveBackupData(BIL_MOV_K5.toMap(),'BIL_MOV_K');
      await SaveBackupData(BIL_MOV_K6.toMap(),'BIL_MOV_K');
      await SaveBackupData(ACC_MOV_K.toMap(),'ACC_MOV_K');
      await SaveBackupData(ACC_MOV_K2.toMap(),'ACC_MOV_K');
      await SaveBackupData(ACC_MOV_K3.toMap(),'ACC_MOV_K');
      await SaveBackupData(USR_PRI1.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI2.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI3.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI4.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI5.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI6.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI7.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI8.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI9.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI10.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI11.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI12.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI13.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI14.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI15.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI16.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI17.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI18.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI19.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI20.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI21.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI22.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI23.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI24.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI25.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI26.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI27.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI28.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI29.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI30.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI31.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI32.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI33.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI34.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI35.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI36.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI37.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI38.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI39.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI40.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI41.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI42.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI43.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI44.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI45.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI46.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI47.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI48.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI49.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI50.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI51.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI52.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI53.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI54.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI55.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI56.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI57.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI58.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI59.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI60.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI61.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI62.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI63.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI64.toMap(),'USR_PRI');
      await SaveBackupData(USR_PRI65.toMap(),'USR_PRI');
      await SaveBackupData(SYS_COM.toMap(),'SYS_COM');
      await SaveBackupData(SYS_OWN.toMap(),'SYS_OWN');
      await SaveBackupData(SYS_VAR1.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR2.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR3.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR4.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR5.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR6.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR7.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR8.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR9.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR10.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR11.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR12.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR13.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR14.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR15.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR16.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR17.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR18.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR19.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR20.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR21.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR22.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR23.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR24.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR25.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR26.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR27.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR28.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR29.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR30.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR31.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR32.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR33.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR34.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR35.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR36.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR37.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR38.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR39.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR40.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR41.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR42.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR43.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR44.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR45.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR46.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR47.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR48.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR49.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR50.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR51.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR52.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR53.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR54.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR55.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR56.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR57.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR58.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR59.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR60.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR61.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR62.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR63.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR64.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR65.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR66.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR67.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR68.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR69.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR70.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR70.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR71.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR72.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR73.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR74.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR75.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR76.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR77.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR78.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR79.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR80.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR81.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR82.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR83.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR84.toMap(),'SYS_VAR');
      await SaveBackupData(SYS_VAR85.toMap(),'SYS_VAR');
      await SaveBackupData(JOB_TYP.toMap(),'JOB_TYP');
      await SaveBackupData(BRA_INF.toMap(),'BRA_INF');
      await SaveBackupData(BRA_INF.toMap(),'BRA_INF_ACC');
      await SaveBackupData(SYS_YEA.toMap(),'SYS_YEA');
      await SaveBackupData(SYS_YEA.toMap(),'SYS_YEA_ACC');
      await SaveBackupData(SYS_USR.toMap(),'SYS_USR');
      await SaveBackupData(SYS_USR_P.toMap(),'SYS_USR_P');
      await SaveBackupData(SYS_USR_B.toMap(),'SYS_USR_B');
      await SaveBackupData(BRA_YEA.toMap(),'BRA_YEA');
      await SaveBackupData(BRA_YEA.toMap(),'BRA_YEA_ACC');
      await SaveBackupData(STO_INF.toMap(),'STO_INF');
      await SaveBackupData(STO_USR.toMap(),'STO_USR');
      await SaveBackupData(MAT_UNI1.toMap(),'MAT_UNI');
      await SaveBackupData(MAT_UNI2.toMap(),'MAT_UNI');
      await SaveBackupData(MAT_GRO.toMap(),'MAT_GRO');
      await SaveBackupData(GRO_USR.toMap(),'GRO_USR');
      await SaveBackupData(MAT_INF1.toMap(),'MAT_INF');
      await SaveBackupData(MAT_INF2.toMap(),'MAT_INF');
      await SaveBackupData(MAT_INF3.toMap(),'MAT_INF');
      await SaveBackupData(MAT_INF4.toMap(),'MAT_INF');
      await SaveBackupData(MAT_INF5.toMap(),'MAT_INF');
      await SaveBackupData(MAT_INF6.toMap(),'MAT_INF');
      await SaveBackupData(MAT_INF7.toMap(),'MAT_INF');
      await SaveBackupData(MAT_UNI_C1.toMap(),'MAT_UNI_C');
      await SaveBackupData(MAT_UNI_C2.toMap(),'MAT_UNI_C');
      await SaveBackupData(MAT_UNI_C3.toMap(),'MAT_UNI_C');
      await SaveBackupData(MAT_UNI_C4.toMap(),'MAT_UNI_C');
      await SaveBackupData(MAT_UNI_B1.toMap(),'MAT_UNI_B');
      await SaveBackupData(MAT_UNI_B2.toMap(),'MAT_UNI_B');
      await SaveBackupData(MAT_UNI_B3.toMap(),'MAT_UNI_B');
      await SaveBackupData(MAT_UNI_B4.toMap(),'MAT_UNI_B');
      await SaveBackupData(STO_NUM1.toMap(),'STO_NUM');
      await SaveBackupData(STO_NUM2.toMap(),'STO_NUM');
      await SaveBackupData(STO_NUM3.toMap(),'STO_NUM');
      await SaveBackupData(STO_NUM4.toMap(),'STO_NUM');
      await SaveBackupData(MAT_PRI1.toMap(),'MAT_PRI');
      await SaveBackupData(MAT_PRI2.toMap(),'MAT_PRI');
      await SaveBackupData(MAT_PRI3.toMap(),'MAT_PRI');
      await SaveBackupData(MAT_PRI4.toMap(),'MAT_PRI');
      await SaveBackupData(MAT_PRI5.toMap(),'MAT_PRI');
      await SaveBackupData(MAT_PRI6.toMap(),'MAT_PRI');
      await SaveBackupData(MAT_PRI7.toMap(),'MAT_PRI');
      await SaveBackupData(MAT_PRI8.toMap(),'MAT_PRI');
      await SaveBackupData(SYS_DOC_D.toMap(),'SYS_DOC_D');
      await SaveBackupData(BIL_POI1.toMap(),'BIL_POI');
      await SaveBackupData(BIL_POI_U.toMap(),'BIL_POI_U');
      await SaveBackupData(SYS_CUR1.toMap(),'SYS_CUR');
      await SaveBackupData(SYS_CUR2.toMap(),'SYS_CUR');
      await SaveBackupData(PAY_KIN1.toMap(),'PAY_KIN');
      await SaveBackupData(PAY_KIN2.toMap(),'PAY_KIN');
      await SaveBackupData(PAY_KIN3.toMap(),'PAY_KIN');
      await SaveBackupData(PAY_KIN4.toMap(),'PAY_KIN');
      await SaveBackupData(PAY_KIN5.toMap(),'PAY_KIN');
      await SaveBackupData(BIL_CUS1.toMap(),'BIL_CUS');
      await SaveBackupData(BIL_CUS2.toMap(),'BIL_CUS');
      await SaveBackupData(BIL_CUS3.toMap(),'BIL_CUS');
      await SaveBackupData(BIL_CUS4.toMap(),'BIL_CUS');
      await SaveBackupData(BIL_CRE_C1.toMap(),'BIL_CRE_C');
      await SaveBackupData(BIL_CRE_C2.toMap(),'BIL_CRE_C');
      await SaveBackupData(BIL_CRE_C2.toMap(),'BIL_CRE_C');
      await SaveBackupData(ACC_USR1.toMap(),'ACC_USR');
      await SaveBackupData(ACC_USR2.toMap(),'ACC_USR');
      await SaveBackupData(ACC_USR3.toMap(),'ACC_USR');
      await SaveBackupData(ACC_USR4.toMap(),'ACC_USR');
      await SaveBackupData(ACC_USR5.toMap(),'ACC_USR');
      await SaveBackupData(ACC_USR6.toMap(),'ACC_USR');
      await SaveBackupData(ACC_CAS.toMap(),'ACC_CAS');
      await SaveBackupData(ACC_COS.toMap(),'ACC_COS');
      await SaveBackupData(COS_USR.toMap(),'COS_USR');
      LoginController().SET_P('BIID_ALL','2');
      LoginController().SET_N_P('JTID',1);
      LoginController().SET_N_P('BIID',1);
      LoginController().SET_N_P('SYID',1);
      LoginController().SET_P('CIID','-2');
      LoginController().SET_P('PKID1','3010000001');
      StteingController().SET_B_P('Save_Sync_Invo',false);
      LoginController().SET_N_P('Chkexperimentalcopy',1);
      TYPEPHONE=="ANDROID"?configloading('انت تعمل حاليا على نسخة تجربيبة'):null;
    }
  }

}

Future<bool> checkConnection() async {
  try {
    final result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print("Connect");
      return true;
    } else {
      print("Not Connect");
      return false;
    }
  } on SocketException catch (_) {
    print("Not Connect");
    return false;
  }
}


void configloading(String MESSAGE){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 8000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.grey[300]
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true;
  EasyLoading.showInfo(MESSAGE);
}