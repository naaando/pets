import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/components/pet_avatar.dart';
import 'package:pets/components/skeleton_lista_pets.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:pets/translate.dart';

class ListaPets extends HookConsumerWidget {
  const ListaPets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    AsyncValue<List<Pet>> pets = ref.watch(petsOrderedByUpdateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            t().dashboardMyPets,
            textAlign: TextAlign.start,
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onBackground,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: pets.when(
            data: (pets) => lista(context, pets),
            error: (object, stackTrace) => const Text('Error'),
            loading: () => const SkeletonListaPets(),
          ),
        ),
      ],
    );
  }

  Widget lista(context, List<Pet> pets) {
    final list = pets.map<Widget>((pet) => toListItem(context, pet)).toList();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 110,
      child: ListView(
        padding: const EdgeInsets.only(left: 12, right: 12),
        primary: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: list,
      ),
    );
  }

  Widget toListItem(BuildContext context, Pet pet) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      width: 90,
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, '/cadastro-pet', arguments: pet),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: PetAvatar.fromPet(
                pet,
                size: 40,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pet.nome,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
