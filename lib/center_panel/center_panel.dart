import 'package:ficha/center_panel/top_panel/centertop_panel.dart';
import 'package:ficha/core/dropdownselection.dart';
import 'package:flutter/material.dart';

import '../models/spells.dart';

class CenterColumn extends StatelessWidget {
  const CenterColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const LimitedBox(
      maxWidth: 550,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CenterTopPanel(),
          ListingBox<SpellList>(
            title: "Attack",
          )
        ],
      ),
    );
  }
}
