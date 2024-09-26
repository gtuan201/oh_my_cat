import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:mood_press/helper/database_helper.dart';
import '../../gen/assets.gen.dart';
import '../model/test.dart';

class StatisticalRepo{
  Future<List<Test>> getListTest() async {
    String jsonString = await rootBundle.loadString(
        Get.locale!.languageCode == "vi"
            ? Assets.json.testVi
            : Assets.json.testEn);
    final jsonResponse = json.decode(jsonString);

    List<Test> tests = (jsonResponse['tests'] as List)
        .map((testJson) => Test.fromMap(testJson))
        .toList();
    return tests;
  }

  Future<List<Test>> getListTestResult(List<Test> baseListTest) async {
    return await Get.find<DatabaseHelper>().getTests(baseListTest);
  }
}