// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StatusController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatusController on _StatusControllerBase, Store {
  late final _$statusAtom =
      Atom(name: '_StatusControllerBase.status', context: context);

  @override
  ObservableMap<dynamic, dynamic> get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(ObservableMap<dynamic, dynamic> value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  @override
  String toString() {
    return '''
status: ${status}
    ''';
  }
}
