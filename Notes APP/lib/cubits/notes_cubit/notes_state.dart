part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}
class NotesSuccess extends NotesState {}
class NotesDeleteDone extends NotesState{}
class FoundNote extends NotesState{}
class Clearfound extends NotesState{}
class NotFound extends NotesState{}
class SnackBarShown extends NotesState{}
class VisibleSnackBar extends NotesState{}