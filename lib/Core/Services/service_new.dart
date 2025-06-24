// import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import '../../../Setting/controllers/login_controller.dart';
// import '../../../Setting/controllers/sync_controller.dart';
// import '../../../Setting/models/syn_ord_l.dart';
// import '../../../Setting/services/syncronize.dart';
// import '../../../Widgets/config.dart';
// import '../../../database/sync_db.dart';
// import 'package:get/get.dart';
// import '../database/setting_db.dart';
// import 'theme_helper.dart';
// import 'package:workmanager/workmanager.dart';
// import 'package:http/http.dart' as http;
//
// var TEST = {
//   "typ": "ver",
// };
//
// Future<dynamic> TEST_API() async {
//   var url = "${LoginController().baseApi}/ESAPI/ESINF";
//   print(url);
//   print("${TEST}/TEST_API");
//   try {
//     var response = await Dio().get(url, queryParameters: TEST);
//     if (response.statusCode == 200) {
//       LoginController().SET_P('API_VER',response.data);
//
//     } else if (response.statusCode == 207) {
//       print(' response.statusCode ${response.statusCode}''${response.data}');
//
//     }else {
//
//       throw Exception("response error: ${response.data}");
//     }
//   } on DioException catch (e) {
//     return Future.error("DioError: ${e.message}");
//   }
// }
//
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     print("Executing task: $task");
//     try {
//       if (task == "syncTask") {
//         await LoginController().initHive();
//         await Future.delayed(const Duration(seconds: 15));
//
//         await Socket_IP_Connect(LoginController().IP, int.parse(LoginController().PORT));
//
//         print("Synchronization task completed.");
//       } else if (task == "backupTask") {
//         await save_path();
//         print("Backup task completed.");
//       }
//     } catch (e) {
//       print("Error in task $task: $e");
//     }
//
//     return Future.value(true); // إنهاء المهمة بنجاح
//   });
// }
//
// void scheduleSyncTask() {
//   print('Scheduling synchronization task.');
//   Workmanager().registerPeriodicTask(
//     "1", // معرف المهمة
//     "syncTask", // اسم المهمة
//     frequency: Duration(minutes: 15), // تنفيذ كل 15 دقيقة
//   );
//   print('Synchronization1 :scheduleSyncTask');
// }
//
// void scheduleBackupTask() {
//   print('Scheduling backup task.');
//   Workmanager().registerPeriodicTask(
//     "2", // معرف المهمة
//     "backupTask", // اسم المهمة
//     frequency: Duration(hours: 24), // تنفيذ كل 24 ساعة
//   );
// }
//
// void initializeWorkManager() {
//   // جدولة مهمة التزامن الدورية
//   print("Initializing WorkManager and scheduling tasks.");
//   scheduleSyncTask();
//   scheduleBackupTask();
// }
//
//
// DateTime time = DateTime.now();
// int? ArrLengthCus = 0;
// Future save_path() async {
//   try {
//     //  final dbFolder2 = await F();
//     File source1 = File('/data/user/0/${APPNAMECOM}/app_flutter/${DBNAME}');
//     Directory copyTo;
//     String ACC = Type == false
//         ? '${LoginController().JTID}_${LoginController().BIID}_${LoginController().SYID}'
//         : '';
//     copyTo = Directory("${LoginController().AppPath}DataBase/");
//     if ((await copyTo.exists())) {
//     } else {
//       print("not exist");
//       await copyTo.create();
//     }
//     // DBNAME = "${time.day}-${time.month}-${time.year} ELITEPRO.db";
//     String newPath = STMID == 'EORD'
//         ? "${copyTo.path}/ ${time.day}-${time.month}-${time.year} ELITEORD$ACC.db"
//         : STMID == 'COU'
//             ? "${copyTo.path}/ ${time.day}-${time.month}-${time.year} ESCOU$ACC.db"
//             : STMID == 'INVC'
//                 ? "${copyTo.path}/ ${time.day}-${time.month}-${time.year} ELITE$ACC.db"
//                 : "${copyTo.path}/ ${time.day}-${time.month}-${time.year} ELITEPRO$ACC.db";
//     // Path = "${copyTo.path}";
//     //[${time.hour}:${time.minute}:${time.second}]
//     await source1.copy(newPath);
//     print(newPath);
//     print('newPath');
//   } catch (e) {
//     // print(s);
//     print('Error creating back-up: ${e.toString()}');
//     Get.snackbar('ERROR', e.toString());
//   }
// }
//
// bool IsConnect = false;
// Future<void> Socket_IP_Connect(String IP, int Port) async {
//   try {
//     final socket = await Socket.connect(IP, Port, timeout: const Duration(seconds: 5));
//     print("Connected to $IP:$Port");
//     IsConnect = true;
//
//     // تنفيذ المهام بعد الاتصال
//     await SyncCustomerData();
//
//     socket.destroy();
//     print("Socket connection closed.");
//   } catch (e) {
//     IsConnect = false;
//     print("Socket connection failed: $e");
//   }
// }
//
// GetCheckCustomerData() {
//   Get_CustomerData_Check().then((data) {
//     ArrLengthCus = data;
//   });
// }
//
// AwaitFunc() async {
//   for (var i = 0; i <= 200; i++) {
//     await Future.delayed(const Duration(milliseconds: 500));
//     {
//       print(i);
//       print(ArrLengthCus);
//       print('arrlength');
//       if (ArrLengthCus == 0) {
//         await Future.delayed(const Duration(seconds: 1));
//         {
//           SyncBIL_MOV_D();
//           i = 200;
//           ArrLengthCus = 0;
//           print(i);
//         }
//       } else {
//         GetCheckCustomerData();
//       }
//     }
//   }
// }
//
// Future SyncCustomerData() async {
//   print("BIL_CUS");
//   INSERT_SYN_LOG('BIL_CUS', 'تم الدخول الى ارسال العملاء', 'U');
//   await SyncronizationData().FetchCustomerData('SyncAll', '0').then((CustomerList) async {
//     if (CustomerList.isNotEmpty && CustomerList.length > 0) {
//       await SyncronizationData().SyncCustomerToSystem(CustomerList, 'SyncAll', '0', 0, false);
//       AwaitFunc();
//     } else {
//       print("BIL_CUS");
//       SyncBIL_MOV_D();
//     }
//   });
// }
//
//
// //فواتير
// Future SyncBIL_MOV_D() async {
//   INSERT_SYN_LOG('BIL_MOV_D', 'تم الدخول الى ارسال الفواتير', 'U');
//   print('SyncBIL_MOV_D');
//   await SyncronizationData().fetchAll_BIL_D('SyncAll', -1, '0', '', '', '').then((listBIL_MOV_D) async {
//     print('listBIL_MOV_D');
//     if (listBIL_MOV_D.isNotEmpty) {
//       await SyncronizationData().SyncBIL_MOV_DToSystem('SyncAll', -1, '0', listBIL_MOV_D, 'BIL_MOV_D', false, 2, '', '');
//       SyncBIF_MOV_D();
//     } else {
//       SyncBIF_MOV_D();
//     }
//   });
// }
//
// Future SyncBIF_MOV_D() async {
//   INSERT_SYN_LOG('BIF_MOV_D', 'تم الدخول الى ارسال الفواتير', 'U');
//   await SyncronizationData().fetchAll_BIL_D('SyncAll', -2, '0', '', '', '').then((listBIF_MOV_D) async {
//     print("BIF_MOV_D");
//     print(listBIF_MOV_D.length);
//     if (listBIF_MOV_D.isNotEmpty) {
//       await SyncronizationData().SyncBIL_MOV_DToSystem('SyncAll', -2, '0', listBIF_MOV_D, 'BIF_MOV_D', false, 2, '', '');
//       SyncACC_MOV_D();
//     } else {
//       SyncACC_MOV_D();
//     }
//   });
// }
//
// //السندات
// Future SyncACC_MOV_D() async {
//   INSERT_SYN_LOG('ACC_MOV_M', 'تم الدخول الى ارسال السندات', 'U');
//   await SyncronizationData().FetchACC_MOV_DData('SyncAll', '0', '0', '', '', '').then((listD) async {
//     if (listD.isNotEmpty && listD.length > 0) {
//       await SyncronizationData().SyncACC_MOV_DToSystem('SyncAll', '0', '', listD, false, '', '', '');
//       print('SyncACC_MOV_D');
//       LoginController().SET_N_P('Timer_Strat', 1);
//       Timer_Strat();
//     } else {
//       print('Timer_Stratsecrvics11');
//       LoginController().SET_N_P('Timer_Strat', 1);
//       Timer_Strat();
//     }
//   });
// }
//
// // Socket_IP_ConnectAgain(String IP, int Port) async {
// //   Socket.connect(IP, Port, timeout: const Duration(seconds: 5)).then((socket) async {
// //     print("Success");
// //     IsConnect=true;
// //     SyncCustomerData();
// //     socket.destroy();
// //   }).catchError((error) {
// //     IsConnect=false;
// //     print("Exception on Socket $error");
// //   });
// // }
// // //فواتير
// // Future SyncBIL_MOV_DAgain() async {
// //   INSERT_SYN_LOG('BIL_MOV_M','تم الدخول الى ارسال الفواتير','D');
// //   await SyncronizationData().FetchCustomerData('SyncAll', '0').then((CustomerList) async {
// //     if (CustomerList.isNotEmpty) {
// //       await SyncronizationData().SyncCustomerToSystem(CustomerList, 'SyncAll',  '0',0,false);        // GET_COUNT_SYNC();
// //     }
// //   });
// //   await SyncronizationData().fetchAll_BIL_D('SyncAll',-1,'0','','','').then((listBIL_MOV_D) async {
// //     print('listBIL_MOV_D');
// //     if (listBIL_MOV_D.isNotEmpty ) {
// //       await SyncronizationData().SyncBIL_MOV_DToSystem('SyncAll',-1,'0',listBIL_MOV_D,'BIL_MOV_D',false,2,'','');
// //       SyncBIF_MOV_DAgain();
// //     }else{
// //       SyncBIF_MOV_DAgain();
// //     }
// //   });
// // }
// //
// // Future SyncBIF_MOV_DAgain() async {
// //   await SyncronizationData().fetchAll_BIL_D('SyncAll',-2,'0','','','').then((listBIF_MOV_D) async {
// //     print("BIF_MOV_D");
// //     print(listBIF_MOV_D);
// //     if (listBIF_MOV_D.isNotEmpty){
// //       await SyncronizationData().SyncBIL_MOV_DToSystem('SyncAll',-2,'0',listBIF_MOV_D,'BIF_MOV_D',false,2,'','');
// //       SyncACC_MOV_DAgain();
// //     }
// //     else{
// //       SyncACC_MOV_DAgain();
// //     }
// //   });
// // }
// // //السندات
// // Future SyncACC_MOV_DAgain() async {
// //   INSERT_SYN_LOG('ACC_MOV_M','تم الدخول الى ارسال السندات','D');
// //   await SyncronizationData().FetchACC_MOV_DData('SyncAll', '0', '0','','','').then((listD) async {
// //     if (listD.isNotEmpty && listD.length>0) {
// //       await SyncronizationData().SyncACC_MOV_DToSystem('SyncAll', '0', '',listD,false,'','','');
// //     }
// //   });
// // }
//
// final SyncController controller2 = Get.put(SyncController());
//
// //مزامنه البيانات كل ثلاث دقائق
// Future<void> Timer_Strat() async {
//   // LoginController().setTimer_Strat(1);
//   print('Timer_Stratsecrvics ${DateTime.now()}');
//   //
//   if (LoginController().Timer_Strat == 1) {
//     INSERT_SYN_LOG('SYNC', 'تم الدخول الى الخدمه لطلب البيانات', 'D');
//     LoginController().SET_N_P('Timer_Strat', 2);
//     controller2.TypeSync = 1;
//     controller2.TypeCheckSync = 1;
//     controller2.TypeSyncAll = 0;
//     controller2.CheckClickAll = true;
//     controller2.loadingone.value = true;
//     controller2.CheckSync(true);
//     controller2.Socket_IP();
//     print('timer');
//   }
// }
//
// //البيانات المستلمه الفاشله
// Future<dynamic> GetAllSYN_ORD_L() async {
//   var url = "${LoginController().API}/ESAPI/ESGET";
//   print("$url/SYN_ORD_L");
//   var Syn_ORDParams = {
//     "STMID_CO_V": "MOB",
//     "SYDV_NAME_V": LoginController().DeviceName,
//     "SYDV_IP_V": LoginController().IP,
//     "SYDV_TY_V": LoginController().SYDV_TY,
//     "SYDV_SER_V": LoginController().DeviceID,
//     "SYDV_POI_V": "",
//     "SYDV_ID_V": LoginController().SYDV_ID,
//     "SYDV_NO_V": LoginController().SYDV_NO,
//     "SYDV_BRA_V": 1,
//     "SYDV_LATITUDE_V": "",
//     "SYDV_LONGITUDE_V": "",
//     "SYDV_APPV_V": LoginController().APPV,
//     "SOID_V": SOID_V,
//     "STID_V": "",
//     "TBNA_V": 'SYN_ORD_L',
//     "LAN_V": LoginController().LAN,
//     "CIID_V": LoginController().CIID,
//     "JTID_V": LoginController().JTID,
//     "BIID_V": LoginController().BIID,
//     "SYID_V": LoginController().SYID,
//     "SUID_V": LoginController().SUID,
//     "SUPA_V": LoginController().SUPA,
//     "F_ROW_V": '0',
//     "T_ROW_V": '0',
//     "F_DAT_V": '',
//     "T_DAT_V": '',
//     "F_GUID_V": '',
//     "WH_V1": '',
//     "PAR_V": "",
//     "JSON_V": PAR_V,
//     "JSON_V2": "",
//     "JSON_V3": ""
//   };
//   try {
//     var response = await Dio().get(url, queryParameters: Syn_ORDParams);
//     if (response.statusCode == 200) {
//       return (response.data)['result'].map((data) {
//         INSERT_SYN_LOG('SYN_ORD_L', 'تم استلام البيانات الفاشله', 'D');
//         SaveSYN_ORD_L(Syn_Ord_L_Local.fromMap(data));
//       }).toList();
//     } else if (response.statusCode == 207) {
//       print(' response.statusCode ${response.statusCode}' '${response.data}');
//       ThemeHelper().ShowToastW(response.data.toString());
//       INSERT_SYN_LOG('SYN_ORD_L', response.data, 'D');
//     } else {
//       ThemeHelper().ShowToastW(response.data.toString());
//       INSERT_SYN_LOG('SYN_ORD_L', response.data, 'D');
//       throw Exception("response error: ${response.data}");
//     }
//   } on DioException catch (e) {
//     INSERT_SYN_LOG('SYN_ORD_L', e.error, 'D');
//     return Future.error("response error: ${e.error}");
//   }
// }
