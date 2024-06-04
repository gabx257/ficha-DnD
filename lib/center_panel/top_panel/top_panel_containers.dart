import 'package:flutter/material.dart';

import '../../core/textinput.dart';

class CenterPanelBoxes extends StatelessWidget {
  final String text;
  final dynamic value;
  final Widget shape;
  final double size;
  final MainAxisAlignment? alignment;
  final double? fontsize;
  const CenterPanelBoxes(
      {super.key,
      this.text = '',
      this.value,
      this.fontsize,
      this.shape = const SquareBox(),
      this.size = 100,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(alignment: AlignmentDirectional.topCenter, children: [
        shape,
        Column(
          mainAxisAlignment: alignment ?? MainAxisAlignment.center,
          children: [
            Text(text, style: Theme.of(context).textTheme.titleLarge),
            ConditionallyEditableBox(value: value),
          ],
        )
      ]),
    );
  }
}

/// value is null, then it is editable
class ConditionallyEditableBox extends StatelessWidget {
  const ConditionallyEditableBox({
    super.key,
    required this.value,
  });

  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return value != null
        ? SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: Text(
                value.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          )
        : SizedBox(width: 50, child: TextInputBox());
  }
}

// -------- forms and shapes for the containers ---------------

//-------------------------------------------------------
// make the color change based on current health
// make it only editable though the menu
class CrossBox extends StatelessWidget {
  final Color color;

  const CrossBox(
      {super.key, this.color = const Color.fromARGB(255, 255, 17, 0)});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Stack(alignment: AlignmentDirectional.center, children: [
          Container(
              height: constrains.maxHeight,
              width: constrains.maxHeight * 0.4,
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(color: color))),
          Container(
              height: constrains.maxHeight * 0.4,
              width: constrains.maxHeight,
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(color: color))),
          Container(
              color: color,
              height: constrains.maxHeight * 0.4,
              width: (constrains.maxHeight * 0.4) - 10)
        ]);
      },
    );
  }
}

//----------------------------------------
class SquareBox extends StatelessWidget {
  const SquareBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 129, 137, 179),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(color: const Color.fromARGB(255, 129, 137, 179)),
          ),
        ),
      ),
    );
  }
}

class HeartShape extends StatelessWidget {
  final Color bodyColor;
  final Color borderColor;
  final double borderWidth;
  final double fillPercentage;

  const HeartShape(
      {super.key,
      this.bodyColor = const Color.fromARGB(255, 255, 17, 0),
      this.borderColor = Colors.white,
      this.borderWidth = 2,
      this.fillPercentage = 1});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _HeartShape(
        bodyColor: bodyColor,
        borderColor: borderColor,
        borderWidth: borderWidth,
        fillPercentage: fillPercentage,
      ),
    );
  }
}

class _HeartShape extends CustomPainter {
  final Color bodyColor;
  final Color borderColor;
  final double borderWidth;
  final double fillPercentage;

  _HeartShape(
      {this.bodyColor = const Color.fromARGB(255, 255, 17, 0),
      this.borderColor = const Color.fromARGB(255, 255, 255, 255),
      this.borderWidth = 2,
      this.fillPercentage = 1});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    Path path = Path()
      ..moveTo(0.5 * width, height * 0.4)
      ..cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
          0.5 * width, height)
      ..moveTo(0.5 * width, height * 0.4)
      ..cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
          0.5 * width, height);

    // Calculate the height to fill
    double fillHeight = height * 0.70 * fillPercentage;
    Rect fillRect = Rect.fromLTRB(0, height - fillHeight, width, height);

    final Paint body = Paint()
      ..color = bodyColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    final Paint border = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderWidth;

    canvas.translate(-width * 0.15, -height * 0.35);
    canvas.scale(1.3);
    canvas.drawPath(path, border);
    canvas.clipRect(fillRect);
    canvas.drawPath(path, body);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
