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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: scheme.primaryContainer.withOpacity(0.5),
      shadowColor: scheme.primaryContainer.withOpacity(0.5),
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
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
