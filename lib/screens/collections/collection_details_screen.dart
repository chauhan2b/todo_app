import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/collection.dart';
import 'package:todo_app/repositories/collection_repository.dart';
import 'package:todo_app/routing/go_router.dart';

class CollectionDetailsScreen extends ConsumerWidget {
  const CollectionDetailsScreen({
    super.key,
    required this.id,
  });
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(collectionByIdProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          collection.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.pushNamed(
                AppRoute.editCollectionScreen.name,
                extra: collection,
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 0,
              (context, index) => null,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
