import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/fab_actions.dart';
import 'package:pets/components/pet_card.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

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

    var petsFiltrados = pets.toList()
      ..sort((a, b) {
        return ratio(b.nome, pesquisa.value)
            .compareTo(ratio(a.nome, pesquisa.value));
      });

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          barraDePesquisa(pesquisa),
          Expanded(
            child: ListView(
              children: petsFiltrados
                  .map<Widget>(
                    (Pet pet) => PetCard(pet),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget barraDePesquisa(ValueNotifier<String> pesquisa) {
    final controller = useTextEditingController();
    controller.addListener(() {
      pesquisa.value = controller.text;
    });

    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Pesquisar',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: pesquisa.value == ''
              ? null
              : IconButton(
                  onPressed: () => controller.clear(),
                  icon: const Icon(Icons.clear),
                ),
        ),
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          pesquisa.value = value;
        },
      ),
    );
  }
}
