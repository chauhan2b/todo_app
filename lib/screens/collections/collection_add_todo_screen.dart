import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:todo_app/constants/todo_examples.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/repositories/collection_repository.dart';

class CollectionAddTodoScreen extends ConsumerStatefulWidget {
  const CollectionAddTodoScreen({
    super.key,
    required this.collectionId,
    required this.todoId,
  });
  final String collectionId;
  final String todoId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionAddTodoScreenState();
}

class _CollectionAddTodoScreenState
    extends ConsumerState<CollectionAddTodoScreen> {
  late List<Todo> todos;
  late TextEditingController controller;
  bool isSubmitVisible = true;

  @override
  void initState() {
    super.initState();

    if (widget.todoId == 'null') {
      controller = TextEditingController(text: '');
    } else {
      final collection = ref.read(collectionByIdProvider(widget.collectionId));
      todos = collection.todos;
      final todo = todos.firstWhere((todo) => todo.id == widget.todoId);
      controller = TextEditingController(text: todo.title);
    }
  }

  void canSubmit() {
    setState(() {
      isSubmitVisible = controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    String todoExample = todoExamples[Random().nextInt(todoExamples.length)];

    void saveTodo() {
      if (widget.todoId == 'null') {
        ref.read(collectionRepositoryProvider.notifier).addTodoToCollection(
              widget.collectionId,
              Todo(
                title: controller.text.trim(),
                id: DateTime.now().toString(),
                time: DateTime.now(),
              ),
            );
      } else {
        ref.read(collectionRepositoryProvider.notifier).editTodoInCollection(
              widget.collectionId,
              widget.todoId,
              controller.text.trim(),
            );
      }
      context.pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: controller.text.isEmpty
            ? const Text('Add a task')
            : const Text('Edit task'),
        actions: [
          IconButton(
            onPressed: isSubmitVisible ? saveTodo : null,
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          autofocus: true,
          onSubmitted: (_) {
            saveTodo();
          },
          onChanged: (_) => canSubmit(),
          decoration: InputDecoration(
            label: const Text('Your task'),
            hintText: 'eg. $todoExample',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
