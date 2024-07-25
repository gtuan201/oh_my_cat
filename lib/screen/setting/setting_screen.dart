import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_press/screen/setting/widget/item_setting.dart';

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
                  const ItemSetting(title: 'Nhắc nhở hàng ngày', icon: Icons.notifications),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  const ItemSetting(title: 'Khoá bảo mật', icon: Icons.lock),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  const ItemSetting(title: 'Sao lưu & Khôi phục', icon: Icons.cloud),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              decoration: decoration,
              child: Column(
                children: [
                  const ItemSetting(title: 'Chủ đề', icon: Icons.format_paint_sharp),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  const ItemSetting(title: 'Biểu tượng cảm xúc', icon: Icons.emoji_emotions),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  const ItemSetting(title: 'Widget', icon: Icons.widgets),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              decoration: decoration,
              child: Column(
                children: [
                  const ItemSetting(title: 'Ngôn ngữ', icon: Icons.translate_rounded),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  const ItemSetting(title: 'Trung tâm trợ giúp', icon: Icons.help),
                  Divider(color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),thickness: 2,),
                  const ItemSetting(title: 'Liên hệ với chúng tôi', icon: Icons.contact_page),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
