import 'package:flutter/material.dart';

class TodoHeading extends StatefulWidget {
  const TodoHeading({
    super.key,
    required this.title,
    required this.count,
  });
  final String title;
  final int count;

  @override
  State<TodoHeading> createState() => _TodoHeadingState();
}

class _TodoHeadingState extends State<TodoHeading> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
      leading: CircleAvatar(
        child: Text(widget.count.toString()),
      ),
      title: Text(widget.title),
      trailing: isVisible
          ? const Icon(Icons.arrow_upward)
          : const Icon(Icons.arrow_downward),
    );
  }
}
