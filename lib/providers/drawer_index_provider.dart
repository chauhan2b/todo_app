import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerIndex extends StateNotifier<int> {
  DrawerIndex(this.ref) : super(0);
  final Ref ref;

  void update(int value) async {
    // adding a little delay to show drawer closing animation
    await Future.delayed(const Duration(milliseconds: 300));
    state = value;
  }
}

final drawerIndexProvider = StateNotifierProvider<DrawerIndex, int>((ref) {
  return DrawerIndex(ref);
});
