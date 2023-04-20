import 'package:ficha/core/dropdownselection.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class BottomRow extends StatelessWidget {
  const BottomRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Abilities(list: spells, title: "Abilities"),
        ToolsEProficiencies(
          list: spells,
          title: "Tools & Proficiencies",
        )
      ],
    );
  }
}

class Abilities extends ListingBox {
  const Abilities(
      {super.key,
      required super.list,
      super.title,
      super.controller,
      super.height = 300,
      super.width = 725});
}

class ToolsEProficiencies extends ListingBox {
  const ToolsEProficiencies(
      {super.key,
      required super.list,
      super.title,
      super.controller,
      super.height = 300,
      super.width = 725});
}
