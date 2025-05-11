import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,###', 'en_US'); // only integer pattern

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text;

    // Remove everything except digits and dots,
    // but collapse multiple dots into a single one.
    String cleaned = text
        .replaceAll(RegExp(r'[^\d.]'), '')
        .replaceAll(RegExp(r'\.{2,}'), '.');

    // Split into integer / decimal parts
    List<String> parts = cleaned.split('.');

    // Format the integer part
    String intPart = parts[0];
    if (intPart.isEmpty) intPart = '0';
    String formattedInt = _formatter.format(int.parse(intPart));

    String formatted;
    if (parts.length == 1) {
      // no dot typed (or trailing dot was just deleted)
      formatted = formattedInt;
    } else {
      // user has typed a dot (and maybe some decimals)
      String decPart = parts[1];
      formatted = '$formattedInt.' + decPart;
    }

    // Maintain the cursor at the end
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

