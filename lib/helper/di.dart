import 'package:get/get.dart';
import 'package:mood_press/helper/database_helper.dart';

init(){
  Get.lazyPut(() => DatabaseHelper());
}