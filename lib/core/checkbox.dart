import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    required this.value,
  });

  final bool value;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _value;

  @override
  initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: const Color.fromARGB(255, 23, 71, 191),
        checkColor: Colors.white,
        splashRadius: 7,
        shape: const CircleBorder(),
        value: _value,
        onChanged: (s) {
          setState(() {
            _value = s ?? false;
          });
        });
  }
}
