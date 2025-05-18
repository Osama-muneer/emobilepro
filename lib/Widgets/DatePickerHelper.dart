import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DatePickerHelper {

  static const MaterialColor buttonTextColor = MaterialColor(
    0xFFEF5350,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFF44336),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  /// تظهر حوار اختيار التاريخ، وتعيد التاريخ المُنسّق كسلسلة
  /// yyyy-MM-dd
  /// أو null إذا لم يختَر المستخدم شيئًا.
  static Future<DateTime?> pickDate({
    required BuildContext context,
    Color primaryColor = const Color(0xFF4A5BF6),
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2100, 12, 31),
      builder: (ctx, child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: primaryColor,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: buttonTextColor,
          ).copyWith(secondary: primaryColor),
        ),
        child: child!,
      ),
    );
  }
}

extension on int {
  /// تحويل اللون من قيمة int إلى MaterialColor صغيرة
  MaterialColor toMaterialColor() {
    Map<int, Color> swatch = {
      50:  Color(this).withOpacity(.1),
      100: Color(this).withOpacity(.2),
      200: Color(this).withOpacity(.3),
      300: Color(this).withOpacity(.4),
      400: Color(this).withOpacity(.5),
      500: Color(this).withOpacity(.6),
      600: Color(this).withOpacity(.7),
      700: Color(this).withOpacity(.8),
      800: Color(this).withOpacity(.9),
      900: Color(this).withOpacity(1),
    };
    return MaterialColor(this, swatch);
  }

}
