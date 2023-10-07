import 'dart:io';
import 'package:notes_app_bloc/NotesModel/notes_Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB_helper {
  //for singleton database class
  DB_helper._();
  static final DB_helper db = DB_helper._();

  //database variable
  Database? _database;

  //note
  static final Note_Table = 'note';
  static final Note_COLUMN_ID = 'note_Id';
  static final Note_COLUMN_TITLE = 'title';
  static final Note_COLUMN_DESC = 'desc';

  Future<Database> getDB() async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDB();
      return _database!;
    }
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    var dbPath = join(documentDirectory.path, 'noteDB.db');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      //creating database
      db.execute(
          'Create table $Note_Table ($Note_COLUMN_ID integer primary key autoincrement, $Note_COLUMN_TITLE text, $Note_COLUMN_DESC text)');
    });
  }

  Future<bool> addNotes(noteModel note) async {
    var db = await getDB();

    int rowEffects = await db.insert(Note_Table, note.toMap());

    return rowEffects > 0;
  }

  Future<List<noteModel>> fetchAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> notes = await db.query(Note_Table);
    List<noteModel> Listnotes = [];

    for (Map<String, dynamic> note in notes) {
      noteModel model = noteModel.fromMap(note);
      Listnotes.add(model);
    }
    return Listnotes;
  }

  Future<bool> updateNotes(noteModel note) async {
    var db = await getDB();
    var count = await db.update(Note_Table, note.toMap(),
        where: "$Note_COLUMN_ID = ${note.note_id}");
    return count > 0;
  }

  Future<bool> deleteNotes(int id) async {
    var db = await getDB();
    var count1 = await db.delete(Note_Table,
        where: "$Note_COLUMN_ID = ?", whereArgs: [id.toString()]);
    return count1 > 0;
  }
}
