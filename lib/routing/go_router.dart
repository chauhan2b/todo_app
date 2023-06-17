import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/screens/add_todo_screen.dart';

import '../screens/home_screen.dart';

enum AppRoute { homeScreen, addTodoScreen }

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home-screen',
    routes: [
      GoRoute(
        name: AppRoute.homeScreen.name,
        path: '/home-screen',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            name: AppRoute.addTodoScreen.name,
            path: 'add-todo-screen',
            builder: (context, state) => const AddTodoScreen(),
          ),
        ],
      )
    ],
  );
});
