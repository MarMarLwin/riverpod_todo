import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterController extends StateNotifier<int> {
  CounterController() : super(0);

  void increaseCount() {
    state++;
  }

  void decraseCount() {
    state--;
  }
}

final counterControllerProvider =
    StateNotifierProvider<CounterController, int>((ref) {
  return CounterController();
});
