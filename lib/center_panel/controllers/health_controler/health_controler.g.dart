// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_controler.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HealthControler on _HealthControlerBase, Store {
  Computed<double>? _$percentageComputed;

  @override
  double get percentage =>
      (_$percentageComputed ??= Computed<double>(() => super.percentage,
              name: '_HealthControlerBase.percentage'))
          .value;

  late final _$healthAtom =
      Atom(name: '_HealthControlerBase.health', context: context);

  @override
  int get health {
    _$healthAtom.reportRead();
    return super.health;
  }

  @override
  set health(int value) {
    _$healthAtom.reportWrite(value, super.health, () {
      super.health = value;
    });
  }

  late final _$temphealthAtom =
      Atom(name: '_HealthControlerBase.temphealth', context: context);

  @override
  int get temphealth {
    _$temphealthAtom.reportRead();
    return super.temphealth;
  }

  @override
  set temphealth(int value) {
    _$temphealthAtom.reportWrite(value, super.temphealth, () {
      super.temphealth = value;
    });
  }

  late final _$maxhpAtom =
      Atom(name: '_HealthControlerBase.maxhp', context: context);

  @override
  int get maxhp {
    _$maxhpAtom.reportRead();
    return super.maxhp;
  }

  @override
  set maxhp(int value) {
    _$maxhpAtom.reportWrite(value, super.maxhp, () {
      super.maxhp = value;
    });
  }

  late final _$_HealthControlerBaseActionController =
      ActionController(name: '_HealthControlerBase', context: context);

  @override
  void updateTempHealth(String display) {
    final _$actionInfo = _$_HealthControlerBaseActionController.startAction(
        name: '_HealthControlerBase.updateTempHealth');
    try {
      return super.updateTempHealth(display);
    } finally {
      _$_HealthControlerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
health: ${health},
temphealth: ${temphealth},
maxhp: ${maxhp},
percentage: ${percentage}
    ''';
  }
}
