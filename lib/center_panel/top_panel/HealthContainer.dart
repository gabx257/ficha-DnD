import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/shadowbox.dart';
import '../../core/textinput.dart';
import 'top_panel_containers.dart';
import '../controllers/health_controler/health_controler.dart';

class AllHealthContainers extends StatelessWidget {
  const AllHealthContainers({
    super.key,
    required this.shapesSize,
    required this.controller,
  });

  final double shapesSize;
  final HealthControler controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HealthContainer(shapesSize: shapesSize, controller: controller),
        const SizedBox(
          height: 20,
        ),
        TempHealthDSave(controller: controller)
      ],
    );
  }
}

class HealthContainer extends StatelessWidget {
  const HealthContainer({
    super.key,
    required this.shapesSize,
    required this.controller,
  });

  final double shapesSize;
  final HealthControler controller;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      Observer(builder: (_) {
        return CenterPanelBoxes(
          shape: CustomPaint(
            size: Size(shapesSize, shapesSize),
            painter: HeartShape(
              bodyColor: const Color.fromARGB(255, 255, 17, 0),
              borderColor: Colors.white,
              borderWidth: 5,
              fillPercentage: controller.percentage,
            ),
          ),
          size: shapesSize,
        );
      }),
      Observer(builder: (_) {
        return CenterPanelBoxes(
          text: 'Health',
          value: controller.health + controller.temphealth,
          shape: CustomPaint(
            size: Size(shapesSize, shapesSize),
            painter: HeartShape(
              bodyColor: const Color.fromARGB(255, 255, 217, 0),
              borderColor: const Color.fromARGB(0, 255, 255, 255),
              borderWidth: 5,
              fillPercentage: (controller.percentage - 1),
            ),
          ),
          size: shapesSize,
        );
      }),
    ]);
  }
}

class TempHealthDSave extends StatelessWidget {
  const TempHealthDSave({
    super.key,
    required this.controller,
  });

  final HealthControler controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TempHealthContainer(controller: controller),
        const DSaveContainer()
      ],
    );
  }
}

class TempHealthContainer extends StatelessWidget {
  const TempHealthContainer({
    super.key,
    required this.controller,
  });

  final HealthControler controller;

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
          HealthPointsInputBox(
            hpcontroller: controller,
          ),
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

class DSaveContainer extends StatefulWidget {
  const DSaveContainer({
    super.key,
  });

  @override
  State<DSaveContainer> createState() => _DSaveContainerState();
}

class _DSaveContainerState extends State<DSaveContainer> {
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
            Checkbox(
                activeColor: const Color.fromARGB(255, 23, 71, 191),
                checkColor: Colors.white,
                splashRadius: 7,
                shape: const CircleBorder(),
                value: _value[0],
                onChanged: (s) {
                  setState(() {
                    _value[0] = s!;
                  });
                }),
            Checkbox(
                activeColor: const Color.fromARGB(255, 23, 71, 191),
                checkColor: Colors.white,
                splashRadius: 7,
                shape: const CircleBorder(),
                value: _value[1],
                onChanged: (s) {
                  setState(() {
                    _value[1] = s!;
                  });
                }),
            Checkbox(
                activeColor: const Color.fromARGB(255, 23, 71, 191),
                checkColor: Colors.white,
                splashRadius: 7,
                shape: const CircleBorder(),
                value: _value[2],
                onChanged: (s) {
                  setState(() {
                    _value[2] = s!;
                  });
                }),
            Text(widget.text)
          ],
        ),
      ],
    );
  }
}
