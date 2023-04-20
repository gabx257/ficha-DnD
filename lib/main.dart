import 'package:ficha/core/textinput.dart';
import 'package:ficha/right_panel/top-right-panel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'atributes/Status-list.dart';
import 'atributes/status_controller/StatusController.dart';
import 'center_panel/center-panel.dart';
import 'bottom_panel/BottomRow.dart';
import 'core/ListSelector.dart';
import 'core/controllers/drawercontroller/drawercontroller.dart';
import 'models/equipaments.dart';
import 'models/spells.dart';

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
  final StatusController statusController = StatusController();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawerEnableOpenDragGesture: false,
        endDrawer: Drawer(
          width: 400,
          child: DescriptionDrawer(controller: drawerController),
        ),
        appBar: AppBar(
          actions: [Container()],
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                Text("Nome:  "),
                CharacterInfoBox(),
                SizedBox(
                  width: 20,
                ),
                Text("Lvl:  "),
                CharacterInfoBox(fieldSize: 50),
                SizedBox(
                  width: 20,
                ),
                Text("Classe:  "),
                CharacterInfoBox(
                  fieldSize: 150,
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Raça:  "),
                CharacterInfoBox(
                  fieldSize: 150,
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Background:  "),
                CharacterInfoBox(
                  fieldSize: 150,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
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
                        StatusList(statusController: statusController),
                        CenterColumn(controller: statusController),
                        RightPanel(statusController: statusController)
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

class CharacterInfoBox extends StatelessWidget {
  const CharacterInfoBox({
    this.fieldSize = 200,
    super.key,
  });

  final double fieldSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        constraints: BoxConstraints.loose(Size.fromWidth(fieldSize)),
        child: const TextInputBox(
          filter: [],
        ));
  }
}
