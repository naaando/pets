import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/fab_actions.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class PetsTab extends HookConsumerWidget {
  const PetsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Map<String, Pet>> pets = ref.watch(petsProvider);

    return Scaffold(
        body: pets.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => throw err,
            data: (pets) => body(context, pets.values)),
        floatingActionButton: const FabActions());
  }

  Widget body(context, Iterable<Pet> pets) {
    return GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(25).add(const EdgeInsets.only(bottom: 80)),
      crossAxisSpacing: 25,
      mainAxisSpacing: 25,
      children: pets
          .map((pet) => InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                Navigator.pushNamed(context, '/cadastro-pet', arguments: pet);
              },
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: pet.imagem != null
                            ? Image.network(
                                pet.imagemUri.toString(),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              )
                            : Container(
                                color: Colors.grey[300],
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Icon(
                                  Icons.pets_outlined,
                                  color: Colors.grey[400],
                                  size: MediaQuery.of(context).size.width / 6,
                                ))),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    pet.nome,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )))
          .toList(),
    );
  }
}
