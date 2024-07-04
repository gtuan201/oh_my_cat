import 'package:flutter/cupertino.dart';
import 'package:mood_press/data/model/test.dart';
import 'package:mood_press/data/repository/healing_repo.dart';

import '../data/model/audio_model.dart';

class HealingProvider with ChangeNotifier{
  final HealingRepo repo;
  List<Test> listTest = [];
  List<String> listQuotes = [];
  AudioModel? currentAudio;

  HealingProvider({required this.repo});


  Future<void> getListTest() async {
    listTest = await repo.getListTest();
    notifyListeners();
  }

  Future<void> getListQuotes() async {
    listQuotes = await repo.getImageUrls();
    notifyListeners();
  }
  void setCurrentAudio(AudioModel? audio){
    currentAudio = audio;
    notifyListeners();
  }
}