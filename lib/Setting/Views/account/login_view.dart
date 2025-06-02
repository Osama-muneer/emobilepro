import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Widgets/colors.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/setting_controller.dart';
import '../../models/job_typ.dart';
import '../../services/api_provider_login.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/header_widget.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/setting_db.dart';
import 'dart:ui' as UI;

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = Get.find();
  late FToast fToast;
 // final LocalAuthentication _auth = LocalAuthentication();
  final TextEditingController _serverController = TextEditingController();
  bool _isFingerprintEnabled = false;
  bool _isBiometricSupported = false;
  bool _isObscure = true;
  UI.TextDirection direction = UI.TextDirection.rtl;

  @override
  void initState() {
    super.initState();
    //_checkBiometricSupport();
    //_loadFingerprintSetting();
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Get.defaultDialog(
      title: 'StringSettingLogin'.tr,
      content: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
      radius: width * 0.05,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Test button
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black45),
                  ),
                ),
              ),
              child: Text(
                "Test",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 0.02 * height,
                  fontWeight: FontWeight.bold,
                ),
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
                setState(() {
                  controller.getIP();
                  StringIP = controller.IPSERERController.text;
                  StringPort = controller.PORTController.text;
                  LoginController().SET_P('baseApi','http://$StringIP:$StringPort');
                  LoginController().SET_P('API','http://${LoginController().IP}:${LoginController().PORT}');
                  LoginController().SET_P('IP',controller.IPSERERController.text);
                  LoginController().SET_P('PORT',controller.PORTController.text);
                });
                ApiProviderLogin().Socket_IP(controller.IPSERERController.text,int.parse(controller.PORTController.text));
                // ApiProviderLogin().TEST_API();
              },
            ),
            // Connect button
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black45),
                  ),
                ),
              ),
              child: Text(
                "Connect",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 0.02 * height,
                  fontWeight: FontWeight.bold,
                ),
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
                setState(()  {
                  controller.getIP();
                  StringIP = controller.IPSERERController.text;
                  StringPort = controller.PORTController.text;
                  LoginController().SET_P('IP',controller.IPSERERController.text);
                  LoginController().SET_P('PORT',controller.PORTController.text);
                  LoginController().SET_P('baseApi','http://$StringIP:$StringPort');

                });
                ApiProviderLogin().Socket_IP_Conn(controller.IPSERERController.text,int.parse(controller.PORTController.text));
                // controller.GET_SYN_TAS_F_P();
                // await Future.delayed(const Duration(seconds: 4));
                // LoginController().CHIKE_ALL_MAIN!=0?
                // controller.GET_SYN_TAS_P(false):false;
              },
            ),
            // Exit button
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black45),
                  ),
                ),
              ),
              child: Text(
                "Exit",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 0.02 * height,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                controller.GET_JTID_ONEData();
                Navigator.of(context).pop(false);
              },
            ),
          ],
        ),
      ],
    );
  }


  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: ((value) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 160.h * 1.6,
                child: HeaderWidget(
                  160.h * 1.6, true,), //let's create a common header widget
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      10.w,
                      5.h,
                      10.w,
                      5.h),
                  margin: EdgeInsets.fromLTRB(
                      10.w,
                      5.h,
                      10.w,
                      5.h), // This will be the login form
                  child: Column(
                    children: [
                      Form(
                          key: controller.loginformKey,
                          child: Column(
                            children: [
                              DropdownJob_TypBuilder(context),
                              SizedBox(height: 0.02.sh),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  controller: controller.BIIDController,
                                  textInputAction: TextInputAction.go,
                                  keyboardType: TextInputType.number,
                                  focusNode: controller.BIIDFocus,
                                  style: const TextStyle(fontFamily: 'Hacen'),
                                  validator: (v) {
                                    return controller.validateBIID(v!);
                                  },
                                  onChanged: (v) {
                                    if (v.isEmpty) {
                                      controller.SelectDataBINA = '';
                                      controller.isloadingHint(false);
                                    }else{
                                      controller.Get_Bra_InfData();
                                    }},
                                  onFieldSubmitted: (String value) {
                                    controller.myFocusSYID.requestFocus();
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'StringBIIDlableText'.tr,
                                      'StringBIIDHint'.tr,
                                      Icon(
                                        Icons.account_tree,
                                        size: 22.h,
                                        color: AppColors.IconColor,
                                      ),
                                      controller.BIIDFocus),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Obx(
                                        () => controller.isloadingHint.value == true
                                        ? Text(
                                      '${controller.SelectDataBINA}',
                                      style: const TextStyle(
                                          color: Colors
                                              .blueGrey),
                                    )
                                        : Text(
                                      '${controller.SelectDataBINA}',
                                      style: const TextStyle(
                                          color: Colors
                                              .blueGrey),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  controller: controller.SYNOController,
                                  focusNode: controller.myFocusSYID,
                                  textInputAction: TextInputAction.go,
                                  keyboardType: TextInputType.number,
                                  validator: (v) {
                                    return controller.validateSYID(v!);
                                  },
                                  onTap: () {
                                    controller.Get_Bra_InfData();
                                  },
                                  onChanged: (v) {
                                    if (v.isEmpty) {
                                      controller.SelectDataSYNA = '';
                                      controller.isloadingHint(false);
                                    }else {
                                      controller.GET_SYID_Data();
                                    }
                                  },
                                  onFieldSubmitted: (String value) {
                                    controller.myFocusNode.requestFocus();
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'StringSYIDlableText'.tr,
                                      'StringSYIDHint'.tr,
                                      Icon(
                                        Icons.calendar_view_month_outlined,
                                        size: 22.h,
                                        color: AppColors.IconColor,
                                      ),
                                      controller.myFocusSYID),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  Obx(
                                        () => controller.isloadingHint.value ==
                                        true
                                        ? Text('${controller.SelectDataSYNA}',
                                      style: const TextStyle(
                                          color: Colors.blueGrey),
                                    )
                                        : Text(
                                      '${controller.SelectDataSYNA}',
                                      style: const TextStyle(
                                          color: Colors.blueGrey),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  controller: controller.usernameController,
                                  keyboardType: TextInputType.number,
                                  focusNode: controller.myFocusNode,
                                  textInputAction: TextInputAction.go,
                                  validator: (v) {
                                    return controller.validateUsername(v!);
                                  },
                                  onChanged: (v) {
                                    controller.CHIKE_USER_PAS();
                                    if (v.isEmpty) {
                                      controller.SelectDataSUNA = '';
                                      controller.isloadingHint(false);
                                    }else{
                                      controller.GET_SUNA();
                                      controller.CONV_P(controller
                                          .passwordController.text);
                                      controller.CHIKE_USER_PAS();
                                    }},
                                  onFieldSubmitted: (String value) {
                                    controller.myFocusSUPW.requestFocus();
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'StringUserName'.tr,
                                      'StringUserNameHint'.tr,
                                      Icon(
                                        Icons.account_circle,
                                        size: 22.h,
                                        color: AppColors.IconColor,
                                      ),
                                      controller.myFocusNode),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Obx(
                                        () => controller.isloadingHint.value == true ? Text(
                                      '${controller.SelectDataSUNA}',
                                      style: const TextStyle(color: Colors.blueGrey),
                                    )
                                        : Text(
                                      '${controller.SelectDataSUNA}',
                                      style: const TextStyle(
                                          color: Colors
                                              .blueGrey),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  obscureText: _isObscure,
                                  controller: controller.passwordController,
                                  focusNode: controller.myFocusSUPW,
                                  validator: (v) {
                                    return controller.validatePassword(v!);
                                  },
                                  onChanged: (v) {
                                    controller.CONV_P(controller.passwordController.text);
                                    controller.CHIKE_USER_PAS();
                                  },
                                  decoration: ThemeHelper().textInputDecorationPassword(
                                    'StringPassword'.tr,
                                    'StringPasswordHint'.tr,
                                    Icon(
                                      Icons.https,
                                      size: 22.h,
                                      color: AppColors.IconColor,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 22.h,
                                        color: AppColors.IconColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    ),
                                    controller.myFocusSUPW
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: controller.isloadingRemmberMy,
                                        onChanged: (value) {
                                          controller.isloadingRemmberMy=value!;
                                          controller.update();
                                        },
                                        activeColor:
                                        AppColors.MainColor,
                                      ),
                                      Text(
                                        'StringRemmberMy'.tr,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 0.02*height),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.h),
                                    child: GestureDetector(
                                      onTap: () async {
                                        controller.IPSERERController.text.isEmpty
                                            ? controller.IPSERERController.text =
                                            controller.IP :
                                        controller.IP;
                                        controller.PORTController.text.isEmpty
                                            ? controller.PORTController.text =
                                            controller.PORT : controller.PORT;
                                        controller.GETMOB_VAR_P(1);
                                        controller.update();
                                        ThemeHelper().showCustomBottomSheet(context,1);
                                       // buildShowDialog(context);
                                      },
                                      child: Text('StringSettingLogin'.tr,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 0.02*height),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(
                                    () => controller.isloading.value == true
                                    ? ThemeHelper().circularProgress()
                                    : Container(
                                  decoration: ThemeHelper().buttonBoxDecoration(context),
                                  child: MaterialButton(
                                      onPressed: ()  {
                                        controller.Get_Bra_InfData();
                                        StteingController().SET_N_P('TypeSalesTemplate',
                                            MediaQuery.of(context).size.width >450?  1 : 2 );
                                        StteingController().SET_P('SalesScreenTemplate',MediaQuery.of(context).size.width >450?
                                        'StringR_TYP1'.tr :'StringR_TYP2'.tr);
                                        setState(() {
                                          LoginController().SET_N_P('experimentalcopy',2);
                                          controller.CONV_P(controller.passwordController.text);
                                          controller.CHIKE_USER_PAS();
                                          controller.Login();

                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: AppColors.MainColor,
                                            borderRadius: BorderRadius.circular(10.h)),
                                      //  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'StringSignIn'.tr,
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 0.023*height),
                                            ),
                                            SizedBox(width: mediaQuery.size.width / 50),
                                            Icon(Icons.login, color: Colors.white),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(height: mediaQuery.size.height * 0.010,),
                              // SizedBox(
                              //   width: double.infinity,
                              //   height: mediaQuery.size.height * 0.059,
                              //   child: OutlinedButton.icon(
                              //     // icon: Icon(Icons.refresh, color: Colors.red[800]),
                              //     label: Text('StringDisplay_Version'.tr,
                              //         style: TextStyle(color: Colors.red[800],
                              //           fontSize: mediaQuery.size.width * 0.04,)),
                              //     style: OutlinedButton.styleFrom(
                              //       padding: const EdgeInsets.symmetric(vertical: 15),
                              //       side: BorderSide(color: Colors.red[800]!),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(25),
                              //       ),
                              //     ),
                              //     onPressed:() {
                              //       EasyLoading.instance
                              //         ..displayDuration = const Duration(milliseconds: 2000)
                              //         ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                              //         ..loadingStyle = EasyLoadingStyle.custom
                              //         ..indicatorSize = 45.0
                              //         ..radius = 10.0
                              //         ..progressColor = Colors.white
                              //         ..backgroundColor = Colors.green
                              //         ..indicatorColor = Colors.white
                              //         ..textColor = Colors.white
                              //         ..maskColor = Colors.blue.withOpacity(0.5)
                              //         ..userInteractions = false
                              //         ..dismissOnTap = false;
                              //       EasyLoading.show(status: 'StringShow_Connent'.tr);
                              //        controller.getIP();
                              //      //controller.IPSERERController.text=5389;
                              //      //controller.PORTController.text='5389';
                              //       StringIP = '144.76.153.210';
                              //       StringPort = '5389';
                              //       print(StringIP);
                              //       print(StringPort);
                              //       controller.update();
                              //       LoginController().SET_P('baseApi','http://$StringIP:$StringPort');
                              //       LoginController().SET_P('API','http://$StringIP:$StringPort');
                              //       LoginController().SET_P('IP','144.76.153.210');
                              //       LoginController().SET_P('PORT','5389');
                              //       UpdateMOB_VAR(8,'144.76.153.210');
                              //       UpdateMOB_VAR(9,'5389');
                              //       UpdateMOB_VAR(10,'http://$StringIP:$StringPort');
                              //       controller.update();
                              //       LoginController().SET_N_P('experimentalcopy',1);
                              //       LoginController().SET_P('DeviceName', '123456');
                              //       ApiProviderLogin().Socket_IP('144.76.153.210',5389);
                              //       // ApiProviderLogin().TEST_API();
                              //     },
                              //   ),
                              // ),
                            ],
                          )),
                    ],
                  )),
            ],
          ),
        )),
      ),
    );

  }


  // دالة مساعدة لإنشاء أيقونات تفاعلية
  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 30),
        color: color,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(12),
        ),
      ),
    );
  }

  FutureBuilder<List<Job_Typ_Local>> DropdownJob_TypBuilder(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    return FutureBuilder<List<Job_Typ_Local>>(
        future: Get_Job_Typ(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Job_Typ_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown4(josnStatus: josnStatus);
          }
          return  DropdownButtonFormField2(
            focusNode:controller.JTIDFocus,
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: 'StringlableJTID'.tr,
              labelStyle: TextStyle(
                  color: controller.JTIDFocus.hasFocus ? Colors.red : Colors.grey // تغيير لون النص بناءً على التركيز
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 11),
              //  filled: true,
              isDense: true,
              prefixIcon: Icon(
                Icons.account_balance,
             //   size: 22.h,
                color: AppColors.IconColor,
              ),
            //  contentPadding: EdgeInsets.zero,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(100.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.sw),
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.sw),
                  borderSide: BorderSide(color: Colors.red, width: 2.sw)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.sw),
                  borderSide: BorderSide(color: Colors.red, width: 2.sw)),
            ),
            hint: Text('StringChicJTID'.tr,
              style: TextStyle(fontFamily: 'Hacen', fontSize: .019*height,
              ),
            ),
            isExpanded: true,
            value: controller.SelectDataJTID,
            style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              onTap: () {
                controller.SelectDataJTNA = item.JTNA_D.toString();
                controller.update();
              },
              value: item.JTID.toString(),
              child:Text(item.JTNA_D.toString(),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(fontSize: 0.018*height),
              ),)).toList().obs,
            validator: (value) {
              if (value == null) {
                return 'StringvalidateJTID'.tr;
              }
              return null;
            },
            onChanged: (value) {
              controller.BIIDController.text = 'null';
              controller.SelectDataJTID = value.toString();
              controller.JTIDController.text = value.toString();
              controller.update();
              controller.SET_N_P('JTID',int.parse( value.toString()));
              controller.GET_BIID_ONEData();
              controller. GET_SYID_ONEData();
              controller.CHIKE_USER_PAS();
              controller.update();
            },
          );
        });
  }


  // Widget _buildFingerprintSwitch() {
  //   return SwitchListTile(
  //     title: const Text('بصمة الإصبع'),
  //     subtitle: const Text('استخدم بصمة الإصبع لتسجيل الدخول'),
  //     secondary: Icon(
  //       Icons.fingerprint,
  //       color: _isFingerprintEnabled ? Colors.blue : Colors.grey,
  //     ),
  //     value: _isFingerprintEnabled,
  //     onChanged: _isBiometricSupported
  //         ? (bool newValue) async {
  //       if (newValue) {
  //         bool authenticated = await _authenticateWithBiometric();
  //         if (authenticated) {
  //           final prefs = await SharedPreferences.getInstance();
  //           await prefs.setBool('fingerprint', true);
  //           setState(() => _isFingerprintEnabled = true);
  //         }
  //       } else {
  //         final prefs = await SharedPreferences.getInstance();
  //         await prefs.setBool('fingerprint', false);
  //         setState(() => _isFingerprintEnabled = false);
  //       }
  //     }
  //         : null,
  //   );
  // }

  // Future<bool> _authenticateWithBiometric() async {
  //   try {
  //     return await LocalAuthentication().authenticate(
  //       localizedReason: 'المس مستشعر البصمة للتفعيل',
  //       options: const AuthenticationOptions(
  //         biometricOnly: true,
  //         stickyAuth: true,
  //       ),
  //     );
  //   } catch (e) {
  //     print('Authentication error: $e');
  //     return false;
  //   }
  // }
  //
  // Future<void> _checkBiometricSupport() async {
  //   final LocalAuthentication auth = LocalAuthentication();
  //   bool canCheck = await auth.canCheckBiometrics;
  //   List<BiometricType> available = await auth.getAvailableBiometrics();
  //
  //   setState(() {
  //     _isBiometricSupported = canCheck && available.isNotEmpty;
  //   });
  // }

  Future<void> _loadFingerprintSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFingerprintEnabled = prefs.getBool('fingerprint') ?? false;
    });
  }



}


