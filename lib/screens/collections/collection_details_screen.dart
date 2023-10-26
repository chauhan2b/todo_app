import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/repositories/collection_repository.dart';
import 'package:todo_app/routing/go_router.dart';

import 'common/collection_todo_heading.dart';
import 'common/collection_todo_list_tile.dart';

class CollectionDetailsScreen extends ConsumerStatefulWidget {
  const CollectionDetailsScreen({
    super.key,
    required this.collectionId,
  });
  final String collectionId;

  @override
  ConsumerState createState() => _CollectionDetailScreenState();
}

class _CollectionDetailScreenState
    extends ConsumerState<CollectionDetailsScreen> {
  bool isUnfinishedVisible = true;
  bool isFinishedVisible = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final collection = ref.watch(collectionByIdProvider(widget.collectionId));
    final unfinishedTodos =
        ref.watch(unfinishedCollectionTodoProvider(widget.collectionId));
    final finishedTodos =
        ref.watch(finishedCollectionTodoProvider(widget.collectionId));
    bool isEmpty = unfinishedTodos.isEmpty && finishedTodos.isEmpty;

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
      body: isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/add_tasks.png',
                    width: size.width * 0.75,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Add some tasks',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CollectionTodoHeading(
                    title: 'Remaining Tasks',
                    count: unfinishedTodos.length,
                    isVisible: isUnfinishedVisible,
                    onTap: () {
                      setState(() {
                        isUnfinishedVisible = !isUnfinishedVisible;
                      });
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: unfinishedTodos.length,
                    (context, index) => CollectionTodoListTile(
                      isVisible: isUnfinishedVisible,
                      todos: unfinishedTodos,
                      index: index,
                      lineThrough: false,
                      collectionId: widget.collectionId,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CollectionTodoHeading(
                    title: 'Completed Tasks',
                    count: finishedTodos.length,
                    isVisible: isFinishedVisible,
                    onTap: () {
                      setState(() {
                        isFinishedVisible = !isFinishedVisible;
                      });
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: finishedTodos.length,
                    (context, index) => CollectionTodoListTile(
                      isVisible: isFinishedVisible,
                      todos: finishedTodos,
                      index: index,
                      lineThrough: true,
                      collectionId: widget.collectionId,
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(
          AppRoute.collectionAddTodoScreen.name,
          pathParameters: {
            'collectionId': widget.collectionId,
            'todoId': 'null', // cannot assign null in goRouter
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
