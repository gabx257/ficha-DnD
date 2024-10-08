import 'package:ficha/models/Character.dart';
import 'package:flutter/material.dart';

class CurrentLoadedData with ChangeNotifier {
  Character character = Character(name: "nothing to show");

  T? get<T>() {
    switch (T.toString()) {
      case "SpellList":
        if (character.spells == null) {
          return null;
        }
        return character.spells as T?;
      case "EquipmentList":
        if (character.equipment == null) {
          return null;
        }
        return character.equipment as T?;
      default:
        return null;
    }
  }

  void loadCharacter(Character character) {
    this.character = character;
    notifyListeners();
  }
}

extension ProficiencyModifier on int {
  int get proficiencyModifier {
    return 1 + (this / 4).ceil();
  }
}
