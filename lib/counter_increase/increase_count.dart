import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/counter_increase/counter_controller.dart';
import 'package:riverpod_todo/counter_increase/increase_counter_controller.dart';

class IncreaseCount extends ConsumerWidget {
  const IncreaseCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final count = ref.watch(counterProvider);
    final count = ref.watch(counterControllerProvider);
    return Center(
      child: Text(
        '$count',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
