import 'package:flutter/material.dart';

class HitDieNotifier with ChangeNotifier {
  int _hitDie = 0;

  int get hitDie => _hitDie;

  void increase() {
    hitDie < 20 ? _hitDie++ : null;
    notifyListeners();
  }

  void decrease() {
    hitDie > 0 ? _hitDie-- : null;
    notifyListeners();
  }
}
