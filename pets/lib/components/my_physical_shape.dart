import 'package:flutter/material.dart';

class MyPhysicalShape extends StatelessWidget {
  final Widget child;
  final Color color;

  const MyPhysicalShape({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      color: color,
      shadowColor: Colors.black54,
      elevation: 4,
      clipper: ShapeBorderClipper(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: child,
    );
  }
}
