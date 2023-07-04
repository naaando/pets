import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/pet_provider.dart';

class ListaPets extends ConsumerWidget {
  const ListaPets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Map<String, Pet>> pets = ref.watch(petsProvider);

    return pets.when(
        data: (pets) => lista(context, pets),
        error: (object, stackTrace) => const Text('Error'),
        loading: () => const CircularProgressIndicator());
  }

  lista(context, Map<String, Pet> pets) {
    final list =
        pets.values.map<Widget>((pet) => toListItem(context, pet)).toList();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 108,
      child: ListView(
        padding: const EdgeInsets.only(left: 12, right: 4),
        // primary: false,
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
            CircleAvatar(
              radius: 40,
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey[200],
              foregroundImage:
                  FastCachedImageProvider(pet.fotoPerfilUrl.toString()),
              child: Text(pet.nome.substring(0, 2).toUpperCase()),
            ),
            const SizedBox(height: 8),
            Text(pet.nome),
          ],
        ),
      ),
    );
  }
}
