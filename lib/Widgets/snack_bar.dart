import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'custom_text.dart';

class CustomSnackBar {
  static showCustomSnackBar({required String message, Duration? duration}) {
    Get.showSnackbar(
      GetSnackBar(
        maxWidth: 300,
        messageText: CustomText(
          txt: message,
          color: Colors.white,
          fontSize: 14,
          maxLine: 5,
        ),
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: FaIcon(
            FontAwesomeIcons.checkCircle,
            color: Colors.white,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        isDismissible: true,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        borderRadius: 12,
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  static showCustomErrorSnackBar(
      {required String message, Color? color, Duration? duration}) {
    Get.showSnackbar(
      GetSnackBar(
        maxWidth: 300,
        messageText: CustomText(
          txt: message,
          color: Colors.white,
          fontSize: 14,
          maxLine: 5,
        ),
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: FaIcon(
            FontAwesomeIcons.exclamationCircle,
            color: Colors.white,
          ),
        ),
        isDismissible: true,
        padding: EdgeInsets.symmetric(
          horizontal: 18.w,
          vertical: 18.h,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 30.w,
          vertical: 30.h,
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        borderRadius: 12.r,
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  static showCustomToast(
      {String? title,
      required String message,
      Color? color,
      Duration? duration}) {
    Get.rawSnackbar(
      // title: (title ?? "").tr,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color ?? Colors.green,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
    );
  }

  static showCustomErrorToast(
      {String? title,
      required String message,
      Color? color,
      Duration? duration}) {
    Get.rawSnackbar(
      // title: (title ?? "").tr,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color ?? Colors.redAccent,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
    );
  }

  static showCustomSnackbar(String title, String message, {Color backgroundColor = Colors.red, Icon? icon, Color textColor = Colors.white}) {
    Get.snackbar(
      title,  // عنوان الرسالة مع الترجمة
      message,  // الرسالة مع الترجمة
      backgroundColor: backgroundColor,
      icon: icon ?? const Icon(Icons.error, color: Colors.white),  // رمز الخطأ الافتراضي إذا لم يُمرر رمز مخصص
      colorText: textColor,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

}
