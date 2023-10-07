import 'package:notes_app_bloc/DataBase/DB_Helper.dart';

class noteModel {
  int? note_id;
  String? title;
  String? desc;

  noteModel({ this.note_id,  this.title,  this.desc});

  //factory func = model to map
  factory noteModel.fromMap(Map<String, dynamic> map) {
    return noteModel(
      note_id: map[DB_helper.Note_COLUMN_ID],
      title: map[DB_helper.Note_COLUMN_TITLE],
      desc: map[DB_helper.Note_COLUMN_DESC],
    );
  }

  //map data from note model
  Map<String, dynamic> toMap() {
    return {
      DB_helper.Note_COLUMN_ID: note_id,
      DB_helper.Note_COLUMN_TITLE: title,
      DB_helper.Note_COLUMN_DESC: desc
    };
  }
}