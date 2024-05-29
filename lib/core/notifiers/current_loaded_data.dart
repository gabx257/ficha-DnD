import 'package:ficha/models/Character.dart';
import 'package:flutter/material.dart';

class CurrentLoadedData with ChangeNotifier {
  Character character = Character(name: "nothing to show");
}
