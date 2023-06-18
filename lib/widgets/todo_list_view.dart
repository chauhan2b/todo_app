// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app/widgets/todo_heading.dart';
import 'package:todo_app/widgets/todo_list_tile.dart';

import '../models/todo.dart';

class TodoListView extends ConsumerStatefulWidget {
  final List<Todo> todos;
  const TodoListView({
    super.key,
    required this.todos,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoListViewState();
}

class _TodoListViewState extends ConsumerState<TodoListView> {
  bool isUnfinishedVisible = true;
  bool isFinishedVisible = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unfinishedTodos =
        widget.todos.where((todo) => !todo.completed).toList();
    final finishedTodos = widget.todos.where((todo) => todo.completed).toList();

    return widget.todos.isEmpty
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
            itemCount: widget.todos.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return TodoHeading(
                  title: 'Remaining Tasks',
                  count: unfinishedTodos.length,
                  isVisible: isUnfinishedVisible,
                  onTap: () {
                    setState(() {
                      isUnfinishedVisible = !isUnfinishedVisible;
                    });
                  },
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
                  isVisible: isFinishedVisible,
                  onTap: () {
                    setState(() {
                      isFinishedVisible = !isFinishedVisible;
                    });
                  },
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
