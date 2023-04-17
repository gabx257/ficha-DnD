import 'package:ficha/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../core/Dropdownselection.dart';
import '../core/controllers/dropdownselection_controller.dart';
import '../core/shadowbox.dart';
import '../models/model.dart';
import 'controllers/drawercontroller.dart';

class Inventory extends StatefulWidget {
  final DropDownSelectionController controller;

  const Inventory({super.key, required this.controller});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  late final List<Widget> itens;

  @override
  void initState() {
    super.initState();
    widget.controller.value = spells.spellNames[0];
    itens = createList();
  }

  List<Widget> createList() {
    List<Widget> list = [];
    for (var item in widget.controller.items) {
      list.add(InventoryItem(item: item));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      mainAxis: MainAxisAlignment.start,
      height: 550,
      width: 600,
      children: [
        Expanded(
          child: Observer(builder: (_) {
            widget.controller.items.length;
            return ListView(children: [
              ...itens,
              InventoryControlInterface(
                spells: equipments,
                value: "choose an item",
                onChanged: (v) {
                  if (v == null) return;
                  itens.add(InventoryItem(item: v));
                  widget.controller.add(v);
                },
              )
            ]);
          }),
        )
      ],
    );
  }
}

class InventoryItem extends StatelessWidget {
  const InventoryItem({
    super.key,
    required this.item,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromARGB(125, 16, 0, 240)),
          borderRadius: BorderRadius.circular(5)),
      height: 50,
      width: 600,
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (v) {}),
          const SizedBox(width: 10),
          Text(
            item,
            style: const TextStyle(fontSize: 15, color: Colors.black),
            textAlign: TextAlign.start,
          ),
          IconButton(
              onPressed: () {
                drawerController.info = equipments[item];
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.help_outline_sharp))
        ],
      ),
    );
  }
}

class InventoryControlInterface extends StatefulWidget {
  final EquipmentList spells;
  final void Function(String?) onChanged;
  final String value;
  const InventoryControlInterface(
      {super.key,
      required this.spells,
      required this.onChanged,
      required this.value});

  @override
  State<InventoryControlInterface> createState() =>
      _InventoryControlInterfaceState();
}

class _InventoryControlInterfaceState extends State<InventoryControlInterface> {
  @override
  void initState() {
    super.initState();
  }

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    if (!isEditing) {
      return Column(
        children: [
          IconButton(
              onPressed: () => setState(() => isEditing = true),
              icon: const Icon(Icons.add))
        ],
      );
    }
    return Column(
      children: [
        DropDownSelection(
          value: widget.value,
          items: widget.spells.equipmentNames,
          onChanged: widget.onChanged,
        ),
        IconButton(
            onPressed: () => setState(() => isEditing = false),
            icon: const Icon(Icons.cancel_outlined))
      ],
    );
  }
}

class DescriptionDrawer<T extends Model> extends StatelessWidget {
  final DescriptionDrawerController controller;
  const DescriptionDrawer({super.key, required this.controller});

  // function build List of TextSpan
  // create a List of TextSpan to be used on the RichText Widget
  // loop though controller.info atributtes
  // considering that controller.info is of type T
  // and make a TextSpan for each one

  List<TextSpan> buildTextSpanList() {
    controller.info = controller.info as T;
    List<TextSpan> list = [];
    for (MapEntry<String, dynamic> item in controller.info.iterator) {
      list.addAll([
        TextSpan(
            text: "${item.key}: ",
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: item.value,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.normal)),
        const TextSpan(text: "\n\n"),
      ]);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
            text: TextSpan(
          children: buildTextSpanList(),
        )),
      );
    });
  }
}
