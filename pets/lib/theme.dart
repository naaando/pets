import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return baseTheme(ColorScheme.fromSeed(
    seedColor: Colors.red,
    brightness: Brightness.light,
  ));
}

ThemeData darkTheme() {
  return baseTheme(ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ));
}

ThemeData baseTheme(ColorScheme scheme) {
  return ThemeData(
    brightness: scheme.brightness,
    colorScheme: scheme,
    cardTheme: CardTheme(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: scheme.primaryContainer,
      shadowColor: scheme.primaryContainer,
      elevation: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: scheme.onSurfaceVariant.withOpacity(0.2),
          width: 2,
        ),
      ),
      filled: true,
      fillColor: scheme.surfaceVariant.withOpacity(0.4),
    ),
  );
}
