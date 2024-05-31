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
    return Stack(alignment: AlignmentDirectional.center, children: [
      CenterPanelBoxes(
        shape: CustomPaint(
          size: Size(shapesSize, shapesSize),
          painter: HeartShape(
            bodyColor: const Color.fromARGB(255, 255, 17, 0),
            borderColor: Colors.white,
            borderWidth: 5,
            fillPercentage: health.percentage,
          ),
        ),
        size: shapesSize,
      ),
      CenterPanelBoxes(
        text: 'Health',
        value: health.health + health.temphealth,
        shape: CustomPaint(
          size: Size(shapesSize, shapesSize),
          painter: HeartShape(
            bodyColor: const Color.fromARGB(255, 255, 217, 0),
            borderColor: const Color.fromARGB(0, 255, 255, 255),
            borderWidth: 5,
            fillPercentage: (health.percentage - 1),
          ),
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
      children: [TempHealthContainer(), DSaveContainer()],
    );
  }
}

class TempHealthContainer extends StatelessWidget {
  const TempHealthContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 100,
      child: ShadowBox(
        mainAxis: MainAxisAlignment.end,
        innerpadding: 0,
        padding: const <double>[5, 0, 0, 0],
        height: 85,
        crossAxis: CrossAxisAlignment.stretch,
        children: [
          HealthPointsInputBox(),
          Container(
            color: const Color.fromARGB(255, 255, 17, 0),
            child: const Text(
              'bonus HP',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class DSaveContainer extends StatelessWidget {
  const DSaveContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 150,
      child: ShadowBox(
        mainAxis: MainAxisAlignment.start,
        direction: Axis.vertical,
        innerpadding: 0,
        padding: const <double>[5, 0, 0, 0],
        height: 85,
        crossAxis: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: const Color.fromARGB(255, 255, 17, 0),
            child: const Text(
              'D Save',
              textAlign: TextAlign.center,
            ),
          ),
          const SaveLine(text: "Success"),
          const SaveLine(text: "Fail"),
        ],
      ),
    );
  }
}

class SaveLine extends StatefulWidget {
  const SaveLine({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<SaveLine> createState() => _SaveLineState();
}

class _SaveLineState extends State<SaveLine> {
  final List<bool> _value = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            CustomCheckBox(value: _value[0]),
            CustomCheckBox(value: _value[1]),
            CustomCheckBox(value: _value[2]),
            Text(widget.text)
          ],
        ),
      ],
    );
  }
}
