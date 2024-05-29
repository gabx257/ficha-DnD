// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'model.dart';

// EquipmentList is a singleton class that holds all equipment
// it is used to populate the dropdowns in the EquipmentList
// and to get the equipment description to be displayed in the DescriptionDrawer
class EquipmentList extends ModelList<Equipament> {
  EquipmentList() {
    final List equipamentJson =
        jsonDecode(File("assets/equipaments.json").readAsStringSync());
    for (Map<String, dynamic> equipament in equipamentJson) {
      add(Equipament.fromJson(equipament));
    }
  }

  EquipmentList.Empty();
}

// Equipment is a model that holds all the information about a equipment
// it is used to populate the dropdowns in the EquipmentList
// and to get the equipment description to be displayed in the DescriptionDrawer
class Equipament extends Model {
  final String? cost;
  final String? weight;
  final String? category;
  final String? properties;
  final String? desc;

  Equipament({
    required super.name,
    this.cost,
    this.weight,
    this.category,
    this.properties,
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

  factory Equipament.fromJson(Map<String, dynamic> json) {
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
    return Equipament(
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
class Weapon extends Equipament {
  final String? damage;
  final String? weapon_range;
  final String? weapon_category;
  final String? two_handed_damage;
  final String? weapon_range_long;
  final String? normal_range;
  final String? damage_type;

  Weapon({
    required super.name,
    super.cost,
    super.weight,
    super.category,
    super.properties,
    this.damage,
    this.weapon_range,
    this.weapon_category,
    this.two_handed_damage,
    this.weapon_range_long,
    this.normal_range,
    this.damage_type,
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
class Armor extends Equipament {
  final String? armor_class;
  final String? armor_category;
  final String? armor_str_minimum;
  final String? stealth_disadvantage;
  final String? dex_bonus;
  final String? max_bonus;

  Armor({
    required super.name,
    super.cost,
    super.weight,
    super.category,
    super.properties,
    this.armor_class,
    this.armor_category,
    this.armor_str_minimum,
    this.stealth_disadvantage,
    this.dex_bonus,
    this.max_bonus,
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
