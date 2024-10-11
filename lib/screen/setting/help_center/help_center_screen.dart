import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/home_provider.dart';
import 'package:mood_press/screen/setting/help_center/video_tutorial_screen.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../widget/item_setting.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listVideo = context.read<HomeProvider>().listVideo;
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
        title: Text(S.of(context).help_center),
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
                    title: S.of(context).howToAddEmotionDiary,
                    onTap: () {
                      Get.to(() => VideoTutorialScreen(videoPath: listVideo[Constant.addMood], title: S.of(context).howToAddEmotionDiary));
                    },
                  ),
                  const Divider(thickness: 2,),
                  ItemSetting(
                    title: S.of(context).addWidgetToHomeScreen,
                    onTap: () {
                      Get.to(() => VideoTutorialScreen(videoPath: listVideo[Constant.widget], title: S.of(context).addWidgetToHomeScreen));
                    },
                  ),
                  const Divider(thickness: 2,),
                  ItemSetting(
                    title: S.of(context).forgotPasswordWhenAppLocked,
                    onTap: () {
                      Get.to(() => VideoTutorialScreen(videoPath: listVideo[Constant.forgotPassword], title: S.of(context).forgotPasswordWhenAppLocked));
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
                    title: S.of(context).howToBackupData,
                    onTap: () {
                      Get.to(() => VideoTutorialScreen(videoPath: listVideo[Constant.backup], title: S.of(context).howToBackupData));
                    },
                  ),
                  const Divider(thickness: 2,),
                  ItemSetting(
                    title: S.of(context).howToChangeEmotionIcon,
                    onTap: () {
                      Get.to(() => VideoTutorialScreen(videoPath: listVideo[Constant.changeEmoji], title: S.of(context).howToChangeEmotionIcon));
                    },
                  ),
                  const Divider(thickness: 2,),
                  ItemSetting(
                    title: S.of(context).changeAppTheme,
                    onTap: () {
                      Get.to(() => VideoTutorialScreen(videoPath: listVideo[Constant.changeTheme], title: S.of(context).changeAppTheme));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
