import 'package:ficha/main.dart';
import 'package:ficha/models/character.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/controllers/drawercontroller/drawercontroller.dart';
import 'models/equipaments.dart';
import 'models/spells.dart';

class LoadModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => DescriptionDrawerController(), export: true),
        AsyncBind((i) => Future.value(SpellList()), export: true),
        AsyncBind((i) => Future.value(EquipmentList()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const Loading(),
        ),
        ModuleRoute('/main/', module: MainPageModule()),
      ];
}

class MainPageModule extends Module {
  @override
  List<Module> get imports => [LoadModule()];

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => CharacterList()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const MainPage()),
      ];
}
