import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:mood_press/helper/platform_check.dart';
import 'package:mood_press/providers/local_auth_provider.dart';
import 'package:provider/provider.dart';
import '../../../../ulti/function.dart';

class NumericKeypad extends StatelessWidget {
  final Function(int) onKeyPress;
  final Function() onDelete;
  final bool isAuth;
  final Function() authAction;
  const NumericKeypad({super.key, required this.onKeyPress, required this.onDelete, required this.isAuth, required this.authAction});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 1.1,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      children: List.generate(12, (index) {
        if (index == 9) {
          return isAuth && context.read<LocalAuthProvider>().enableBiometric
              ? PlatformCheck.isAndroid
                  ? IconButton(
                      onPressed: () {
                        authBiometric(context);
                      },
                      icon: const Icon(
                        Icons.fingerprint,
                        color: Colors.white,
                        size: 50,
                      ))
                  : InkWell(
                      onTap: (){
                        authBiometric(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(30),
                          child: Assets.image.faceid.svg(colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),)),
                    )
              : const SizedBox();
        } else if (index == 10) {
          return KeypadButton(text: '0', onPressed: () => onKeyPress(0));
        } else if (index == 11) {
          return InkWell(
            onTap: (){
              onDelete();
            },
            child: Container(
              padding: const EdgeInsets.all(26),
                child: Assets.image.backspace.svg(colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn))),
          );
        } else {
          return KeypadButton(
            text: '${index + 1}',
            onPressed: () => onKeyPress(index + 1),
          );
        }
      }),
    );
  }
  Future<void> authBiometric(BuildContext context) async {
    try{
      final auth = LocalAuthentication();
      bool authenticated = await auth.authenticate(
        localizedReason: 'Xác thực để truy cập ứng dụng',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      if(authenticated){
        authAction();
      }
    }on PlatformException catch (e) {
      if (e.code == 'NotAvailable') {
        log('Xác thực bị hủy bỏ: ${e.message}');
        Future.delayed(1.seconds,(){
          showCustomToast(context: context, message: 'Xác thực bị hủy bỏ');
        });
      } else if (e.code == 'NotEnrolled') {
        log('Thiết bị chưa đăng ký xác thực sinh trắc học: ${e.message}');
        Future.delayed(1.seconds,(){
          showCustomToast(context: context, message: 'Thiết bị chưa đăng ký xác thực sinh trắc học');
        });
      } else {
        log('Lỗi xác thực: ${e.code} - ${e.message}');
        Future.delayed(1.seconds,(){
          showCustomToast(context: context, message: 'Lỗi xác thực');
        });
      }
    } catch (e) {
      log('Lỗi không xác định: $e');
      Future.delayed(1.seconds,(){
        showCustomToast(context: context, message: 'Lỗi không xác định');
      });
    }
  }
}

class KeypadButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const KeypadButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueGrey
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24,color: Colors.blueGrey.shade100),
        ),
      ),
    );
  }
}