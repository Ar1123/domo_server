import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
export 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqflite {
  static late Database _database;

  static final Sqflite db = Sqflite._();

  Sqflite._();

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    _database = await initDB();
    if (_database.path.isNotEmpty) return _database;

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'DomoDBServer.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE City ('
          ' id TEXT PRIMARY KEY,'
          ' city TEXT,'
          ' departamento TEXT'
          ')');
    });
  }

  Future<int> insert(
      {required Map<String, dynamic> data, required String table}) async {
    final db = await database;
    final result = await db.insert(
      table,
      data,
    );
    return result;
  }

  Future<dynamic> getById(
      {required List<dynamic> arg,
      required String params,
      required String table}) async {
    final db = await database;
    final result = await db.query(
      table,
      where: params,
      whereArgs: arg,
    );

    return result;
  }

  Future<List<dynamic>> getById2({
    required String sql,
  }) async {
    final db = await database;

    final result = await db.rawQuery(sql);
    return result;
  }

  Future<List<dynamic>> getAll({required String table}) async {
    final db = await database;
    final result = await db.query(
      table,
    );
    return result;
  }

  Future<int> updateData(
      {required List<dynamic> args,
      required String params,
      required String table,
      required Map<String, dynamic> data}) async {
    final db = await database;
    final result = await db.update(
      table,
      data,
      where: params,
      whereArgs: args,
    );
    return result;
  }
}
