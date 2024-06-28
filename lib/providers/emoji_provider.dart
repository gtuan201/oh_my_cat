import 'package:flutter/material.dart';
import '../gen/assets.gen.dart';
import '../ulti/constant.dart';

class EmojiProvider extends ChangeNotifier {
  List<SvgGenImage> _currentEmojiList = Constant.listEmoji;

  List<SvgGenImage> get currentEmojiList => _currentEmojiList;

  void toggleEmojiList() {
    if (_currentEmojiList == Constant.listEmoji) {
      _currentEmojiList = Constant.listEmojiHuman;
    } else {
      _currentEmojiList = Constant.listEmoji;
    }
    notifyListeners();
  }
}