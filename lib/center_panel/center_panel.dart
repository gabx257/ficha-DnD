import 'package:ficha/center_panel/top_panel/centertop_panel.dart';
import 'package:ficha/core/dropdownselection.dart';
import 'package:flutter/material.dart';

import '../atributes/status_controller/status_controller.dart';
import '../models/spells.dart';

class CenterColumn extends StatelessWidget {
  const CenterColumn({
    super.key,
    required this.controller,
  });

  final StatusController controller;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 550,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CenterTopPanel(
            controller: controller,
          ),
          const ListingBox<SpellList>(
            title: "Attack",
          )
        ],
      ),
    );
  }
}
