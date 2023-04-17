import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ficha/core/textinput.dart';
import 'package:flutter/material.dart';

class DropDownSelection extends StatelessWidget {
  final String value;
  final List<String> items;
  final void Function(String?)? onChanged;
  final TextEditingController searchController = TextEditingController();

  DropDownSelection(
      {super.key, required this.value, required this.items, this.onChanged});

  //regex for words only

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      searchController: searchController,
      searchInnerWidget: TextInputBox(
        controller: searchController,
        filter: const [],
      ),
      searchInnerWidgetHeight: 50,
      dropdownMaxHeight: 200,
      dropdownDecoration: BoxDecoration(
        color: const Color.fromARGB(255, 35, 38, 51),
        borderRadius: BorderRadius.circular(10),
      ),
      isExpanded: true,
      buttonDecoration: BoxDecoration(
        color: const Color.fromARGB(255, 35, 38, 51),
        borderRadius: BorderRadius.circular(10),
      ),
      hint: Text(value),
      icon: const Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(Icons.arrow_downward),
      ),
      iconSize: 24,
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
