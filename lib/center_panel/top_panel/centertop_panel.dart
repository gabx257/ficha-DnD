import 'package:ficha/atributes/notifiers/atribute.dart';
import 'package:ficha/center_panel/top_panel/top_panel_containers.dart';
import 'package:ficha/core/notifiers/current_loaded_data.dart';
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
    final attr = context.read<AttributesNotifier>();
    return ShadowBox(
        innerpadding: const [00.0, 10.0, 0.0, 0.0],
        height: 440,
        children: [
          const HealthACContainer(shapesSize: 150),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Selector<CurrentLoadedData, int?>(
              selector: (context, data) =>
                  data.character.level?.proficiencyModifier,
              builder: (c, d, w) => CenterPanelBoxes(
                text: 'Proficiency',
                shape: const ShadowBox(width: 150),
                value: d ?? 2,
                fontsize: 13,
                size: 150,
              ),
            ),
            CenterPanelBoxes(
              text: 'Initiative',
              shape: const ShadowBox(
                width: 150,
              ),
              size: 150,
              value: (attr.dexterity.modifier),
            ),
            const CenterPanelBoxes(
              text: 'Moviment',
              shape: ShadowBox(
                width: 150,
              ),
              size: 150,
            ),
          ])
        ]);
  }
}
