import 'package:ficha/core/shadowbox.dart';
import 'package:ficha/core/textinput.dart';
import 'package:flutter/material.dart';


class StatusBox extends StatelessWidget {
  final List<String> proficiencies;
  final String attr;
  const StatusBox({Key? key, required this.proficiencies, required this.attr})
      : super(key: key);

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
        Proficiencies(proficiencies: proficiencies),
      ],
    );
  }
}


class Atributes extends StatefulWidget {
  final String attr;
  const Atributes({
    Key? key,
    required this.attr,
  }) : super(key: key);

  @override
  State<Atributes> createState() => _AtributesState();
}

class _AtributesState extends State<Atributes> {
  int modifier = 0;
  String val = "10";

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      padding: 5,
      mainAxis: MainAxisAlignment.spaceAround,
      width: 100,
      children: [
        Text(widget.attr),
        Flexible(
          flex: 70,
          child: TextInputBox(
              onChanged: (value) => val = value,
              onTapOutside: (event) => setState(() {
                    modifier = ((int.tryParse(val) ?? 10) - 10) ~/ 2;
                  }),
              onSubmitted: (v) => setState(() {
                    modifier = (int.parse(v) - 10) ~/ 2;
                  }),filled: true,),
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
                modifier.toString(),
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
                  state = s!;
                });
              }),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(widget.proficiency),
          )
        ],
      ),
    );
  }
}


class Proficiencies extends StatelessWidget {
  const Proficiencies({
    required this.proficiencies,
    Key? key,
  }) : super(key: key);
  final List<String> proficiencies;

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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: makeLine()),
      ),
    );
  }
}