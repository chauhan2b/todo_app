// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';

class TodoRepository extends StateNotifier<List<Todo>> {
  TodoRepository() : super([]);

  void addTodo(Todo todo) {
    state = [todo, ...state];
  }

  void removeTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id != id) todo
    ];
  }

  void editTodo(String id, String title) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(title: title) else todo
    ];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo
    ];
  }
}

final todoRepositoryProvider =
    StateNotifierProvider<TodoRepository, List<Todo>>((ref) {
  return TodoRepository();
});
