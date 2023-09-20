import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/pet_avatar.dart';
import 'package:pets/components/skeleton_lista_pets.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class ListaPets extends ConsumerWidget {
  const ListaPets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Pet>> pets = ref.watch(petsOrderedByUpdateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Seus pets',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        pets.when(
          data: (pets) => lista(context, pets),
          error: (object, stackTrace) => const Text('Error'),
          loading: () => const SkeletonListaPets(),
        ),
      ],
    );
  }

  lista(context, List<Pet> pets) {
    final list = pets.map<Widget>((pet) => toListItem(context, pet)).toList();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 108,
      child: ListView(
        padding: const EdgeInsets.only(left: 8, right: 4),
        primary: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: list,
      ),
    );
  }

  Widget toListItem(BuildContext context, Pet pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, '/cadastro-pet', arguments: pet),
        child: Column(
          children: [
            PetAvatar.fromPet(
              pet,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(pet.nome),
          ],
        ),
      ),
    );
  }
}
