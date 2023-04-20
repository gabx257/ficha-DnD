import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/shadowbox.dart';
import 'top_panel_containers.dart';
import '../controllers/health_controler/health_controler.dart';
import '../controllers/hitdie_controler/hitdie_controler.dart';

class ACAndHitDie extends StatelessWidget {
  const ACAndHitDie({
    super.key,
    required this.shapesSize,
    required this.controller,
    required this.dieController,
  });

  final double shapesSize;
  final HealthControler controller;
  final HitDieController dieController;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: CenterPanelBoxes(
          size: shapesSize,
          text: "AC",
          shape: SvgPicture.asset(
            'assets/Shield.svg',
            // ignore: deprecated_member_use
            color: const Color.fromARGB(255, 129, 137, 179),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      HitDieBox(controller: controller, dieController: dieController)
    ]);
  }
}

class DieBox extends StatelessWidget {
  const DieBox({
    super.key,
    required this.size,
    this.text = 'd6',
    this.color = const Color.fromARGB(255, 255, 217, 0),
    this.controller,
    required this.dieController,
  });

  final double size;
  final String text;
  final Color color;
  final HealthControler? controller;
  final HitDieController dieController;

  void onPressed() {
    controller?.health += rollDie(int.parse(text.substring(1)));
    dieController.hitDie -= 1;
  }

  int rollDie(int sides) {
    final Random random = Random();
    return random.nextInt(sides) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: size,
      maxHeight: size,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: TextButton(
          //remove the button text decoration
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
                decoration: TextDecoration.none, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class HitDieControlpart extends StatelessWidget {
  const HitDieControlpart({
    super.key,
    required this.size,
    required this.hitDieController,
    required this.add,
    required this.color,
  });

  final double size;
  final HitDieController hitDieController;
  final bool add;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: size,
      maxHeight: size,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: TextButton(
          onPressed: () =>
              add ? hitDieController.increment() : hitDieController.decrement(),
          child: Text(
            add ? '+' : '-',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class HitDieBox extends StatelessWidget {
  const HitDieBox({
    super.key,
    required this.controller,
    required this.dieController,
  });

  final HealthControler controller;
  final HitDieController dieController;

  List<DieBox> generateDieBoxes() {
    List<DieBox> list = [];
    for (int i = 0; i < dieController.hitDie; i++) {
      list.add(DieBox(
        dieController: dieController,
        size: 30,
        controller: controller,
        color: const Color.fromARGB(255, 255, 17, 0),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 250,
      child: ShadowBox(direction: Axis.horizontal, height: 85, children: [
        Flexible(child: Observer(builder: (_) {
          List<DieBox> list = generateDieBoxes();
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ...list.take(6),
                HitDieControlpart(
                  hitDieController: dieController,
                  size: 30,
                  add: true,
                  color: Colors.green,
                )
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ...list.skip(6),
                HitDieControlpart(
                    hitDieController: dieController,
                    size: 30,
                    add: false,
                    color: Colors.red)
              ])
            ],
          );
        }))
      ]),
    );
  }
}
