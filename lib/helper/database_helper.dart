import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/model/mood.dart';
import '../data/model/test.dart';

class DatabaseHelper{
  static Database? _database;
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
}