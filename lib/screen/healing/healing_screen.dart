import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/model/audio_model.dart';
import 'package:mood_press/providers/healing_provider.dart';
import 'package:mood_press/screen/healing/all_screen.dart';
import 'package:mood_press/screen/healing/music_screen.dart';
import 'package:mood_press/screen/healing/self_care_screen.dart';
import 'package:mood_press/screen/healing/test_screen.dart';
import 'package:mood_press/screen/healing/widget/item_current_audio.dart';
import 'package:provider/provider.dart';

import '../../gen/colors.gen.dart';

class HealingScreen extends StatefulWidget {
  const HealingScreen({super.key});

  @override
  State<HealingScreen> createState() => _HealingScreenState();
}

class _HealingScreenState extends State<HealingScreen>  with TickerProviderStateMixin{

  late TabController tabController;
  var showTab = false.obs;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.colorPrimary,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text('Khám phá'),
                pinned: true,
                floating: true,
                backgroundColor: ColorName.colorPrimary,
                bottom: TabBar(
                    controller: tabController,
                    isScrollable: true,
                    indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0, color: Colors.blue),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const [
                      Tab(text: "Tất cả",),
                      Tab(text: "Âm thanh thư giãn",),
                      Tab(text: "Tự chăm sóc",),
                      Tab(text: "Bài kiểm tra",),
                    ]
                ),
              )
            ];
          },
          body: Stack(
            children: [
              TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  AllScreen(),
                  MusicScreen(),
                  SelfCareScreen(),
                  TestScreen(),
                ]
              ),
              Positioned(
                bottom: 36,
                left: 0,
                right: 0,
                child: Selector<HealingProvider,AudioModel?>(
                    builder: (context,audio,child){
                      if(audio != null){
                        return ItemCurrentAudio(audio: audio);
                      }
                      else {
                        return const SizedBox();
                      }
                    }, 
                    selector: (_,provider) => provider.currentAudio 
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
