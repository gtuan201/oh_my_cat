import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/backup_provider.dart';
import 'package:mood_press/providers/emoji_provider.dart';
import 'package:mood_press/providers/local_auth_provider.dart';
import 'package:mood_press/screen/dashboard/dashboard_screen.dart';
import 'package:mood_press/screen/setting/local_auth/password_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.signInAnonymously();
    context.read<LocalAuthProvider>().getStatusLocalAuth();
    context.read<LocalAuthProvider>().getStatusAuthBio();
    context.read<BackupProvider>().checkSignInOnStartup();
    context.read<EmojiProvider>().getEmoji();
    Timer(1.5.seconds, (){
      Get.off(() => context.read<LocalAuthProvider>().enableAuth
          ? PasswordScreen(isAuth: true,authAction: (){Get.off(() => const DashBoardScreen());},)
          : const DashBoardScreen()
      );
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
