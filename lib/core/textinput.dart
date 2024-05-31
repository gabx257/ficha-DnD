import 'package:ficha/center_panel/notifiers/health.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TextInputBox extends StatelessWidget {
  final bool? filled;
  final int? maxchar;
  final String? display;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent, String)? onTapOutside;
  final TextEditingController? controller;
  final List<TextInputFormatter>? filter;

  TextInputBox(
      {super.key,
      this.filled,
      this.maxchar,
      this.display,
      this.onChanged,
      this.onTapOutside,
      this.filter,
      this.controller});

  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  void _onChanged(String value) {
    _controller.text = value;
  }

  void _onTapOutside(PointerDownEvent event, HealthNotifier notifier) {
    onTapOutside?.call(event, _controller.text);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final health = context.watch<HealthNotifier>();
    return TextField(
      style: const TextStyle(fontSize: 30),
      focusNode: _focusNode,
      controller: _controller,
      onChanged: _onChanged,
      onTapOutside: (e) => _onTapOutside(e, health),
      inputFormatters: filter ?? [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        counter: const SizedBox(),
        fillColor: Colors.grey,
        filled: filled,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(157, 244, 67, 54), width: 2),
        ),
      ),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      showCursor: false,
      maxLength: maxchar,
    );
  }
}

class HealthPointsInputBox extends TextInputBox {
  HealthPointsInputBox({
    super.key,
    super.filled,
    super.maxchar,
    super.display,
    super.onChanged,
    super.onTapOutside,
  });

  @override
  void _onTapOutside(PointerDownEvent event, HealthNotifier notifier) {
    notifier.health = int.parse(_controller.text);
    super._onTapOutside(event, notifier);
  }
}
