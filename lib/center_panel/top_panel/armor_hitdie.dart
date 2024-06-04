import 'dart:math';

import 'package:ficha/atributes/notifiers/atribute.dart';
import 'package:ficha/center_panel/notifiers/health.dart';
import 'package:ficha/center_panel/notifiers/hitdie.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/shadowbox.dart';
import 'top_panel_containers.dart';

enum DieType { d4, d6, d8, d10, d12, d20 }

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
        child: AC(shapesSize: shapesSize),
      ),
      const SizedBox(
        height: 20,
      ),
      const HitDieBox()
    ]);
  }
}

class HitDieBox extends StatelessWidget {
  const HitDieBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ShadowBox(
        innerpadding: 10,
        direction: Axis.horizontal,
        height: 85,
        width: 200,
        children: [
          HitdieDisplay(),
          Column(children: [
            HitDieControlpart(size: 30, add: true),
            SizedBox(height: 5),
            HitDieControlpart(size: 30, add: false),
          ]),
        ]);
  }
}

class HitdieDisplay extends StatelessWidget {
  const HitdieDisplay({
    super.key,
  });

  List<DieBox> generateDieBoxes(int dieCount) {
    List<DieBox> list = [];
    for (int i = 0; i < dieCount; i++) {
      list.add(const DieBox(
        dieType: DieType.d6,
        size: 35,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final die = context.watch<HitDieNotifier>();
    List<DieBox> list = generateDieBoxes(die.hitDie);
    return Flexible(
        child: list.length < 8
            ? Wrap(spacing: 0, runSpacing: 0, children: list)
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('${list.length} x '),
                list[0],
              ]));
  }
}

class DieBox extends StatelessWidget {
  const DieBox({
    super.key,
    required this.size,
    required this.dieType,
  });

  final double size;
  final DieType dieType;

  IconData get _getIcon {
    switch (dieType) {
      case DieType.d4:
        return Icons.looks_4;
      case DieType.d6:
        return Icons.looks_6;
      case DieType.d8:
        return Icons.looks_6;
      case DieType.d10:
        return Icons.looks_6;
      case DieType.d12:
        return Icons.looks_6;
      case DieType.d20:
        return Icons.looks_6;
    }
  }

  int get _rollMax {
    switch (dieType) {
      case DieType.d4:
        return 4;
      case DieType.d6:
        return 6;
      case DieType.d8:
        return 8;
      case DieType.d10:
        return 10;
      case DieType.d12:
        return 12;
      case DieType.d20:
        return 20;
    }
  }

  void _onPressed(HealthNotifier health, HitDieNotifier die, int con) {
    health.health += _rollDie(_rollMax) + con.modifier;
    die.decrease();
  }

  int _rollDie(int sides) {
    final Random random = Random();
    return random.nextInt(sides) + 1;
  }

  @override
  Widget build(BuildContext context) {
    final health = context.read<HealthNotifier>();
    final die = context.read<HitDieNotifier>();
    final con = context.read<AttributesNotifier>().constitution;
    return IconButton(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        iconSize: size,
        onPressed: () => _onPressed(health, die, con),
        icon: FittedBox(
          fit: BoxFit.fill,
          child: Icon(
            _getIcon,
          ),
        ));
  }
}

class HitDieControlpart extends StatelessWidget {
  const HitDieControlpart({
    super.key,
    required this.size,
    required this.add,
  });

  final double size;

  final bool add;

  @override
  Widget build(BuildContext context) {
    final dieNotifier = context.read<HitDieNotifier>();
    return IconButton(
        padding: EdgeInsets.zero,
        iconSize: size,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        icon: Icon(add ? Icons.add : Icons.remove),
        onPressed: () => add ? dieNotifier.increase() : dieNotifier.decrease());
  }
}

class AC extends StatelessWidget {
  const AC({
    super.key,
    required this.shapesSize,
  });

  final double shapesSize;

  @override
  Widget build(BuildContext context) {
    return CenterPanelBoxes(
      size: shapesSize,
      text: "AC",
      shape: SvgPicture.asset(
        'assets/Shield.svg',
      ),
    );
  }
}
