import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/note.dart';

class NoteRepository extends StateNotifier<List<Note>> {
  NoteRepository() : super([]) {
    loadNotes();
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedNotes = prefs.getString('notes');
    if (encodedNotes != null) {
      final decodedNotes = jsonDecode(encodedNotes) as List<dynamic>;
      state = decodedNotes.map((json) => Note.fromJson(json)).toList();
    }
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedNotes =
        jsonEncode(notes.map((note) => note.toJson()).toList());
    await prefs.setString('notes', encodedNotes);
  }

  @override
  set state(List<Note> newState) {
    super.state = newState;
    saveNotes(newState);
  }

  void addNote(String text) {
    final note = Note(id: DateTime.now().toString(), text: text);
    state = [note, ...state];
  }

  void removeNote(String id) {
    state = [
      for (final note in state)
        if (note.id != id) note
    ];
  }

  void editNote(String id, String text) {
    state = [
      for (final note in state)
        if (note.id == id) note.copyWith(text: text) else note
    ];
  }
}

final noteRepositoryProvider =
    StateNotifierProvider<NoteRepository, List<Note>>((ref) {
  return NoteRepository();
});
