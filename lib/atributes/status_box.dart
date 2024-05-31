import 'package:ficha/atributes/notifiers/status.dart';
import 'package:ficha/core/checkbox.dart';
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
        Atributes(
          attr: attr,
        ),
        Proficiencies(proficiencies: proficiencies, attr: attr),
      ],
    );
  }
}

class Atributes extends StatelessWidget {
  final String attr;
  const Atributes({super.key, required this.attr});

  @override
  Widget build(BuildContext context) {
    final StatusNotifier status = context.watch<StatusNotifier>();
    return ShadowBox(
      padding: 5,
      mainAxis: MainAxisAlignment.spaceAround,
      width: 100,
      children: [
        Text(attr),
        Flexible(
          flex: 70,
          child: TextInputBox(
            onChanged: (event) => status.status[attr] = int.tryParse(event)!,
            filled: true,
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 50,
          child: Container(
            width: 60,
            height: 35,
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 10, 15, 70), width: 1),
                borderRadius: const BorderRadius.all(Radius.elliptical(60, 35)),
                color: Colors.white),
            child: Center(
              child: Text(
                ((status.status[attr]! - 10) ~/ 2).toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ProficiencieLine extends StatelessWidget {
  const ProficiencieLine(
      {super.key, required this.proficiency, required this.attr});
  final String proficiency;
  final String attr;

  @override
  Widget build(BuildContext context) {
    final StatusNotifier status = context.watch<StatusNotifier>();
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          const CustomCheckBox(value: false),
          Padding(
            padding: const EdgeInsets.only(bottom: 3, right: 2),
            child: Text(proficiency),
          ),
          Text((((status.status[attr] ?? 10) - 10) ~/ 2).toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  backgroundColor: Color.fromARGB(40, 255, 255, 255),
                  fontSize: 10))
        ],
      ),
    );
  }
}

class Proficiencies extends StatelessWidget {
  const Proficiencies({
    required this.proficiencies,
    required this.attr,
    this.direction = Axis.vertical,
    super.key,
  });
  final List<String> proficiencies;
  final Axis direction;
  final String attr;

  List<ProficiencieLine> makeLine() {
    List<ProficiencieLine> out = [];
    for (String proficiency in proficiencies) {
      out.add(ProficiencieLine(proficiency: proficiency, attr: attr));
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Flex(
            direction: direction,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: makeLine()),
      ),
    );
  }
}
