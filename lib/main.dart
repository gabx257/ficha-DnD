import 'package:ficha/atributes/notifiers/atribute.dart';
import 'package:ficha/center_panel/notifiers/health.dart';
import 'package:ficha/center_panel/notifiers/hitdie.dart';
import 'package:ficha/character_info/character_info.dart';
import 'package:ficha/core/notifiers/current_loaded_data.dart';
import 'package:ficha/core/notifiers/description_drawer.dart';
import 'package:ficha/core/notifiers/dropdown_selection.dart';
import 'package:ficha/core/singletons/singletons.dart';
import 'package:ficha/right_panel/top_right_panel.dart';
import 'package:ficha/theme/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'atributes/status_list.dart';
import 'bottom_panel/bottom_row.dart';
import 'center_panel/center_panel.dart';
import 'core/list_selector.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DropDownSelectionNotifier()),
      Provider(create: (context) => DescriptionDrawerContent()),
      ChangeNotifierProvider(create: (context) => CurrentLoadedData()),
      ChangeNotifierProvider(create: (context) => AttributesNotifier()),
      ChangeNotifierProvider(create: (context) => HealthNotifier()),
      ChangeNotifierProvider(create: (context) => HitDieNotifier()),
      Provider(create: (context) => Singletons()),
    ],
    child: const MainPage(),
  ));
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        //PointerDeviceKind.mouse,
      };
}

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      theme: Themes().main,
      home: Scaffold(
          endDrawerEnableOpenDragGesture: false,
          drawer: const Drawer(
            child: LoadMenu(),
          ),
          endDrawer: const Drawer(
            width: 400,
            child: DescriptionDrawer(),
          ),
          appBar: AppBar(
            actions: [Container()],
            automaticallyImplyLeading: true,
            toolbarHeight: 80,
            title: const CharacterInfo(),
          ),
          body: Scrollbar(
            thumbVisibility: true,
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1500),
                  child: const Column(
                    children: [
                      Row(
                        children: [StatusList(), CenterColumn(), RightPanel()],
                      ),
                      BottomRow()
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
