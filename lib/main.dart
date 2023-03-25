import 'package:ficha/core/shadowbox.dart';
import 'package:ficha/core/textinput.dart';
import 'package:flutter/material.dart';
import 'package:ficha/atributes.dart/status-box.dart';

//width fixa

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MainPage(), theme: ThemeData.dark(useMaterial3: true));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
        ),
        body: SingleChildScrollView(
            child: ShadowBox(
                direction: Axis.horizontal,
                crossAxis: CrossAxisAlignment.center,
                mainAxis: MainAxisAlignment.start,
                width: double.infinity,
                children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(children: const [
                          StatusBox(
                              attr: 'Strenght', proficiencies: ['Atletics']),
                          StatusBox(attr: 'Dexterity', proficiencies: [
                            'Acrobatics',
                            'Sneaky',
                            'Sleight of hands'
                          ]),
                          StatusBox(attr: 'Constitution', proficiencies: []),
                          StatusBox(attr: 'Inteligence', proficiencies: [
                            'Arcana',
                            'History',
                            'Investigation',
                            'Nature',
                            'Religion'
                          ]),
                          StatusBox(attr: 'Wisdom', proficiencies: [
                            'Intuition',
                            'Animal Handling',
                            'Medicine',
                            'Perception',
                            'Survival'
                          ]),
                          StatusBox(attr: 'Charism', proficiencies: [
                            'Performance',
                            'Deception',
                            'Intimidation',
                            'Persuasion'
                          ])
                        ]),
                        Expanded(
                          child: Column(
                            children: [
                              ShadowBox(
                                crossAxis: CrossAxisAlignment.start,
                                height: 400,
                                width: double.infinity,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: DefenseBox()),
                                      Expanded(child: DefenseBox()),
                                      Expanded(child: DefenseBox()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 180,
                                          child:
                                              FittedBox(child: DefenseBox())),
                                      const ShadowBox(
                                        width: 200,
                                        height: 200,
                                        children: [
                                          const Text(
                                              "health, armor,initiative,moviment,proficiencie,hit die,passive wisdom, bonus health")
                                        ],
                                      )
                                    ],
                                  ), // melhorar defense box para variar tamanho
                                ],
                              ),
                              const ShadowBox(
                                height: 580,
                                width: double.infinity,
                                children: [Text("attacks")],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(children: [
                            SizedBox(
                              height: 200,
                              child: Row(children: const [
                                Expanded(
                                  child: ShadowBox(
                                    height: 200,
                                    children: [Text("Saving, Dsaving")],
                                  ),
                                ),
                                Expanded(
                                  child: ShadowBox(
                                    height: 200,
                                    children: [Text("special resouces")],
                                  ),
                                )
                              ]),
                            ),
                            const ShadowBox(
                              height: 580,
                              width: double.infinity,
                              children: [Text("Inventory")],
                            ),
                            const ShadowBox(
                              height: 180,
                              width: double.infinity,
                              children: [Text("conjuration")],
                            )
                          ]),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: ShadowBox(
                            height: 200,
                            children: [Text("Tool Proficiencies")],
                          ),
                        ),
                        Expanded(
                          child: ShadowBox(
                            height: 200,
                            children: [Text("Languages")],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ])));
  }
}

class DefenseBox extends StatelessWidget {
  DefenseBox({super.key});
  Image img = Image.asset("Shield.png");
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(alignment: AlignmentDirectional.center, children: [
        SizedBox(width: 120, height: 120, child: FittedBox(child: img)),
        Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(width: 60, child: TextInputBox()),
              Text(
                'AC',
                softWrap: true,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    backgroundColor: Color.fromARGB(101, 0, 0, 0)),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
