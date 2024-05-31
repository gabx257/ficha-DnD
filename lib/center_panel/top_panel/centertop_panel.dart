import 'package:ficha/atributes/notifiers/status.dart';
import 'package:ficha/center_panel/top_panel/top_panel_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/shadowbox.dart';
import 'armor_hitdie.dart';
import 'health_container.dart';

class HealthACContainer extends StatelessWidget {
  final double shapesSize;
  final double containersSize;
  const HealthACContainer({
    this.shapesSize = 120,
    this.containersSize = 80,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AllHealthContainers(shapesSize: shapesSize),
        ACAndHitDie(
          shapesSize: shapesSize,
        ),
      ],
    );
  }
}

class CenterTopPanel extends StatelessWidget {
  const CenterTopPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<StatusNotifier>();
    return ShadowBox(
        innerpadding: const [00.0, 20.0, 0.0, 0.0],
        height: 430,
        children: [
          const HealthACContainer(shapesSize: 150),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const CenterPanelBoxes(
                text: 'Proficiencie',
                shape: SquareBox(),
                fontsize: 13,
                size: 100,
                alignment: MainAxisAlignment.spaceBetween),
            CenterPanelBoxes(
              text: 'Initiative',
              alignment: MainAxisAlignment.spaceBetween,
              shape: const SquareBox(),
              value: (controller.status['Dexterity']! - 10) ~/ 2,
            ),
            const CenterPanelBoxes(
              text: 'Moviment',
              shape: SquareBox(),
              alignment: MainAxisAlignment.spaceBetween,
            ),
            const CenterPanelBoxes(
              text: 'NAO SEI',
              shape: SquareBox(),
              alignment: MainAxisAlignment.spaceBetween,
            )
          ])
        ]);
  }
}
