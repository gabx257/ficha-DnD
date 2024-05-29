import 'package:ficha/models/Character.dart';
import 'package:ficha/models/basemodel.dart';
import 'package:ficha/models/equipaments.dart';
import 'package:ficha/models/spells.dart';

class Singletons {
  SpellList spells = SpellList();
  CharacterList characters = CharacterList();
  EquipmentList equipment = EquipmentList();

  T returnRelevantModel<T extends BaseModelsList>() {
    if (T == SpellList) {
      return spells as T;
    }
    if (T == CharacterList) {
      return characters as T;
    }
    if (T == EquipmentList) {
      return equipment as T;
    }

    throw Exception("Type not found");
  }
}
