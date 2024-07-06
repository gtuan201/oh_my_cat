import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mood_press/data/model/audio_model.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/helper/audio_handler.dart';

class ItemCurrentAudio extends StatelessWidget {
  final AudioModel audio;
  const ItemCurrentAudio({super.key, required this.audio});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: ColorName.darkBlue.withOpacity(0.6),
          border: Border.all(color: Colors.blueGrey,width: 2),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(audio.name,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 16),),
              const SizedBox(height: 4,),
              Text(audio.type.displayName,style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w600),),
            ],
          ),
          const Spacer(),
          StreamBuilder(
              stream: Get.find<AudioPlayerHandler>().loopStream,
              builder: (context,snapshot){
                final loopMode = snapshot.data;
                return InkWell(
                    onTap: () async {
                      await Get.find<AudioHandler>().customAction('toggleLoop');
                    },
                    child: Icon(
                      Icons.loop,
                      color: loopMode == LoopMode.one ? Colors.lightBlue : Colors.white,
                    )
                );
              }
          ),
          const SizedBox(width: 20,),
          StreamBuilder(
              stream: Get.find<AudioHandler>().playbackState,
              builder: (context,snapshot){
                final playing = snapshot.data?.playing ?? false;
                return InkWell(
                  onTap: (){
                    playing ? Get.find<AudioHandler>().pause() : Get.find<AudioHandler>().play();
                  },
                  child: Icon(
                    playing ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  )
                );
              }
          ),
          StreamBuilder(
              stream: Get.find<AudioHandler>().playbackState,
              builder: (context,snapshot){
                final processState = snapshot.data?.processingState;
                  return processState != AudioProcessingState.idle ? Row(
                    children: [
                      const SizedBox(width: 20,),
                      InkWell(
                          onTap: (){
                            Get.find<AudioHandler>().stop();
                          },
                          child: const Icon(
                            Icons.stop,
                            color: Colors.white,
                          )
                      ),
                    ],
                  ) : const SizedBox();
              }
          ),
        ],
      ),
    );
  }
}
