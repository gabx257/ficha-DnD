import 'package:mobx/mobx.dart';
part 'dropdownselection_controller.g.dart';

class DropDownSelectionController = _DropDownSelectionControllerBase
    with _$DropDownSelectionController;

abstract class _DropDownSelectionControllerBase with Store {
  @observable
  String value = "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv";

  @observable
  ObservableList<String> items = ObservableList.of([]);

  @action
  void add(String item) {
    items.add(item);
    value = item;
  }
}
