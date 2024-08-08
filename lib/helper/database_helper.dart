import 'dart:convert';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../data/model/mood.dart';
import '../data/model/reminder.dart';
import '../data/model/test.dart';

class DatabaseHelper{
  static Database? _database;
  static const int DEFAULT_REMINDER_ID = 0;
  DatabaseHelper(){
    database;
  }
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'moods.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''CREATE TABLE moods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mood INTEGER,
        note TEXT,
        date TEXT,
        location TEXT,
        imagePath TEXT,
        isSpecial INTEGER,
        align INTEGER
      )''');

    await db.execute('''CREATE TABLE tests (
        id TEXT,
        title TEXT,
        description TEXT,
        source TEXT,
        imageUrl TEXT,
        note TEXT,
        questions TEXT,
        conclude TEXT,
        dateCompleted TEXT PRIMARY KEY
      )''');

    await db.execute('''CREATE TABLE reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        enable INTEGER,
        time TEXT,
        isDefault INTEGER
      )''');

    await db.insert('reminders', {
      'id': DEFAULT_REMINDER_ID,
      'title': 'Viết nhật ký',
      'body': 'Hôm nay tâm tâm trạng của bạn như thế nào? Hãy thêm nhật ký ngày hôm nay nhé!',
      'enable': 0,
      'time': '20:00',
      'isDefault': 1
    });
  }
  Future<void> insertMood(Mood mood) async {
    final db = await database;
    await db.insert(
      'moods',
      mood.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Mood>> getMoods() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('moods');

    return List.generate(maps.length, (i) {
      return Mood.fromMap(maps[i]);
    });
  }

  Future<void> updateMood(Mood mood) async {
    final db = await database;
    await db.update(
      'moods',
      mood.toMap(),
      where: 'id = ?',
      whereArgs: [mood.id],
    );
  }

  Future<void> deleteMood(int id) async {
    final db = await database;
    await db.delete(
      'moods',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Mood?> getMood(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'moods',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Mood.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Mood?> getMoodFromDate(String date) async {
    final db = await database;
    final DateTime targetDate = DateTime.parse(date);

    final List<Map<String, dynamic>> maps = await db.query('moods');

    for (var map in maps) {
      final DateTime moodDate = DateTime.parse(map['date']);
      if (moodDate.year == targetDate.year &&
          moodDate.month == targetDate.month &&
          moodDate.day == targetDate.day) {
        return Mood.fromMap(map);
      }
    }
    return null;
  }

  Future<List<Mood>> getListMoodFromDate(String date) async {
    final db = await database;
    final DateTime targetDate = DateTime.parse(date);
    List<Mood> listMood = [];

    final List<Map<String, dynamic>> maps = await db.query('moods');

    for (var map in maps) {
      final DateTime moodDate = DateTime.parse(map['date']);
      if (moodDate.year == targetDate.year &&
          moodDate.month == targetDate.month &&
          moodDate.day == targetDate.day) {
        listMood.add(Mood.fromMap(map));
      }
    }
    return listMood;
  }

  Future<void> removeAllMoods() async {
    final db = await database;
    await db.delete('moods');
  }

  Future<void> insertTest(Test test) async {
    final db = await database;
    await db.insert(
      'tests',
      test.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Test>> getTests() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tests');

    return List.generate(maps.length, (i) {
      return Test.fromJson(maps[i]);
    });
  }

  Future<Test?> getTest(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tests',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Test.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<void> updateTest(Test test) async {
    final db = await database;
    await db.update(
      'tests',
      test.toMap(),
      where: 'id = ?',
      whereArgs: [test.id],
    );
  }

  Future<void> deleteTest(String id) async {
    final db = await database;
    await db.delete(
      'tests',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertReminder(Reminder reminder) async {
    final db = await database;
    await db.insert(
      'reminders',
      reminder.toMap()..['isDefault'] = 0,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Reminder>> getReminders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reminders', orderBy: 'isDefault DESC, time ASC');

    return List.generate(maps.length, (i) {
      return Reminder.fromMap(maps[i]);
    });
  }

  Future<Reminder?> getReminder(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'reminders',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Reminder.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> updateReminder(Reminder reminder) async {
    final db = await database;
    await db.update(
      'reminders',
      reminder.toMap(),
      where: 'id = ?',
      whereArgs: [reminder.id],
    );
  }

  Future<void> deleteReminder(int id) async {
    if (id == DEFAULT_REMINDER_ID) {
      throw Exception('Không thể xóa bản ghi mặc định');
    }
    final db = await database;
    await db.delete(
      'reminders',
      where: 'id = ? AND isDefault = 0',
      whereArgs: [id],
    );
  }

  Future<String> getDataAsJsonString() async {
    final db = await database;

    final List<Map<String, dynamic>> moods = await db.query('moods');
    final List<Map<String, dynamic>> tests = await db.query('tests');
    final List<Map<String, dynamic>> reminders = await db.query('reminders');


    final Map<String, dynamic> allData = {
      'moods': moods,
      'tests': tests,
      'reminders': reminders,
    };
    return jsonEncode(allData);
  }

  Future<void> updateDatabaseFromJsonString(String jsonString) async {
    final db = await database;
    final Map<String, dynamic> allData = jsonDecode(jsonString);

    await db.transaction((txn) async {
      if (allData.containsKey('moods')) {
        await txn.delete('moods');
        for (var mood in allData['moods']) {
          await txn.insert('moods', mood);
        }
      }

      if (allData.containsKey('tests')) {
        await txn.delete('tests');
        for (var test in allData['tests']) {
          await txn.insert('tests', test);
        }
      }

      if (allData.containsKey('reminders')) {
        await txn.delete('reminders');
        for (var reminder in allData['reminders']) {
          await txn.insert('reminders', reminder);
        }
      }
    });
  }
}