import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app_bloc/DataBase/DB_Helper.dart';
import 'package:notes_app_bloc/NotesModel/notes_Model.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  DB_helper db;

  NotesBloc({required this.db}) : super(NotesInitial()) {
    //to Add Notes
    on<AddNotesEvent>((event, emit) async {
      emit(NotesLoading());
      bool check = await db.addNotes(event.newNotes);
      if (check) {
        var arrnotes = await db.fetchAllNotes();
        emit(NotesLoaded(arrnotes: arrnotes));
      } else {
        emit(NotesError(errorMsg: 'Notes Not Added'));
      }
    });

    //get all notes
    on<FetchNotesEvent>((event, emit) async {
      emit(NotesLoading());
      var arrNotes = await db.fetchAllNotes();
      emit(NotesLoaded(arrnotes: arrNotes));
    });

    //delete notes
    on<deleteNotesEvent>((event, emit) async {
      emit(NotesLoading());
      await db.deleteNotes(event.id);
      var arrNotes = await db.fetchAllNotes();
      emit(NotesLoaded(arrnotes: arrNotes));
    });

    //update notes
    on<updateNotesEvent>((event, emit) async {
      emit(NotesLoading());
      await db.updateNotes(noteModel(note_id: event.id,title: event.title, desc: event.desc));
      var arrNotes = await db.fetchAllNotes();
      emit(NotesLoaded(arrnotes: arrNotes));
    });
  }
}
