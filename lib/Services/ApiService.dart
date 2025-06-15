import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../Setting/controllers/login_controller.dart';
import 'package:intl/intl.dart';
import 'ToastService.dart'; // استيراد خدمة حفظ السجلات

class ApiService {
  final Dio dio = Dio();  // Dio لإجراء طلبات GET

  // إرسال طلب GET مع queryParameters باستخدام Dio
  Future<Response> getRequest(String baseUrl, {Map<String, String>? queryParams}) async {
    try {
      //var url = "${LoginController().baseApi}/ESAPI/ESGET";
      // إضافة queryParameters إلى الرابط باستخدام Dio
      final response = await dio.get(
        '$baseUrl',
        queryParameters: queryParams,
      );

      // عند نجاح الطلب
      if (response.statusCode == 200) {
        print('GET Success: ${response.data}');
        return response;
      } else {
        // في حالة فشل الطلب
        String errorMessage = 'Error in GET request: ${response.statusCode}';
        print(errorMessage);
        await ToastService.showError(errorMessage);  // عرض خطأ للمستخدم
        throw Exception(errorMessage);  // إرجاع استثناء
      }
    } on DioError catch (e) {
      // في حالة حدوث خطأ في Dio
      String errorMessage = 'Error in GET request: ${e.message}';
      print(errorMessage);
      await ToastService.showError(errorMessage);  // عرض خطأ للمستخدم
      throw Exception(errorMessage);  // إرجاع استثناء
    }
  }

  // إرسال طلب POST مع البيانات باستخدام http
  Future<http.Response> postRequest(String baseUrl,body,bodylang) async {
    try {
      //Uri.parse("${LoginController().API}/ESAPI/ESPOST"
      final response = await http.post(Uri.parse(baseUrl),
          body: body,
          headers: {'Transfer-Encoding': 'chunked',
            HttpHeaders.contentTypeHeader: "application/json",
            'Content-Length': bodylang.length.toString(),
          });

      // عند نجاح الطلب
      if (response.statusCode == 200) {
        print('POST Success: ${response.body}');
        return response;
      } else {
        // في حالة فشل الطلب
        String errorMessage = 'Error in POST request: ${response.statusCode}';
        print(errorMessage);
        await ToastService.showError(errorMessage);  // عرض خطأ للمستخدم
        throw Exception(errorMessage);
      }
    } catch (e) {
      // في حالة حدوث خطأ في http
      String errorMessage = 'Error in POST request: $e';
      print(errorMessage);
      await ToastService.showError(errorMessage);  // عرض خطأ للمستخدم
      throw Exception(errorMessage);
    }
  }


  Map<String, dynamic> createParams({
    required String STMID,
    required String TAB_N,
    required String SOID_V,
    required String PAR_V,
    String? F_ROW_V,
    String? T_ROW_V,
    String? F_DAT_V,
    String? T_DAT_V,
  }) {
    Map<String, dynamic> params = {
      "STMID_CO_V": STMID,
      "SYDV_NAME_V": LoginController().DeviceName,
      "SYDV_IP_V": LoginController().IP,
      "SYDV_TY_V":  LoginController().SYDV_TY,
      "SYDV_SER_V": LoginController().DeviceID,
      "SYDV_POI_V":"",
      "SYDV_ID_V":LoginController().SYDV_ID,
      "SYDV_NO_V":LoginController().SYDV_NO,
      "SYDV_BRA_V": 1,
      "SYDV_LATITUDE_V":"",  // يمكن تمرير هذه القيم إذا كانت موجودة
      "SYDV_LONGITUDE_V":"",
      "SYDV_APPV_V":LoginController().APPV,
      "SOID_V":SOID_V,
      "STID_V":"",
      "TBNA_V": TAB_N,
      "LAN_V":LoginController().LAN,
      "CIID_V":LoginController().CIID,
      "JTID_V":LoginController().JTID,
      "BIID_V":LoginController().BIID,
      "SYID_V":LoginController().SYID,
      "SUID_V":LoginController().SUID,
      "SUPA_V":LoginController().SUPA,
      "F_ROW_V":F_ROW_V.toString(),
      "T_ROW_V":T_ROW_V.toString(),
      "F_DAT_V": F_DAT_V.toString(),
      "T_DAT_V": T_DAT_V.toString(),
      "F_GUID_V": '',
      "WH_V1": '',
      "PAR_V": "",
      "JSON_V": PAR_V,
      "JSON_V2": "",
      "JSON_V3": "",
    };

    return params;
  }

}
