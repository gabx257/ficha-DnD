import 'package:ficha/atributes/status_controller/status_controller.dart';
import 'package:flutter/material.dart';
import 'status_box.dart';

class StatusList extends StatelessWidget {
  final StatusController statusController;
  const StatusList({super.key, required this.statusController});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StatusBoxData(
          attr: 'Strength',
          controller: statusController,
          child: const StatusBox(proficiencies: ['Atletics'])),
      StatusBoxData(
          attr: 'Dexterity',
          controller: statusController,
          child: const StatusBox(
              proficiencies: ['Acrobatics', 'Sneaky', 'Sleight of hands'])),
      StatusBoxData(
          controller: statusController,
          attr: 'Constitution',
          child: const StatusBox(proficiencies: [])),
      StatusBoxData(
          controller: statusController,
          attr: 'Intelligence',
          child: const StatusBox(proficiencies: [
            'Arcana',
            'History',
            'Investigation',
            'Nature',
            'Religion'
          ])),
      StatusBoxData(
          controller: statusController,
          attr: 'Wisdom',
          child: const StatusBox(proficiencies: [
            'Intuition',
            'Animal Handling',
            'Medicine',
            'Perception',
            'Survival'
          ])),
      StatusBoxData(
          controller: statusController,
          attr: 'Charisma',
          child: const StatusBox(proficiencies: [
            'Performance',
            'Deception',
            'Intimidation',
            'Persuasion'
          ]))
    ]);
  }
}
