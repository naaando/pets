import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/fab_actions.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class PetsListTab extends HookConsumerWidget {
  const PetsListTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Map<String, Pet>> pets = ref.watch(petsProvider);

    return Scaffold(
      body: pets.when(
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => throw err,
        data: (pets) => body(
          context,
          pets.values.toList()
            ..sort((a, b) {
              return a.updatedAt is String
                  ? DateTime.parse(a.updatedAt ?? '').microsecondsSinceEpoch
                  : DateTime.parse(a.createdAt ?? '').microsecondsSinceEpoch;
            }),
        ),
      ),
      floatingActionButton: const FabActions(),
    );
  }

  Widget body(context, Iterable<Pet> pets) {
    ValueNotifier<String> pesquisa = useState('');

    var petsFiltrados = pets.where((pet) => pet.nome.contains(pesquisa.value));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          barraDePesquisa(pesquisa),
          Column(
            children: petsFiltrados
                .map<Widget>((Pet pet) => petCard(context, pet))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget barraDePesquisa(ValueNotifier<String> pesquisa) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Pesquisar',
        ),
        onChanged: (value) {
          pesquisa.value = value;
        },
      ),
    );
  }

  Widget petCard(BuildContext context, Pet pet) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leadingImage(context, pet),
            Padding(
                padding: const EdgeInsets.only(left: 22, top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      pet.nome,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      pet.especieId ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                )),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/cadastro-pet', arguments: pet);
      },
    );
  }

  leadingImage(BuildContext context, Pet pet) {
    return SizedBox.square(
      dimension: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: pet.imagem != null
            ? Image.network(
                pet.imagemUri.toString(),
                fit: BoxFit.cover,
              )
            : Container(
                color: Colors.grey[300],
                child: Icon(
                  Icons.pets_outlined,
                  color: Colors.grey[400],
                ),
              ),
      ),
    );
  }
}
