enum AudioType {
  all,
  animal,
  nature,
  musical,
  meditation;

  static const Map<AudioType, Map<String, String>> displayNames = {
    AudioType.all: {
      'vi': 'Tất cả',
      'en': 'All',
    },
    AudioType.animal: {
      'vi': 'Động vật',
      'en': 'Animals',
    },
    AudioType.nature: {
      'vi': 'Thiên nhiên',
      'en': 'Nature',
    },
    AudioType.musical: {
      'vi': 'Âm nhạc',
      'en': 'Music',
    },
    AudioType.meditation: {
      'vi': 'Thiền',
      'en': 'Meditation',
    },
  };

  String getDisplayName(String langCode) {
    return displayNames[this]?[langCode] ?? displayNames[this]!['vi']!;
  }
}


class AudioModel {
  final String id;
  final String path;
  final String image;
  final AudioType type;
  final Map<String, String> name;

  AudioModel({
    required this.id,
    required this.path,
    required this.image,
    required this.type,
    required this.name,
  });

  String getLocalizedName(String languageCode) {
    return name[languageCode] ?? name['en'] ?? '';
  }
}