import 'package:flutter/material.dart';

class Reminder {
  int? id;
  String title;
  String body;
  bool enable;
  TimeOfDay time;
  bool isDefault;

  Reminder({
    this.id,
    required this.title,
    required this.body,
    this.enable = true,
    required this.time,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'enable': enable ? 1 : 0,
      'time': '${time.hour}:${time.minute}',
      'isDefault': isDefault ? 1 : 0,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    final timeParts = map['time'].split(':');
    return Reminder(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      enable: map['enable'] == 1,
      time: TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1])),
      isDefault: map['isDefault'] == 1,
    );
  }
}