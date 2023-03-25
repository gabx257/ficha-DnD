import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputBox extends TextField {
  final bool? filled;
  const TextInputBox(
      {super.key,
      super.onChanged,
      super.onTapOutside,
      super.onSubmitted,
      this.filled})
      : super();

  @override
  State<TextInputBox> createState() => _TextInputBoxState();
}

class _TextInputBoxState extends State<TextInputBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      onTapOutside: widget.onTapOutside,
      onSubmitted: widget.onSubmitted,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        counter: const SizedBox(),
        fillColor: Colors.grey,
        filled: widget.filled,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2)),
      ),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.top,
      showCursor: false,
      maxLength: 2,
    );
  }
}
