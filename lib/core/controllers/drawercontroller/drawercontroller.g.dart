// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawercontroller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DescriptionDrawerController on _DescriptionDrawerControllerBase, Store {
  late final _$infoAtom =
      Atom(name: '_DescriptionDrawerControllerBase.info', context: context);

  @override
  Model get info {
    _$infoAtom.reportRead();
    return super.info;
  }

  @override
  set info(Model value) {
    _$infoAtom.reportWrite(value, super.info, () {
      super.info = value;
    });
  }

  @override
  String toString() {
    return '''
info: ${info}
    ''';
  }
}
