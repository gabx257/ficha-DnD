import 'package:mobx/mobx.dart';
part 'health_controler.g.dart';

class HealthControler = _HealthControlerBase with _$HealthControler;

abstract class _HealthControlerBase with Store {
  @observable
  int health = 120;

  @observable
  int temphealth = 0;

  @observable
  int maxhp = 100;

  @computed
  double get percentage => (health + temphealth) / maxhp;

  @action
  void updateTempHealth(String display) {
    temphealth = int.tryParse(display) ?? 0;
  }
}
