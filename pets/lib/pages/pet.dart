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
    var pet = ModalRoute.of(context)!.settings.arguments as Pet;
    var title = pet.nome;

    return Scaffold(
      appBar: PetsAppBar(
        title: title,
      ),
      body: body(context, title, pet),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Adicionar novo animal',
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget body(context, String title, Pet pet) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          TextFormField(
            initialValue: pet.nome,
            decoration: const InputDecoration(
              icon: Icon(Icons.pets),
              hintText: 'Nome do animal',
              labelText: 'Nome',
            ),
          ),
          TextFormField(
            initialValue: pet.especie,
            decoration: const InputDecoration(
              icon: Icon(Icons.pets),
              hintText: 'Espécie do animal',
              labelText: 'Espécie',
            ),
          ),
          TextFormField(
            initialValue: pet.raca,
            decoration: const InputDecoration(
              icon: Icon(Icons.pets),
              hintText: 'Raça do animal',
              labelText: 'Raça',
            ),
          ),
        ],
      ),
    ));
  }
}
