import 'package:ficha/right_panel/controllers/drawercontroller.dart';
import 'package:ficha/right_panel/inventory.dart';
import 'package:ficha/right_panel/top-right-panel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'atributes/Status-list.dart';
import 'center_panel/center-panel.dart';
import 'center_panel/controllers/status_controller/StatusController.dart';
import 'bottom_panel/BottomRow.dart';
import 'models/model.dart';

//width fixa
final DescriptionDrawerController drawerController =
    DescriptionDrawerController();
final SpellList spells = SpellList();
final EquipmentList equipments = EquipmentList();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        home: const MainPage(),
        theme: ThemeData.dark(useMaterial3: true));
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final StatusController controller = StatusController();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: Drawer(
          child: DescriptionDrawer(controller: drawerController),
          width: 400,
        ),
        appBar: AppBar(
          toolbarHeight: 80,
        ),
        body: Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1500),
                child: Column(
                  children: [
                    Row(
                      children: [
                        StatusList(
                          controller: controller,
                        ),
                        CenterColumn(controller: controller),
                        RightPanel()
                      ],
                    ),
                    const BottomRow()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
