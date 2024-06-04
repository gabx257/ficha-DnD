import 'dart:collection';

import 'package:flutter/material.dart';

class ProficienciesNotifier with ChangeNotifier, MapMixin<String, bool> {
  final String attr;
  final Map<String, bool> _proficiencies = {};
  ProficienciesNotifier({required this.attr, List<String>? proficiencies}) {
    for (var prof in proficiencies!) {
      _proficiencies[prof] = false;
    }
  }

  @override
  operator [](Object? key) => _proficiencies[key];

  @override
  void operator []=(key, value) {
    _proficiencies[key] = value;
    notifyListeners();
  }

  @override
  void clear() => _proficiencies.clear();

  @override
  Iterable<String> get keys => _proficiencies.keys;

  @override
  remove(Object? key) {
    _proficiencies.remove(key);
    return null;
  }
}
