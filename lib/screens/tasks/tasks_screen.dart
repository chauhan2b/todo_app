import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:todo_app/routing/go_router.dart';
import 'package:todo_app/widgets/my_drawer.dart';

import '../../widgets/todo_list_view.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      drawer: const MyDrawer(),
      body: const TodoListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoute.addTodoScreen.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
