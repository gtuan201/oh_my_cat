import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:mood_press/screen/dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(1.5.seconds, (){
      Get.off(() => const DashBoardScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      body: Center(child: Assets.image.splash.image()),
    );
  }
}
