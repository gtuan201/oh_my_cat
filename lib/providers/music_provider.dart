import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:mood_press/ulti/audio.dart';
import '../data/model/audio_model.dart';

class MusicProvider extends ChangeNotifier {
  double _toolbarHeight = 48.0;

  double get toolbarHeight => _toolbarHeight;

  List<AudioModel> listAudio = Audio.listAudio;

  void updateToolbarHeight(double newHeight) {
    if (newHeight != _toolbarHeight) {
      _toolbarHeight = newHeight;
      notifyListeners();
    }
  }

  void changeTypeListAudio(AudioType type){
    if(type == AudioType.all){
      listAudio = Audio.listAudio;
    }
    else {
      listAudio = Audio.listAudio.where((audio) => audio.type == type).toList();
    }
    notifyListeners();
  }
}