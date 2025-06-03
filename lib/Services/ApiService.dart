import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'ToastService.dart'; // استيراد خدمة حفظ السجلات

class ApiService {
  final Dio dio = Dio();  // Dio لإجراء طلبات GET
  final String baseUrl = 'https://api.example.com';  // رابط الـ API الأساسي

  // إرسال طلب GET مع queryParameters باستخدام Dio
  Future<void> getRequest(String endpoint, {Map<String, String>? queryParams}) async {
    try {
      // إضافة queryParameters إلى الرابط باستخدام Dio
      final response = await dio.get(
        '$baseUrl$endpoint',
        queryParameters: queryParams,
      );

      // عند نجاح الطلب
      if (response.statusCode == 200) {
        print('GET Success: ${response.data}');
      } else {
        // في حالة فشل الطلب
        String errorMessage = 'Error in GET request: ${response.statusCode}';
        print(errorMessage);
        await ToastService.showError(errorMessage);  // عرض خطأ للمستخدم
      }
    } on DioError catch (e) {
      // في حالة حدوث خطأ في Dio
      String errorMessage = 'Error in GET request: ${e.message}';
      print(errorMessage);
      await ToastService.showError(errorMessage);  // عرض خطأ للمستخدم
    }
  }

  // إرسال طلب POST مع البيانات باستخدام http
  Future<void> postRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data), // تحويل البيانات إلى JSON
      );

      // عند نجاح الطلب
      if (response.statusCode == 200) {
        print('POST Success: ${response.body}');
      } else {
        // في حالة فشل الطلب
        String errorMessage = 'Error in POST request: ${response.statusCode}';
        print(errorMessage);
        await ToastService.showError(errorMessage);  // عرض خطأ للمستخدم
      }
    } catch (e) {
      // في حالة حدوث خطأ في http
      String errorMessage = 'Error in POST request: $e';
      print(errorMessage);
      await ToastService.showError(errorMessage);  // عرض خطأ للمستخدم
    }
  }

}
