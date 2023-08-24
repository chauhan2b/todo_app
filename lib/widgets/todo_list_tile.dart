import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/routing/go_router.dart';

import '../controllers/todo_controller.dart';
import '../models/todo.dart';

class TodoListTile extends ConsumerWidget {
  const TodoListTile({
    Key? key,
    required this.isVisible,
    required this.todos,
    required this.index,
    required this.lineThrough,
  }) : super(key: key);

  final bool isVisible;
  final List<Todo> todos;
  final int index;
  final bool lineThrough;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: isVisible,
      child: Dismissible(
        key: Key(todos[index].id),
        background: Container(
          padding: const EdgeInsets.only(right: 16.0),
          color: Colors.redAccent.shade700,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          ref.read(todoControllerProvider).removeTodo(todos[index].id);
        },
        child: ListTile(
          onTap: () {
            context.pushNamed(AppRoute.addTodoScreen.name, extra: todos[index]);
          },
          leading: Checkbox(
            value: todos[index].completed,
            onChanged: (_) {
              ref.read(todoControllerProvider).toggleTodo(todos[index].id);
            },
          ),
          title: Text(
            todos[index].title,
            style: lineThrough
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
        ),
      ),
    );
  }
}
