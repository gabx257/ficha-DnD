import 'package:flutter/material.dart';

class HealthNotifier extends ChangeNotifier {
  int health = 120;
  int temphealth = 0;
  int maxhp = 100;

  double get percentage => (health + temphealth) / maxhp;
}
