import 'dart:math';

import 'package:flutter/material.dart';

Color magicColors(Brightness brightness) {
  final colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.amber,
    Colors.indigo,
    Colors.lime,
    Colors.brown,
    Colors.grey,
  ];

  final baseColor = colors.elementAt(Random().nextInt(colors.length));
  return brightness == Brightness.light
      ? baseColor.shade400
      : baseColor.shade800;
}
