import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/emoji_provider.dart';
import 'package:mood_press/providers/healing_provider.dart';
import 'package:mood_press/providers/home_provider.dart';
import 'package:mood_press/providers/music_provider.dart';
import 'package:mood_press/providers/statisticaL_provider.dart';
import 'package:mood_press/providers/test_provider.dart';
import 'package:mood_press/providers/theme_provider.dart';
import 'helper/audio_handler.dart';
import 'helper/di.dart' as di;
import 'package:intl/date_symbol_data_local.dart';
import 'package:mood_press/screen/splash/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('vi_VN', null);
  AudioHandler audioHandler =  await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ohmycat.audio',
      androidNotificationChannelName: 'Audio Service OhMyCat',
      androidNotificationOngoing: true,
    ),
  );
  di.init(audioHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HealingProvider(repo: Get.find())),
        ChangeNotifierProvider(create: (_) => HomeProvider(repo: Get.find())),
        ChangeNotifierProvider(create: (_) => EmojiProvider()),
        ChangeNotifierProvider(create: (_) => TestProvider()),
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        ChangeNotifierProvider(create: (_) => StatisticalProvider(repo: Get.find())),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
          builder: (context,themeProvider,_){
            return GetMaterialApp(
              theme: themeProvider.themeData,
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            );
          }
      ),
    );
  }
}
