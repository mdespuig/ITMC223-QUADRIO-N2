import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*
  Authored by: Matt Despuig
  Company: Quadr.io
  Project: Who?/Luh!
  Feature: [WL-013]: Admin Page
  Description: As an administrator, I should be able to store user details of my app in a reliable and secure database.
*/

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL DEFAULT 0';

    await db.execute('''
    CREATE TABLE users (
      id $idType,
      username $textType,
      password $textType,
      email $textType,
      total_points $intType
    )
    ''');
  }

  Future _updateDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE users ADD COLUMN total_points INTEGER NOT NULL DEFAULT 0');
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _updateDB,
    );
  }

  Future<int> registerUser(String username, String password, String email) async {
    final db = await instance.database;

    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return -1;
    }

    final user = {
      'username': username,
      'password': password,
      'email': email,
    };

    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: ['current_user'],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> updateUserPoints(String username, int points) async {
    final db = await instance.database;
    await db.update(
      'users',
      {'total_points': points},
      where: 'username = ?',
      whereArgs: [username],
    );
  }
}