class LoginView3 extends StatelessWidget {

  static const routeName = '/login-screen';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Widget login(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: Text('Login')),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Colors.blueGrey.shade200, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: TextStyle(fontSize: 18, color: Colors.white70, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 535,
        width: double.infinity,
        decoration: BoxDecoration(
          color: HexColor("#ffffff"),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 45),
                    userInput(emailController, 'Email', TextInputType.emailAddress),
                    userInput(passwordController, 'Password', TextInputType.visiblePassword),
                    // Container(
                    //   height: 55,
                    //   // for an exact replicate, remove the padding.
                    //   // pour une réplique exact, enlever le padding.
                    //   padding: const EdgeInsets.only(top: 5, left: 70, right: 70),
                    //   child: RaisedButton(
                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    //     color: Colors.indigo.shade800,
                    //     onPressed: () {
                    //       print(emailController);
                    //       print(passwordController);
                    //       Provider.of<Auth>(context, listen: false).login(emailController.text, passwordController.text);
                    //       Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SuccessfulScreen()));
                    //     },
                    //     child: Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Center(child: Text('Forgot password ?'),),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          login(Icons.add),
                          login(Icons.book_online),
                        ],
                      ),
                    ),
                    Divider(thickness: 0, color: Colors.white),
                    /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Text('Don\'t have an account yet ? ', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                    TextButton(
                    onPressed: () {},
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  ],
                ),
                  */
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}