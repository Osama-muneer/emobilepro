import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class SplashController extends GetxController {
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void onReady() {
    super.onReady();
  //  loading();
  }

  Future<void> loading() async {
    Timer(const Duration(seconds: 5), () {
      LoginController().RemmberMy==false? Get.offAndToNamed('/login'): Get.offAndToNamed('/Home');
    });
  }
}
