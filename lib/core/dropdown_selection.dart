import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ficha/core/list_selector.dart';
import 'package:ficha/core/notifiers/current_loaded_data.dart';
import 'package:ficha/core/shadowbox.dart';
import 'package:ficha/core/singletons/singletons.dart';
import 'package:ficha/core/textinput.dart';
import 'package:ficha/models/basemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownSelection extends StatelessWidget {
  final String? value;
  final List<String> items;
  final void Function(String?)? onChanged;
  final TextEditingController searchController = TextEditingController();

  DropDownSelection(
      {super.key, this.value, required this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      dropdownSearchData: DropdownSearchData(
        searchController: searchController,
        searchInnerWidget: TextInputBox(
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
      iconStyleData: const IconStyleData(
        icon: Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Icons.arrow_downward),
        ),
        iconSize: 24,
      ),
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
  const ListingBox(
      {super.key, this.title = "", this.height = 580, this.width = 600});

  final String title;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final T fullList = context.read<Singletons>().returnRelevantModel<T>();

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
          child: Text(title),
        ),
        Flexible(
          child: Selector<CurrentLoadedData, T?>(
            selector: (context, data) => data.get<T>(),
            builder: (c, d, w) => ListSelector<T>(
              itens: d?.map((e) => Item<T>(name: e.name)).toList() ?? [],
              list: fullList,
            ),
          ),
        )
      ],
    );
  }
}
