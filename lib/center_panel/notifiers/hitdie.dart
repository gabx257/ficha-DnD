import 'package:flutter/material.dart';

class HitDieNotifier with ChangeNotifier {
  int hitDie = 0;

  void increase() => hitDie < 12 ? hitDie++ : hitDie = 12;

  void decrease() => hitDie > 0 ? hitDie-- : hitDie = 0;
}
