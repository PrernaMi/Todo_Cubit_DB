import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/notes_model.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper getInstances = DbHelper._();
  static String table_notes = 'notes';
  static String table_col_title = 'title';
  static String table_col_desc = 'desc';
  static String table_col_isCompleted = 'isCom';
  static String table_col_s_no = 's_no';

  Database? mainDb;

  Future<Database> getDb() async {
    mainDb ??= await openDb();
    return mainDb!;
  }

  Future<Database> openDb() async {
    Directory myDirectory = await getApplicationDocumentsDirectory();
    String myPath = myDirectory.path;
    String rootPath = join(myPath, 'notes.db');

    return openDatabase(rootPath, version: 1, onCreate: (db, version) {
      db.rawQuery('''create table $table_notes ( 
          $table_col_s_no integer primary key autoincrement , 
          $table_col_title text, 
          $table_col_desc text,
          $table_col_isCompleted integer)''');
    });
  }

  Future<bool> addInDb(
      {required String title,
      required String desc,
      required int isComp}) async {
    var db = await getDb();
    int count = await db.insert(table_notes,
        NotesModel(title: title, desc: desc, isComp: isComp).toMap());
    return count > 0;
  }

  Future<bool> updateInDb(
      {required String title, required String desc, required int s_no}) async {
    var db = await getDb();
    int count = await db.update(
        table_notes,
        {
          table_col_title: title,
          table_col_desc: desc,
        },
        where: '$table_col_s_no = ?',
        whereArgs: [s_no]);
    return count > 0;
  }

  Future<bool> deleteFromDb({required int s_no}) async {
    var db = await getDb();
    int count = await db
        .delete(table_notes, where: '$table_col_s_no = ?', whereArgs: [s_no]);
    return count > 0;
  }

  Future<List<NotesModel>> getAllNotesFromDb() async {
    var db = await getDb();
    var allNotes = await db.query(table_notes);
    List<NotesModel> notes = [];
    for (Map<String, dynamic> eachMap in allNotes) {
      notes.add(NotesModel.fromMap(map: eachMap));
    }
    return notes;
  }

  Future<bool> addIsCompleted({required int s_no, required int isCheck}) async {
    var db = await getDb();
    int count = await db.update(
        table_notes,
        {
          table_col_isCompleted: isCheck,
        },
        where: '$table_col_s_no = ?',
        whereArgs: [s_no]);
    return count > 0;
  }

  Future<double> getIsCompleted() async {
    var db = await getDb();
    var c = await db.rawQuery(
        'select count($table_col_isCompleted) as count from $table_notes where $table_col_isCompleted = ?',
        [1]);
    int count = Sqflite.firstIntValue(c) ?? 0;
    return count.toDouble();
  }
}
