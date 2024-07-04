import 'package:mood_press/gen/assets.gen.dart';

import '../data/model/audio_model.dart';

class Audio{
  static List<AudioModel> listAudio = [
    AudioModel(id: "1", path: Assets.audio.catSound, image: Assets.image.cat.path, type: AudioType.animal, name: 'Âm thanh của mèo'),
    AudioModel(id: "2", path: Assets.audio.fireplaceSound, image: Assets.image.fireplace.path, type: AudioType.nature, name: 'Lò sưởi'),
    AudioModel(id: "3", path: Assets.audio.forestSound, image: Assets.image.forest.path, type: AudioType.nature, name: 'Rừng'),
    AudioModel(id: "4", path: Assets.audio.guitarSound, image: Assets.image.guitar.path, type: AudioType.musical, name: 'Guitar'),
    AudioModel(id: "5", path: Assets.audio.pianoSound, image: Assets.image.piano.path, type: AudioType.musical, name: 'Piano'),
    AudioModel(id: "6", path: Assets.audio.saxophone, image: Assets.image.saxophone.path, type: AudioType.musical, name: 'Saxophone'),
    AudioModel(id: "7", path: Assets.audio.rainSound, image: Assets.image.rain.path, type: AudioType.nature, name: 'Mưa'),
    AudioModel(id: "8", path: Assets.audio.suthanhhoa, image: Assets.image.suthanhhoa.path, type: AudioType.musical, name: 'Sáo trúc'),
    AudioModel(id: "9", path: Assets.audio.waveSound, image: Assets.image.wave.path, type: AudioType.nature, name: 'Tiếng sóng'),
  ];
}