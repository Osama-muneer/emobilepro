import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'LogMobService.dart';

/// Unified toast service that also logs each toast to the MOB_LOG database.
class ToastService {
  ToastService._(); // Private constructor

  /// Show a toast and record the event in the database.
  static Future<void> show(
      String message, {
        ToastGravity gravity = ToastGravity.BOTTOM,
        Toast toastLength = Toast.LENGTH_LONG,
        Color? backgroundColor,
        Color? textColor,
        int timeInSecForIosWeb = 2,
        LogType type = LogType.INF,
      }) async {
   // await Fluttertoast.cancel();
    // Display the toast
    await Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor ?? Colors.black.withOpacity(0.8),
      textColor: textColor ?? Colors.white,
    );

    // Log to database
    await MobLogDatabase().log(
      type: type,
      detail: message,
    );
  }

  /// Success toast
  static Future<void> showSuccess(
      String message, {
        ToastGravity gravity = ToastGravity.BOTTOM,
        Toast toastLength = Toast.LENGTH_SHORT,
      }) {
    return show(
      message,
      gravity: gravity,
      toastLength: toastLength,
      backgroundColor: Colors.green.withOpacity(0.8),
      type: LogType.SUC,
    );
  }

  /// Error toast
  static Future<void> showError(
      String message, {
        ToastGravity gravity = ToastGravity.BOTTOM,
        Toast toastLength = Toast.LENGTH_LONG,
      }) {
    return show(
      message,
      gravity: gravity,
      toastLength: toastLength,
      backgroundColor: Colors.red.withOpacity(0.8),
      type: LogType.ERR,
    );
  }

}
