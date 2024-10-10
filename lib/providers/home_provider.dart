import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mood_press/data/model/address.dart';
import 'package:mood_press/data/repository/home_repo.dart';
import '../data/model/mood.dart';
import '../helper/database_helper.dart';

class HomeProvider with ChangeNotifier {
  final HomeRepo repo;
  String _selectedLocation = "";
  List<File> listImage = [];
  List<Mood> listMood = [];
  List<String> listVideo = [];

  HomeProvider({required this.repo});

  String get selectedLocation => _selectedLocation;

  void selectLocation(String location) {
    _selectedLocation = location;
    notifyListeners();
  }
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile> images = await picker.pickMultiImage();
      listImage.addAll(images.map((xFile) => File(xFile.path)).toList());
      notifyListeners();
    } catch (e) {
      log('Error picking multiple images: $e');
    }
  }

  void setUpInfoMood(Mood mood){
    if(mood.imagePath != null && mood.imagePath!.isNotEmpty){
      listImage.clear();
      List<File> images = mood.imagePath?.map((path) => File(path)).toList() ?? [];
      listImage.addAll(images);
      _selectedLocation = mood.location ?? '';
      notifyListeners();
    }
  }

  void deleteImage(int index){
    listImage.removeAt(index);
    notifyListeners();
  }
  Future<void> insertMood(Mood mood)async {
    if(listImage.isNotEmpty) {
      mood.imagePath = listImage.map((e) => e.path).toList();
    }
    mood.location = selectedLocation;
    await Get.find<DatabaseHelper>().insertMood(mood);
    await getMoods();
  }

  Future<void> updateMood(Mood mood)async {
    if(listImage.isNotEmpty) {
      mood.imagePath = listImage.map((e) => e.path).toList();
    }
    mood.location = selectedLocation;
    await Get.find<DatabaseHelper>().updateMood(mood);
    await getMoods();
  }

  Future<void> removeMood(Mood mood) async {
    await Get.find<DatabaseHelper>().deleteMood(mood.id!);  notifyListeners();
    await getMoods();
  }

  Future<void> getMoods()async {
    listMood = await Get.find<DatabaseHelper>().getMoods();
    notifyListeners();
  }

  Future<String?> getAddress(double lat, double long, double zoom) async {
    Response response = await repo.getAddress(lat, long, zoom);
    if(response.isOk){
      LocationDetail locationDetail = LocationDetail.fromJson(response.body);
      return locationDetail.displayName ?? '';
    }
    return null;
  }

  Future<Mood?> getMoodFromDate(String date)async {
    Mood? mood = await Get.find<DatabaseHelper>().getMoodFromDate(date);
    return mood;
  }

  Future<List<Mood>> getListMoodFromDate(String date)async {
    return await Get.find<DatabaseHelper>().getListMoodFromDate(date);
  }

  void clear(){
    _selectedLocation = "";
    listImage.clear();
  }
  Future<void> getVideo() async {
    listVideo = await repo.getVideoUrls();
    notifyListeners();
  }
}