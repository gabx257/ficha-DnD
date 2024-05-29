// ignore_for_file: non_constant_identifier_names

// base class for all models
// all models must inherit from this class
// to be used with the DescriptionDrawer

class Model {
  String name;

  Model({
    this.name = "",
  });

  String operator [](String name) {
    return toMap[name];
  }

  Map<String, dynamic> get toMap => {
        'name': name,
      };

  @override
  bool operator ==(other) {
    if (other is Model) {
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

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(name: json['name']);
  }

  Iterable<MapEntry<String, dynamic>> get iterator => toMap.entries;
}

abstract class ModelList<T extends Model> {
  final List<T> _list = [];

  void add(T model) {
    _list.add(model);
  }

  List<String> get names => _list.map((e) => e.name).toList();

  T operator [](dynamic name) {
    if (name is int) {
      return _list[name];
    }
    return _list.firstWhere((element) => element.name == name);
  }

  int get length => _list.length;

  List<String> get nameList => _list.map((e) => e.name).toList();

  Iterable<T> get iterator => _list;
}
