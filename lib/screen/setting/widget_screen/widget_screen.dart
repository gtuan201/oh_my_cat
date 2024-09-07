import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:video_player/video_player.dart';

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
    _controller = VideoPlayerController.asset(Assets.video.previewVideo)..initialize().then((_) {
      setState(() {
        _controller.play();
      });
    })
    ..setVolume(0)
    ..setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text('Widget'),
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
                      child: VideoPlayer(_controller)
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text('Hướng dẫn thêm widget vào màn hình chính của bạn',style: TextStyle(color: Colors.white,fontSize: 16),),
              const SizedBox(height: 20,),
              const Text('1. Ở màn hình chính, nhấn và giữ ở một vùng trống cho tới khi một menu xuất hiện.',style: TextStyle(color: Colors.white),),
              const SizedBox(height: 10,),
              const Text('2. Nhấn vào Widget.',style: TextStyle(color: Colors.white),),
              const SizedBox(height: 10,),
              const Text('3. Tìm widgets được cung cấp bởi Oh My Cat. Nhấn và giữ widget mà bạn muốn thêm, rồi kéo và thả widget đến vùng thích hợp.',style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
