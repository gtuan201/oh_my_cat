import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/providers/local_auth_provider.dart';
import 'package:mood_press/screen/setting/local_auth/password_screen.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  
  RxBool enableLocalAuth = false.obs;
  final auth = LocalAuthentication();
  late LocalAuthProvider localAuthProvider;


  @override
  void initState() {
    super.initState();
    localAuthProvider = context.read<LocalAuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      appBar: AppBar(
        backgroundColor: ColorName.colorPrimary,
        elevation: 0,
        title: const Text('Khoá mật mã',style: TextStyle(fontSize: 20),),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.blueGrey.withBlue(140),
                      width: 3
                  )
              ),
              child: Consumer<LocalAuthProvider>(
                builder: (context,localAuthProvider,_){
                  enableLocalAuth.value = localAuthProvider.enableAuth;
                  return Column(
                    children: [
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.lock,color: Colors.blueGrey.shade100,),
                          const SizedBox(width: 12,),
                          const Expanded(child: Text('Thiết lập mật mã',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),)),
                          Obx(() => Switch(
                              value: enableLocalAuth.value,
                              activeColor: Colors.tealAccent,
                              onChanged: (value) async {
                                enableLocalAuth.value = value;
                                if(value){
                                  bool isSupported = await auth.isDeviceSupported() || await auth.canCheckBiometrics;
                                  if(isSupported){
                                    Get.to(() => PasswordScreen(isAuth: false, authAction: () { Get.back(); },));
                                  }
                                  else{
                                    enableLocalAuth.value = false;
                                    showCustomToast(context: context, message: 'Thiết bị của bạn không hỗ trợ');
                                  }
                                }
                                else{
                                  localAuthProvider.disableLocalAuth();
                                }
                              }
                          ))
                        ],
                      ),
                      Visibility(
                        visible: localAuthProvider.enableAuth,
                        child: Column(
                          children: [
                            const Divider(color: Colors.blueGrey,),
                            Row(
                              children: [
                                FaIcon(FontAwesomeIcons.fingerprint,color: Colors.blueGrey.shade100,),
                                const SizedBox(width: 12,),
                                const Expanded(child: Text('Sử dụng sinh trắc học',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),)),
                                Selector<LocalAuthProvider,bool>(
                                  builder: (context,enableBiometric,_){
                                    return Switch(
                                        value: enableBiometric,
                                        activeColor: Colors.tealAccent,
                                        onChanged: (value) async {
                                          localAuthProvider.toggleBiometricAuth(value);
                                          authBiometric(enable: value);
                                        }
                                    );
                                  },
                                  selector: (context,localAuthProvider) => localAuthProvider.enableBiometric
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> authBiometric({required bool enable}) async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Xác thực để truy cập ứng dụng',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        enable ? localAuthProvider.enableAuthBio() : localAuthProvider.disableAuthBio();
      } else {
        localAuthProvider.disableAuthBio();
      }
    } on PlatformException catch (e) {
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
      localAuthProvider.toggleBiometricAuth(!enable);
    } catch (e) {
      log('Lỗi không xác định: $e');
      Future.delayed(1.seconds,(){
        showCustomToast(context: context, message: 'Lỗi không xác định');
      });
      localAuthProvider.disableAuthBio();
    }
  }
  void showDialogRequestEnableBioMetric(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Bật xác thực sinh trắc học"),
          content: const Text('Để sử dụng tính năng này, bạn cần bật xác thực sinh trắc học trong cài đặt hệ thống.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Để sau'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Mở cài đặt'),
              onPressed: () {
                Navigator.of(context).pop();
                AppSettings.openAppSettings(type: AppSettingsType.security);
              },
            ),
          ],
        );
      },
    );
  }
}
