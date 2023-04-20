import 'package:ficha/atributes/status_controller/StatusController.dart';
import 'package:ficha/core/shadowbox.dart';
import 'package:ficha/core/textinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class StatusBoxData extends InheritedWidget {
  final StatusController controller;
  final String attr;
  const StatusBoxData(
      {super.key,
      required super.child,
      required this.controller,
      required this.attr});

  @override
  bool updateShouldNotify(covariant StatusBoxData oldWidget) {
    return oldWidget.controller != controller;
  }

  static StatusBoxData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StatusBoxData>();
  }
}

class StatusBox extends StatelessWidget {
  final List<String> proficiencies;
  const StatusBox({Key? key, required this.proficiencies}) : super(key: key);

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
          attr: StatusBoxData.of(context)!.attr,
        ),
        Proficiencies(proficiencies: proficiencies),
      ],
    );
  }
}

class Atributes extends StatelessWidget {
  final String attr;
  const Atributes({super.key, required this.attr});

  @override
  Widget build(BuildContext context) {
    final StatusController controller =
        StatusBoxData.of(context)?.controller ?? StatusController();
    return ShadowBox(
      padding: 5,
      mainAxis: MainAxisAlignment.spaceAround,
      width: 100,
      children: [
        Text(attr),
        Flexible(
          flex: 70,
          child: TextInputBox(
            onChanged: (event) =>
                controller.status[attr] = int.tryParse(event) ?? 10,
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
              child: Observer(builder: (_) {
                return Text(
                  (((controller.status[attr] ?? 10) - 10) ~/ 2).toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                );
              }),
            ),
          ),
        )
      ],
    );
  }
}

class ProficiencieLine extends StatefulWidget {
  const ProficiencieLine({Key? key, required this.proficiency})
      : super(key: key);
  final String proficiency;

  @override
  State<ProficiencieLine> createState() => _ProficiencieLineState();
}

class _ProficiencieLineState extends State<ProficiencieLine> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    final StatusController controller = StatusBoxData.of(context)!.controller;
    final String attr = StatusBoxData.of(context)!.attr;
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          Checkbox(
              activeColor: const Color.fromARGB(255, 23, 71, 191),
              checkColor: Colors.white,
              splashRadius: 7,
              shape: const CircleBorder(),
              value: state,
              onChanged: (s) {
                setState(() {
                  state = s ?? false;
                });
              }),
          Padding(
            padding: const EdgeInsets.only(bottom: 3, right: 2),
            child: Text(widget.proficiency),
          ),
          Observer(builder: (_) {
            return Text(
                (((controller.status[attr] ?? 10) - 10) ~/ 2).toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    backgroundColor: Color.fromARGB(40, 255, 255, 255),
                    fontSize: 10));
          })
        ],
      ),
    );
  }
}

class Proficiencies extends StatelessWidget {
  const Proficiencies({
    required this.proficiencies,
    this.direction = Axis.vertical,
    Key? key,
  }) : super(key: key);
  final List<String> proficiencies;
  final Axis direction;

  List<ProficiencieLine> makeLine() {
    List<ProficiencieLine> out = [];
    for (String proficiency in proficiencies) {
      out.add(ProficiencieLine(proficiency: proficiency));
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
