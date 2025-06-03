import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'LogMobService.dart';  // استيراد خدمة حفظ السجلات

class EasyLoadingService {
  EasyLoadingService._(); // Private constructor

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

  /// Show a loading indicator and log to database
  static void showLoading([String? message]) {
    EasyLoading.show(status: message ?? 'جاري التحميل...');
    _logToDatabase(message ?? 'جاري التحميل...',LogType.INF);
  }

  /// Show a success message and log to database
  static void showSuccess(
      String message, {
        Duration duration = const Duration(milliseconds: 2000),
      }) {
    EasyLoading.showSuccess(message, duration: duration);
    _logToDatabase(message,LogType.SUC);
  }

  /// Show an error message and log to database
  static void showError(
      String message, {
        Duration duration = const Duration(milliseconds: 2000),
      }) {
    EasyLoading.showError(message, duration: duration);
    _logToDatabase(message,LogType.ERR);
  }

  /// Dismiss the loading or message
  static void dismiss() {
    EasyLoading.dismiss();
  }

  /// Private method to log messages to database
  static Future<void> _logToDatabase(String message,LogType type) async {
    await MobLogDatabase().log(
      type: type, // You can adjust the LogType here (e.g., LogType.ERR or LogType.SUC)
      detail: message,
    );
  }
}
