import 'package:ficha/core/dropdown_selection.dart';
import 'package:ficha/core/notifiers/current_loaded_data.dart';
import 'package:ficha/core/singletons/singletons.dart';
import 'package:ficha/core/textinput.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadMenu extends StatelessWidget {
  const LoadMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l = context.read<Singletons>().characters;
    return SizedBox(
      width: 100,
      height: 50,
      child: DropDownSelection(
          items: l.names.toList(),
          onChanged: (v) {
            context.read<CurrentLoadedData>().loadCharacter(l[v]);
          }),
    );
  }
}

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
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
        child: TextInputBox(
          filter: const [],
        ));
  }
}
