import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String title;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: colorsScheme.onPrimaryContainer),
        borderRadius: BorderRadius.circular(16),
        color: colorsScheme.onPrimary,
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 40,
          ),
          const SizedBox(width: 20),
          Text(title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
