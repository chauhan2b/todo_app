// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:todo_app/controllers/todo_controller.dart';

import '../constants/todo_examples.dart';
import '../models/todo.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({
    Key? key,
    this.todo,
  }) : super(key: key);
  final Todo? todo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends ConsumerState<AddTodoScreen> {
  late TextEditingController controller;
  String todoExample = todoExamples[Random().nextInt(todoExamples.length)];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.todo?.title ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: controller.text == ''
            ? const Text('Add a task')
            : const Text('Edit task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (widget.todo == null) {
                ref
                    .read(todoControllerProvider)
                    .addTodo(controller.text.trim());
              } else {
                ref
                    .read(todoControllerProvider)
                    .editTodo(widget.todo!.id, controller.text.trim());
              }
              context.pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              // WARNING REMOVE WHEN ADDING NEW FEATURES
              onSubmitted: (_) {
                if (widget.todo == null) {
                  ref
                      .read(todoControllerProvider)
                      .addTodo(controller.text.trim());
                } else {
                  ref
                      .read(todoControllerProvider)
                      .editTodo(widget.todo!.id, controller.text.trim());
                }
                context.pop();
              },
              decoration: InputDecoration(
                hintText: 'e.g., $todoExample',
                label: const Text('Your task'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
