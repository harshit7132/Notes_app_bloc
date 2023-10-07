part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  List<noteModel> arrnotes;
  NotesLoaded({required this.arrnotes});
}

class NotesError extends NotesState {
  String errorMsg;
  NotesError({required this.errorMsg});
}
