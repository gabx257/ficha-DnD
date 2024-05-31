import 'package:ficha/atributes/notifiers/status.dart';
import 'package:ficha/core/checkbox.dart';
import 'package:ficha/core/dropdownselection.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/shadowbox.dart';
import '../models/equipaments.dart';

class RightPanel extends StatelessWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      TopRightPanel(),
      ShadowBox(
        height: 180,
        width: 600,
        children: [Text("conjuration")],
      ),
      ListingBox<EquipmentList>(
        title: "Inventory",
      ),
    ]);
  }
}

class TopRightPanel extends StatelessWidget {
  const TopRightPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 250,
      child: Row(children: [
        ShadowBox(
          height: 200,
          width: 200,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("Saving Throws"),
            ),
            SavingThrows(proficiencies: [
              "Strength",
              "Dexterity",
              "Constitution",
              "Intelligence",
              "Wisdom",
              "Charisma"
            ])
          ],
        ),
        SizedBox(width: 400, child: SpecialResources())
      ]),
    );
  }
}

class SpecialResources extends StatelessWidget {
  const SpecialResources({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ShadowBox(
      height: 200,
      children: [Text("special resouces")],
    );
  }
}

class SavingThrows extends StatelessWidget {
  const SavingThrows({
    required this.proficiencies,
    this.direction = Axis.vertical,
    super.key,
  });
  final List<String> proficiencies;
  final Axis direction;

  List<SavingThrowsLine> makeLine() {
    List<SavingThrowsLine> out = [];
    for (String proficiency in proficiencies) {
      out.add(SavingThrowsLine(proficiency: proficiency));
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Flex(
            direction: direction,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: makeLine()),
      ),
    );
  }
}

class SavingThrowsLine extends StatelessWidget {
  const SavingThrowsLine({super.key, required this.proficiency});
  final String proficiency;

  @override
  Widget build(BuildContext context) {
    final StatusNotifier controller = context.read<StatusNotifier>();
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          const CustomCheckBox(value: false),
          Padding(
            padding: const EdgeInsets.only(bottom: 3, right: 2),
            child: Text(proficiency),
          ),
          Text((((controller.status[proficiency] ?? 0) - 10) ~/ 2).toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  backgroundColor: Color.fromARGB(40, 255, 255, 255),
                  fontSize: 10))
        ],
      ),
    );
  }
}
