import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/mood.dart';

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
        imagePath TEXT
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

  Future<void> removeAllMoods() async {
    final db = await database;
    await db.delete('moods');
  }
}