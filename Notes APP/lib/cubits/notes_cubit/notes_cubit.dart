import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/views/searchview.dart';

import '../../constants.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<NoteModel>? notes;
  fetchAllNotes() {
    var notesBox = Hive.box<NoteModel>(kNotesBox);

    notes = notesBox.values.toList();

    emit(NotesSuccess());
  }

  deletenote(int index) {
    notes![index].delete();
  }

// notes![i].subTitle.contains(value) ||
//           notes![i].title.contains(value)
  foundornot(String value) {
    for (int i = 0; i < notes!.length; i++) {
      if (('${notes![i].title} ${notes![i].subTitle}').contains(value)) {
        if (!found.contains(i)) {
          found.add(i);
          emit(FoundNote());
        }
      } else {
        clearfound();
      }
    }
  }

  clearfound() {
    found.clear();
    emit(NotFound());
  }

  snackbar(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 1000),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Copied to Clipboard '),
                Icon(Icons.done, color: Colors.green),
              ],
            ),
          ),
        )
        .closed
        .then((_) {
      isSnackBarVisible = false;
      emit(SnackBarShown());
    });
  }

  visblesnackbar() {
    isSnackBarVisible = true;
    emit(VisibleSnackBar());
  }
}
