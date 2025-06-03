import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingService {
  static void init() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.redAccent
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static void showError(String message) {
    EasyLoading.showError(message);
  }

  static void showSuccess(String message) {
    EasyLoading.showSuccess(message);
  }

  static void showLoading([String? message]) {
    EasyLoading.show(status: message ?? 'جاري التحميل...');
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}
