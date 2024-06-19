import 'dart:convert';

class Mood {
  int? id;
  int mood;
  String? note;
  DateTime date;
  String? location;
  List<String>? imagePath;

  Mood({
    this.id,
    required this.mood,
    this.note,
    required this.date,
    this.location,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mood': mood,
      'note': note,
      'date': date.toIso8601String(),
      'location': location,
      'imagePath': imagePath?.join(","),
    };
  }

  @override
  String toString() {
    return 'Mood{id: $id, mood: $mood, note: $note, date: $date, location: $location, imagePath: $imagePath}';
  }

  static Mood fromMap(Map<String, dynamic> map) {
    return Mood(
      id: map['id'],
      mood: map['mood'],
      note: map['note'],
      date: DateTime.parse(map['date']),
      location: map['location'],
      imagePath: map['imagePath'] != null ? map['imagePath'].split(",") : [],
    );
  }
}
