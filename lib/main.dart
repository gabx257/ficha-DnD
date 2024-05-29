import 'package:ficha/core/textinput.dart';
import 'package:ficha/right_panel/top-right-panel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'atributes/status_list.dart';
import 'atributes/status_controller/status_controller.dart';
import 'bottom_panel/bottom_row.dart';
import 'center_panel/center_panel.dart';
import 'core/ListSelector.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'core/controllers/drawercontroller/drawercontroller.dart';
import 'models/Character.dart';
import 'modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ModularApp(
      module: LoadModule(),
      child: MaterialApp.router(
          scrollBehavior: MyCustomScrollBehavior(),
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
          theme: ThemeData.dark(useMaterial3: true))));
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
  final drawerController = Modular.get<DescriptionDrawerController>();
  final StatusController statusController = StatusController();
  final ScrollController scrollController = ScrollController();
  final CharacterList characterList = Modular.get<CharacterList>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawerEnableOpenDragGesture: false,
        drawer: Drawer(
          child: IconButton(
            onPressed: () {
              Modular.get<Character>().replaceFromOther(Character(name: "JJ"));
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        endDrawer: Drawer(
          width: 400,
          child: DescriptionDrawer(controller: drawerController),
        ),
        appBar: AppBar(
          actions: [Container()],
          automaticallyImplyLeading: true,
          toolbarHeight: 80,
          title: const CharacterInfo(),
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

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
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

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Modular.isModuleReady<LoadModule>().then((r) {
      Modular.to.navigate("/main/");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CircularProgressIndicator(),
    );
  }
}
