import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class PetsBottomNavigationBar extends ConsumerWidget {
  const PetsBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pets = ref.watch(petsProvider);

    return BottomAppBar(
      clipBehavior: Clip.antiAlias,
      shape: const CircularNotchedRectangle(),
      notchMargin: 12,
      child: TabBar(
        tabs: [
          const Tab(
            icon: Icon(Icons.home_rounded),
            text: 'Home',
          ),
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.pets_rounded),
                const SizedBox(width: 5),
                Text(
                  pets.when(
                      data: (Map<String, Pet> pets) => pets.length.toString(),
                      error: (object, stackTrace) => 'E',
                      loading: () => ''),
                ),
              ],
            ),
            text: 'Pets',
          ),
        ],
      ),
    );
  }
}
