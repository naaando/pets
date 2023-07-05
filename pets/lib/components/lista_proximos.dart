import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/models/medicacao.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/medicacao_provider.dart';
import 'package:pets/provider/pet_provider.dart';

import 'chip_evento.dart';

class ListaProximos extends ConsumerWidget {
  const ListaProximos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: eventos(context, ref),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        if (snapshot.hasData) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      'Agendados',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                ...snapshot.data!
              ]);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<Widget>> eventos(BuildContext context, WidgetRef ref) async {
    var pets = await ref.watch(petsProvider.future);
    var medicacoes = await ref.watch(medicacoesProvider.future);

    var medicacoesComoEvento = medicacoes.values
        .map<MapEntry<String, Widget>>(
            (medicacao) => medicacaoComoEvento(context, pets, medicacao))
        .toList();

    var eventosPorData = medicacoesComoEvento
      ..sort((a, b) => b.key.compareTo(a.key));

    return eventosPorData.map((e) => e.value).toList();
  }

  MapEntry<String, Widget> medicacaoComoEvento(
      BuildContext context, Map<String, Pet> pets, Medicacao value) {
    return evento(
        pets[value.petId]?.imagemUrl.toString() ?? '',
        pets[value.petId]?.nome ?? '',
        value.nome ?? '',
        value.quando ?? '',
        () => Navigator.pushNamed(context, '/cadastro-medicacao',
            arguments: value));
  }

  MapEntry<String, Widget> evento(
      String? thumbUrl, String title, String subtitle, String date, onTap) {
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
            Text(Jiffy.parse(date).format(pattern: 'dd/MM/yyyy')),
            const SizedBox(height: 4),
            ChipEvento.vacina()
          ]),
          onTap: onTap,
        ));

    return MapEntry(date, widget);
  }
}
