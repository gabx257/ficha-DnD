// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hitdie_controler.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HitDieController on _HitDieControllerBase, Store {
  late final _$hitDieAtom =
      Atom(name: '_HitDieControllerBase.hitDie', context: context);

  @override
  int get hitDie {
    _$hitDieAtom.reportRead();
    return super.hitDie;
  }

  @override
  set hitDie(int value) {
    _$hitDieAtom.reportWrite(value, super.hitDie, () {
      super.hitDie = value;
    });
  }

  late final _$_HitDieControllerBaseActionController =
      ActionController(name: '_HitDieControllerBase', context: context);

  @override
  void increment() {
    final _$actionInfo = _$_HitDieControllerBaseActionController.startAction(
        name: '_HitDieControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_HitDieControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement() {
    final _$actionInfo = _$_HitDieControllerBaseActionController.startAction(
        name: '_HitDieControllerBase.decrement');
    try {
      return super.decrement();
    } finally {
      _$_HitDieControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hitDie: ${hitDie}
    ''';
  }
}
