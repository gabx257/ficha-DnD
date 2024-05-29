import 'package:ficha/models/basemodel.dart';
import 'package:flutter/material.dart';

class DescriptionDrawerNotifier with ChangeNotifier {
  BaseModel _info = DefaultModel(name: "nothing to show");

  BaseModel get info => _info;

  set info(BaseModel info) {
    _info = info;
    notifyListeners();
  }

  void updateInfo(BaseModel info) {
    _info = info;
    notifyListeners();
  }
}
