import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pets/magic_colors.dart';
import 'package:pets/models/pet.dart';

class PetSquareAvatar extends StatelessWidget {
  final FastCachedImageProvider? image;
  final String nome;
  final double? size;
  final TextStyle? textStyle;

  const PetSquareAvatar({
    super.key,
    required this.image,
    required this.nome,
    this.size = 20,
    this.textStyle,
  });

  PetSquareAvatar.fromPet(
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
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = colorScheme.onPrimaryContainer;
    final iconColor = magicColors(colorScheme.brightness);
    final placeholder = Container(
      width: size! * 2,
      height: size! * 2,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Icon(
        Icons.pets,
        color: iconColor,
        size: size!,
      ),
    );

    if (image == null) {
      return placeholder;
    }

    return Image(
      image: image!,
      fit: BoxFit.cover,
      width: size! * 2,
      height: size! * 2,
      errorBuilder: (context, error, stackTrace) => placeholder,
    );
  }
}
