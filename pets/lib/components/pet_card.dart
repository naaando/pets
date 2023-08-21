import 'package:flutter/material.dart';
import 'package:pets/components/pet_avatar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/models/pet.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard(this.pet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leadingImage(context, pet),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(left: 22, top: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        pet.nome,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: info(context),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: badges(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/cadastro-pet', arguments: pet);
      },
    );
  }

  List<Widget> info(BuildContext context) {
    final idade = infoText(
      context,
      'Idade ',
      pet.nascimento != null
          ? Jiffy.parse(pet.nascimento ?? '')
              .fromNow(withPrefixAndSuffix: false)
          : null,
    );

    final especie = infoText(
      context,
      'Espécie ',
      pet.especie?.nome,
    );

    final raca = infoText(
      context,
      'Raça ',
      pet.raca,
    );

    return [
      idade,
      const SizedBox(height: 3),
      especie,
      const SizedBox(height: 3),
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
        const SizedBox(height: 3),
        Badge(
          backgroundColor: pet.sexo == 'macho' ? Colors.blue : Colors.pink[300],
          label:
              pet.sexo == 'macho' ? const Text('Macho') : const Text('Fêmea'),
        ),
      ]);
    }

    if (pet.falecimento != null) {
      badges.addAll([
        const SizedBox(height: 3),
        const Badge(
          backgroundColor: Colors.grey,
          label: Text('Falecido'),
        ),
      ]);
    }

    return badges;
  }

  leadingImage(BuildContext context, Pet pet) {
    return PetAvatar.fromPet(pet, size: 50);
  }

  RichText infoText(BuildContext context, String label, String? value) {
    var labelStyle = Theme.of(context).textTheme.bodyMedium;
    final fontWeight = value != null ? FontWeight.w600 : FontWeight.w400;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: labelStyle,
          ),
          TextSpan(
            text: value ?? '-',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: fontWeight),
          )
        ],
      ),
    );
  }
}
