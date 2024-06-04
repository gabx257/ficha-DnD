import 'package:ficha/atributes/notifiers/atribute.dart';
import 'package:ficha/atributes/notifiers/proficiencies.dart';
import 'package:ficha/core/checkbox.dart';
import 'package:ficha/core/notifiers/current_loaded_data.dart';
import 'package:ficha/core/shadowbox.dart';
import 'package:ficha/core/textinput.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusBox extends StatelessWidget {
  final List<String> proficiencies;
  final String attr;
  const StatusBox({super.key, required this.proficiencies, required this.attr});

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      innerpadding: 10,
      width: 300,
      height: 150,
      mainAxis: MainAxisAlignment.start,
      direction: Axis.horizontal,
      children: [
        AtributeModifier(
          attr: attr,
        ),
        ChangeNotifierProvider(
            create: (context) =>
                ProficienciesNotifier(attr: attr, proficiencies: proficiencies),
            child: ProficiencyList(proficiencies: proficiencies, attr: attr)),
      ],
    );
  }
}

class AtributeModifier extends StatelessWidget {
  final String attr;
  const AtributeModifier({super.key, required this.attr});

  @override
  Widget build(BuildContext context) {
    final AttributesNotifier status = context.read<AttributesNotifier>();
    return ShadowBox(
      padding: 5,
      innerpadding: 0,
      mainAxis: MainAxisAlignment.spaceAround,
      width: 100,
      children: [
        Text(
          attr,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Atribute(status: status, attr: attr),
        Modifier(attr: attr)
      ],
    );
  }
}

class Atribute extends StatelessWidget {
  const Atribute({
    super.key,
    required this.status,
    required this.attr,
  });

  final AttributesNotifier status;
  final String attr;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 40,
      child: TextInputBox(
        onChanged: (event) {
          status[attr] = int.tryParse(event) ?? 10;
        },
        filled: true,
      ),
    );
  }
}

class Modifier extends StatelessWidget {
  const Modifier({
    super.key,
    required this.attr,
  });

  final String attr;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 35,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(60, 35)),
          color: Colors.white),
      child: Center(
        child: Selector<AttributesNotifier, int>(
          selector: (_, n) => n[attr]!,
          builder: (c, atr, w) {
            return Text(
              atr.modifier.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}

class ProficiencyList extends StatelessWidget {
  const ProficiencyList({
    required this.proficiencies,
    required this.attr,
    this.direction = Axis.vertical,
    super.key,
  });
  final List<String> proficiencies;
  final Axis direction;
  final String attr;

  List<Proficiency> makeLine(BuildContext context) {
    List<Proficiency> out = [];
    for (String proficiency in proficiencies) {
      out.add(Proficiency(proficiency: proficiency, attr: attr));
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Flex(
          direction: direction,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: makeLine(context)),
    );
  }
}

class Proficiency extends StatelessWidget {
  const Proficiency({super.key, required this.proficiency, required this.attr});
  final String proficiency;
  final String attr;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          CustomCheckBox(
            value: false,
            onChanged: (value) => context
                .read<ProficienciesNotifier>()[proficiency] = value ?? false,
          ),
          Text(proficiency, style: Theme.of(context).textTheme.labelSmall),
          BonusModifierTotal(attr: attr, proficiency: proficiency)
        ],
      ),
    );
  }
}

class BonusModifierTotal extends StatelessWidget {
  const BonusModifierTotal({
    super.key,
    required this.attr,
    required this.proficiency,
  });

  final String attr;
  final String proficiency;

  @override
  Widget build(BuildContext context) {
    var mod =
        context.watch<CurrentLoadedData>().character.level?.proficiencyModifier;
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child: Selector2<AttributesNotifier, ProficienciesNotifier, (int, bool)>(
        selector: (_, a, p) => (a[attr]!, p[proficiency]!),
        builder: (a, values, c) => Text(
          (values.$1.modifier + (values.$2 ? (mod ?? 2) : 0)).toString(),
          style: Theme.of(context).textTheme.labelMedium!,
        ),
      ),
    );
  }
}
