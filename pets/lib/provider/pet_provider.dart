import 'package:pets/models/pet.dart';
import 'package:pets/models/user.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:pets/repository/pet_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pet_provider.g.dart';

@riverpod
PetRepository petRepository(PetRepositoryRef ref) {
  return PetRepository(ref.watch(httpClientProvider));
}

// used to generate a fetchPostsProvider (as a FutureProvider)
@riverpod
Future<Map<String, Pet>> pets(PetsRef ref) async {
  User? user = await ref.watch(userProvider.future);
  String espacoId = user!.espacoAtivo.value!.id;

  return ref.watch(petRepositoryProvider).findAll(espacoId: espacoId);
}

@riverpod
Future<Pet?> pet(PetRef ref, String id) {
  return ref.watch(petRepositoryProvider).find(id);
}
