import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class PetsBottomNavigationBar extends ConsumerWidget {
  const PetsBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pets = ref.watch(petsProvider);

    final indicatorColor = Theme.of(context).colorScheme.primary;
    final decorationColor = Theme.of(context).colorScheme.primaryContainer;
    final labelColor = Theme.of(context).colorScheme.onPrimaryContainer;

    return Container(
      padding: const EdgeInsets.only(top: 6),
      margin: const EdgeInsets.all(6),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: decorationColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.dashboard_rounded, color: labelColor),
          ),
          Tab(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.pets, color: labelColor),
                const SizedBox(width: 5),
                Text(pets.when(
                    data: (Map<String, Pet> pets) => pets.length.toString(),
                    error: (object, stackTrace) => 'E',
                    loading: () => '')),
              ],
            ),
          ),
        ],
        labelColor: labelColor,
        indicator: BoxDecoration(
            color: indicatorColor, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
        splashBorderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
