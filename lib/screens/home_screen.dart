import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/routing/go_router.dart';

import '../widgets/todo_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do'),
      ),
      body: const TodoListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppRoute.addTodoScreen.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
