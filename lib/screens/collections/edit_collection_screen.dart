import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/collection.dart';
import 'package:todo_app/repositories/collection_repository.dart';
import 'package:todo_app/routing/go_router.dart';

class EditCollectionScreen extends ConsumerStatefulWidget {
  const EditCollectionScreen({
    super.key,
    required this.collection,
  });
  final Collection collection;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCollectionScreenState();
}

class _EditCollectionScreenState extends ConsumerState<EditCollectionScreen> {
  late TextEditingController controller;
  bool isSubmitVisible = true;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.collection.name);
  }

  void editCollectionName() {
    ref.read(collectionRepositoryProvider.notifier).editCollectionName(
          controller.text.trim(),
          widget.collection.id,
        );
    context.pop();
  }

  void canSubmit() {
    setState(() {
      isSubmitVisible = controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit collection'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: isSubmitVisible ? editCollectionName : null,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              controller: controller,
              onSubmitted: (_) => editCollectionName,
              onChanged: (_) => canSubmit(),
              decoration: InputDecoration(
                label: const Text('Collection name'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: isSubmitVisible
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          controller.clear();
                          canSubmit();
                        },
                      )
                    : null,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              ref
                  .read(collectionRepositoryProvider.notifier)
                  .removeCollection(widget.collection.id);

              ref.invalidate(collectionRepositoryProvider);

              // use goNamed because we want to replace the stack as it gets deleted
              context.goNamed(AppRoute.homeScreen.name);
            },
            icon: const Icon(Icons.delete),
            label: const Text('Delete collection'),
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
