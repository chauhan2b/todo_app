import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';
import '../respositories/todo_repository.dart';

class TodoListView extends ConsumerStatefulWidget {
  const TodoListView({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final List<Todo> todos;

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
                return ListTile(
                  onTap: () {
                    setState(() {
                      isUnfinishedVisible = !isUnfinishedVisible;
                    });
                  },
                  leading: CircleAvatar(
                    child: Text(unfinishedTodos.length.toString()),
                  ),
                  title: const Text('Remaining Tasks'),
                  trailing: isUnfinishedVisible
                      ? const Icon(Icons.arrow_upward)
                      : const Icon(Icons.arrow_downward),
                );
              } else if (unfinishedTodos.isNotEmpty &&
                  index <= unfinishedTodos.length) {
                return Visibility(
                  visible: isUnfinishedVisible,
                  child: ListTile(
                    leading: Checkbox(
                      value: unfinishedTodos[index - 1].completed,
                      onChanged: (_) {
                        ref
                            .read(todoRepositoryProvider.notifier)
                            .toggleTodo(unfinishedTodos[index - 1].id);
                      },
                    ),
                    title: Text(unfinishedTodos[index - 1].title),
                  ),
                );
              } else if (index == unfinishedTodos.length + 1) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      isFinishedVisible = !isFinishedVisible;
                    });
                  },
                  leading: CircleAvatar(
                    child: Text(finishedTodos.length.toString()),
                  ),
                  title: const Text(
                    'Finished Tasks',
                  ),
                  trailing: isFinishedVisible
                      ? const Icon(Icons.arrow_upward)
                      : const Icon(Icons.arrow_downward),
                );
              } else if (finishedTodos.isNotEmpty &&
                  index >= unfinishedTodos.length) {
                int i = index - unfinishedTodos.length - 2;
                return Visibility(
                  visible: isFinishedVisible,
                  child: ListTile(
                    leading: Checkbox(
                      value: finishedTodos[i].completed,
                      onChanged: (_) {
                        ref
                            .read(todoRepositoryProvider.notifier)
                            .toggleTodo(finishedTodos[i].id);
                      },
                    ),
                    title: Text(
                      finishedTodos[i].title,
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                );
              }
              return null;
            },
          );
  }
}
