import 'package:flutter/material.dart';

class MyPhysicalShape extends StatelessWidget {
  final Widget child;
  final Color color;

  const MyPhysicalShape({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = theme.listTileTheme.shape;

    return PhysicalShape(
      color: color,
      shadowColor: theme.cardTheme.shadowColor ?? Colors.transparent,
      elevation: theme.cardTheme.elevation ?? 0,
      clipper: ShapeBorderClipper(
        shape: shape!,
      ),
      child: child,
    );
  }
}
