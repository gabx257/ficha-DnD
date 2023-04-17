// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
// base class for all models
// all models must inherit from this class
// to be used with the DescriptionDrawer

abstract class Model {
  String name;

  Model({
    required this.name,
  });

  String operator [](String name) {
    return toMap[name];
  }

  Map<String, dynamic> get toMap => {
        'name': name,
      };

  @override
  bool operator ==(other) {
    if (other is Model) {
      return other.name == name;
    }
    return false;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name.toString();
  }

  Iterable<MapEntry<String, dynamic>> get iterator => toMap.entries;
}

// SpellList is a singleton class that holds all spells
// it is used to populate the dropdowns in the SpellList
// and to get the spell description to be displayed in the DescriptionDrawer
class SpellList {
  final List _spellsJson =
      jsonDecode(File("assets/spells.json").readAsStringSync());
  final List<Spell> _spells = [];
  SpellList() {
    for (Map<String, dynamic> spell in _spellsJson) {
      _spells.add(Spell.fromJson(spell));
    }
  }

  List<String> get spellNames => _spells.map((e) => e.name).toList();

  Spell operator [](dynamic name) {
    if (name is int) {
      return _spells[name];
    }
    return _spells.firstWhere((element) => element.name == name);
  }

  int get length => _spells.length;
}

// Spell is a model that holds all the information about a spell
// it is used to populate the dropdowns in the SpellList
// and to get the spell description to be displayed in the DescriptionDrawer
class Spell extends Model {
  final String? page;
  final String? range;
  final String? desc;
  final String? components;
  final String? material;
  final String? ritual;
  final String? duration;
  final String? concentration;
  final String? casting_time;
  final String? level;
  final String? school;
  final String? classes;

  Spell({
    required super.name,
    required this.desc,
    required this.page,
    required this.range,
    required this.components,
    required this.material,
    required this.ritual,
    required this.duration,
    required this.concentration,
    required this.casting_time,
    required this.level,
    required this.school,
    required this.classes,
  });

  @override
  Map<String, dynamic> get toMap => {
        'name': name,
        'desc': desc,
        'page': page,
        'range': range,
        'components': components,
        'material': material,
        'ritual': ritual,
        'duration': duration,
        'concentration': concentration,
        'casting_time': casting_time,
        'level': level,
        'school': school,
        'class': classes,
      };

  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      name: json['name'],
      desc: json['desc'],
      page: json['page'],
      range: json['range'],
      components: json['components'],
      material: json['material'],
      ritual: json['ritual'],
      duration: json['duration'],
      concentration: json['concentration'],
      casting_time: json['casting_time'],
      level: json['level'],
      school: json['school'],
      classes: json['class'],
    );
  }
}

// EquipmentList is a singleton class that holds all equipment
// it is used to populate the dropdowns in the EquipmentList
// and to get the equipment description to be displayed in the DescriptionDrawer
class EquipmentList {
  final List _equipmentJson =
      jsonDecode(File("assets/equipments.json").readAsStringSync());
  final List<Equipment> _equipment = [];
  EquipmentList() {
    for (Map<String, dynamic> equipment in _equipmentJson) {
      _equipment.add(Equipment.fromJson(equipment));
    }
  }

  List<String> get equipmentNames => _equipment.map((e) => e.name).toList();

  Equipment operator [](dynamic name) {
    if (name is int) {
      return _equipment[name];
    }
    return _equipment.firstWhere((element) => element.name == name);
  }

  int get length => _equipment.length;
}

// Equipment is a model that holds all the information about a equipment
// it is used to populate the dropdowns in the EquipmentList
// and to get the equipment description to be displayed in the DescriptionDrawer
class Equipment extends Model {
  final String? cost;
  final String? weight;
  final String? category;
  final String? properties;

  Equipment({
    required super.name,
    required this.cost,
    required this.weight,
    required this.category,
    required this.properties,
  });

  @override
  Map<String, dynamic> get toMap => {
        'name': name,
        'cost': cost,
        'weight': weight,
        'category': category,
      };

  factory Equipment.fromJson(Map<String, dynamic> json) {
    String mountprop() {
      String prop = "";
      if (json['properties'] == null) return prop;
      for (Map property in json['properties']) {
        prop += "${property['name']}, ";
      }
      if (prop.isNotEmpty) prop = prop.substring(0, prop.length - 3);
      return prop;
    }

    if (json['equipment_category']['name'] == "Weapon") {
      return Weapon(
        name: json['name'],
        cost: "${json['cost']['quantity']} ${json['cost']['unit']}",
        weight: json['weight'].toString(),
        category: json['equipment_category']['name'],
        properties: mountprop(),
        damage: json['damage']?['damage_dice'],
        weapon_range: json['weapon_range'],
        weapon_category: json['weapon_category'],
        two_handed_damage: json['two_handed_damage']?['damage_dice'],
        weapon_range_long: json['range']['long']?.toString(),
        normal_range: json['range']['normal'].toString(),
      );
    }
    return Equipment(
      name: json['name'],
      cost: "${json['cost']['quantity']} ${json['cost']['unit']}",
      weight: json['weight'].toString(),
      category: json['equipment_category']['name'],
      properties: mountprop(),
    );
  }
}

// Weapon is a model that holds all the information about a weapon
// it extends Equipment
// but has additional properties
class Weapon extends Equipment {
  final String? damage;
  final String? weapon_range;
  final String? weapon_category;
  final String? two_handed_damage;
  final String? weapon_range_long;
  final String? normal_range;

  Weapon({
    required super.name,
    required super.cost,
    required super.weight,
    required super.category,
    required super.properties,
    required this.damage,
    required this.weapon_range,
    required this.weapon_category,
    required this.two_handed_damage,
    required this.weapon_range_long,
    required this.normal_range,
  });

  @override
  Map<String, dynamic> get toMap => {
        'name': name,
        'cost': cost,
        'weight': weight,
        'category': category,
        'damage': damage,
        'weapon_range': weapon_range,
        'weapon_category': weapon_category,
        'two_handed_damage': two_handed_damage,
        'weapon_range_long': weapon_range_long,
        'normal_range': normal_range,
      };

  factory Weapon.fromJson(Map<String, dynamic> json) {
    String mountprop() {
      String prop = "";
      if (json['properties'] == null) return prop;
      for (Map property in json['properties']) {
        prop += "${property['name']}, ";
      }
      if (prop.isNotEmpty) prop = prop.substring(0, prop.length - 3);
      return prop;
    }

    return Weapon(
      name: json['name'],
      cost: "${json['cost']['quantity']} ${json['cost']['unit']}",
      weight: json['weight'],
      category: json['equipment_category']['name'],
      properties: mountprop(),
      damage: json['damage']['damage_dice'],
      weapon_range: json['weapon_range'],
      weapon_category: json['weapon_category'],
      two_handed_damage: json['two_handed_damage']['damage_dice'],
      weapon_range_long: json['range']['long'],
      normal_range: json['range']['normal'],
    );
  }
}


/// to-do:
/// - add model for armor
/// - add model for Magic Items
/// - add damage types to weapons and spells 
