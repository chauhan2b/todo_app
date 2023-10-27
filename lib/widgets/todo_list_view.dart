// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/repositories/todo_repository.dart';

import 'package:todo_app/widgets/todo_heading.dart';
import 'package:todo_app/widgets/todo_list_tile.dart';

class TodoListView extends ConsumerStatefulWidget {
  const TodoListView({
    super.key,
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
    final unfinishedTodos = ref.watch(unfinishedTodoProvider);
    final finishedTodos = ref.watch(finishedTodoProvider);
    bool isEmpty = unfinishedTodos.isEmpty && finishedTodos.isEmpty;

    return isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/add_tasks.png',
                  width: size.width * 0.75,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Add some tasks',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          )
        : CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: TodoHeading(
                  title: 'Remaining Tasks',
                  count: unfinishedTodos.length,
                  isVisible: isUnfinishedVisible,
                  onTap: () {
                    setState(() {
                      isUnfinishedVisible = !isUnfinishedVisible;
                    });
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: unfinishedTodos.length,
                  (context, index) => TodoListTile(
                    isVisible: isUnfinishedVisible,
                    todos: unfinishedTodos,
                    index: index,
                    lineThrough: false,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: TodoHeading(
                  title: 'Completed Tasks',
                  count: finishedTodos.length,
                  isVisible: isFinishedVisible,
                  onTap: () {
                    setState(() {
                      isFinishedVisible = !isFinishedVisible;
                    });
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: finishedTodos.length,
                  (context, index) => TodoListTile(
                    isVisible: isFinishedVisible,
                    todos: finishedTodos,
                    index: index,
                    lineThrough: true,
                  ),
                ),
              ),
            ],
          );
  }
}
