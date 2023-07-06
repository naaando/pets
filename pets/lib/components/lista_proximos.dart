import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/models/medicacao.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:pets/provider/proxima_medicacao_provider.dart';

import 'chip_evento.dart';

class ListaProximos extends ConsumerWidget {
  const ListaProximos({Key? key}) : super(key: key);

  Future<List<Widget>> eventos(BuildContext context, WidgetRef ref) async {
    var pets = await ref.watch(petsProvider.future);
    var medicacoes = await ref.watch(proximasMedicacoesProvider.future);

    var medicacoesComoEvento = medicacoes.values
        .map<MapEntry<String, Widget>>(
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
        if (snapshot.hasData) {
          var columnArray = [
            const Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Agendados',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
            ...snapshot.data!
          ];

          if (snapshot.data!.isEmpty) {
            columnArray.add(
              const Padding(
                padding: EdgeInsets.all(18),
                child: Text('Nenhum agendamento'),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnArray,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  MapEntry<String, Widget> medicacaoComoEvento(
      BuildContext context, Map<String, Pet> pets, Medicacao medicacao) {
    Pet pet = pets[medicacao.petId]!;
    String? thumbUrl = pet.imagem != null ? pet.imagemUrl.toString() : null;
    String title = pet.nome;
    String subtitle = medicacao.nome ?? '';
    String date = medicacao.proximaDose ?? '';

    var widget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          tileColor: Colors.grey[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: CircleAvatar(
              foregroundImage:
                  thumbUrl != null ? FastCachedImageProvider(thumbUrl) : null),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(Jiffy.parse(date).fromNow()),
            const SizedBox(height: 4),
            ChipEvento.vacina()
          ]),
          onTap: () => Navigator.pushNamed(context, '/proxima-medicacao',
              arguments: medicacao),
        ));

    return MapEntry(date, widget);
  }
}
