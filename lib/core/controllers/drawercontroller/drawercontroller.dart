import 'package:mobx/mobx.dart';

import '../../../models/model.dart';
part 'drawercontroller.g.dart';

class DescriptionDrawerController = _DescriptionDrawerControllerBase
    with _$DescriptionDrawerController;

abstract class _DescriptionDrawerControllerBase with Store {
  @observable
  Model info = Model(name: "nothing to show");
}
