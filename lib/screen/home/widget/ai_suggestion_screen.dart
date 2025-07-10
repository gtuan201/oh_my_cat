import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mood_press/screen/home/widget/input_info_mood_widget.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

import '../../../providers/emoji_provider.dart';
import '../../../ulti/constant.dart';
import '../../../generated/l10n.dart';

class AIMoodSuggestionScreen extends StatefulWidget {
  final DateTime? date;
  const AIMoodSuggestionScreen({super.key, this.date});

  @override
  _AIMoodSuggestionScreenState createState() => _AIMoodSuggestionScreenState();
}

class _AIMoodSuggestionScreenState extends State<AIMoodSuggestionScreen> {
  final TextEditingController _textController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();

  final RxBool _isListening = false.obs;
  final RxBool _isLoading = false.obs;
  final RxString _recognizedText = ''.obs;

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(right: 6),
          child: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: FaIcon(FontAwesomeIcons.arrowLeft,color: Colors.grey.shade400,)
          ),
        ),
        title: Text(
          S.of(context).listening_corner,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).tell_ai_your_story,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).ai_analyze_description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _textController,
                maxLines: 8,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: S.of(context).story_input_placeholder,
                  hintStyle: const TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: GestureDetector(
                onTap: ()=> _startListening(),
                child: Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _isListening.value ? Colors.red : Colors.blue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isListening.value ? Colors.red : Colors.blue).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: _isListening.value ? 5 : 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isListening.value ? Icons.mic : Icons.mic_none,
                    color: Colors.white,
                    size: 30,
                  ),
                )),
              ),
            ),

            const SizedBox(height: 10),
            Center(
              child: Obx(() => Text(
                _isListening.value
                    ? S.of(context).listening_status
                    : S.of(context).tap_to_speak,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              )),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                onPressed: _isLoading.value ? null : _analyzeAndSuggest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).splashColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: _isLoading.value
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      S.of(context).ai_thinking,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.psychology, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      S.of(context).analyze_button,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _speech.cancel();
    _isListening.close();
    _isLoading.close();
    _recognizedText.close();
    super.dispose();
  }

  void _initializeSpeech() async {
    await _requestMicrophonePermission();
    await _speech.initialize();
  }

  void _startListening() async {
    bool hasPermission = await _requestMicrophonePermission();
    if (!hasPermission) {
      return;
    }
    if (!_isListening.value) {
      bool available = await _speech.initialize();
      if (available) {
        _isListening.value = true;
        _speech.listen(
          onResult: (result) {
            _recognizedText.value = result.recognizedWords;
            _textController.text = _recognizedText.value;
          },
          localeId: 'vi_VN',
        );
      }
    } else {
      _isListening.value = false;
      _speech.stop();
    }
  }

  void _analyzeAndSuggest() async {
    if (_textController.text.trim().isEmpty) {
      showCustomToast(
          context: context,
          message: S.of(context).empty_story_toast
      );
      return;
    }
    _isLoading.value = true;
    String value = await context.read<EmojiProvider>().suggestEmotion(_textController.text, context);
    int? moodIndex = Constant.emojiNames[Get.locale!.languageCode]?.indexOf(value);
    _showSuggestionDialog(moodIndex ?? 0);
    _isLoading.value = false;
  }

  Future<bool> _requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      _showPermissionDeniedDialog();
      return false;
    }
    return true;
  }

  void _showSuggestionDialog(int moodIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D2D2D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            S.of(context).ai_suggestion_title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).ai_suggestion_content,
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Consumer<EmojiProvider>(builder: (context,emojiProvider,_){
                return emojiProvider.currentEmojiList[moodIndex].svg(width: 60,height: 60);
              }),
              const SizedBox(height: 8),
              Text(
                Constant.emojiNames[Get.locale!.languageCode]![moodIndex],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w600),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                S.of(context).choose_again_button,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.off(() => InputInfoMoodWidget(moodIndex: moodIndex, date: widget.date ?? DateTime.now()));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                S.of(context).select_emotion_button,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D2D2D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            S.of(context).permission_required_title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            S.of(context).permission_required_content,
            style: const TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                S.of(context).cancel_button,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).splashColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                S.of(context).open_settings_button,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}