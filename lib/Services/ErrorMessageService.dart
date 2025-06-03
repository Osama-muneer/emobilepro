import 'package:flutter/material.dart';

class ErrorMessageService {
  // دالة لعرض رسالة خطأ عبر Snackbar
  static void showSnackbarError(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // دالة لعرض رسالة نجاح عبر Snackbar
  static void showSnackbarSuccess(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }
}
