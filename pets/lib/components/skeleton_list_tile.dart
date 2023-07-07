import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade300,
        ),
        title: Container(
          height: 16,
          color: Colors.grey.shade300,
        ),
        subtitle: Container(
          height: 16,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
