import 'package:ficha/center_panel/notifiers/health.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputBox extends StatelessWidget {
  final bool? filled;
  final int? maxchar;
  final String? hint;
  final String? initialValue;
  final void Function(PointerDownEvent?, String)? onFinishEdit;
  final void Function(String)? onChanged;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<TextInputFormatter>? filter;

  TextInputBox(
      {super.key,
      this.filled,
      this.maxchar,
      this.hint,
      this.initialValue,
      this.onFinishEdit,
      this.filter,
      this.onChanged});

  void _onTapOutside(PointerDownEvent event) {
    onFinishEdit?.call(event, _controller.text);
    _focusNode.unfocus();
  }

  void _onSubmited(String value) {
    onFinishEdit?.call(null, value);
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = initialValue ?? '';
    return TextField(
      focusNode: _focusNode,
      controller: _controller,
      onChanged: onChanged,
      onSubmitted: _onSubmited,
      onTapOutside: _onTapOutside,
      inputFormatters: filter ?? [FilteringTextInputFormatter.digitsOnly],
      style: Theme.of(context).textTheme.titleLarge,
      decoration: const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
            filled: filled,
            hintText: hint,
          ),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      showCursor: false,
      maxLength: maxchar,
    );
  }
}

class HealthPointsInputBox extends TextInputBox {
  HealthPointsInputBox(
      {super.key,
      super.filled,
      super.maxchar,
      super.hint,
      super.onFinishEdit,
      required this.healthNotifier});

  final HealthNotifier healthNotifier;

  @override
  void _onTapOutside(PointerDownEvent event) {
    healthNotifier.temphealth = int.tryParse(_controller.text) ?? 0;
    super._onTapOutside(event);
  }

  @override
  void _onSubmited(String value) {
    healthNotifier.temphealth = int.tryParse(value) ?? 0;
    super._onSubmited(value);
  }
}
