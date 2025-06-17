import 'package:flutter/material.dart';
import 'ToastService.dart';

class ValidationService {
  static bool validateForm(GlobalKey<FormState> formKey, BuildContext context) {
    bool isValid = formKey.currentState?.validate() ?? false;

    // إذا كانت البيانات صحيحة، نعرض رسالة نجاح
    if (isValid) {
      ToastService.showSuccess('البيانات صحيحة');
    } else {
      // إذا كانت البيانات غير صحيحة، نعرض رسالة خطأ
      ToastService.showError('الرجاء التحقق من المدخلات');
    }

    return isValid;
  }

  static String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName مطلوب ';
    }
    return null;
  }
}