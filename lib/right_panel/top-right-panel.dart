import 'package:ficha/atributes/status-box.dart';
import 'package:ficha/right_panel/inventory.dart';
import 'package:flutter/material.dart';

import '../core/controllers/dropdownselection_controller.dart';
import '../core/shadowbox.dart';
import '../models/model.dart';

class RightPanel extends StatelessWidget {
  RightPanel({
    super.key,
  });
  final spells = SpellList();
  final DropDownSelectionController controller = DropDownSelectionController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TopRightPanel(),
      const ShadowBox(
        height: 180,
        width: 600,
        children: [Text("conjuration")],
      ),
      Inventory(controller: controller)
    ]);
  }
}

class TopRightPanel extends StatelessWidget {
  const TopRightPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Row(children: const [
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

class SavingThrows extends Proficiencies {
  const SavingThrows({super.key, required super.proficiencies});
}
