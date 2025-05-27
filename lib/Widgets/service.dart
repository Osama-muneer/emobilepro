import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/controllers/sync_controller.dart';
import '../../../Setting/models/syn_ord_l.dart';
import '../../../Setting/services/api_provider.dart';
import '../../../Setting/services/syncronize.dart';
import '../../../Widgets/config.dart';
import '../../../database/sync_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/setting_db.dart';
import 'theme_helper.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'SERVICE',
    description: 'MY FOREGROUND SERVICE', // title// description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  //
  // if (Platform.isIOS) {
  //   await flutterLocalNotificationsPlugin.initialize(
  //     const InitializationSettings(
  //       iOS: IOSInitializationSettings(),
  //     ),
  //   );
  // }

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: STMID=='EORD'?'EOrder SERVICE':'EMobile Pro SERVICE',
      initialNotificationContent: 'Synchronize',
      foregroundServiceNotificationId: 888,
      // foregroundServiceType: 'dataSync',
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);
  return true;
}

var apiProvider = ApiProvider();
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  // final controller2=Get.put(SEND_SMSController());
  DartPluginRegistrant.ensureInitialized();

  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.setString("hello", "world");

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // 1) اربط الخدمة كمقدّمة أمامية فوراً
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
    service.setForegroundNotificationInfo(
      title: STMID=='EORD' ? 'EOrder SERVICE' : 'EMobile Pro SERVICE',
      content: 'Synchronize',
    );
  }

  // if (service is AndroidServiceInstance) {
  //   service.on('setAsForeground').listen((event) {
  //     service.setAsForegroundService();
  //   });
  //
  //   service.on('setAsBackground').listen((event) {
  //     service.setAsBackgroundService();
  //   });
  // }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 15), (timer) async {
    print('Socket_IP_Connect');
    await LoginController().initHive();
    DeleteSYN_ORD_L();
    await Future.delayed(const Duration(seconds: 15));{
      INSERT_SYN_LOG('SYNC','تم الدخول الى الخدمه ','U');
      Socket_IP_Connect(LoginController().IP, int.parse(LoginController().PORT));
      print('IsConnect');
      print(IsConnect);
    }

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.
        flutterLocalNotificationsPlugin.show(
          888,
          STMID=='EORD'?'EOrder: ${IsConnect==true?'Connect':'DisConnect'}':'EMobile Pro: ${IsConnect==true?'Connect':'DisConnect'}',
          'Services is Running  ${DateTime.now().toString().substring(0,16)}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
        // if you don't using custom notification, uncomment this
        // service.setForegroundNotificationInfo(
        //   title: "My App Service",
        //   content: "Updated at ${DateTime.now()}",
        // );
      }
    }
    /// you can see this log in logcat
    // test using external plugin
    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }

    service.invoke('update', {
      "current_date": DateTime.now().toIso8601String(),
      "device": device,
    },);
  });



  Timer.periodic(const Duration(hours: 24), (timer) async {
    await LoginController().initHive();
    await Future.delayed(const Duration(seconds: 3));
    save_path();
  });
  // bring to foreground
}

DateTime time = DateTime.now();
int? ArrLengthCus = 0;
Future save_path() async {
  try {
    //  final dbFolder2 = await F();
    File source1 = File('/data/user/0/${APPNAMECOM}/app_flutter/${DBNAME}');
    Directory copyTo;
    String ACC=Type==false?'${LoginController().JTID}_${LoginController().BIID}_${LoginController().SYID}':'';
    copyTo = Directory("${LoginController().AppPath}DataBase/");
    if ((await copyTo.exists())) {
    } else {
      print("not exist");
      await copyTo.create();
    }
    // DBNAME = "${time.day}-${time.month}-${time.year} ELITEPRO.db";
    String newPath = STMID=='EORD'? "${copyTo.path}/ ${time.day}-${time.month}-${time.year} ELITEORD$ACC.db"
        : STMID=='COU'? "${copyTo.path}/ ${time.day}-${time.month}-${time.year} ESCOU$ACC.db"
        : STMID=='INVC'? "${copyTo.path}/ ${time.day}-${time.month}-${time.year} ELITE$ACC.db"
        :  "${copyTo.path}/ ${time.day}-${time.month}-${time.year} ELITEPRO$ACC.db";
    // Path = "${copyTo.path}";
    //[${time.hour}:${time.minute}:${time.second}]
    await source1.copy(newPath);
    print(newPath);
    print('newPath');
  } catch (e) {
    // print(s);
    print('Error creating back-up: ${e.toString()}');
    Get.snackbar('ERROR', e.toString());
  }
}

