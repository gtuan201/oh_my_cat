import 'package:audio_service/audio_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/repository/healing_repo.dart';
import 'package:mood_press/data/repository/home_repo.dart';
import 'package:mood_press/data/repository/local_auth_repo.dart';
import 'package:mood_press/data/repository/reminder_repo.dart';
import 'package:mood_press/data/repository/statistical_repo.dart';
import 'package:mood_press/helper/api_client.dart';
import 'package:mood_press/helper/audio_handler.dart';
import 'package:mood_press/helper/database_helper.dart';
import 'package:mood_press/helper/notification_helper.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init(AudioHandler audioHandler) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.lazyPut(() => ApiClient(baseUrl: Constant.BASE_URL_MAP));
  Get.lazyPut(() => DatabaseHelper());
  Get.lazyPut(() => NotificationHelper());
  Get.lazyPut(() => AudioPlayerHandler());
  Get.lazyPut(() => audioHandler);
  Get.lazyPut(() => const FlutterSecureStorage());
  Get.lazyPut(() => prefs);


  //Repository
  Get.lazyPut(() => HomeRepo(api: Get.find()));
  Get.lazyPut(() => HealingRepo());
  Get.lazyPut(() => StatisticalRepo());
  Get.lazyPut(() => ReminderRepo(db: Get.find()));
  Get.lazyPut(() => LocalAuthRepo(storage: Get.find(),prefs: Get.find()));
}