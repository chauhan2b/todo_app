import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:todo_app/models/todo.dart';

class Collection {
  final String name;
  final String id;
  final List<Todo> todos;

  Collection({
    required this.name,
    required this.id,
    required this.todos,
  });

  Collection copyWith({
    String? name,
    String? id,
    List<Todo>? todos,
  }) {
    return Collection(
      name: name ?? this.name,
      id: id ?? this.id,
      todos: todos ?? this.todos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'todos': todos.map((x) => x.toMap()).toList(),
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      todos: List<Todo>.from(map['todos']?.map((x) => Todo.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source));

  @override
  String toString() => 'Collection(name: $name, id: $id, todos: $todos)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Collection &&
        other.name == name &&
        other.id == id &&
        listEquals(other.todos, todos);
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ todos.hashCode;
}
