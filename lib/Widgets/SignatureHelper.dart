import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SignatureScreen.dart';

class SignatureHelper {
  /// تعرض شاشة التوقيع أو تتخطاها بناءً على المتغيرات.
  /// - useSignature: 0 يعني لا توقيع → تُعيد null فورًا.
  /// - showAlert: 0 يعني لا تعرض تنبيه قبل الرسمة.
  /// تُعيد بيانات التوقيع كـ Uint8List أو null إذا أُلغي.
  static Future<Uint8List?> pickSignature({
    required BuildContext context,
    required int useSignature,
    required int showAlert,
  }) async {
    if (useSignature == 0) return null;

    Future<Uint8List?> _openSignature() async {
      return await Get.to(() => SignatureScreen());
    }

    if (showAlert == 1) {
      await Get.defaultDialog(
        title: 'StringMestitle'.tr,
        middleText: 'StringPrintSureSUID'.tr,
        backgroundColor: Colors.white,
        radius: 40,
        textCancel: 'StringNo'.tr,
        cancelTextColor: Colors.red,
        textConfirm: 'StringYes'.tr,

        // هنا نربط زر “نعم” لفتح شاشة التوقيع
        onConfirm: () async {
          Get.back();                  // إغلاق الحوار
          await _openSignature();      // فتح شاشة التوقيع
        },

        // (اختياري) التعامل مع الإلغاء
        onCancel: () {
          Get.back();                  // إغلاق الحوار فقط
        },
      );
    }

    // إذا لم يكن مطلوبًا عرض التنبيه، نفتح شاشة التوقيع مباشرة
    return await _openSignature();
  }

}
