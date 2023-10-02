import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pets/translate.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonListaPets extends HookWidget {
  const SkeletonListaPets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceVariant;
    final highlightColor = Theme.of(context).colorScheme.primaryContainer;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: true,
      child: FittedBox(
        fit: BoxFit.fill,
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 4),
          child: Row(
            children: List.filled(
              5,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: baseColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t(context).loading,
                      style: TextStyle(backgroundColor: baseColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
