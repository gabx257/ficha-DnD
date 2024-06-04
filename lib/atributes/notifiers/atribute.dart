import 'dart:collection';

import 'package:flutter/material.dart';

class AttributesNotifier extends ChangeNotifier with MapMixin<String, int> {
  final Map<String, int> _status = {
    'Dexterity': 10,
    'Strength': 10,
    'Charisma': 10,
    'Wisdom': 10,
    'Intelligence': 10,
    'Constitution': 10,
  };

  @override
  operator [](Object? key) => _status[key];

  @override
  void operator []=(key, value) {
    _status[key] = value;
    notifyListeners();
  }

  @override
  void clear() => _status.clear();

  @override
  Iterable<String> get keys => _status.keys;

  @override
  remove(Object? key) {
    _status.remove(key);
    return null;
  }

  Map<String, int> get status => _status;

  int get dexterity => this['Dexterity']!;
  int get strength => this['Strength']!;
  int get charisma => this['Charisma']!;
  int get wisdom => this['Wisdom']!;
  int get intelligence => this['Intelligence']!;
  int get constitution => this['Constitution']!;

  int modifier(String attr) {
    return ((this[attr]! - 10) / 2).floor();
  }
}

extension CalculateModifier on int {
  int get modifier => ((this - 10) / 2).floor();
}
