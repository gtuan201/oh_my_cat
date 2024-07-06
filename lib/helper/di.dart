import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/repository/healing_repo.dart';
import 'package:mood_press/data/repository/home_repo.dart';
import 'package:mood_press/helper/api_client.dart';
import 'package:mood_press/helper/audio_handler.dart';
import 'package:mood_press/helper/database_helper.dart';
import 'package:mood_press/ulti/constant.dart';

init(AudioHandler audioHandler){
  Get.lazyPut(() => ApiClient(baseUrl: Constant.BASE_URL_MAP));
  Get.lazyPut(() => DatabaseHelper());
  Get.lazyPut(() => AudioPlayerHandler());
  Get.lazyPut(() => audioHandler);


  //Repository
  Get.lazyPut(() => HomeRepo(api: Get.find()));
  Get.lazyPut(() => HealingRepo());
}