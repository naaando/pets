import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:pets/translate.dart';
import 'package:remixicon/remixicon.dart';

class PetsBottomNavigationBar extends HookConsumerWidget {
  const PetsBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pets = ref.watch(petsProvider);

    return BottomAppBar(
      padding: const EdgeInsets.all(0),
      notchMargin: 0,
      child: TabBar(
        tabs: [
          Tab(
            icon: const Icon(Remix.home_2_fill),
            text: t(context).home,
          ),
          Tab(
            icon: const Icon(Icons.pets_outlined),
            text: pets.when(
              data: (Map<String, Pet> pets) => t(context).nPets(pets.length),
              error: (object, stackTrace) => 'E',
              loading: () => t(context).pets,
            ),
          ),
          const Tab(
            icon: Icon(Remix.syringe_fill),
            text: "Vaccine",
          ),
          const Tab(
            icon: Icon(Remix.capsule_fill),
            text: "Medicine",
          ),
        ],
      ),
    );
  }
}
