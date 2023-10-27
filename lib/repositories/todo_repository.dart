// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

class TodoRepository extends StateNotifier<List<Todo>> {
  TodoRepository() : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTodos = prefs.getString('todos');
    if (encodedTodos != null) {
      final decodedTodos = jsonDecode(encodedTodos) as List<dynamic>;
      state = decodedTodos.map((json) => Todo.fromJson(json)).toList();
    }
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTodos =
        jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString('todos', encodedTodos);
  }

  @override
  set state(List<Todo> newState) {
    super.state = newState;
    saveTodos(newState);
  }

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

final finishedTodoProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoRepositoryProvider);
  return todos.where((todo) => todo.completed).toList();
});

final unfinishedTodoProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoRepositoryProvider);
  return todos.where((todo) => !todo.completed).toList();
});
