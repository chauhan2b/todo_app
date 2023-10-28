import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/repositories/note_repository.dart';
import 'package:todo_app/routing/go_router.dart';
import 'package:todo_app/widgets/my_drawer.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: notes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final note = notes[index];

              // show delete dialog when long pressing the note
              void showDialogBox() {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete this note?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(noteRepositoryProvider.notifier)
                              .removeNote(note.id);
                          context.pop();
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              }

              return GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.editNotesScreen.name, extra: note);
                },
                onLongPress: () {
                  showDialogBox();
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    note.text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(AppRoute.editNotesScreen.name);
          },
          child: const Icon(Icons.add)),
    );
  }
}