bool IsConnect=false;

Socket_IP_Connect(String IP, int Port) async {
  Socket.connect(IP, Port, timeout: const Duration(seconds: 5)).then((socket) async {
    print("Success");
    IsConnect=true;
    GetAllSYN_ORD_L();
    await Future.delayed(const Duration(seconds: 2));
    SYN_ORD_L_ROW();
    await Future.delayed(const Duration(seconds: 3));
    SyncCustomerData();
    socket.destroy();
  }).catchError((error) {
    IsConnect=false;
    print("Exception on Socket $error");
  });
}

GetCheckCustomerData() async {
  ArrLengthCus= await Get_CustomerData_Check();
}

AwaitFunc() async {
  for (var i = 0; i <= 200; i++) {
    await Future.delayed(const Duration(milliseconds: 500));
    {
      print(i);
      print(ArrLengthCus);
      print('arrlength');
      if (ArrLengthCus == 0) {
        await Future.delayed(const Duration(seconds: 1));
        ArrLengthCus=0;
        await  SyncBIL_MOV_D();
        break; // Exit the loop instead of setting i = 200 manually
      }
      else{
        await GetCheckCustomerData();
      }
    }
  }
}


Future<void> SyncCustomerData() async {
  INSERT_SYN_LOG('BIL_CUS', 'تم الدخول الى ارسال العملاء', 'U');
  var CustomerList = await SyncronizationData().FetchCustomerData('SyncAll', '0');
  if (CustomerList.isNotEmpty) {
    await SyncronizationData().SyncCustomerToSystem(CustomerList, 'SyncAll', '0', 0, false);
    await AwaitFunc(); // Ensure it completes before proceeding
  } else {
    await SyncBIL_MOV_D();
  }
}

//فواتير
Future<void> SyncBIL_MOV_D() async {
  INSERT_SYN_LOG('BIL_MOV_D', 'تم الدخول الى ارسال الفواتير', 'U');

  // Fetch data
  var ListBIL_MOV_D = await SyncronizationData().fetchAll_BIL_D('SyncAll', -1, '0', '', '', '');

  print('listBIL_MOV_D Length: ${ListBIL_MOV_D.length}');

  if (ListBIL_MOV_D.isNotEmpty) {
    await SyncronizationData().SyncBIL_MOV_DToSystem('SyncAll', -1, '0', ListBIL_MOV_D, 'BIL_MOV_D', false, 2, '', '');
  }

  // Wait for SyncBIF_MOV_D to complete before proceeding
  await SyncBIF_MOV_D();
}

Future<void> SyncBIF_MOV_D() async {
  INSERT_SYN_LOG('BIF_MOV_D', 'تم الدخول الى ارسال الفواتير', 'U');

  var ListBIF_MOV_D = await SyncronizationData().fetchAll_BIL_D('SyncAll', -2, '0', '', '', '');

  print("BIF_MOV_D");
  print(ListBIF_MOV_D.length);

  if (ListBIF_MOV_D.isNotEmpty) {

    await SyncronizationData().SyncBIL_MOV_DToSystem('SyncAll', -2, '0', ListBIF_MOV_D, 'BIF_MOV_D', false, 2, '', '');
  }

  // Call SyncACC_MOV_D after finishing, regardless of the condition
  await SyncACC_MOV_D();
}

//السندات
Future<void> SyncACC_MOV_D() async {
  INSERT_SYN_LOG('ACC_MOV_M', 'تم الدخول الى ارسال السندات', 'U');
  var ListACC_MOV_D = await SyncronizationData().FetchACC_MOV_DData('SyncAll', '0', '0', '', '', '');
  if (ListACC_MOV_D.isNotEmpty) {
    await SyncronizationData().SyncACC_MOV_DToSystem('SyncAll', '0', '', ListACC_MOV_D, false, '', '', '');
    print('SyncACC_MOV_D');
  } else {
    print('Timer_Stratsecrvics11');
  }
  // تحديث المتغير واستدعاء `Timer_Strat`
  STMID=='MOB'? {
    LoginController().SET_N_P('Timer_Strat', 1), Timer_Strat(),}
      : false;
}


