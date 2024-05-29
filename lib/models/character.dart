import 'dart:convert';
import 'dart:io';

import 'package:ficha/models/equipaments.dart';
import 'package:ficha/models/model.dart';
import 'package:ficha/models/spells.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CharacterList extends ModelList<Character> {
  CharacterList() {
    late Map<String, dynamic> characterJson;
    for (var characterFile in Directory("assets/saved/").listSync()) {
      characterJson = jsonDecode(File(characterFile.path).readAsStringSync());
      add(Character.fromJson(characterJson));
    }
  }

  CharacterList.Empty();
}

class Character extends Model {
  String? classType;
  int? level;
  String? race;
  String? alignment;
  String? background;
  int? armorClass;
  int? hitPoints;
  String? hitDice;
  int? speed;
  Map<String, int>? abilityScores;
  List<String>? proficiencies;
  EquipmentList? equipment;
  SpellList? spells;
  Map<String, int>? spellSlots;

  Character({
    required super.name,
    this.classType,
    this.level,
    this.race,
    this.alignment,
    this.background,
    this.armorClass,
    this.hitPoints,
    this.hitDice,
    this.speed,
    this.abilityScores,
    this.proficiencies,
    this.equipment,
    this.spells,
    this.spellSlots,
  });

  @override
  factory Character.fromJson(Map<String, dynamic> json) {
    SpellList characterSpells() {
      final spellsGlobal = Modular.get<SpellList>();
      SpellList out = SpellList.Empty();
      for (String spell in json["spells"]) {
        out.add(spellsGlobal[spell]);
      }
      return out;
    }

    EquipmentList characterEquipaments() {
      final equipamentsGlobal = Modular.get<EquipmentList>();
      EquipmentList out = EquipmentList.Empty();
      for (String equip in json["equipment"]) {
        out.add(equipamentsGlobal[equip]);
      }
      return out;
    }

    return Character(
      name: json['name'],
      classType: json['class'],
      level: json['level'],
      race: json['race'],
      alignment: json['alignment'],
      background: json['background'],
      armorClass: json['armorClass'],
      hitPoints: json['hitPoints'],
      hitDice: json['hitDice'],
      speed: json['speed'],
      abilityScores: Map<String, int>.from(json['abilityScores']),
      proficiencies: List<String>.from(json['proficiencies']),
      equipment: characterEquipaments(),
      spells: characterSpells(),
      spellSlots: Map<String, int>.from(json['spellSlots']),
    );
  }

  Map<String, dynamic> get toMap => {
        'name': name,
        'class': classType,
        'level': level,
        'race': race,
        'alignment': alignment,
        'background': background,
        'armorClass': armorClass,
        'hitPoints': hitPoints,
        'hitDice': hitDice,
        'speed': speed,
        'abilityScores': abilityScores,
        'proficiencies': proficiencies,
        'equipment': equipment,
        'spells': spells?.nameList.toString(),
        'spellSlots': spellSlots,
      };

  void save() =>
      File("assets/saved/$name.json").writeAsStringSync(jsonEncode(toMap));

  void replaceFromOther(covariant Character other) {
    name = other.name;
    classType = other.classType;
    level = other.level;
    race = other.race;
    alignment = other.alignment;
    background = other.background;
    armorClass = other.armorClass;
    hitPoints = other.hitPoints;
    hitDice = other.hitDice;
    speed = other.speed;
    abilityScores = other.abilityScores;
    proficiencies = other.proficiencies;
    equipment = other.equipment;
    spells = other.spells;
    spellSlots = other.spellSlots;
  }
}
