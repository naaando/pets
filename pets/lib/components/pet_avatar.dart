import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pets/models/pet.dart';

class PetAvatar extends StatelessWidget {
  final FastCachedImageProvider image;
  final String nome;
  final double size;

  const PetAvatar({
    super.key,
    required this.image,
    required this.nome,
    required this.size,
  });

  PetAvatar.fromPet({
    super.key,
    required Pet pet,
    required this.size,
  })  : image = FastCachedImageProvider(pet.imagemUri.toString()),
        nome = pet.nome.substring(0, 2).toUpperCase();

  @override
  Widget build(BuildContext context) {
    // get primary color
    final primary = Theme.of(context).primaryColor;

    final textStyle = Theme.of(context).textTheme.headlineSmall;

    return CircleAvatar(
      radius: size,
      foregroundColor: Colors.black,
      backgroundColor: primary,
      foregroundImage: image,
      child: Text(nome, style: textStyle),
    );
  }
}
