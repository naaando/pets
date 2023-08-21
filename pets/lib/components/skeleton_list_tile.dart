import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.surfaceVariant;
    final themeHighlight = Theme.of(context).colorScheme.primaryContainer;

    return Shimmer.fromColors(
      baseColor: theme,
      highlightColor: themeHighlight,
      enabled: true,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: theme,
        ),
        title: Container(
          height: 16,
          color: theme,
        ),
        subtitle: Container(
          height: 16,
          color: theme,
        ),
      ),
    );
  }
}
