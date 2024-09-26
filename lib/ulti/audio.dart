import 'package:mood_press/gen/assets.gen.dart';

import '../data/model/audio_model.dart';

class Audio {
  static List<AudioModel> listAudio = [
    AudioModel(
      id: "1",
      path: Assets.audio.catSound,
      image: Assets.image.cat.path,
      type: AudioType.animal,
      name: {
        'en': 'Cat Sound',
        'vi': 'Âm thanh của mèo',
      },
    ),
    AudioModel(
      id: "2",
      path: Assets.audio.fireplaceSound,
      image: Assets.image.fireplace.path,
      type: AudioType.nature,
      name: {
        'en': 'Fireplace',
        'vi': 'Lò sưởi',
      },
    ),
    AudioModel(
      id: "3",
      path: Assets.audio.forestSound,
      image: Assets.image.forest.path,
      type: AudioType.nature,
      name: {
        'en': 'Forest',
        'vi': 'Rừng',
      },
    ),
    AudioModel(
      id: "4",
      path: Assets.audio.guitarSound,
      image: Assets.image.guitar.path,
      type: AudioType.musical,
      name: {
        'en': 'Guitar',
        'vi': 'Guitar',
      },
    ),
    AudioModel(
      id: "5",
      path: Assets.audio.pianoSound,
      image: Assets.image.piano.path,
      type: AudioType.musical,
      name: {
        'en': 'Piano',
        'vi': 'Piano',
      },
    ),
    AudioModel(
      id: "6",
      path: Assets.audio.saxophone,
      image: Assets.image.saxophone.path,
      type: AudioType.musical,
      name: {
        'en': 'Saxophone',
        'vi': 'Saxophone',
      },
    ),
    AudioModel(
      id: "7",
      path: Assets.audio.rainSound,
      image: Assets.image.rain.path,
      type: AudioType.nature,
      name: {
        'en': 'Rain',
        'vi': 'Mưa',
      },
    ),
    AudioModel(
      id: "8",
      path: Assets.audio.suthanhhoa,
      image: Assets.image.suthanhhoa.path,
      type: AudioType.musical,
      name: {
        'en': 'Bamboo Flute',
        'vi': 'Sáo trúc',
      },
    ),
    AudioModel(
      id: "9",
      path: Assets.audio.waveSound,
      image: Assets.image.wave.path,
      type: AudioType.nature,
      name: {
        'en': 'Wave Sound',
        'vi': 'Tiếng sóng',
      },
    ),
  ];
}