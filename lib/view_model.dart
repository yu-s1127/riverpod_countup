import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_coutup/logic.dart';
import 'package:riverpod_coutup/provider.dart';

class ViewModel {
  final Logic _logic = Logic();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  get count => _ref.watch(countDataPrivider).count.toString();
  get countUp =>
      _ref.watch(countDataPrivider.select((value) => value.countUp)).toString();
  get countDown => _ref
      .watch(countDataPrivider.select((value) => value.countDown))
      .toString();

  void onIncrease() {
    _logic.increase();
    _ref.watch(countDataPrivider.state).update((state) => _logic.countData);
  }

  void onDecrease() {
    _logic.decrease();
    _ref.watch(countDataPrivider.state).update((state) => _logic.countData);
  }

  void onReset() {
    _logic.reset();
    _ref.watch(countDataPrivider.state).update((state) => _logic.countData);
  }
}
