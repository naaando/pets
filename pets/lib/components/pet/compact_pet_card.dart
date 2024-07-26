import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pets/components/pet/pet_avatar.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/translate.dart';

class CompactPetCard extends HookWidget {
  final Pet pet;

  const CompactPetCard(this.pet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _leadingImage(context, pet),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      pet.nome,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      runSpacing: 3,
                      children: _badges(context),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/cadastro-pet', arguments: pet);
      },
    );
  }

  _leadingImage(BuildContext context, Pet pet) {
    return PetAvatar.fromPet(pet, size: 40);
  }

  List<Widget> _badges(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.labelSmall;
    final castrado = pet.castracao != null;
    final colorSet = scheme.brightness == Brightness.light
        ? [
            Colors.teal,
            Colors.red.shade300,
            Colors.blue,
            Colors.pink.shade300,
            Colors.grey.shade400,
          ]
        : [
            Colors.teal.shade700,
            Colors.red.shade900,
            Colors.blue.shade700,
            Colors.pink.shade700,
            Colors.grey.shade600,
          ];

    final macho = pet.sexo == 'macho';

    var badges = <Widget>[
      Badge(
        backgroundColor: castrado ? colorSet[0] : colorSet[1],
        label: castrado
            ? Text(t(context).castred, style: textStyle)
            : Text(t(context).notCastred, style: textStyle),
      ),
    ];

    if (pet.sexo != null) {
      badges.addAll([
        Badge(
          backgroundColor: macho ? colorSet[2] : colorSet[3],
          label: macho
              ? Text(t(context).sharedMale, style: textStyle)
              : Text(t(context).sharedFemale, style: textStyle),
        ),
      ]);
    }

    if (pet.falecimento != null) {
      badges.addAll([
        Badge(
          backgroundColor: colorSet[4],
          label: Text(t(context).dead, style: textStyle),
        ),
      ]);
    }

    return badges;
  }
}
