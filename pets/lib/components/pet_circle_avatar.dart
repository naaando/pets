import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

class PetCircleAvatar extends StatelessWidget {
  final String? thumbUrl;

  const PetCircleAvatar({Key? key, this.thumbUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundImage:
          thumbUrl != null ? FastCachedImageProvider(thumbUrl!) : null,
      child: Icon(Icons.pets),
    );
  }
}
