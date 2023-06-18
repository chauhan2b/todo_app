// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/widgets/todo_heading.dart';

import 'package:todo_app/widgets/todo_list_tile.dart';

import '../models/todo.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({
    super.key,
    required this.todos,
  });

  final List<Todo> todos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isUnfinishedVisible = true;
    bool isFinishedVisible = true;
    final size = MediaQuery.of(context).size;
    final unfinishedTodos = todos.where((todo) => !todo.completed).toList();
    final finishedTodos = todos.where((todo) => todo.completed).toList();

    return todos.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/add-tasks.png',
                  width: size.width * 0.75,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Add some tasks',
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          )
        : ListView.builder(
            itemCount: todos.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return TodoHeading(
                  title: 'Remaining Tasks',
                  count: unfinishedTodos.length,
                );
              } else if (unfinishedTodos.isNotEmpty &&
                  index <= unfinishedTodos.length) {
                return TodoListTile(
                  key: Key(unfinishedTodos[index - 1].id),
                  isVisible: isUnfinishedVisible,
                  todos: unfinishedTodos,
                  index: index - 1, // subtracting title which is at index 0
                );
              } else if (index == unfinishedTodos.length + 1) {
                return TodoHeading(
                  title: 'Finished Tasks',
                  count: finishedTodos.length,
                );
              } else if (finishedTodos.isNotEmpty &&
                  index >= unfinishedTodos.length) {
                int i = index -
                    unfinishedTodos.length -
                    2; // subtracting finished todo and 2 heading
                return TodoListTile(
                  key: Key(finishedTodos[i].id),
                  isVisible: isFinishedVisible,
                  todos: finishedTodos,
                  index: i,
                  textStyle: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                );
              }
              return null;
            },
          );
  }
}
