import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/helper/my_ad_manager.dart';
import 'package:mood_press/providers/backup_provider.dart';
import 'package:mood_press/providers/local_auth_provider.dart';
import 'package:mood_press/screen/healing/healing_screen.dart';
import 'package:mood_press/screen/home/home_screen.dart';
import 'package:mood_press/screen/setting/backup/backup_screen.dart';
import 'package:mood_press/screen/setting/local_auth/password_screen.dart';
import 'package:mood_press/screen/setting/setting_screen.dart';
import 'package:mood_press/screen/statistical/statistical_screen.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../providers/statisticaL_provider.dart';
import '../../ulti/function.dart';
import '../home/widget/add_emotion_widget.dart';
import 'widget/nav_bar_widget.dart';

class DashBoardScreen extends StatefulWidget {
  final bool isRestart;
  const DashBoardScreen({super.key, required this.isRestart});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with WidgetsBindingObserver {

  final _bottomNavIndex = 0.obs;
  late LocalAuthProvider localAuthProvider;
  DateTime? _pausedTime;
  List<Widget> screens = [
    const HomeScreen(),
    const HealingScreen(),
    const StatisticalScreen(),
    const SettingScreen()
  ];

  @override
  void initState() {
    super.initState();
    localAuthProvider = context.read<LocalAuthProvider>();
    context.read<BackupProvider>().getListFile();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.isRestart){
        showDialogRestoreData();
      }
    });
    Get.find<MyAdManager>().loadAd().then((_){
      Get.find<MyAdManager>().showAd();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _pausedTime = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      if (_pausedTime != null) {
        final pauseDuration = DateTime.now().difference(_pausedTime!);
        if (pauseDuration > const Duration(seconds: 5)) {
          if(localAuthProvider.enableAuth){
            Get.to(() => PasswordScreen(isAuth: true, authAction: () { Get.back(); },));
          }
        }
      }
      _pausedTime = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Obx(() => IndexedStack(
        index: _bottomNavIndex.value,
        children: screens,
      )),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).splashColor,
          elevation: 0,
          onPressed: (){
            navigationToMood();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.add_reaction,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() =>  NavBar(
        pageIndex: _bottomNavIndex.value,
        onTap: (index) {
          _bottomNavIndex.value = index;
        },
      )),
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
          context.read<StatisticalProvider>().percentOfMood();
          showCustomToast(context: context, message: result['message']);
        }
      }
    });
  }
  void showDialogRestoreData(){
    showDialog(context: context, builder: (context){
      return Dialog(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.of(context).restore_your_data_now,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(height: 16,),
              Text(S.of(context).login_then_restore_data,style: const TextStyle(color: Colors.white)),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: (){
                      Get.back();
                    },
                    child: Text(S.of(context).cancel)
                  ),
                  TextButton(
                      onPressed: (){
                        Get.back();
                        Get.to(() => const BackupScreen());
                      },
                      child: Text(S.of(context).restore)
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
