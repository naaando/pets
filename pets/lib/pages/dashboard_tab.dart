import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/fab_actions.dart';
import 'package:pets/models/medicacao.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/medicacao_provider.dart';
import 'package:pets/provider/pet_provider.dart';

class DashboardTab extends HookConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: content(context, ref), floatingActionButton: const FabActions());
  }

  Widget content(BuildContext context, WidgetRef ref) {
    var themeData = Theme.of(context).copyWith(
        cardTheme: CardTheme.of(context).copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.grey[200],
      elevation: 0,
    ));

    AsyncValue<Map<String, Pet>> pets = ref.watch(petsProvider);

    return Theme(
        data: themeData,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Seus pets',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            pets.when(
                data: (pets) => petsList(context, pets),
                error: (object, stackTrace) => const Text('Error'),
                loading: () => const CircularProgressIndicator()),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Linha do tempo',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            FutureBuilder(
              future: eventos(context, ref),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.hasData) {
                  return Column(children: snapshot.data!);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ));
  }

  petsList(BuildContext context, Map<String, Pet> pets) {
    var petsItems = pets.values
        .map((pet) => InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, '/cadastro-pet', arguments: pet),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[200],
                    foregroundImage:
                        FastCachedImageProvider(pet.fotoPerfilUrl.toString()),
                    child: Text(pet.nome.substring(0, 2).toUpperCase()),
                  ),
                  const SizedBox(height: 8),
                  Text(pet.nome),
                ],
              ),
            ))
        .toList();

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 108,
        child: ListView(
          padding: const EdgeInsets.only(left: 12, right: 4),
          // primary: false,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: petsItems
              .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4), child: e))
              .toList(),
        ));
  }

  Future<List<Widget>> eventos(BuildContext context, WidgetRef ref) async {
    var pets = await ref.watch(petsProvider.future);
    var medicacoes = await ref.watch(medicacoesProvider.future);

    var medicacoesComoEvento = medicacoes.values
        .map((medicacao) => medicacaoComoEvento(context, pets, medicacao))
        .toList();

    var eventosPorData = medicacoesComoEvento
      ..sort((a, b) => b.key.compareTo(a.key));

    return eventosPorData.map((e) => e.value).toList();
  }

  MapEntry<String, Widget> medicacaoComoEvento(
      BuildContext context, Map<String, Pet> pets, Medicacao value) {
    return evento(
        pets[value.petId]?.fotoPerfilUrl.toString() ?? '',
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
          dense: true,
          tileColor: Colors.grey[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: CircleAvatar(
              foregroundImage:
                  thumbUrl != null ? FastCachedImageProvider(thumbUrl) : null),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Text(Jiffy.parse(date).format(pattern: 'dd/MM/yyyy')),
          onTap: onTap,
        ));

    return MapEntry(date, widget);
  }
}
