// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CollectionTodoHeading extends StatelessWidget {
  const CollectionTodoHeading({
    super.key,
    required this.title,
    required this.count,
    required this.isVisible,
    required this.onTap,
  });
  final String title;
  final int count;
  final bool isVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Text(count.toString()),
      ),
      title: Text(title),
      trailing: isVisible
          ? const Icon(Icons.keyboard_arrow_up)
          : const Icon(Icons.keyboard_arrow_down),
    );
  }
}
