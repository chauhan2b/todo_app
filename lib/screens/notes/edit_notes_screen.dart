import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/repositories/note_repository.dart';

class EditNotesScreen extends ConsumerStatefulWidget {
  const EditNotesScreen({super.key, this.note});

  final Note? note;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditNotesScreenState();
}

class _EditNotesScreenState extends ConsumerState<EditNotesScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.note?.text ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // don't save empty note
              if (controller.text.isEmpty) {
                return;
              }

              if (widget.note == null) {
                ref.read(noteRepositoryProvider.notifier).addNote(
                      controller.text.trim(),
                    );
              } else {
                ref
                    .read(noteRepositoryProvider.notifier)
                    .editNote(widget.note!.id, controller.text.trim());
              }
              context.pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration.collapsed(
            hintText: 'Start writing stuff...',
          ),
          autofocus: true,
          scrollPadding: const EdgeInsets.all(20),
          maxLines: 99999,
        ),
      ),
    );
  }
}
