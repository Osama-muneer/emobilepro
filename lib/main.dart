import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'Setting/controllers/login_controller.dart';
import 'Setting/controllers/setting_controller.dart';
import 'Widgets/config.dart';
import 'Widgets/localestring.dart';
import 'Services/service.dart';
import 'routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'routes/dependences.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StteingController().initHive();
  await LoginController().initHive();
  await initializeService();
  //await FlutterBackgroundService.initialize(onStart);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await dep.init();
   runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      builder: (_,C) => GetMaterialApp(
        translations: LocalString(),
        //defaultTransition: Transition.downToUp,
        locale:LoginController().LAN==0 ? Get.deviceLocale:LoginController().LAN==1 ? Locale("ar"):Locale("en"),
        debugShowCheckedModeBanner: false,
        title: TitleApp,
        initialRoute: LoginController().CHIKE_ALL_MAIN==1?LoginController().RemmberMy==false?
        AppRoutes.LOGIN:
        AppRoutes.Home:Routes.LOGIN,
        getPages: AppRoutes.routes,
        builder: EasyLoading.init(),
        theme: ThemeData(fontFamily: 'Hacen'),
      ),
    );
  }}
