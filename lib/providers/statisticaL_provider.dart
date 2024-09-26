import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/model/mood.dart';
import 'package:mood_press/data/repository/statistical_repo.dart';
import 'package:mood_press/helper/date_time_helper.dart';
import 'package:mood_press/helper/extension.dart';
import 'package:mood_press/ulti/constant.dart';
import '../data/model/test.dart';
import '../helper/database_helper.dart';

class StatisticalProvider extends ChangeNotifier{
  final StatisticalRepo repo;
  List<Test> listTest = [];
  List<Test> listTestResult = [];
  List<double> moodPercents = List.filled(11, 0.0);
  List<String> dateComplete = List.filled(4, "");
  bool enableChart = false;

  StatisticalProvider({required this.repo});

  Future<void> percentOfMood() async {
    List<Mood> listMood = await Get.find<DatabaseHelper>().getMoods();
    int totalMoods = listMood.length;
    enableChart = listMood.isNotEmpty;

    if(totalMoods != 0){
      for (int i = 0; i < moodPercents.length; i++) {
        moodPercents[i] = percent(i, listMood, totalMoods);
      }
    }
    else{
      moodPercents = List.filled(11, 100/Constant.listEmoji.length);
    }
    notifyListeners();
  }

  double percent(int moodIndex, List<Mood> listMood, int totalMoods) {
    if (totalMoods == 0) return 0;
    int count = listMood.where((mood) => mood.mood == moodIndex).length;
    return ((count / totalMoods) * 100);
  }

  Future<void> getListTest() async {
    listTest = await repo.getListTest();
    notifyListeners();
  }

  Future<void> getListTestResult() async {
    listTestResult = await repo.getListTestResult(listTest);
    for (int i = 0; i< dateComplete.length; i++) {
      dateComplete[i] = timeResult("${i + 1}");
    }
    notifyListeners();
  }
  String timeResult(String id){
    DateTime? time = listTestResult.lastWhereOrNull((test) => test.id == id)?.dateCompleted;
    return DateTimeHelper.dateTimeToString(time);
  }
}