import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/helper/notification_helper.dart';
import 'package:mood_press/screen/setting/daily_reminder/daily_reminder_screen.dart';
import 'package:mood_press/screen/setting/widget/item_setting.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

import '../../gen/colors.gen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  BoxDecoration decoration = BoxDecoration(
      color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
          color: Colors.blueGrey.withBlue(140),
          width: 3
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      appBar: AppBar(
        backgroundColor: ColorName.colorPrimary,
        elevation: 0,
        title: const Text('Cài đặt'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              decoration: decoration,
              child: Column(
                children: [
                  ItemSetting(title: 'Nhắc nhở hàng ngày', icon: Icons.notifications, onTap: () async {
                    Get.to(() => const DailyReminderScreen());
                  },),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  ItemSetting(title: 'Khoá bảo mật', icon: Icons.lock, onTap: () {

                  },),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  ItemSetting(title: 'Sao lưu & Khôi phục', icon: Icons.cloud, onTap: () {  },),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              decoration: decoration,
              child: Column(
                children: [
                  ItemSetting(title: 'Chủ đề', icon: Icons.format_paint_sharp, onTap: () {  },),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  ItemSetting(title: 'Biểu tượng cảm xúc', icon: Icons.emoji_emotions, onTap: () {  },),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  ItemSetting(title: 'Widget', icon: Icons.widgets, onTap: () {  },),
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
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  ItemSetting(title: 'Trung tâm trợ giúp', icon: Icons.help, onTap: () {  },),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
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
