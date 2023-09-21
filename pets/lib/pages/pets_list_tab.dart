import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
      body: RefreshIndicator(
        child: pets.when(
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
        onRefresh: () => ref.refresh(petsProvider.future),
      ),
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
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          barraDePesquisa(pesquisa),
          Expanded(
            child: ListView(
              children: [
                ...petsFiltrados.map<Widget>(
                  (Pet pet) => PetCard(pet),
                ),
                const SizedBox(height: 20), // Para não ficar escondido pelo FAB
              ],
            ),
          ),
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
      padding: const EdgeInsets.only(bottom: 6, left: 2, right: 2),
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
