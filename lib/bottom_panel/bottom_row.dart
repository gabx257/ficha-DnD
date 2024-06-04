import 'package:ficha/core/dropdown_selection.dart';
import 'package:flutter/material.dart';

import '../models/spells.dart';

class BottomRow extends StatelessWidget {
  const BottomRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Abilities(title: "Abilities"),
        ToolsEProficiencies(
          title: "Tools & Proficiencies",
        )
      ],
    );
  }
}

class Abilities extends ListingBox<SpellList> {
  const Abilities(
      {super.key, super.title, super.height = 300, super.width = 725});
}

class ToolsEProficiencies extends ListingBox<SpellList> {
  const ToolsEProficiencies(
      {super.key, super.title, super.height = 300, super.width = 725});
}
