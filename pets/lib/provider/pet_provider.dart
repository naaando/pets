import 'package:image_picker/image_picker.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/repository/pet_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pet_provider.g.dart';

@riverpod
PetRepository petRepository(PetRepositoryRef ref) {
  return PetRepository(ref.watch(httpClientProvider));
}

@riverpod
class Pets extends _$Pets {
  @override
  FutureOr<Map<String, Pet>> build() async {
    return _fetch();
  }

  Future<void> save(Pet pet) async {
    final rep = ref.read(petRepositoryProvider);
    await rep.save(pet);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => _fetch());
  }

  Future<String?> updateProfilePicture(Pet pet, XFile file) async {
    final rep = ref.read(petRepositoryProvider);
    final imgUrl = await rep.updateProfilePicture(pet, file);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => _fetch());

    return imgUrl;
  }

  Future<void> remove(pet) async {
    final rep = ref.read(petRepositoryProvider);
    await rep.remove(pet);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => _fetch());
  }

  FutureOr<Map<String, Pet>> _fetch() async {
    final rep = ref.read(petRepositoryProvider);
    return await rep.findAll();
  }
}
