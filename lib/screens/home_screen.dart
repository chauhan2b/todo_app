import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/respositories/todo_repository.dart';

import '../widgets/todo_list_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do'),
      ),
      body: TodoListView(todos: todos),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(todoControllerProvider).addTodo('good then');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
