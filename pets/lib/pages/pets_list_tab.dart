import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/fab_actions.dart';
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
    final controller = useTextEditingController();
    controller.addListener(() {
      pesquisa.value = controller.text;
    });

    return Container(
      padding: const EdgeInsets.only(bottom: 15),
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

  Widget petCard(BuildContext context, Pet pet) {
    textOrPlaceholder(value, placeholder) => TextSpan(
          text: value ?? placeholder,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: value != null ? FontWeight.w500 : FontWeight.w400,
                color: value != null ? Colors.grey[900] : Colors.grey[600],
              ),
        );

    return InkWell(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                leadingImage(context, pet),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(left: 22, top: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          pet.nome,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // idade
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Idade ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  textOrPlaceholder(
                                      pet.nascimento != null
                                          ? Jiffy.parse(pet.nascimento ?? '')
                                              .fromNow()
                                          : null,
                                      'indefinido'),
                                ])),
                                const SizedBox(height: 3),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Espécie ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  textOrPlaceholder(
                                      pet.especie?.nome, 'indefinida'),
                                ])),
                                const SizedBox(height: 3),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Raça ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  textOrPlaceholder(pet.raca, 'indefinida'),
                                ])),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Badge(
                                  backgroundColor: pet.castrado == true
                                      ? Colors.teal
                                      : Colors.orange,
                                  label: pet.castrado == true
                                      ? const Text('Castrado')
                                      : const Text('Não castrado'),
                                ),
                                const SizedBox(height: 3),
                                Badge(
                                  backgroundColor: pet.sexo == 'macho'
                                      ? Colors.blue
                                      : Colors.pink[300],
                                  label: pet.sexo == 'macho'
                                      ? const Text('Macho')
                                      : const Text('Fêmea'),
                                ),
                                const SizedBox(height: 3),
                                Badge(
                                  backgroundColor: pet.obito == null
                                      ? Colors.lightGreen
                                      : Colors.grey,
                                  label: pet.obito == null
                                      ? const Text('Vivo')
                                      : const Text('Falecido'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
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
