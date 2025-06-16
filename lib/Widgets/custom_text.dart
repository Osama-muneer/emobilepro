import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  final String txt;
  final String? fontFamily;
  final double fontSize;
  final double height;
  final int maxLine;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final TextDecoration textDecoration;

  const CustomText({
    super.key,
    required this.txt,
    this.height = 1,
    this.maxLine = 1,
    this.fontSize = 16,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.fontFamily = "NotoSans",
    this.textDecoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txt.tr,
      maxLines: maxLine,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
        fontFamily: "NotoSans",
        decoration: textDecoration,
      ),
      textAlign: textAlign,
    );
  }
}
