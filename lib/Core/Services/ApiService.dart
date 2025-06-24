import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;
import '../../Setting/controllers/login_controller.dart';
import '../../Widgets/snack_bar.dart';
import 'EasyLoadingService.dart';
import 'ToastService.dart'; // استيراد خدمة حفظ السجلات

class ApiService {
  final Dio dio = Dio();  // Dio لإجراء طلبات GET

  // إرسال طلب GET مع queryParameters باستخدام Dio
  Future<Response> getRequest(String baseUrl, {Map<String, String>? queryParams,
    Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.get(
        baseUrl,
        queryParameters: queryParams,
      //  options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print('GET Success: ${response.data}');
        return response;
      } else {
        String errorMessage = 'Error in GET request: ${response.statusCode}';
        print(errorMessage);
        await ToastService.showError(errorMessage);
        throw Exception(errorMessage);
      }
    } on DioException catch (e) {
      String errorMessage = 'Error in GET request: ${e.message}';
      print(errorMessage);
      await ToastService.showError(errorMessage);
      throw Exception(errorMessage);
    }
  }


  // إرسال طلب POST مع البيانات باستخدام http
  Future<http.Response> postRequest(String baseUrl, body, bodylang, {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: body,
        headers: headers ?? {
          'Transfer-Encoding': 'chunked',
          HttpHeaders.contentTypeHeader: "application/json",
          'Content-Length': bodylang.length.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('POST Success: ${response.body}');
        return response;
      } else {
        String errorMessage = 'Error in POST request: ${response.statusCode}';
        print(errorMessage);
        await ToastService.showError(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      String errorMessage = 'Error in POST request: $e';
      print(errorMessage);
      await ToastService.showError(errorMessage);
      throw Exception(errorMessage);
    }
  }


  Map<String, dynamic> createParams({
    required String STMID,
    required String TAB_N,
    required String SOID_V,
    required String PAR_V,
    String? SYDV_SER_V,
    String? CIID_V,
    String? JTID_V,
    String? BIID_V,
    String? SYID_V,
    String? SUID_V,
    String? SUPA_V,
    String? F_ROW_V,
    String? T_ROW_V,
    String? F_DAT_V,
    String? T_DAT_V,
  }) {
    final loginController = LoginController();
    Map<String, dynamic> params = {
      "STMID_CO_V": STMID,
      "SYDV_NAME_V": loginController.DeviceName,
      "SYDV_IP_V": loginController.IP,
      "SYDV_TY_V": loginController.SYDV_TY,
      "SYDV_SER_V": SYDV_SER_V ?? loginController.DeviceID,
      "SYDV_POI_V": "",
      "SYDV_ID_V": loginController.SYDV_ID,
      "SYDV_NO_V": loginController.SYDV_NO,
      "SYDV_BRA_V": 1,
      "SYDV_LATITUDE_V": "",
      "SYDV_LONGITUDE_V": "",
      "SYDV_APPV_V": loginController.APPV,
      "SOID_V": SOID_V,
      "STID_V": "",
      "TBNA_V": TAB_N,
      "LAN_V": loginController.LAN,
      "CIID_V": CIID_V ?? loginController.CIID,
      "JTID_V": JTID_V ?? loginController.JTID,
      "BIID_V": BIID_V ?? loginController.BIID,
      "SYID_V": SYID_V ?? loginController.SYID,
      "SUID_V": SUID_V ?? loginController.SUID,
      "SUPA_V": SUPA_V ?? loginController.SUPA,
      "F_ROW_V": F_ROW_V ?? '',
      "T_ROW_V": T_ROW_V ?? '',
      "F_DAT_V": F_DAT_V ?? '',
      "T_DAT_V": T_DAT_V ?? '',
      "F_GUID_V": '',
      "WH_V1": '',
      "PAR_V": PAR_V,
      "JSON_V": PAR_V,
      "JSON_V2": "",
      "JSON_V3": "",
    };

    return params;
  }


   connectSocket(String IP, int Port, {Function? onSuccess}) async {
    try {
      // محاولة الاتصال بـ Socket
      Socket.connect(IP, Port, timeout: const Duration(seconds: 10)).then((socket) async {
        print("Socket Connection Successful");
        // إذا كان هناك دالة onSuccess تم تمريرها، قم باستدعائها
        if (onSuccess != null) {
          onSuccess();
        }
        // إنهاء الاتصال بعد إجراء العمليات
        socket.destroy();
      }).catchError((error) async {
        await CustomSnackBar.showCustomSnackbar('StringCHK_Err_Con', 'StringCHK_Con');  // عرض الأخطاء في حالة الفشل
        EasyLoadingService.showError("StringShow_Err_Connent".tr);
        await ToastService.showError(error.toString());
      });
    } catch (e) {
      await CustomSnackBar.showCustomSnackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr);  // عرض الأخطاء في حالة الفشل
      EasyLoadingService.showError("StringShow_Err_Connent".tr);
      await ToastService.showError(e.toString());  // عرض الأخطاء في حالة الفشل
    }
  }

}
