import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return baseTheme(ColorScheme.fromSeed(
    seedColor: Colors.purple,
    brightness: Brightness.light,
  ));
}

ThemeData darkTheme() {
  return baseTheme(ColorScheme.fromSeed(
    seedColor: Colors.purple,
    brightness: Brightness.dark,
  ));
}

ThemeData baseTheme(ColorScheme scheme) {
  return ThemeData(
    brightness: scheme.brightness,
    colorScheme: scheme,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: scheme.primaryContainer,
      shadowColor: Colors.black54,
      elevation: 4,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: scheme.surfaceVariant, width: 2),
      ),
    ),
  );
}
