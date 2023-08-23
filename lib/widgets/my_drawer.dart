import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:todo_app/providers/drawer_index_provider.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(drawerIndexProvider);
    return NavigationDrawer(
      onDestinationSelected: (index) {
        context.pop();
        ref.read(drawerIndexProvider.notifier).update(index);
      },
      selectedIndex: currentIndex,
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Todo',
            style: TextStyle(fontSize: 26.0),
          ),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.task_alt),
          label: Text('Tasks'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.library_books_outlined),
          label: Text('Collections'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.note_outlined),
          label: Text('Notes'),
        ),
      ],
    );
  }
}
