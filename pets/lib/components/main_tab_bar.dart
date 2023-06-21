import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class MainTabBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pets = ref.watch(petsProvider);

    return TabBar(
      tabs: [
        const Tab(
          icon: Icon(Icons.dashboard_rounded),
          text: 'Início',
        ),
        Tab(
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.pets),
              const SizedBox(width: 5),
              Text(pets.when(
                  data: (Map<String, Pet> pets) => pets.length.toString(),
                  error: (object, stackTrace) => 'E',
                  loading: () => '')),
            ],
          ),
          text: 'Animais',
        ),
        // const Tab(icon: Icon(Icons.store)),
        const Tab(
          icon: Icon(Icons.person_search),
          text: 'Adoção',
        ), // Adoção
      ],
      labelColor: Colors.white,
      indicator: BoxDecoration(
          color: Colors.red.shade700, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
      splashBorderRadius: BorderRadius.circular(20),
    );
  }
}
