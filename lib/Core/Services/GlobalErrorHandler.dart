import 'package:flutter/foundation.dart';
import 'ToastService.dart';
import 'package:flutter/material.dart';

class GlobalErrorHandler {
  static void init() {
    FlutterError.onError = (FlutterErrorDetails details) {
      // هنا يمكنك معالحة الأخطاء أو عرضها للمطور في الـ Logs
      print('Global Error: ${details.exception}');
      // عرض رسالة خطأ باستخدام ToastService
      ToastService.showError('${details.exception.toString()}');
    };
  }
}
