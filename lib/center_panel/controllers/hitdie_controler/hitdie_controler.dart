import 'package:mobx/mobx.dart';
part 'hitdie_controler.g.dart';

class HitDieController = _HitDieControllerBase with _$HitDieController;

abstract class _HitDieControllerBase with Store {
  @observable
  int hitDie = 0;

  @action
  void increment() => hitDie < 12 ? hitDie++ : hitDie = 12;

  @action
  void decrement() => hitDie > 0 ? hitDie-- : hitDie = 0;
}
