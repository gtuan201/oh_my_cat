import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/local_auth_provider.dart';
import 'package:mood_press/screen/setting/local_auth/widget/numberic_keypad.dart';
import 'package:mood_press/screen/setting/local_auth/widget/pin_code_widget.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';

class PasswordScreen extends StatefulWidget {
  final bool isAuth;
  final Function() authAction;
  const PasswordScreen({super.key, required this.isAuth, required this.authAction});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  RxString pin = "".obs;
  RxBool confirmPassword = false.obs;
  String password = "";
  String rePassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        automaticallyImplyLeading: !widget.isAuth,
      ),
      body: PopScope(
        onPopInvoked: (b) {
          context.read<LocalAuthProvider>().getStatusLocalAuth();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
              confirmPassword.value ? S.of(context).confirm_password : S.of(context).enter_password,
              style: TextStyle(color: Colors.blueGrey.shade100, fontSize: 18),
            )
            ),
            PinCodeInput(pin: pin,),
            NumericKeypad(
              isAuth: widget.isAuth,
              onKeyPress: (i) {
                addDigit(i);
              },
              onDelete: removeDigit,
              authAction: () {
                widget.authAction();
              },
            )
          ],
        ),
      ),
    );
  }

  void addDigit(int i) {
    if (pin.value.length < 4) {
      pin.value += "$i";
    }
    if (pin.value.length == 4) {
      if (widget.isAuth) {
        auth();
      } else {
        if (confirmPassword.value) {
          rePassword = pin.value;
          checkEqualPassword();
        } else {
          password = pin.value;
          pin.value = "";
          confirmPassword.value = true;
        }
      }
    }
  }

  void removeDigit() {
    if (pin.value.isNotEmpty) {
      pin.value = pin.value.substring(0, pin.value.length - 1);
    }
  }

  void checkEqualPassword() {
    if (password == rePassword) {
      context.read<LocalAuthProvider>().savePassword(password);
      context.read<LocalAuthProvider>().enableLocalAuth();
      Get.back();
    } else {
      pin.value = "";
      showCustomToast(context: context, message: S.of(context).password_mismatch, backgroundColor: Colors.red); 
    }
  }

  Future<void> auth() async {
    String? password = await context.read<LocalAuthProvider>().getPassword();
    if (pin.value == password) {
      widget.authAction();
    } else {
      pin.value = "";
      showCustomToast(context: context, message: S.of(context).authentication_failed, backgroundColor: Colors.red); 
    }
  }
}
