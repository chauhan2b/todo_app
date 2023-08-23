import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/collection.dart';
import 'package:todo_app/repositories/collection_repository.dart';
import 'package:todo_app/widgets/my_drawer.dart';

class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(collectionRepositoryProvider);
    final controller = TextEditingController();

    void addCollection() {
      ref.read(collectionRepositoryProvider.notifier).addCollection(
            Collection(
              name: controller.text.trim(),
              id: DateTime.now().toString(),
              todos: [],
            ),
          );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collections'),
      ),
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Add new collection',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: collections.length,
              (context, index) => ListTile(
                leading: CircleAvatar(
                  child: Text(collections[index].todos.length.toString()),
                ),
                title: Text(
                  collections[index].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCollection,
        child: const Icon(Icons.add),
      ),
    );
  }
}
