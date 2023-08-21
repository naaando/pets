import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceVariant;
    final highlightColor = Theme.of(context).colorScheme.primaryContainer;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: true,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: baseColor,
        ),
        title: Container(
          height: 16,
          color: baseColor,
        ),
        subtitle: Container(
          height: 16,
          color: baseColor,
        ),
      ),
    );
  }
}
