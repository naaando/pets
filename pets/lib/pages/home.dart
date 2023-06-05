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
    var title = 'Pets';

    AsyncValue<Map<String, Pet>> pets = ref.watch(petsProvider);

    return pets.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (pets) {
        return Scaffold(
          appBar: PetsAppBar(
            title: title,
          ),
          body: body(context, title, pets),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // final loginState = Provider.of<LoginState>(context, listen: false);
              // loginState.logout();
            },
            tooltip: 'Adicionar novo pet',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget body(context, String title, Map<String, Pet> pets) {
    return GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(35),
      crossAxisSpacing: 35,
      mainAxisSpacing: 35,
      children: pets.values
          .map((e) => InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/pet', arguments: e);
              },
              child: Column(
                children: [
                  Image.network(
                    'https://source.unsplash.com/random/?cat',
                    fit: BoxFit.scaleDown,
                    height: 80,
                  ),
                  Text(
                    e.nome,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              )))
          .toList(),
    );
  }
}
