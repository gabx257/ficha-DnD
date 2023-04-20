// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'model.dart';

// EquipmentList is a singleton class that holds all equipment
// it is used to populate the dropdowns in the EquipmentList
// and to get the equipment description to be displayed in the DescriptionDrawer
class EquipmentList extends ModelList<Equipment> {
  final List _equipamentJson =
      jsonDecode(File("assets/equipaments.json").readAsStringSync());
  EquipmentList() {
    for (Map<String, dynamic> equipament in _equipamentJson) {
      add(Equipment.fromJson(equipament));
    }
  }
}

// Equipment is a model that holds all the information about a equipment
// it is used to populate the dropdowns in the EquipmentList
// and to get the equipment description to be displayed in the DescriptionDrawer
class Equipment extends Model {
  final String? cost;
  final String? weight;
  final String? category;
  final String? properties;
  final String? desc;

  Equipment({
    required super.name,
    required this.cost,
    required this.weight,
    required this.category,
    required this.properties,
    this.desc,
  });

  @override
  Map<String, dynamic> get toMap => {
        'name': name,
        'cost': cost,
        'weight': weight,
        'category': category,
        'properties': properties,
        'desc': desc,
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

    if (json['equipment_category']['name'] == "Armor") {
      return Armor(
        name: json['name'],
        cost: "${json['cost']['quantity']} ${json['cost']['unit']}",
        weight: json['weight'].toString(),
        category: json['equipment_category']['name'],
        armor_category: json['armor_category'],
        armor_class: json['armor_class']['base'].toString(),
        stealth_disadvantage: json['stealth_disadvantage'].toString(),
        properties: mountprop(),
        armor_str_minimum: json['str_minimum']?.toString(),
        dex_bonus: json['armor_class']['dex_bonus']?.toString(),
        max_bonus: json['armor_class']['max_bonus']?.toString(),
      );
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
        damage_type: json['damage']?['damage_type']['name'],
      );
    }
    return Equipment(
      name: json['name'],
      cost: "${json['cost']['quantity']} ${json['cost']['unit']}",
      weight: json['weight'].toString(),
      category: json['equipment_category']['name'],
      properties: mountprop(),
      desc: json['desc']?.join(''),
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
  final String? damage_type;

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
    required this.damage_type,
  });

  @override
  Map<String, dynamic> get toMap => {
        'name': name,
        'cost': cost,
        'weight': weight,
        'category': category,
        'damage': damage,
        'weapon_range': weapon_range,
        'properties': properties,
        'weapon_category': weapon_category,
        'two_handed_damage': two_handed_damage,
        'weapon_range_long': weapon_range_long,
        'normal_range': normal_range,
        'damage_type': damage_type,
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
      damage_type: json['damage']['damage_type']['name'],
    );
  }
}

// Armor is a model that holds all the information about a armor
// it extends Equipment
// but has additional properties specific to armor from equipment.json
class Armor extends Equipment {
  final String? armor_class;
  final String? armor_category;
  final String? armor_str_minimum;
  final String? stealth_disadvantage;
  final String? dex_bonus;
  final String? max_bonus;

  Armor({
    required super.name,
    required super.cost,
    required super.weight,
    required super.category,
    required super.properties,
    required this.armor_class,
    required this.armor_category,
    required this.armor_str_minimum,
    required this.stealth_disadvantage,
    required this.dex_bonus,
    required this.max_bonus,
  });

  @override
  Map<String, dynamic> get toMap => {
        'name': name,
        'cost': cost,
        'weight': weight,
        'category': category,
        'armor_class': armor_class,
        'armor_category': armor_category,
        'armor_str_minimum': armor_str_minimum,
        'stealth_disadvantage': stealth_disadvantage,
        'properties': properties,
        'dex_bonus': dex_bonus,
        'max_bonus': max_bonus,
      };

  factory Armor.fromJson(Map<String, dynamic> json) {
    String mountprop() {
      String prop = "";
      if (json['properties'] == null) return prop;
      for (Map property in json['properties']) {
        prop += "${property['name']}, ";
      }
      if (prop.isNotEmpty) prop = prop.substring(0, prop.length - 3);
      return prop;
    }

    return Armor(
      name: json['name'],
      cost: "${json['cost']['quantity']} ${json['cost']['unit']}",
      weight: json['weight'],
      category: json['equipment_category']['name'],
      properties: mountprop(),
      armor_class: json['armor_class']['base'].toString(),
      armor_category: json['armor_category'],
      armor_str_minimum: json['str_minimum'].toString(),
      stealth_disadvantage: json['stealth_disadvantage'].toString(),
      dex_bonus: json['armor_class']['dex_bonus'].toString(),
      max_bonus: json['armor_class']['max_bonus'].toString(),
    );
  }
}
