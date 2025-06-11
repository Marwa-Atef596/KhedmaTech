import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widget/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/homeview');
    });
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}
