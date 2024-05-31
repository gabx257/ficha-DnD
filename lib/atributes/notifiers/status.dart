import 'package:flutter/material.dart';

class StatusNotifier extends ChangeNotifier {
  final Map<String, int> _status = {
    'Dexterity': 10,
    'Strength': 10,
    'Charisma': 10,
    'Wisdom': 10,
    'Intelligence': 10,
    'Constitution': 10,
  };

  Map<String, int> get status => _status;

  int get dexterity => _status['Dexterity']!;
  int get strength => _status['Strength']!;
  int get charisma => _status['Charisma']!;
  int get wisdom => _status['Wisdom']!;
  int get intelligence => _status['Intelligence']!;
  int get constitution => _status['Constitution']!;

  void increment(String status) =>
      _status[status]! < 20 ? _status[status] = _status[status]! + 1 : null;
}
