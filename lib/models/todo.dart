import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'time': time.millisecondsSinceEpoch,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] as String,
      id: map['id'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      completed: map['completed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
