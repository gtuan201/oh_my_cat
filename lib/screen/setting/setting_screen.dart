import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/healing_provider.dart';
import 'package:mood_press/providers/statisticaL_provider.dart';
import 'package:mood_press/providers/theme_provider.dart';
import 'package:mood_press/screen/setting/contact/contact_screen.dart';
import 'package:mood_press/screen/setting/help_center/help_center_screen.dart';
import 'package:mood_press/screen/setting/widget_screen/widget_screen.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import 'backup/backup_screen.dart';
import 'daily_reminder/daily_reminder_screen.dart';
import 'emoji/emoji_screen.dart';
import 'local_auth/local_auth_screen.dart';
import 'theme/theme_screen.dart';
import 'widget/item_setting.dart';  // Import localization

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).cardTheme.shadowColor!,
            width: 3
        )
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(S.of(context).settings),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              decoration: decoration,
              child: Column(
                children: [
                  ItemSetting(
                    title: S.of(context).daily_reminder,
                    icon: Icons.notifications,
                    onTap: () {
                      Get.to(() => const DailyReminderScreen());
                    },
                  ),
                  const Divider(thickness: 2,),
                  ItemSetting(
                    title: S.of(context).local_auth,
                    icon: Icons.lock,
                    onTap: () {
                      Get.to(() => const LocalAuthScreen());
                    },
                  ),
                  const Divider(thickness: 2,),
                  ItemSetting(
                    title: S.of(context).backup_restore,
                    icon: Icons.cloud,
                    onTap: () {
                      Get.to(() => const BackupScreen());
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              decoration: decoration,
              child: Column(
                children: [
                  ItemSetting(
                    title: S.of(context).theme,
                    icon: Icons.format_paint_sharp,
                    onTap: () {
                      Get.to(() => const ThemeScreen());
                    },
                  ),
                  const Divider(thickness: 2,),
                  ItemSetting(
                    title: S.of(context).emoji,
                    icon: Icons.emoji_emotions,
                    onTap: () {
                      Get.to(() => const EmojiScreen());
                    },
                  ),
                  const Divider(thickness: 2,),
                  ItemSetting(
                    title: S.of(context).widget,
                    icon: Icons.widgets,
                    onTap: () {
                      Get.to(() => const WidgetScreen());
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              decoration: decoration,
              child: Column(
                children: [
                  ItemSetting(
                    title: S.of(context).language,
                    icon: Icons.translate_rounded,
                    onTap: () {
                      showLanguageDialog(
                        Get.locale!.languageCode,
                        (String selectedLanguage) {
                          context.read<ThemeProvider>().setLocale(Locale(selectedLanguage));
                          context.read<HealingProvider>().getListTest();
                          context.read<StatisticalProvider>().getListTest().then((_){
                            context.read<StatisticalProvider>().getListTestResult();
                          });
                        },
                      );
                    },
                  ),
                  const Divider(thickness: 2,),
                  ItemSetting(
                    title: S.of(context).help_center,
                    icon: Icons.help,
                    onTap: () {
                      Get.to(() => const HelpCenterScreen());
                    },
                  ),
                  const Divider(thickness: 2,),
                  ItemSetting(
                    title: S.of(context).contact_us,
                    icon: Icons.contact_page,
                    onTap: () {
                      Get.to(() => const ContactScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showLanguageDialog(String currentLanguage, Function(String) onLanguageSelected) {
    RxString selectedLanguage = currentLanguage.obs;

    Get.dialog(
      AlertDialog(
        backgroundColor: Get.theme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        title: Text(S.of(context).chooseLanguage,style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(color: Colors.grey,),
            SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Obx(() => RadioListTile<String>(
                    title: const Text('Tiếng Việt',style: TextStyle(color: Colors.white),),
                    value: 'vi',
                    groupValue: selectedLanguage.value,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    onChanged: (String? value) {
                      selectedLanguage.value = value!;
                    },
                  )),
                  Obx(() => RadioListTile<String>(
                    title: const Text('English',style: TextStyle(color: Colors.white)),
                    value: 'en',
                    groupValue: selectedLanguage.value,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    onChanged: (String? value) {
                      selectedLanguage.value = value!;
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(S.of(context).close),
          ),
          TextButton(
            onPressed: () {
              onLanguageSelected(selectedLanguage.value);
              Get.back();
            },
            child: Text(S.of(context).confirm),
          ),
        ],
      ),
    );
  }
}
