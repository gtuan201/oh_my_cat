
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/repository/emoji_repo.dart';
import '../gen/assets.gen.dart';
import '../generated/l10n.dart';
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
  final EmojiRepo repo;
  List<SvgGenImage> _currentEmojiList = Constant.listEmoji;

  EmojiProvider({required this.storage,required this.repo});

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
  Future<String> suggestEmotion(String userStory, BuildContext context) async {
    final String prompt = _buildPrompt(userStory, S.of(context));
    final Response response = await repo.getChatCompletion(prompt);

    if (response.statusCode == 200) {
      var data = response.body;
      final String content = data['choices']?[0]?['message']?['content'] ?? '';
      return content.isNotEmpty ? content : 'neutral';
    } else {
      return 'neutral';
    }
  }

  String _buildPrompt(String userStory,S s) {
    final buffer = StringBuffer();

    buffer
      ..writeln(s.emotion_analysis_system_role)
      ..writeln()
      ..writeln('${s.emotion_analysis_user_story}: "$userStory"')
      ..writeln()
      ..writeln('${s.emotion_analysis_available_emotions}: ${Constant.emojiNames[Get.locale!.languageCode]!.join(', ')}')
      ..writeln()
      ..writeln('${s.emotion_analysis_instructions}:')
      ..writeln('- ${s.emotion_analysis_instruction_1}')
      ..writeln('- ${s.emotion_analysis_instruction_2}')
      ..writeln('- ${s.emotion_analysis_instruction_3}')
      ..writeln('- ${s.emotion_analysis_instruction_4}')
      ..writeln()
      ..write('${s.emotion_analysis_response}:');

    return buffer.toString();
  }
}