part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class AddNotesEvent extends NotesEvent {
  noteModel newNotes;
  AddNotesEvent({required this.newNotes});
}

class FetchNotesEvent extends NotesEvent {}

class updateNotesEvent extends NotesEvent {
  int id;
 String title;
 String desc;
  updateNotesEvent({required this.title,required this.desc, required this.id});
}

class deleteNotesEvent extends NotesEvent {
  int id;
  deleteNotesEvent({required this.id});
}
