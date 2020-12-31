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
    String path = directory.path + 'mydb5.db';
    var imagePath = Directory(directory.path + '/image');
    var productPath = Directory(directory.path + '/image/product');
    if (await imagePath.exists() == false) {
      imagePath.create();
    }
    if (await productPath.exists() == false) {
      productPath.create();
    }

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tbl_category (id INTEGER PRIMARY KEY AUTOINCREMENT,
                              category_name TEXT)
    ''');

    await db.execute('''
    CREATE TABLE tbl_product (id INTEGER PRIMARY KEY AUTOINCREMENT,
                              category_id int,
                              product_code TEXT,
                              product_name TEXT,
                              product_price REAL,
                              product_picture TEXT,
                              product_description TEXT,
                              timestamp TEXT)
    ''');

    await db.execute('''
    CREATE VIEW v_list_product 
    AS 
    SELECT
	  tbl_product.id,tbl_product.category_id,
    tbl_product.product_code,tbl_product.product_name,
    tbl_product.product_price,tbl_product.product_description,
    tbl_product.product_picture,tbl_product.timestamp,
    tbl_category.category_name
    FROM
	  tbl_product INNER JOIN tbl_category 
    ON tbl_product.category_id = tbl_category.id
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
