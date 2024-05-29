import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ficha/core/list_selector.dart';
import 'package:ficha/core/shadowbox.dart';
import 'package:ficha/core/singletons/singletons.dart';
import 'package:ficha/core/textinput.dart';
import 'package:ficha/models/basemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class ListingBox<T extends BaseModelsList> extends StatelessWidget {
  ListingBox({super.key, this.title = "", this.height = 580, this.width = 600});

  final String title;
  final double height;
  final double width;

  List<Widget> createList(T l) {
    List<Widget> list = [];
    for (var item in l) {
      list.add(Item(
        item: item.name,
        list: l,
        itens: list,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final T list = context.watch<Singletons>().returnRelevantModel<T>();
    return ShadowBox(
      innerpadding: 0,
      height: height,
      width: width,
      children: [
        Container(
            color: const Color.fromARGB(68, 105, 101, 101),
            width: width,
            height: 40,
            alignment: Alignment.center,
            child: Text(title, style: const TextStyle(fontSize: 20))),
        ListSelector(
          itens: createList(list),
          list: list,
        )
      ],
    );
  }
}
