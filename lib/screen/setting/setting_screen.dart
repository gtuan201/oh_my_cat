import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/screen/setting/backup/backup_screen.dart';
import 'package:mood_press/screen/setting/daily_reminder/daily_reminder_screen.dart';
import 'package:mood_press/screen/setting/emoji/emoji_screen.dart';
import 'package:mood_press/screen/setting/local_auth/local_auth_screen.dart';
import 'package:mood_press/screen/setting/theme/theme_screen.dart';
import 'package:mood_press/screen/setting/widget/item_setting.dart';
import 'package:mood_press/screen/setting/widget_screen/widget_screen.dart';
import '../../gen/colors.gen.dart';

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
        title: const Text('Cài đặt'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              decoration: decoration,
              child: Column(
                children: [
                  ItemSetting(title: 'Nhắc nhở hàng ngày', icon: Icons.notifications, onTap: ()  {
                    Get.to(() => const DailyReminderScreen());
                  },),
                  const Divider(thickness: 2,),
                  ItemSetting(title: 'Khoá bảo mật', icon: Icons.lock, onTap: () {
                    Get.to(() => const LocalAuthScreen());
                  },),
                  const Divider(thickness: 2,),
                  ItemSetting(title: 'Sao lưu & Khôi phục', icon: Icons.cloud, onTap: ()  {
                    Get.to(() => const BackupScreen());
                  },),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              decoration: decoration,
              child: Column(
                children: [
                  ItemSetting(title: 'Chủ đề', icon: Icons.format_paint_sharp, onTap: () {
                    Get.to(() => const ThemeScreen());
                  },),
                  const Divider(thickness: 2,),
                  ItemSetting(title: 'Biểu tượng cảm xúc', icon: Icons.emoji_emotions, onTap: () {
                    Get.to(() => const EmojiScreen());
                  },),
                  const Divider(thickness: 2,),
                  ItemSetting(title: 'Widget', icon: Icons.widgets, onTap: () {
                    Get.to(() => const WidgetScreen());
                  },),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              decoration: decoration,
              child: Column(
                children: [
                  ItemSetting(title: 'Ngôn ngữ', icon: Icons.translate_rounded, onTap: () {  },),
                  const Divider(thickness: 2,),
                  ItemSetting(title: 'Trung tâm trợ giúp', icon: Icons.help, onTap: () {  },),
                  const Divider(thickness: 2,),
                  ItemSetting(title: 'Liên hệ với chúng tôi', icon: Icons.contact_page, onTap: () {  },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
