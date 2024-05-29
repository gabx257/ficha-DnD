// ignore_for_file: non_constant_identifier_names

// SpellList is a singleton class that holds all spells
// it is used to populate the dropdowns in the SpellList
// and to get the spell description to be displayed in the DescriptionDrawer

import 'dart:convert';
import 'dart:io';

import 'package:ficha/models/basemodel.dart';

// Spell is a model that holds all the information about a spell
// it is used to populate the dropdowns in the SpellList
// and to get the spell description to be displayed in the DescriptionDrawer
class Spell extends BaseModel {
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
    this.desc,
    this.page,
    this.range,
    this.components,
    this.material,
    this.ritual,
    this.duration,
    this.concentration,
    this.casting_time,
    this.level,
    this.school,
    this.classes,
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

class SpellList extends BaseModelsList<Spell> {
  static late final SpellList? _instance;

  SpellList() {
    if (_instance != null) return;
    final List spellsJson =
        jsonDecode(File("assets/spells.json").readAsStringSync());

    for (Map<String, dynamic> spell in spellsJson) {
      add(Spell.fromJson(spell));
    }

    _instance = this;
  }

  SpellList.empty() : super.empty();

  static SpellList get fullList {
    if (_instance == null) {
      return SpellList();
    }
    return _instance!;
  }
}
