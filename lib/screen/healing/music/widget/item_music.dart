import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/model/audio_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/healing_provider.dart';
import '../../../../ulti/function.dart';

class ItemMusic extends StatelessWidget {
  final AudioModel audioModel;
  const ItemMusic({super.key, required this.audioModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final byteData = await rootBundle.load(audioModel.path);
        final file = File('${(await getTemporaryDirectory()).path}/${audioModel.id}.mp3');
        await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

        Get.find<AudioHandler>().playMediaItem(
            MediaItem(
                id: file.path,
                title: audioModel.name,
                extras: {'isLocal': true},
                artist: audioModel.type.displayName,
                artUri: Uri.file(await getLocalImagePath(audioModel.image)),
                duration: await getAudioDuration(file.path)
            )
        ).then((_){
          context.read<HealingProvider>().setCurrentAudio(audioModel);
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueGrey, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                audioModel.image,
                height: 110,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            audioModel.name,
            style: TextStyle(color: Colors.blueGrey.shade100),
          ),
        ],
      ),
    );
  }
}
