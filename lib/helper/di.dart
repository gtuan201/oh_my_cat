import 'package:get/get.dart';
import 'package:mood_press/data/repository/home_repo.dart';
import 'package:mood_press/helper/api_client.dart';
import 'package:mood_press/helper/database_helper.dart';
import 'package:mood_press/ulti/constant.dart';

init(){
  Get.lazyPut(() => ApiClient(baseUrl: Constant.BASE_URL_MAP));
  Get.lazyPut(() => DatabaseHelper());

  //Repository
  Get.lazyPut(() => HomeRepo(api: Get.find()));
}