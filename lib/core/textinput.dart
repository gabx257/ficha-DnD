import 'package:ficha/center_panel/controllers/health_controler/health_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputBox extends StatefulWidget {
  final bool? filled;
  final int? maxchar;
  final String? display;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent, String)? onTapOutside;
  final TextEditingController? controller;
  final List<TextInputFormatter>? filter;

  const TextInputBox(
      {Key? key,
      this.filled,
      this.maxchar,
      this.display,
      this.onChanged,
      this.onTapOutside,
      this.filter,
      this.controller})
      : super(key: key);

  @override
  _TextInputBoxState createState() => _TextInputBoxState();
}

class _TextInputBoxState extends State<TextInputBox> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late String _display;
  late String _oldDisplay;

  @override
  void initState() {
    super.initState();
    _display = '';
    _oldDisplay = _display;
    _controller = widget.controller ?? TextEditingController(text: _display);
  }

  void _onChanged(String value) {
    setState(() {
      _display = value.isEmpty ? _oldDisplay : value;
    });
    widget.onChanged?.call(value);
  }

  void _onTapOutside(PointerDownEvent event) {
    setState(() {
      _display = _display.isEmpty ? _oldDisplay : _display;
    });
    widget.onTapOutside?.call(event, _display);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 30),
      focusNode: _focusNode,
      controller: _controller,
      onChanged: _onChanged,
      onTapOutside: _onTapOutside,
      inputFormatters:
          widget.filter ?? [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        counter: const SizedBox(),
        fillColor: Colors.grey,
        filled: widget.filled,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      showCursor: false,
      maxLength: widget.maxchar,
    );
  }
}

class HealthPointsInputBox extends TextInputBox {
  final HealthControler hpcontroller;

  const HealthPointsInputBox({
    Key? key,
    bool? filled,
    int? maxchar,
    String? display,
    void Function(String)? onChanged,
    void Function(PointerDownEvent, String)? onTapOutside,
    required this.hpcontroller,
  }) : super(
          key: key,
          filled: filled,
          maxchar: maxchar,
          display: display,
          onChanged: onChanged,
          onTapOutside: onTapOutside,
        );

  @override
  _HealthPointsInputBoxState createState() => _HealthPointsInputBoxState();
}

class _HealthPointsInputBoxState extends _TextInputBoxState {
  late final HealthControler _hpcontroller;
  @override
  HealthPointsInputBox get widget => super.widget as HealthPointsInputBox;
  @override
  void initState() {
    super.initState();
    _hpcontroller = widget.hpcontroller;
    if (widget.display != null) {
      _controller.text = widget.display!;
    }
  }

  @override
  void _onTapOutside(PointerDownEvent event) {
    _hpcontroller.updateTempHealth(_display);
    super._onTapOutside(event);
  }
}
