import 'package:flutter/material.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:mood_press/providers/home_provider.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../generated/l10n.dart';

class WidgetScreen extends StatefulWidget {
  const WidgetScreen({super.key});

  @override
  State<WidgetScreen> createState() => _WidgetScreenState();
}

class _WidgetScreenState extends State<WidgetScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(context.read<HomeProvider>().listVideo[Constant.widget]))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      })
      ..setVolume(0)
      ..setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(S.of(context).widgetTitle), // S.of(context) for title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: SizedBox(
                    height: 433,
                    width: 234,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text(S.of(context).widgetInstructions, style: const TextStyle(color: Colors.white, fontSize: 16),), // S.of(context) for instructions
              const SizedBox(height: 20,),
              Text(S.of(context).widgetStep1, style: const TextStyle(color: Colors.white),), // Step 1
              const SizedBox(height: 10,),
              Text(S.of(context).widgetStep2, style: const TextStyle(color: Colors.white),), // Step 2
              const SizedBox(height: 10,),
              Text(S.of(context).widgetStep3, style: const TextStyle(color: Colors.white),), // Step 3
            ],
          ),
        ),
      ),
    );
  }
}
