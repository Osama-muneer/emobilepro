import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/splash_controller.dart';
import '../../../Widgets/theme_helper.dart';

class SplashView extends GetView<SplashController> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        gradient:  LinearGradient(
          colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity:  1.0 ,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.h,
            width: 140.w,
            child:  Center(
              child: InkWell(
                child: ThemeHelper().buildContainerforHome(
                    350.h,
                    "Assets/image/SM-APP.jpg",
                    context,
                    '',
                    "2",
                    .110),
              ),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2.0,
                    offset: Offset(5.0, 3.0),
                    spreadRadius: 2.0,
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}
