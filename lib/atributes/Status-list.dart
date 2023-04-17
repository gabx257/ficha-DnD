import 'package:flutter/material.dart';

import '../center_panel/controllers/status_controller/StatusController.dart';
import 'status-box.dart';

class StatusList extends StatelessWidget {
  final StatusController controller;
  const StatusList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StatusBoxData(
          controller: controller,
          child:
              const StatusBox(attr: 'Strenght', proficiencies: ['Atletics'])),
      StatusBoxData(
          controller: controller,
          child: const StatusBox(
              attr: 'Dexterity',
              proficiencies: ['Acrobatics', 'Sneaky', 'Sleight of hands'])),
      StatusBoxData(
          controller: controller,
          child: const StatusBox(attr: 'Constitution', proficiencies: [])),
      StatusBoxData(
          controller: controller,
          child: const StatusBox(attr: 'Inteligence', proficiencies: [
            'Arcana',
            'History',
            'Investigation',
            'Nature',
            'Religion'
          ])),
      StatusBoxData(
          controller: controller,
          child: const StatusBox(attr: 'Wisdom', proficiencies: [
            'Intuition',
            'Animal Handling',
            'Medicine',
            'Perception',
            'Survival'
          ])),
      StatusBoxData(
          controller: controller,
          child: const StatusBox(attr: 'Charism', proficiencies: [
            'Performance',
            'Deception',
            'Intimidation',
            'Persuasion'
          ]))
    ]);
  }
}
