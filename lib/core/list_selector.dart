import 'package:ficha/core/notifiers/description_drawer.dart';
import 'package:ficha/core/notifiers/dropdown_selection.dart';
import 'package:ficha/models/basemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Dropdownselection.dart';

class ListSelector extends StatelessWidget {
  const ListSelector({super.key, required this.itens, required this.list});

  final List<Widget> itens;

  final BaseModelsList list;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DropDownSelectionNotifier>();
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: ListView(children: [
        ...itens,
        ControlInterface(
          itemList: list,
          value: "choose an item",
          onChanged: (v) {
            if (v == null) return;
            itens.add(Item(
              list: list,
              item: v,
              itens: itens,
            ));
            controller.add(v);
          },
        )
      ]),
    ));
  }
}

// ---------------------------------------------------------------------------
// InventoryItem is a widget that represents an item in the inventory
// it has a checkbox, a text and a button to open the info drawer
// it also has a button to remove itself from the inventory
// it is used by the Inventory widget
// it is used by the InventoryControlInterface widget
class Item extends StatelessWidget {
  const Item(
      {super.key, required this.item, required this.itens, required this.list});

  final String item;
  final List<Widget> itens;
  final BaseModelsList list;

  @override
  Widget build(BuildContext context) {
    final dropDownState = context.watch<DropDownSelectionNotifier>();
    final drawerState = context.watch<DescriptionDrawerNotifier>();
    return Container(
      padding: const EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: const Color.fromARGB(94, 0, 0, 0),
          border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
          borderRadius: BorderRadius.circular(5)),
      height: 50,
      width: 600,
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (v) {}),
          const SizedBox(width: 10),
          Text(
            item,
            style: const TextStyle(
                fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),
            textAlign: TextAlign.start,
          ),
          IconButton(
              onPressed: () {
                drawerState.info = list[item];
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.help_outline_sharp)),
          const Spacer(),
          IconButton(
              onPressed: () {
                itens.remove(this);
                dropDownState.remove(item);
              },
              icon: const Icon(Icons.remove_circle_outline_sharp))
        ],
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// InventoryControlInterface is a widget that controls the inventory
// it has a button to add a new item to the inventory
// it has a button to cancel the add operation
// it is used by the Inventory widget
class ControlInterface extends StatefulWidget {
  final BaseModelsList itemList;
  final void Function(String?) onChanged;
  final String value;
  const ControlInterface(
      {super.key,
      required this.itemList,
      required this.onChanged,
      required this.value});

  @override
  State<ControlInterface> createState() => _ControlInterfaceState();
}

class _ControlInterfaceState extends State<ControlInterface> {
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
          items: widget.itemList.names.toList(),
          onChanged: widget.onChanged,
        ),
        IconButton(
            onPressed: () => setState(() => isEditing = false),
            icon: const Icon(Icons.cancel_outlined))
      ],
    );
  }
}

// ----------------------------------------------------------------------------
// DescriptionDrawer is a widget that update the info of an item
// to be displayed on the info drawer
// it is used by the InventoryItem widget
class DescriptionDrawer<T extends BaseModel> extends StatelessWidget {
  const DescriptionDrawer({super.key});

  // function build List of TextSpan
  // create a List of TextSpan to be used on the RichText Widget
  // loop though controller.info atributtes
  // considering that controller.info is of type T
  // and make a TextSpan for each one
  List<TextSpan> buildTextSpanList(DescriptionDrawerNotifier state) {
    state.info = state.info as T;
    List<TextSpan> list = [];
    for (MapEntry<String, dynamic> item in state.info.iterator) {
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
    final state = context.watch<DescriptionDrawerNotifier>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          text: TextSpan(
        children: buildTextSpanList(state),
      )),
    );
  }
}
