import 'package:flutter/material.dart';
import 'status_box.dart';

class StatusList extends StatelessWidget {
  const StatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      StatusBox(attr: 'Strength', proficiencies: ['Atletics']),
      StatusBox(
          attr: 'Dexterity',
          proficiencies: ['Acrobatics', 'Sneaky', 'Sleight of hands']),
      StatusBox(attr: 'Constitution', proficiencies: []),
      StatusBox(attr: 'Intelligence', proficiencies: [
        'Arcana',
        'History',
        'Investigation',
        'Nature',
        'Religion'
      ]),
      StatusBox(attr: 'Wisdom', proficiencies: [
        'Intuition',
        'Animal Handling',
        'Medicine',
        'Perception',
        'Survival'
      ]),
      StatusBox(attr: 'Charisma', proficiencies: [
        'Performance',
        'Deception',
        'Intimidation',
        'Persuasion'
      ])
    ]);
  }
}
