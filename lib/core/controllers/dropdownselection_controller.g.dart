// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdownselection_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DropDownSelectionController on _DropDownSelectionControllerBase, Store {
  late final _$valueAtom =
      Atom(name: '_DropDownSelectionControllerBase.value', context: context);

  @override
  String get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(String value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$itemsAtom =
      Atom(name: '_DropDownSelectionControllerBase.items', context: context);

  @override
  ObservableList<String> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<String> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$_DropDownSelectionControllerBaseActionController =
      ActionController(
          name: '_DropDownSelectionControllerBase', context: context);

  @override
  void add(String item) {
    final _$actionInfo = _$_DropDownSelectionControllerBaseActionController
        .startAction(name: '_DropDownSelectionControllerBase.add');
    try {
      return super.add(item);
    } finally {
      _$_DropDownSelectionControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
items: ${items}
    ''';
  }
}
