import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pets/models/pet.dart';

class PetSquareAvatar extends StatelessWidget {
  final FastCachedImageProvider image;
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
  })  : image = FastCachedImageProvider(pet.imagemUri.toString()),
        nome = pet.nome.substring(0, 2).toUpperCase();

  @override
  Widget build(BuildContext context) {
    // final backgroundColor = Theme.of(context).colorScheme.primaryContainer;
    // final iconColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final backgroundColor = Theme.of(context).colorScheme.primary;
    final iconColor = Theme.of(context).colorScheme.background;

    final myTextStyle = textStyle ?? Theme.of(context).textTheme.headlineSmall;

    return Image(
      image: image,
      fit: BoxFit.cover,
      width: size! * 2,
      height: size! * 2,
      // use pet icon on error builder
      errorBuilder: (context, error, stackTrace) => Container(
        width: size! * 2,
        height: size! * 2,
        decoration: BoxDecoration(
          color: backgroundColor,
          // borderRadius: BorderRadius.circular(size!),
        ),
        child: Icon(
          Icons.pets,
          color: iconColor,
          size: size!,
        ),
      ),
    );

    // return Image(
    //   radius: size,
    //   foregroundColor: Colors.black,
    //   backgroundColor: backgroundColor,
    //   foregroundImage: image,
    //   child:
    // );
  }
}
