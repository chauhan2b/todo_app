// ignore_for_file: public_member_api_docs, sort_constructors_first
class Todo {
  final String title;
  final String id;
  final DateTime time;
  bool completed;

  Todo({
    required this.title,
    required this.id,
    required this.time,
    this.completed = false,
  });

  Todo copyWith({
    String? title,
    String? id,
    DateTime? time,
    bool? completed,
  }) {
    return Todo(
      title: title ?? this.title,
      id: id ?? this.id,
      time: time ?? this.time,
      completed: completed ?? this.completed,
    );
  }
}
