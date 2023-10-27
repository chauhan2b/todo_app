import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/collection.dart';
import 'package:todo_app/models/todo.dart';

class CollectionRepository extends StateNotifier<List<Collection>> {
  CollectionRepository() : super([]) {
    loadCollections();
  }

  Future<void> loadCollections() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedCollections = prefs.getString('collections');
    if (encodedCollections != null) {
      final decodedCollections =
          jsonDecode(encodedCollections) as List<dynamic>;
      state =
          decodedCollections.map((json) => Collection.fromJson(json)).toList();
    }
  }

  Future<void> saveCollections(List<Collection> collections) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedCollections = jsonEncode(
        collections.map((collection) => collection.toJson()).toList());
    await prefs.setString('collections', encodedCollections);
  }

  @override
  set state(List<Collection> newState) {
    super.state = newState;
    saveCollections(newState);
  }

  void addCollection(Collection collection) {
    state = [...state, collection];
  }

  void removeCollection(String id) {
    state = state.where((collection) => collection.id != id).toList();
  }

  void editCollectionName(String name, String id) {
    state = [
      for (final collection in state)
        if (collection.id == id) collection.copyWith(name: name) else collection
    ];
  }

  void addTodoToCollection(String id, Todo todo) {
    state = state.map((collection) {
      if (collection.id == id) {
        return collection.copyWith(todos: [...collection.todos, todo]);
      }
      return collection;
    }).toList();
  }

  void removeTodoFromCollection(String collectionId, String id) {
    state = state.map((collection) {
      if (collection.id == collectionId) {
        final updatedTodos =
            collection.todos.where((todo) => todo.id != id).toList();
        return collection.copyWith(todos: updatedTodos);
      }
      return collection;
    }).toList();
  }

  void toggleTodoInCollection(String collectionId, String todoId) {
    state = state.map((collection) {
      if (collection.id == collectionId) {
        final updatedTodos = collection.todos.map((todo) {
          if (todo.id == todoId) {
            return todo.copyWith(completed: !todo.completed);
          }
          return todo;
        }).toList();
        return collection.copyWith(todos: updatedTodos);
      }
      return collection;
    }).toList();
  }

  void editTodoInCollection(
      String collectionId, String todoId, String newTitle) {
    state = state.map((collection) {
      if (collection.id == collectionId) {
        final updatedTodos = collection.todos.map((todo) {
          if (todo.id == todoId) {
            return todo.copyWith(title: newTitle);
          }
          return todo;
        }).toList();
        return collection.copyWith(todos: updatedTodos);
      }
      return collection;
    }).toList();
  }
}

final collectionRepositoryProvider =
    StateNotifierProvider<CollectionRepository, List<Collection>>((ref) {
  return CollectionRepository();
});

final collectionByIdProvider = Provider.family<Collection, String>((ref, id) {
  final collections = ref.watch(collectionRepositoryProvider);
  return collections.firstWhere((collection) => collection.id == id);
});

final unfinishedCollectionTodoProvider =
    Provider.family<List<Todo>, String>((ref, id) {
  final collections = ref.watch(collectionRepositoryProvider);
  final todos =
      collections.firstWhere((collection) => collection.id == id).todos;
  return todos.where((todo) => !todo.completed).toList();
});

final finishedCollectionTodoProvider =
    Provider.family<List<Todo>, String>((ref, id) {
  final collections = ref.watch(collectionRepositoryProvider);
  final todos =
      collections.firstWhere((collection) => collection.id == id).todos;
  return todos.where((todo) => todo.completed).toList();
});
