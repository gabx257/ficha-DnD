// base class for all models
// all models must inherit from this class
// to be used with the DescriptionDrawer

import 'dart:collection';

abstract class JsonConvertableModel {
  Map<String, dynamic> get toMap;

  JsonConvertableModel.fromJson(Map<String, dynamic> json);
}

abstract class BaseModel implements JsonConvertableModel {
  String name;
  BaseModel({required this.name});

  BaseModel.fromJson(Map<String, dynamic> json) : name = json['name'];

  String operator [](String name) {
    return toMap[name];
  }

  @override
  Map<String, dynamic> get toMap => {
        'name': name,
      };

  @override
  bool operator ==(other) {
    if (other is BaseModel) {
      return other.name == name;
    }
    return false;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name.toString();
  }

  Iterable<MapEntry<String, dynamic>> get iterator => toMap.entries;
}

abstract class BaseModelsList<T extends BaseModel> with ListMixin<T> {
  Iterable<String> get names => map((e) => e.name);

  @override
  int length;

  BaseModelsList.empty() : length = 0;

  BaseModelsList() : length = 0;

  @override
  T operator [](dynamic name) {
    if (name is int) {
      return this[name];
    }
    return firstWhere((element) => element.name == name);
  }

  @override
  void operator []=(dynamic index, T value) {
    if (index is int) {
      this[index] = value;
    }
    for (var element in this) {
      if (element.name == index) {
        element = value;
        break;
      }
    }
  }
}

class DefaultModel extends BaseModel {
  DefaultModel({required super.name});
}
