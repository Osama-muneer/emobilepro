import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import 'theme_helper.dart';


class AnimatedTextWidget extends StatelessWidget {
  final String text;
  final double height;

  const AnimatedTextWidget({
    Key? key,
    required this.text,
    this.height = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // إذا كان النص طويلًا نستخدم Marquee، وإلا نعرضه كنص ثابت
    return Container(
      height: height,
      width: double.infinity,
      child:  Marquee(
        text: text,
        style: ThemeHelper().buildTextStyle(
            context, Colors.black, 'M'),
        scrollAxis: Axis.horizontal,
        blankSpace: 20.0,
        velocity: 50.0,
        pauseAfterRound: Duration(seconds: 1),
        startPadding: 10.0,
        accelerationDuration: Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: Duration(seconds: 1),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}
