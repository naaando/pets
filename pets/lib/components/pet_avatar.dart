import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pets/models/pet.dart';

class PetAvatar extends StatelessWidget {
  final FastCachedImageProvider image;
  final String nome;
  final double? size;
  final TextStyle? textStyle;

  const PetAvatar({
    super.key,
    required this.image,
    required this.nome,
    this.size,
    this.textStyle,
  });

  PetAvatar.fromPet(
    Pet pet, {
    super.key,
    this.size,
    this.textStyle,
  })  : image = FastCachedImageProvider(pet.imagemUri.toString()),
        nome = pet.nome.substring(0, 2).toUpperCase();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final myTextStyle = textStyle ?? Theme.of(context).textTheme.headlineSmall;

    return CircleAvatar(
      radius: size,
      foregroundColor: Colors.black,
      backgroundColor: primary,
      foregroundImage: image,
      child: Text(nome, style: myTextStyle),
    );
  }
}
