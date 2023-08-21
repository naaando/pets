import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/components/fab_actions.dart';
import 'package:pets/components/pet_avatar.dart';
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
                  .map<Widget>((Pet pet) => petCard(context, pet))
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

  Widget petCard(BuildContext context, Pet pet) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    var labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        // color: Colors.grey[700],
        );

    textOrPlaceholder(value, placeholder) => TextSpan(
          text: value ?? placeholder,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: value != null ? FontWeight.w600 : FontWeight.w400,
                color: value != null ? primaryColor : null,
              ),
        );

    var info = [
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: 'Idade ',
          style: labelStyle,
        ),
        textOrPlaceholder(
          pet.nascimento != null
              ? Jiffy.parse(pet.nascimento ?? '')
                  .fromNow(withPrefixAndSuffix: false)
              : null,
          'indefinido',
        ),
      ])),
      const SizedBox(height: 3),
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: 'Espécie ',
          style: labelStyle,
        ),
        textOrPlaceholder(
          pet.especie?.nome,
          'indefinida',
        ),
      ])),
      const SizedBox(height: 3),
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: 'Raça ',
          style: labelStyle,
        ),
        textOrPlaceholder(
          pet.raca,
          'indefinida',
        ),
      ])),
    ];

    var badges = <Widget>[
      Badge(
        backgroundColor: pet.castrado == true ? Colors.teal : Colors.red[400],
        label: pet.castrado == true
            ? const Text('Castrado')
            : const Text('Não castrado'),
      ),
    ];

    if (pet.sexo != null) {
      badges.addAll([
        const SizedBox(height: 3),
        Badge(
          backgroundColor: pet.sexo == 'macho' ? Colors.blue : Colors.pink[300],
          label:
              pet.sexo == 'macho' ? const Text('Macho') : const Text('Fêmea'),
        ),
      ]);
    }

    if (pet.falecimento != null) {
      badges.addAll([
        const SizedBox(height: 3),
        const Badge(
          backgroundColor: Colors.grey,
          label: Text('Falecido'),
        ),
      ]);
    }

    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leadingImage(context, pet),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(left: 22, top: 3),
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
                            children: info,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: badges,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/cadastro-pet', arguments: pet);
      },
    );
  }

  leadingImage(BuildContext context, Pet pet) {
    return PetAvatar.fromPet(pet, size: 50);
  }
}
