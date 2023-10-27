import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/collection.dart';
import 'package:todo_app/repositories/collection_repository.dart';
import 'package:todo_app/routing/go_router.dart';
import 'package:todo_app/widgets/my_drawer.dart';

class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(collectionRepositoryProvider);
    final controller = TextEditingController();

    void addCollection() {
      if (controller.text.isNotEmpty) {
        ref.read(collectionRepositoryProvider.notifier).addCollection(
              Collection(
                name: controller.text.trim(),
                id: DateTime.now().toString(),
                todos: [],
              ),
            );
      }
      context.pop();
    }

    void showDialogBox() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: TextField(
            onSubmitted: (_) {
              addCollection();
            },
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              label: Text('Collection name'),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              onPressed: addCollection,
              child: const Text('Create'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collections'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add new collection',
            onPressed: () {
              showDialogBox();
            },
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: collections.isEmpty
          ? const Center(
              child: Text(
                'No collection found!\nTap the + icon to add one.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: collections.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  child: Text(collections[index].todos.length.toString()),
                ),
                title: Text(
                  collections[index].name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  context.pushNamed(
                    AppRoute.collectionDetailsScreen.name,
                    extra: collections[index].id,
                  );
                },
              ),
            ),
    );
  }
}
