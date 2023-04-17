import 'package:ficha/center_panel/controllers/hitdie_controler/hitdie_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../core/shadowbox.dart';
import 'ACHitDie.dart';
import 'center_panel_widgets.dart';
import 'controllers/health_controler/health_controler.dart';
import 'controllers/status_controller/StatusController.dart';
import 'HealthContainer.dart';

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
          const ShadowBox(
            height: 580,
            children: [Text("attacks")],
          )
        ],
      ),
    );
  }
}

class CenterTopPanel extends StatelessWidget {
  final StatusController controller;
  const CenterTopPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
        innerpadding: const [00.0, 20.0, 0.0, 0.0],
        height: 400,
        children: [
          HealthACContainer(shapesSize: 150),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const CenterPanelBoxes(
                text: 'Proficiencie',
                shape: SquareBox(),
                fontsize: 13,
                size: 100,
                alignment: MainAxisAlignment.spaceBetween),
            Observer(builder: (_) {
              return CenterPanelBoxes(
                text: 'Initiative',
                alignment: MainAxisAlignment.spaceBetween,
                shape: const SquareBox(),
                value: (controller.status['Dexterity'] - 10) ~/ 2,
              );
            }),
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

class HealthACContainer extends StatelessWidget {
  final double shapesSize;
  final double containersSize;
  HealthACContainer({
    this.shapesSize = 120,
    this.containersSize = 80,
    super.key,
  });
  final HealthControler controller = HealthControler();
  final HitDieController dieController = HitDieController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AllHealthContainers(shapesSize: shapesSize, controller: controller),
        ACAndHitDie(
          dieController: HitDieController(),
          shapesSize: shapesSize,
          controller: controller,
        ),
      ],
    );
  }
}
