import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pets/components/pets_app_bar.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var title = 'Meus animais';

    AsyncValue<List<Pet>> pets = ref.watch(filteredPetsProvider);

    return pets.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => throw err,
      data: (pets) {
        return Scaffold(
          appBar: PetsAppBar(
            title: title,
          ),
          body: body(context, title, pets),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/pet');
            },
            tooltip: 'Adicionar novo animal',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget body(context, String title, Iterable<Pet> pets) {
    return GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(25),
      crossAxisSpacing: 25,
      mainAxisSpacing: 25,
      children: pets
          .map((pet) => InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                Navigator.pushNamed(context, '/pet', arguments: pet);
              },
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: pet.fotoPerfil != null
                            ? Image.network(
                                pet.fotoPerfilUrl.toString(),
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
