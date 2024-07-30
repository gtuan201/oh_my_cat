import 'package:flutter/material.dart';
import 'package:mood_press/screen/healing/music/widget/item_music.dart';
import 'package:provider/provider.dart';
import 'package:mood_press/data/model/audio_model.dart';
import '../../../providers/music_provider.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  MusicScreenState createState() => MusicScreenState();
}

class MusicScreenState extends State<MusicScreen> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: Selector<MusicProvider, List<AudioModel>>(
            selector: (_, musicProvider) => musicProvider.listAudio,
            builder: (context, listAudio, child) {
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.87,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) => ItemMusic(audioModel: listAudio[index]),
                  childCount: listAudio.length,
                ),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }
}