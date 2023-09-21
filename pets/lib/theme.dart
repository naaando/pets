import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return baseTheme(ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
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
  const elevation = 1.0;
  final borderRadius = BorderRadius.circular(8);
  final roundedShape = RoundedRectangleBorder(
    borderRadius: borderRadius,
  );

  return ThemeData(
    scaffoldBackgroundColor: scheme.background,
    brightness: scheme.brightness,
    colorScheme: scheme,
    listTileTheme: ListTileThemeData(
      shape: roundedShape,
    ),
    cardTheme: CardTheme(
      clipBehavior: Clip.antiAlias,
      shape: roundedShape,
      color: scheme.primaryContainer,
      shadowColor: scheme.primaryContainer,
      elevation: elevation,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: borderRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: scheme.onSurfaceVariant.withOpacity(0.2),
          width: 2,
        ),
      ),
      filled: true,
      fillColor: scheme.surfaceVariant.withOpacity(0.4),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: scheme.primaryContainer,
      elevation: 24.0,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: scheme.onPrimaryContainer,
      unselectedLabelColor: scheme.onPrimaryContainer.withOpacity(0.45),
      indicator: BoxDecoration(color: scheme.primaryContainer),
    ),
  );
}
