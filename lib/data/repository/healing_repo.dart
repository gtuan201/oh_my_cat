import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:mood_press/data/model/test.dart';
import 'package:mood_press/gen/assets.gen.dart';

class HealingRepo{
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
  Future<List<String>> getImageUrls() async {
    List<String> imageUrls = [];
    FirebaseStorage storage = FirebaseStorage.instance;
    ListResult result = await storage.ref('quotes').listAll();

    for (var item in result.items) {
      String downloadUrl = await item.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
  }
}