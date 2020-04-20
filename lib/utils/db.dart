import 'dart:async';

import 'package:cdmtarefass/models/base_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static int get _versionDB => 1;
  static Database _dbInstance;

  static Future<void> init() async {
    if (_dbInstance != null) return;

    String _pathDB = await getDatabasesPath() + 'tarefas.db';
    _dbInstance = await openDatabase(
      _pathDB,
      version: _versionDB,
      onCreate: _onCreate,
    );
  }

  static FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE tarefas (id INTEGER PRIMARY KEY NOT NULL, '
        'tarefa STRING, completo BOOLEAN)');
  }
  
  static Future<int> insert(String table, BaseModel model) async =>
      await _dbInstance.insert(table, model.toMap());

  static Future<int> delete(String table, BaseModel model) async =>
      await _dbInstance.delete(table, where: 'id = ?', whereArgs: [model.id]);

  static Future<int> update(String table, BaseModel model) async =>
      await _dbInstance
          .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<List<Map<String, dynamic>>> query(
          String sql, List<dynamic> args) async =>
      await _dbInstance.rawQuery(sql, args);

}