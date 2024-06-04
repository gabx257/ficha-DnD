import 'package:flutter/material.dart';

class HealthNotifier extends ChangeNotifier {
  int _health = 80;

  int get health => _health;

  set health(int value) {
    _health = value;
    notifyListeners();
  }

  void operator +(int value) {
    _health = (_health + value) < maxhp ? value : maxhp;
    health += value;
  }

  void operator -(int value) {
    _health = (_health - value) > 0 ? value : 0;
    health -= value;
  }

  int _temphealth = 0;

  int get temphealth => _temphealth;

  set temphealth(int value) {
    _temphealth = value;
    notifyListeners();
  }

  int _maxhp = 100;

  int get maxhp => _maxhp;

  set maxhp(int value) {
    _maxhp = value;
    notifyListeners();
  }

  double get hpPercentage => health / maxhp;

  double get tempHpPercentage => temphealth / maxhp;
}
