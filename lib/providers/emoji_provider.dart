import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../gen/assets.gen.dart';
import '../ulti/constant.dart';

enum EmojiType {
  cat,
  human,
  bear;

  List<SvgGenImage> get listEmoji{
    switch(this){
      case cat : return Constant.listEmoji;
      case human : return Constant.listEmojiHuman;
      case bear : return Constant.listEmojiBear;
    }
  }
}

class EmojiProvider extends ChangeNotifier {
  final FlutterSecureStorage storage;
  List<SvgGenImage> _currentEmojiList = Constant.listEmoji;

  EmojiProvider({required this.storage});

  List<SvgGenImage> get currentEmojiList => _currentEmojiList;

  void changeEmoji(EmojiType type) {
    storage.write(key: Constant.emoji, value: type.name);
    switch(type){
      case EmojiType.cat :
        _currentEmojiList = Constant.listEmoji;
      case EmojiType.bear :
        _currentEmojiList = Constant.listEmojiBear;
      case EmojiType.human :
        _currentEmojiList = Constant.listEmojiHuman;
      default:
        _currentEmojiList = Constant.listEmoji;
    }
    notifyListeners();
  }
  Future<void> getEmoji() async {
    String? emoji = await storage.read(key:Constant.emoji);
    if(emoji != null){
      _currentEmojiList = EmojiType.values.firstWhere((e) => e.name == emoji).listEmoji;
    }
    else{
      _currentEmojiList = Constant.listEmoji;
    }
    notifyListeners();
  }
}