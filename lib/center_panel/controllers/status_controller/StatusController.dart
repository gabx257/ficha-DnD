import 'package:mobx/mobx.dart';
part 'StatusController.g.dart';

class StatusController = _StatusControllerBase with _$StatusController;

abstract class _StatusControllerBase with Store {
  @observable
  ObservableMap status = ObservableMap.of({
    'Dexterity': 10,
    'Strenght': 10,
    'Charisma': 10,
    'Wisdom': 10,
    'Inteligence': 10,
    'Constitutuin': 10,
  });
}
