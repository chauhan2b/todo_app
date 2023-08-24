import 'package:flutter/material.dart';
import 'package:todo_app/widgets/my_drawer.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      drawer: const MyDrawer(),
      body: const Center(child: Text('Notes')),
    );
  }
}
