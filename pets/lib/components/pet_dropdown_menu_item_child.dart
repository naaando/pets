import 'package:flutter/material.dart';
import 'package:pets/components/pet_avatar.dart';
import 'package:pets/models/pet.dart';

class PetDropdownMenuItemChild extends StatelessWidget {
  final Pet pet;

  const PetDropdownMenuItemChild(this.pet, {super.key});

  @override
  Widget build(BuildContext context) {
    // return Text(pet.nome);
    return Row(children: [
      PetAvatar.fromPet(
        pet,
        size: 12,
        textStyle: Theme.of(context).textTheme.labelSmall,
      ),
      const SizedBox(width: 8),
      Text(pet.nome)
    ]);
  }
}
