import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mood_press/screen/healing/healing_screen.dart';
import 'package:mood_press/screen/home/home_screen.dart';
import 'package:mood_press/screen/setting/setting_screen.dart';
import 'package:mood_press/screen/statistical/statistical_screen.dart';

import '../../ulti/function.dart';
import '../home/widget/add_emotion_widget.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  final _bottomNavIndex = 0.obs;
  List<Widget> screens = [
    const HomeScreen(),
    const HealingScreen(),
    const StatisticalScreen(),
    const SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      body: Obx(()=> screens[_bottomNavIndex.value]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigationToMood();
        },
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add_reaction),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: ColorName.colorBackground,
        icons: const [FontAwesomeIcons.calendarWeek,FontAwesomeIcons.heartCircleBolt,FontAwesomeIcons.chartPie,FontAwesomeIcons.gear,],
        activeIndex: _bottomNavIndex.value,
        gapLocation: GapLocation.center,
        activeColor: Colors.white,
        inactiveColor: Colors.grey[500],
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 16,
        rightCornerRadius: 16,
        onTap: (index) => setState(() => _bottomNavIndex.value = index),
        //other params
      ),
    );
  }
  void navigationToMood() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>  AddEmotionWidget(date: DateTime.now(),),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ).then((result){
      if (result != null && result is Map<String, dynamic>) {
        if (result['showToast'] == true) {
          showCustomToast(context: context, message: result['message']);
        }
      }
    });
  }
}
