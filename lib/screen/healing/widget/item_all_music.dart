import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/model/audio_model.dart';
import 'package:mood_press/helper/audio_handler.dart';
import 'package:mood_press/providers/healing_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ItemAllMusic extends StatelessWidget {
  final AudioModel audioModel;
  const ItemAllMusic(this.audioModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final byteData = await rootBundle.load(audioModel.path);
        final file = File('${(await getTemporaryDirectory()).path}/${audioModel.id}.mp3');
        await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
        Get.find<AudioPlayerHandler>().playMediaItem(
            MediaItem(id: file.path, title: audioModel.name, extras: {'isLocal': true},)
        ).then((_){
          context.read<HealingProvider>().setCurrentAudio(audioModel);
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Colors.blueGrey.withBlue(140),
                  width: 3
              )
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(audioModel.image,height: 80,width: 80,fit: BoxFit.cover,),
              ),
              const SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(audioModel.name,style: TextStyle(color: Colors.blueGrey.shade100,fontWeight: FontWeight.w800,fontSize: 16),),
                  const SizedBox(height: 2,),
                  Text(audioModel.type.displayName,style: TextStyle(color: Colors.grey.shade400),),
                ],
              )
            ],
          )
      ),
    );
  }
}
