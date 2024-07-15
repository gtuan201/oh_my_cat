enum AudioType {
  all('Tất cả'),
  animal('Động vật'),
  nature('Thiên nhiên'),
  musical('Âm nhạc'),
  meditation('Thiền');

  final String displayName;
  const AudioType(this.displayName);
}

class AudioModel {
  final String id;
  final String name;
  final String path;
  final String image;
  final AudioType type;

  AudioModel({
    required this.id,
    required this.name,
    required this.path,
    required this.image,
    required this.type,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      image: json['image'],
      type: AudioType.values.firstWhere((e) => e.name == json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'image': image,
      'type': type.name,
    };
  }
}