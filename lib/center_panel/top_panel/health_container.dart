import 'package:ficha/center_panel/notifiers/health.dart';
import 'package:ficha/core/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/shadowbox.dart';
import '../../core/textinput.dart';
import 'top_panel_containers.dart';

class AllHealthContainers extends StatelessWidget {
  const AllHealthContainers({
    super.key,
    required this.shapesSize,
  });

  final double shapesSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HealthContainer(shapesSize: shapesSize),
        const SizedBox(
          height: 20,
        ),
        const TempHealthDSave()
      ],
    );
  }
}

class HealthContainer extends StatelessWidget {
  const HealthContainer({
    super.key,
    required this.shapesSize,
  });

  final double shapesSize;

  @override
  Widget build(BuildContext context) {
    final health = context.watch<HealthNotifier>();
    return Stack(alignment: AlignmentDirectional.topCenter, children: [
      CenterPanelBoxes(
        shape: HeartShape(
          bodyColor: const Color.fromARGB(255, 255, 17, 0),
          borderColor: Colors.white,
          borderWidth: 5,
          fillPercentage: health.hpPercentage,
        ),
        size: shapesSize,
      ),
      CenterPanelBoxes(
        text: 'Health',
        value: health.health + health.temphealth,
        shape: HeartShape(
          bodyColor: const Color.fromARGB(255, 255, 217, 0),
          borderColor: const Color.fromARGB(0, 255, 255, 255),
          borderWidth: 5,
          fillPercentage: (health.tempHpPercentage),
        ),
        size: shapesSize,
      )
    ]);
  }
}

class TempHealthDSave extends StatelessWidget {
  const TempHealthDSave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [TempHealthContainer(), SizedBox(width: 2), DSaveContainer()],
    );
  }
}

class TempHealthContainer extends StatelessWidget {
  const TempHealthContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      mainAxis: MainAxisAlignment.start,
      innerpadding: const <double>[5, 0, 5, 5],
      height: 85,
      children: [
        Text(
          'bonus HP',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(
            width: 50,
            child: HealthPointsInputBox(
              healthNotifier: context.read<HealthNotifier>(),
            )),
      ],
    );
  }
}

class DSaveContainer extends StatelessWidget {
  const DSaveContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      mainAxis: MainAxisAlignment.start,
      direction: Axis.vertical,
      innerpadding: const <double>[5, 0, 5, 5],
      height: 85,
      children: [
        Text(
          'Death Save',
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        const SaveLine(text: "Success"),
        const SaveLine(text: "Fail"),
      ],
    );
  }
}

class SaveLine extends StatelessWidget {
  const SaveLine({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomCheckBox(),
          const CustomCheckBox(),
          const CustomCheckBox(),
          SizedBox(width: 50, child: Text(text))
        ],
      ),
    );
  }
}
