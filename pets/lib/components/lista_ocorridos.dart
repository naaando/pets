import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/my_physical_shape.dart';
import 'package:pets/components/pet_avatar.dart';
import 'package:pets/models/medicacao.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/medicacao_provider.dart';
import 'package:pets/provider/pet_provider.dart';

import 'chip_evento.dart';
import 'skeleton_list_tile.dart';

class ListaOcorridos extends ConsumerWidget {
  const ListaOcorridos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<Widget>> eventos() async {
      var pets = await ref.watch(petsProvider.future);
      var medicacoes = await ref.watch(medicacoesProvider.future);

      var medicacoesComoEvento = medicacoes.values
          .where((element) => element.completado)
          .map((medicacao) => medicacaoComoEvento(context, pets, medicacao))
          .toList();

      var eventosPorData = medicacoesComoEvento
        ..sort((a, b) => b.key.compareTo(a.key));

      return eventosPorData.map((e) => e.value).toList();
    }

    return FutureBuilder(
      future: eventos(),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        List<Widget> columnArray = [
          const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Linha do tempo',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w600),
              )),
        ];

        if (snapshot.hasData) {
          columnArray.addAll(snapshot.data!);

          if (snapshot.data!.isEmpty) {
            columnArray.add(
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Nenhuma anotação'),
              ),
            );
          }
        } else {
          columnArray.add(
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: SkeletonListTile(),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnArray,
        );
      },
    );
  }

  MapEntry<String, Widget> medicacaoComoEvento(
    BuildContext context,
    Map<String, Pet> pets,
    Medicacao medicacao,
  ) {
    Pet pet = pets[medicacao.petId]!;
    String? thumbUrl = pet.imagem != null ? pet.imagemUri.toString() : null;
    String title = pet.nome;
    String subtitle = medicacao.nome;
    String date = medicacao.quando ?? '';

    final defaultTileColor = Theme.of(context).colorScheme.primaryContainer;

    var widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: MyPhysicalShape(
        color: defaultTileColor,
        child: ListTile(
          leading: PetAvatar.fromPet(pet),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(Jiffy.parse(date, isUtc: true).toLocal().fromNow()),
            const SizedBox(height: 4),
            ChipEvento.parse(medicacao.tipo)
          ]),
          onTap: () => Navigator.pushNamed(
            context,
            '/medicacao',
            arguments: medicacao,
          ),
        ),
      ),
    );

    return MapEntry(date, widget);
  }
}
