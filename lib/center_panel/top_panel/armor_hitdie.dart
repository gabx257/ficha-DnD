import 'dart:math';

import 'package:ficha/center_panel/notifiers/health.dart';
import 'package:ficha/center_panel/notifiers/hitdie.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/shadowbox.dart';
import 'top_panel_containers.dart';

class ACAndHitDie extends StatelessWidget {
  const ACAndHitDie({
    super.key,
    required this.shapesSize,
  });

  final double shapesSize;

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
      const HitDieBox()
    ]);
  }
}

class DieBox extends StatelessWidget {
  const DieBox({
    super.key,
    required this.size,
    this.text = 'd6',
    this.color = const Color.fromARGB(255, 255, 217, 0),
  });

  final double size;
  final String text;
  final Color color;

  void _onPressed(HealthNotifier health, HitDieNotifier die) {
    health.health += _rollDie(int.parse(text.substring(1)));
    die.hitDie -= 1;
  }

  int _rollDie(int sides) {
    final Random random = Random();
    return random.nextInt(sides) + 1;
  }

  @override
  Widget build(BuildContext context) {
    final health = context.watch<HealthNotifier>();
    final die = context.watch<HitDieNotifier>();
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
            padding: WidgetStateProperty.all(EdgeInsets.zero),
          ),
          onPressed: () => _onPressed(health, die),
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
    required this.add,
    required this.color,
  });

  final double size;

  final bool add;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final dieNotifier = context.watch<HitDieNotifier>();
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
              add ? dieNotifier.increase() : dieNotifier.decrease(),
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
  });

  List<DieBox> generateDieBoxes(HitDieNotifier die) {
    List<DieBox> list = [];
    for (int i = 0; i < die.hitDie; i++) {
      list.add(const DieBox(
        size: 30,
        color: Color.fromARGB(255, 255, 17, 0),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final die = context.read<HitDieNotifier>();
    List<DieBox> list = generateDieBoxes(die);
    return LimitedBox(
      maxWidth: 250,
      child: ShadowBox(direction: Axis.horizontal, height: 85, children: [
        Flexible(
            child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ...list.take(6),
              const HitDieControlpart(
                size: 30,
                add: true,
                color: Colors.green,
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ...list.skip(6),
              const HitDieControlpart(size: 30, add: false, color: Colors.red)
            ])
          ],
        ))
      ]),
    );
  }
}
