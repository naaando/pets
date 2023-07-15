import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonListaPets extends StatelessWidget {
  const SkeletonListaPets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
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
                        backgroundColor: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 8),
                      Text('LOADING',
                          style:
                              TextStyle(backgroundColor: Colors.grey.shade300)),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
