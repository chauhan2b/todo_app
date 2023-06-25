import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';
import '../repositories/todo_repository.dart';

class TodoController {
  final ProviderRef ref;

  TodoController(this.ref);

  List<Todo> getTodos() {
    List<Todo> todos = ref.watch(todoRepositoryProvider);
    return todos;
  }

  void addTodo(String title) {
    if (title == '') {
      return;
    }
    DateTime time = DateTime.now();
    final todo = Todo(title: title, id: time.toString(), time: time);
    ref.read(todoRepositoryProvider.notifier).addTodo(todo);
  }

  void removeTodo(String id) {
    ref.read(todoRepositoryProvider.notifier).removeTodo(id);
  }

  void editTodo(String id, String title) {
    ref.read(todoRepositoryProvider.notifier).editTodo(id, title);
  }

  void toggleTodo(String id) {
    ref.read(todoRepositoryProvider.notifier).toggleTodo(id);
  }
}

final todoControllerProvider = Provider<TodoController>((ref) {
  return TodoController(ref);
});
