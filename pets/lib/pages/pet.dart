import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pets/components/pets_app_bar.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class PetPage extends ConsumerWidget {
  static const String routeName = '/pet';

  const PetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var title = 'Pets';

    // AsyncValue<Map<String, Pet>> pets = ref.watch(petsProvider);
    // context.
    // var pet = pets[e];
    var pet = ModalRoute.of(context)!.settings.arguments as Pet;

    return Scaffold(
      appBar: PetsAppBar(
        title: title,
      ),
      body: body(context, title, pet),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // final loginState = Provider.of<LoginState>(context, listen: false);
          // loginState.logout();
        },
        tooltip: 'Adicionar novo pet',
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget body(context, String title, Pet pet) {
    return Form(
        child: Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        children: [
          TextFormField(
            initialValue: pet.nome,
            decoration: const InputDecoration(
              icon: Icon(Icons.pets),
              hintText: 'Nome do pet',
              labelText: 'Nome',
            ),
          ),
          TextFormField(
            initialValue: pet.especie,
            decoration: const InputDecoration(
              icon: Icon(Icons.pets),
              hintText: 'Espécie do pet',
              labelText: 'Espécie',
            ),
          ),
          TextFormField(
            initialValue: pet.raca,
            decoration: const InputDecoration(
              icon: Icon(Icons.pets),
              hintText: 'Raça do pet',
              labelText: 'Raça',
            ),
          ),
        ],
      ),
    ));
    //   return GridView.count(
    //     crossAxisCount: 2,
    //     scrollDirection: Axis.vertical,
    //     padding: const EdgeInsets.all(35),
    //     crossAxisSpacing: 35,
    //     mainAxisSpacing: 35,
    //     children: pets.values
    //         .map((e) => InkWell(
    //             onTap: () {
    //               Navigator.pushNamed(context, '/pet', arguments: e);
    //             },
    //             child: Column(
    //               children: [
    //                 Image.network(
    //                   'https://source.unsplash.com/random/?cat',
    //                   fit: BoxFit.scaleDown,
    //                   height: 80,
    //                 ),
    //                 Text(
    //                   e.nome,
    //                   style: Theme.of(context).textTheme.headline5,
    //                 ),
    //               ],
    //             )))
    //         .toList(),
    //   );
  }
}
