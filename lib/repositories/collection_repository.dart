import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/collection.dart';
import 'package:todo_app/models/todo.dart';

class CollectionRepository extends StateNotifier<List<Collection>> {
  CollectionRepository() : super([]) {
    loadCollection();
  }

  void loadCollection() {}

  void saveCollection(List<Collection> collection) {}

  @override
  set state(List<Collection> newState) {
    super.state = newState;
    saveCollection(newState);
  }

  void addCollection(Collection collection) {
    state = [...state, collection];
  }

  void removeCollection(String id) {
    state = state.where((collection) => collection.id != id).toList();
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
}

final collectionRepositoryProvider =
    StateNotifierProvider<CollectionRepository, List<Collection>>((ref) {
  return CollectionRepository();
});
