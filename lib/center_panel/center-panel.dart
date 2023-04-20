import 'package:ficha/center_panel/top_panel/centertop_panel.dart';
import 'package:ficha/main.dart';
import 'package:flutter/material.dart';

import '../atributes/status_controller/StatusController.dart';
import 'attacks.dart';

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
          AttackList(
            list: spells,
            title: "Attack",
          )
        ],
      ),
    );
  }
}
