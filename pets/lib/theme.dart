import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return baseTheme(ColorScheme.fromSeed(
    seedColor: Colors.purple,
    brightness: Brightness.light,
  ));
}

ThemeData darkTheme() {
  final base = baseTheme(ColorScheme.fromSeed(
    seedColor: Colors.purple,
    brightness: Brightness.dark,
  ));

  return base.copyWith(
    brightness: Brightness.dark,
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      fillColor: Colors.grey.shade900,
    ),
  );
}

ThemeData baseTheme(ColorScheme scheme) {
  return ThemeData(
    colorScheme: scheme,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: scheme.primaryContainer,
      elevation: 2,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade200),
      ),
      fillColor: Colors.grey.shade100,
      filled: true,
    ),
  );
}
