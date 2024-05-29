import 'package:mobx/mobx.dart';
part 'status_controller.g.dart';

class StatusController = _StatusControllerBase with _$StatusController;

abstract class _StatusControllerBase with Store {
  @observable
  ObservableMap status = ObservableMap.of({
    'Dexterity': 10,
    'Strength': 10,
    'Charisma': 10,
    'Wisdom': 10,
    'Intelligence': 10,
    'Constitution': 10,
  });
}