// Socket_IP_ConnectAgain(String IP, int Port) async {
//   Socket.connect(IP, Port, timeout: const Duration(seconds: 5)).then((socket) async {
//     print("Success");
//     IsConnect=true;
//     SyncCustomerData();
//     socket.destroy();
//   }).catchError((error) {
//     IsConnect=false;
//     print("Exception on Socket $error");
//   });
// }
// //فواتير
// Future SyncBIL_MOV_DAgain() async {
//   INSERT_SYN_LOG('BIL_MOV_M','تم الدخول الى ارسال الفواتير','D');
//   await SyncronizationData().FetchCustomerData('SyncAll', '0').then((CustomerList) async {
//     if (CustomerList.isNotEmpty) {
//       await SyncronizationData().SyncCustomerToSystem(CustomerList, 'SyncAll',  '0',0,false);        // GET_COUNT_SYNC();
//     }
//   });
//   await SyncronizationData().fetchAll_BIL_D('SyncAll',-1,'0','','','').then((listBIL_MOV_D) async {
//     print('listBIL_MOV_D');
//     if (listBIL_MOV_D.isNotEmpty ) {
//       await SyncronizationData().SyncBIL_MOV_DToSystem('SyncAll',-1,'0',listBIL_MOV_D,'BIL_MOV_D',false,2,'','');
//       SyncBIF_MOV_DAgain();
//     }else{
//       SyncBIF_MOV_DAgain();
//     }
//   });
// }
//
// Future SyncBIF_MOV_DAgain() async {
//   await SyncronizationData().fetchAll_BIL_D('SyncAll',-2,'0','','','').then((listBIF_MOV_D) async {
//     print("BIF_MOV_D");
//     print(listBIF_MOV_D);
//     if (listBIF_MOV_D.isNotEmpty){
//       await SyncronizationData().SyncBIL_MOV_DToSystem('SyncAll',-2,'0',listBIF_MOV_D,'BIF_MOV_D',false,2,'','');
//       SyncACC_MOV_DAgain();
//     }
//     else{
//       SyncACC_MOV_DAgain();
//     }
//   });
// }
// //السندات
// Future SyncACC_MOV_DAgain() async {
//   INSERT_SYN_LOG('ACC_MOV_M','تم الدخول الى ارسال السندات','D');
//   await SyncronizationData().FetchACC_MOV_DData('SyncAll', '0', '0','','','').then((listD) async {
//     if (listD.isNotEmpty && listD.length>0) {
//       await SyncronizationData().SyncACC_MOV_DToSystem('SyncAll', '0', '',listD,false,'','','');
//     }
//   });
// }

final SyncController controller2 = Get.put(SyncController());

//مزامنه البيانات كل ثلاث دقائق
Future<void> Timer_Strat() async {
  // LoginController().setTimer_Strat(1);
  print('Timer_Stratsecrvics ${DateTime.now()}');
  //
  if(LoginController().Timer_Strat==1) {
    INSERT_SYN_LOG('SYNC','تم الدخول الى الخدمه لطلب البيانات','D');
    LoginController().SET_N_P('Timer_Strat',2);
    controller2.TypeSync = 1;
    controller2.TypeCheckSync = 1;
    controller2.TypeSyncAll = 0;
    controller2.CheckClickAll = true;
    controller2.loadingone.value = true;
    controller2.CheckSync(true);
    controller2.Socket_IP();
    print('timer');
  }
}

//البيانات المستلمه الفاشله
Future<dynamic> GetAllSYN_ORD_L() async {
  var url = "${LoginController().API}/ESAPI/ESGET";
  print("$url/SYN_ORD_L");
  var Syn_ORDParams = {
    "STMID_CO_V": "MOB",
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
    "TBNA_V":'SYN_ORD_L',
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
    "F_GUID_V":'',
    "WH_V1":'',
    "PAR_V":"",
    "JSON_V":PAR_V,
    "JSON_V2":"",
    "JSON_V3":""
  };
  try {
    var response = await Dio().get(url,queryParameters: Syn_ORDParams);
    if (response.statusCode == 200 ) {
      return (response.data)['result'].map((data) {
        INSERT_SYN_LOG('SYN_ORD_L','تم استلام البيانات الفاشله','D');
        SaveSYN_ORD_L(Syn_Ord_L_Local.fromMap(data));
      }).toList();
    }
    else if (response.statusCode == 207) {
      print(' response.statusCode ${response.statusCode}''${response.data}');
      ThemeHelper().ShowToastW(response.data.toString());
      INSERT_SYN_LOG('SYN_ORD_L',response.data,'D');
    }
    else {
      ThemeHelper().ShowToastW(response.data.toString());
      INSERT_SYN_LOG('SYN_ORD_L',response.data,'D');
      throw Exception("response error: ${response.data}");
    }
  } on DioException catch (e) {
    INSERT_SYN_LOG('SYN_ORD_L',e.error,'D');
    return Future.error("response error: ${e.error}");
  }
}