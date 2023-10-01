import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/pet_square_avatar.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/translate.dart';

class PetCard extends HookWidget {
  final Pet pet;

  const PetCard(this.pet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leadingImage(context, pet),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      pet.nome,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      runSpacing: 3,
                      children: badges(context),
                    ),
                    const SizedBox(height: 6),
                    Table(
                      children: [
                        ...info(context).map(
                          (row) {
                            return TableRow(
                              children: row.map(
                                (widget) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: widget,
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ).toList(),
                      ],
                    ),
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

  List<List<Widget>> info(BuildContext context) {
    final idade = info2Text(
      context,
      '${t().age} ',
      pet.nascimento != null
          ? Jiffy.parse(pet.nascimento ?? '')
              .fromNow(withPrefixAndSuffix: false)
          : null,
    );

    final especie = info2Text(
      context,
      '${t().specie} ',
      pet.especie?.nome,
    );

    final raca = info2Text(
      context,
      '${t().breed} ',
      pet.raca,
    );

    return [
      idade,
      especie,
      raca,
    ];
  }

  List<Widget> badges(BuildContext context) {
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
            ? Text(t().castred, style: textStyle)
            : Text(t().notCastred, style: textStyle),
      ),
    ];

    if (pet.sexo != null) {
      badges.addAll([
        Badge(
          backgroundColor: macho ? colorSet[2] : colorSet[3],
          label: macho
              ? Text(t().sharedMale, style: textStyle)
              : Text(t().sharedFemale, style: textStyle),
        ),
      ]);
    }

    if (pet.falecimento != null) {
      badges.addAll([
        Badge(
          backgroundColor: colorSet[4],
          label: Text(t().dead, style: textStyle),
        ),
      ]);
    }

    return badges;
  }

  leadingImage(BuildContext context, Pet pet) {
    return PetSquareAvatar.fromPet(pet, size: 70);
  }

  List<Text> info2Text(BuildContext context, String label, String? value) {
    var labelStyle = Theme.of(context).textTheme.bodyMedium;
    final fontWeight = value != null ? FontWeight.w600 : FontWeight.w400;

    return [
      Text(
        label,
        style: labelStyle,
      ),
      Text(
        value ?? '-',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: fontWeight),
      )
    ];
  }
}
