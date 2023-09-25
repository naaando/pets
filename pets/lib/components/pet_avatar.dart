import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pets/models/pet.dart';

class PetAvatar extends StatelessWidget {
  final FastCachedImageProvider? image;
  final String nome;
  final double? size;
  final TextStyle? textStyle;

  const PetAvatar({
    super.key,
    required this.image,
    required this.nome,
    this.size = 20,
    this.textStyle,
  });

  PetAvatar.fromPet(
    Pet pet, {
    super.key,
    this.size = 20,
    this.textStyle,
  })  : image = pet.imagemUri != null
            ? FastCachedImageProvider(pet.imagemUri.toString())
            : null,
        nome = pet.nome.substring(0, 2).toUpperCase();

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.primary;
    final iconColor = Theme.of(context).colorScheme.primaryContainer;

    return CircleAvatar(
      radius: size,
      foregroundColor: Colors.black,
      backgroundColor: backgroundColor,
      foregroundImage: image,
      child: Icon(
        Icons.pets,
        color: iconColor,
        size: size!,
      ),
    );
  }
}
