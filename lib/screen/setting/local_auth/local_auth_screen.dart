import 'dart:developer';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mood_press/providers/local_auth_provider.dart';
import 'package:mood_press/screen/setting/backup/backup_screen.dart';
import 'package:mood_press/screen/setting/local_auth/password_screen.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import '../../../generated/l10n.dart';

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
    localAuthProvider.getStatusLocalAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(S.of(context).lock_code),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<LocalAuthProvider>(
            builder: (context, localAuthProvider, _) {
              enableLocalAuth.value = localAuthProvider.enableAuth;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).cardTheme.shadowColor!,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.lock, color: Colors.blueGrey.shade100,),
                            const SizedBox(width: 12,),
                            Expanded(
                              child: Text(
                                S.of(context).set_password,
                                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Obx(() => Switch(
                              value: enableLocalAuth.value,
                              onChanged: (value) async {
                                enableLocalAuth.value = value;
                                if (value) {
                                  bool isSupported = await auth.isDeviceSupported() || await auth.canCheckBiometrics;
                                  if (isSupported) {
                                    Get.to(() => PasswordScreen(isAuth: false, authAction: () { Get.back(); },));
                                  } else {
                                    enableLocalAuth.value = false;
                                    if(context.mounted){
                                      showCustomToast(context: context, message: S.of(context).device_not_supported);
                                    }
                                  }
                                } else {
                                  localAuthProvider.disableLocalAuth();
                                }
                              },
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
                                  FaIcon(FontAwesomeIcons.fingerprint, color: Colors.blueGrey.shade100,),
                                  const SizedBox(width: 12,),
                                  Expanded(
                                    child: Text(
                                      S.of(context).use_biometric,
                                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Selector<LocalAuthProvider, bool>(
                                    builder: (context, enableBiometric, _) {
                                      return Switch(
                                          value: enableBiometric,
                                          onChanged: (value) async {
                                            localAuthProvider.toggleBiometricAuth(value);
                                            authBiometric(enable: value);
                                          }
                                      );
                                    },
                                    selector: (context, localAuthProvider) => localAuthProvider.enableBiometric,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  if(localAuthProvider.enableAuth)
                  Text(S.of(context).backup_restore_message, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),),
                  if(localAuthProvider.enableAuth)
                  TextButton(
                    onPressed: (){
                      Get.to(() => const BackupScreen());
                    },
                    child: Text(S.of(context).backup_restore,style: const TextStyle(fontSize: 16,decoration: TextDecoration.underline),)
                  )
                ],
              );
            }
        ),
      ),
    );
  }

  Future<void> authBiometric({required bool enable}) async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: S.of(context).auth_to_access, // Localized string
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
      if (e.code == Constant.notAvailable) {
        log('Authentication cancelled: ${e.message}');
        Future.delayed(1.seconds, () {
          showCustomToast(context: context, message: S.of(context).authentication_cancelled); // Localized string
        });
      } else if (e.code == Constant.notEnrolled) {
        log('Device not enrolled for biometric authentication: ${e.message}');
        Future.delayed(1.seconds, () {
          showCustomToast(context: context, message: S.of(context).device_not_enrolled); // Localized string
        });
      } else {
        log('Authentication error: ${e.code} - ${e.message}');
        Future.delayed(1.seconds, () {
          showCustomToast(context: context, message: S.of(context).authentication_error); // Localized string
        });
      }
      localAuthProvider.toggleBiometricAuth(!enable);
    } catch (e) {
      log('Unknown error: $e');
      Future.delayed(1.seconds, () {
        showCustomToast(context: context, message: S.of(context).unknown_error); // Localized string
      });
      localAuthProvider.disableAuthBio();
    }
  }

  void showDialogRequestEnableBioMetric() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).enable_biometric_auth), // Localized string
          content: Text(S.of(context).biometric_auth_message), // Localized string
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).later), // Localized string
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(S.of(context).open_settings), // Localized string
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
