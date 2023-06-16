import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';
import '../respositories/todo_repository.dart';

class TodoController {
  final ProviderRef ref;

  TodoController(this.ref);

  List<Todo> getTodos() {
    List<Todo> todos = ref.watch(todoRepositoryProvider);
    return todos;
  }

  void addTodo(String title) {
    DateTime time = DateTime.now();
    final todo = Todo(title: title, id: time.toString(), time: time);
    ref.read(todoRepositoryProvider.notifier).addTodo(todo);
  }

  void removeTodo() {}

  void toggleTodo() {}
}

final todoControllerProvider = Provider<TodoController>((ref) {
  return TodoController(ref);
});
