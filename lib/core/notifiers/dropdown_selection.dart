import 'package:flutter/material.dart';

class DropDownSelectionNotifier with ChangeNotifier {
  String value = "";

  List<String> item = [];

  void add(String val) {
    item.add(val);
    value = val;
    notifyListeners();
  }

  void remove(String val) {
    item.remove(val);
    value = "";
    notifyListeners();
  }
}
