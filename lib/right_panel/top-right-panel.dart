import 'package:ficha/atributes/status_controller/status_controller.dart';
import 'package:ficha/core/dropdownselection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../core/controllers/dropdownselectioncontroller/dropdownselection_controller.dart';
import '../core/shadowbox.dart';
import '../models/equipaments.dart';

class RightPanelData extends InheritedWidget {
  final StatusController statusController;
  const RightPanelData({
    super.key,
    required super.child,
    required this.statusController,
  });

  @override
  bool updateShouldNotify(covariant RightPanelData oldWidget) {
    return oldWidget.statusController != statusController;
  }

  static RightPanelData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RightPanelData>();
  }
}

class RightPanel extends StatelessWidget {
  RightPanel({
    super.key,
    required this.statusController,
  });
  final StatusController statusController;
  final DropDownSelectionController controller = DropDownSelectionController();

  @override
  Widget build(BuildContext context) {
    return RightPanelData(
      statusController: statusController,
      child: Column(children: const [
        TopRightPanel(),
        ShadowBox(
          height: 180,
          width: 600,
          children: [Text("conjuration")],
        ),
        ListingBox<EquipmentList>(
          title: "Inventory",
        ),
      ]),
    );
  }
}

class TopRightPanel extends StatelessWidget {
  const TopRightPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Row(children: const [
        ShadowBox(
          height: 200,
          width: 200,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("Saving Throws"),
            ),
            SavingThrows(proficiencies: [
              "Strength",
              "Dexterity",
              "Constitution",
              "Intelligence",
              "Wisdom",
              "Charisma"
            ])
          ],
        ),
        SizedBox(width: 400, child: SpecialResources())
      ]),
    );
  }
}

class SpecialResources extends StatelessWidget {
  const SpecialResources({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ShadowBox(
      height: 200,
      children: [Text("special resouces")],
    );
  }
}

class SavingThrows extends StatelessWidget {
  const SavingThrows({
    required this.proficiencies,
    this.direction = Axis.vertical,
    Key? key,
  }) : super(key: key);
  final List<String> proficiencies;
  final Axis direction;

  List<SavingThrowsLine> makeLine() {
    List<SavingThrowsLine> out = [];
    for (String proficiency in proficiencies) {
      out.add(SavingThrowsLine(proficiency: proficiency));
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

class SavingThrowsLine extends StatefulWidget {
  const SavingThrowsLine({super.key, required this.proficiency});
  final String proficiency;

  @override
  State<SavingThrowsLine> createState() => _SavingThrowsLineState();
}

class _SavingThrowsLineState extends State<SavingThrowsLine> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    final StatusController controller =
        RightPanelData.of(context)!.statusController;
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
            padding: const EdgeInsets.only(bottom: 3, right: 2),
            child: Text(widget.proficiency),
          ),
          Observer(builder: (_) {
            return Text(
                (((controller.status[widget.proficiency] ?? 0) - 10) ~/ 2)
                    .toString(),
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
