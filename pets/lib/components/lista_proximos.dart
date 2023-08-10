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

class ListaProximos extends ConsumerWidget {
  const ListaProximos({Key? key}) : super(key: key);

  Future<List<Widget>> eventos(BuildContext context, WidgetRef ref) async {
    var pets = await ref.watch(petsProvider.future);
    var medicacoes = await ref.watch(medicacoesProvider.future);

    var medicacoesComoEvento = medicacoes.values
        .where((element) => !element.completado)
        .map<MapEntry<int, Widget>>(
            (medicacao) => medicacaoComoEvento(context, pets, medicacao))
        .toList();

    var eventosPorData = medicacoesComoEvento
      ..sort((a, b) => b.key.compareTo(a.key));

    return eventosPorData.map((e) => e.value).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: eventos(context, ref),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        List<Widget> columnArray = [
          const Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              'Agendados',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ];

        if (snapshot.hasData) {
          columnArray.addAll(snapshot.data!);

          if (snapshot.data!.isEmpty) {
            columnArray.add(
              const Padding(
                padding: EdgeInsets.all(18),
                child: Text('Nenhum agendamento'),
              ),
            );
          }
        } else {
          columnArray.add(
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

  MapEntry<int, Widget> medicacaoComoEvento(
      BuildContext context, Map<String, Pet> pets, Medicacao medicacao) {
    Pet pet = pets[medicacao.petId]!;
    String? thumbUrl = pet.imagem != null ? pet.imagemUri.toString() : null;
    String title = pet.nome;
    String subtitle = medicacao.nome;
    Jiffy date = Jiffy.parse(medicacao.quando!, isUtc: true).toLocal();
    bool isPast = date.isAfter(Jiffy.now());

    final primaryContainer = Theme.of(context).colorScheme.primaryContainer;
    Color tileColor = isPast ? primaryContainer : Colors.yellow.shade700;

    var widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: MyPhysicalShape(
        color: tileColor,
        child: ListTile(
          leading: PetAvatar.fromPet(pet),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(date.fromNow()),
              const SizedBox(height: 4),
              ChipEvento.parse(medicacao.tipo),
            ],
          ),
          onTap: () => Navigator.pushNamed(
            context,
            '/proxima-medicacao',
            arguments: medicacao,
          ),
        ),
      ),
    );

    return MapEntry(date.millisecondsSinceEpoch, widget);
  }
}
