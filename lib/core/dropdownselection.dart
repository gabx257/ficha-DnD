import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ficha/core/shadowbox.dart';
import 'package:ficha/core/textinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/model.dart';
import '../models/spells.dart';
import 'ListSelector.dart';
import 'controllers/dropdownselectioncontroller/dropdownselection_controller.dart';

class DropDownSelection extends StatelessWidget {
  final String value;
  final List<String> items;
  final void Function(String?)? onChanged;
  final TextEditingController searchController = TextEditingController();

  DropDownSelection(
      {super.key, required this.value, required this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      dropdownSearchData: DropdownSearchData(
        searchController: searchController,
        searchInnerWidget: TextInputBox(
          controller: searchController,
          filter: const [],
        ),
        searchInnerWidgetHeight: 50,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 35, 38, 51),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      isExpanded: true,
      buttonStyleData: ButtonStyleData(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 35, 38, 51),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      hint: Text(value),
      iconStyleData: const IconStyleData(
        icon: Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Icons.arrow_downward),
        ),
        iconSize: 24,
      ),
      style: const TextStyle(color: Color.fromARGB(255, 230, 230, 230)),
      underline: Container(),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            softWrap: false,
          ),
        );
      }).toList(),
    );
  }
}

class ListingBox<T extends ModelList> extends StatefulWidget {
  const ListingBox(
      {super.key,
      this.title = "",
      this.controller,
      this.height = 580,
      this.width = 600});
  final DropDownSelectionController? controller;

  final String title;
  final double height;
  final double width;

  @override
  State<ListingBox> createState() => _ListingBoxStateState<T>();
}

class _ListingBoxStateState<T extends ModelList> extends State<ListingBox> {
  late final List<Widget> itens;
  late final DropDownSelectionController controller;
  final ModelList list = Modular.get<T>();
  final spells = Modular.get<SpellList>();

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? DropDownSelectionController();
    controller.value = "";
    itens = createList();
  }

  List<Widget> createList() {
    List<Widget> list = [];
    for (var item in controller.items) {
      list.add(Item(
        list: spells,
        item: item,
        controller: controller,
        itens: list,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      innerpadding: 0,
      height: widget.height,
      width: widget.width,
      children: [
        Container(
            color: const Color.fromARGB(68, 105, 101, 101),
            width: widget.width,
            height: 40,
            alignment: Alignment.center,
            child: Text(widget.title, style: const TextStyle(fontSize: 20))),
        ListSelector(
          itens: itens,
          controller: controller,
          list: list,
        )
      ],
    );
  }
}
