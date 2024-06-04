import 'package:flutter/material.dart';

class ShadowBox extends StatelessWidget {
  ///paddings can be int, double or null
  ///
  ///the default padding is 10
  const ShadowBox(
      {super.key,
      this.shadow,
      this.children,
      this.width,
      this.height,
      this.padding,
      this.innerpadding,
      this.color,
      this.mainAxis,
      this.crossAxis,
      this.direction});
  final Color? color;
  final BoxShadow? shadow;
  final List<Widget>? children;
  final double? width;
  final double? height;
  final dynamic padding;
  final dynamic innerpadding;
  final MainAxisAlignment? mainAxis;
  final CrossAxisAlignment? crossAxis;
  final Axis? direction;

  EdgeInsets setpadding(p) {
    if (p == null) {
      return const EdgeInsets.all(10);
    }
    if (p is double || p is int) {
      return EdgeInsets.all(p.toDouble());
    }
    if (p is List) {
      return EdgeInsets.only(top: p[0], bottom: p[1], left: p[2], right: p[3]);
    }
    if (p is Map) {
      return EdgeInsets.only(
        top: p['top'] ?? 0,
        bottom: p['bottom'] ?? 0,
        left: p['left'] ?? 0,
        right: p['right'] ?? 0,
      );
    }
    if (p is EdgeInsets) {
      return p;
    }
    throw Exception('padding must be int, double, List, map or EdgeInsets');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: setpadding(padding),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(boxShadow: [
          shadow ??
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 0,
                  blurRadius: 6, // changes position of shadow
                  offset: const Offset(3, 7)),
        ], color: color ?? Theme.of(context).cardColor),
        child: Padding(
          padding: setpadding(innerpadding),
          child: Flex(
              direction: direction ?? Axis.vertical,
              mainAxisAlignment: mainAxis ?? MainAxisAlignment.spaceBetween,
              crossAxisAlignment: crossAxis ?? CrossAxisAlignment.center,
              children: children ?? []),
        ),
      ),
    );
  }
}
