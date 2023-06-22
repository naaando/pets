import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/fab_actions.dart';
import 'package:pets/config.dart';
import 'package:pets/models/pet.dart';
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
            evento(),
            evento(),
            evento(),
          ],
        ));
  }

  petsList(context, Map<String, Pet> pets) {
    var petsItems = pets.values
        .map((pet) => Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey[200],
                  foregroundImage: NetworkImage(pet.fotoPerfilUrl.toString()),
                  child: Text(pet.nome.substring(0, 2).toUpperCase()),
                ),
                const SizedBox(height: 8),
                Text(pet.nome),
              ],
            ))
        .toList();

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 108,
        child: ListView(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          // primary: false,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: petsItems
              .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4), child: e))
              .toList(),
        ));
  }

  evento() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          dense: true,
          tileColor: Colors.grey[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: CircleAvatar(
              foregroundImage: NetworkImage(
                  "${baseUri}storage/pets/7VL11n8DzKZ2u8toLIoOASRXfJ7UOODi5HaVmOJE.jpg")),
          title: const Text('Agnaldo'),
          subtitle: const Text('Vacina V8'),
          trailing: Text(Jiffy.now().format(pattern: 'dd/MM/yyyy')),
        ));
  }
}
