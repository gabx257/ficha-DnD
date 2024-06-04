import 'package:ficha/atributes/notifiers/atribute.dart';
import 'package:ficha/atributes/notifiers/proficiencies.dart';
import 'package:ficha/core/checkbox.dart';
import 'package:ficha/core/dropdown_selection.dart';
import 'package:ficha/core/notifiers/current_loaded_data.dart';

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
            SavingThrows()
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
    super.key,
  });
  final List<String> proficiencies = const [
    "Strength",
    "Dexterity",
    "Constitution",
    "Intelligence",
    "Wisdom",
    "Charisma"
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProficienciesNotifier>(
        create: (_) => ProficienciesNotifier(
            attr: 'savingThrows', proficiencies: proficiencies),
        builder: (_, w) => Column(
            children:
                proficiencies.map((e) => SavingThrowsLine(attr: e)).toList()));
  }
}

class SavingThrowsLine extends StatelessWidget {
  const SavingThrowsLine({super.key, required this.attr});
  final String attr;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          CustomCheckBox(
              value: false,
              onChanged: (v) =>
                  context.read<ProficienciesNotifier>()[attr] = v ?? false),
          Text(attr, style: Theme.of(context).textTheme.labelSmall),
          BonusModifierTotal(attr: attr)
        ],
      ),
    );
  }
}

class BonusModifierTotal extends StatelessWidget {
  const BonusModifierTotal({super.key, required this.attr});

  final String attr;

  @override
  Widget build(BuildContext context) {
    var mod =
        context.watch<CurrentLoadedData>().character.level?.proficiencyModifier;
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child: Selector2<AttributesNotifier, ProficienciesNotifier, (int, bool)>(
        selector: (_, a, p) => (a[attr]!, p[attr]!),
        builder: (a, values, c) => Text(
          (values.$1.modifier + (values.$2 ? (mod ?? 2) : 0)).toString(),
          style: Theme.of(context).textTheme.labelMedium!,
        ),
      ),
    );
  }
}
