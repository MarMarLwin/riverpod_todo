import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'counter_controller.g.dart';

//auto generate counterProvider using dart run build_runner watch -d
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  int increase() => state++;
}
