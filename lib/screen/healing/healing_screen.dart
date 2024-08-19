import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/model/audio_model.dart';
import 'package:mood_press/screen/healing/all/all_screen.dart';
import 'package:mood_press/screen/healing/music/music_screen.dart';
import 'package:provider/provider.dart';
import '../../gen/colors.gen.dart';
import '../../providers/healing_provider.dart';
import '../../providers/music_provider.dart';
import 'self_care/self_care_screen.dart';
import 'test/test_screen.dart';
import 'widget/item_current_audio.dart';

class HealingScreen extends StatefulWidget {
  const HealingScreen({super.key});

  @override
  State<HealingScreen> createState() => _HealingScreenState();
}

class _HealingScreenState extends State<HealingScreen> with TickerProviderStateMixin {
  late TabController tabController;
  RxInt musicSelectedIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
  late TabController _musicTabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    _musicTabController = TabController(length: AudioType.values.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('Khám phá'),
              centerTitle: true,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: Theme.of(context).primaryColor,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(context.watch<MusicProvider>().toolbarHeight),
                child: Column(
                  children: [
                    TabBar(
                        controller: tabController,
                        isScrollable: true,
                        indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide(width: 4.0, color: Colors.blue),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                        ),
                        onTap: (i){
                          selectedIndex.value = i;
                          context.read<MusicProvider>().updateToolbarHeight(i == 1 ? 118 : 48);
                        },
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: const [
                          Tab(text: "Tất cả"),
                          Tab(text: "Âm thanh thư giãn"),
                          Tab(text: "Tự chăm sóc"),
                          Tab(text: "Bài kiểm tra"),
                        ]
                    ),
                    Obx(() => Visibility(
                      visible: selectedIndex.value == 1,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: ButtonsTabBar(
                          buttonMargin: const EdgeInsets.symmetric(horizontal: 16),
                          unselectedBorderColor: Colors.blueGrey,
                          borderWidth: 1.5,
                          radius: 12,
                          controller: _musicTabController,
                          unselectedDecoration: const BoxDecoration(
                            color: ColorName.colorPrimary,
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.blue
                          ),
                          onTap: (i) {
                            musicSelectedIndex.value = i;
                            context.read<MusicProvider>().changeTypeListAudio(AudioType.values[i]);
                          },
                          tabs: AudioType.values.map((type) => Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Obx(() => Row(
                                children: [
                                  if(musicSelectedIndex.value == AudioType.values.indexOf(type))
                                    Container(
                                        margin: const EdgeInsets.only(right: 6),
                                        child: const Icon(Icons.check, size: 18,)),
                                  Text(type.displayName, style: const TextStyle(fontWeight: FontWeight.w600),),
                                ],
                              )),
                            ),
                          )).toList(),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children:  [
                  AllScreen(changeTab: (i) => changeTab(i)),
                  const MusicScreen(),
                  const SelfCareScreen(),
                  const TestScreen(),
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
    );
  }
  void changeTab(int index){
    selectedIndex.value = index;
    context.read<MusicProvider>().updateToolbarHeight(index == 1 ? 118 : 48);
    tabController.animateTo(index);
  }
}
