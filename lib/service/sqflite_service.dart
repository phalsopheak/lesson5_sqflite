import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io';

class SqfliteService {
  SqfliteService._();
  static final SqfliteService instance = SqfliteService._();

  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDB();
    }
    return _database;
  }

  _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'mydb2.db';

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tbl_category (id INTEGER PRIMARY KEY AUTOINCREMENT,
                              category_name TEXT)
    ''');
  }

  Future<int> create(Map<String, dynamic> data, String tableName) async {
    Database db = await instance.database;
    return await db.insert(tableName, data);
  }

  Future<List<Map<String, dynamic>>> read(
      {String tableName, int id = 0}) async {
    Database db = await instance.database;
    if (id == 0) {
      return await db.query(tableName);
    } else {
      return await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    }
  }

  Future<int> update(Map<String, dynamic> data, String tableName) async {
    Database db = await instance.database;
    int id = data['id'];
    return await db.update(tableName, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id, String tableName) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
