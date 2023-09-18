import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/pet_square_avatar.dart';
import 'package:pets/models/pet.dart';

class PetCard extends StatelessWidget {
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
                      spacing: 2,
                      runSpacing: 3,
                      children: badges(),
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
      'Idade ',
      pet.nascimento != null
          ? Jiffy.parse(pet.nascimento ?? '')
              .fromNow(withPrefixAndSuffix: false)
          : null,
    );

    final especie = info2Text(
      context,
      'Espécie ',
      pet.especie?.nome,
    );

    final raca = info2Text(
      context,
      'Raça ',
      pet.raca,
    );

    return [
      idade,
      especie,
      raca,
    ];
  }

  List<Widget> badges() {
    var badges = <Widget>[
      Badge(
        backgroundColor: pet.castrado == true ? Colors.teal : Colors.red[400],
        label: pet.castrado == true
            ? const Text('Castrado')
            : const Text('Não castrado'),
      ),
    ];

    if (pet.sexo != null) {
      badges.addAll([
        Badge(
          backgroundColor: pet.sexo == 'macho' ? Colors.blue : Colors.pink[300],
          label:
              pet.sexo == 'macho' ? const Text('Macho') : const Text('Fêmea'),
        ),
      ]);
    }

    if (pet.falecimento != null) {
      badges.addAll([
        const Badge(
          backgroundColor: Colors.grey,
          label: Text('Falecido'),
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
