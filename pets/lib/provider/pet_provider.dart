import 'package:image_picker/image_picker.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/especie_provider.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/repository/pet_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pet_provider.g.dart';

@riverpod
PetRepository petRepository(PetRepositoryRef ref) {
  return PetRepository(ref.watch(httpClientProvider));
}

// ordered per updatedAt
@riverpod
Future<List<Pet>> petsOrderedByUpdate(PetsOrderedByUpdateRef ref) async {
  final pets = await ref.watch(petsProvider.future);

  return pets.values.toList()
    ..sort((a, b) {
      return a.updatedAt is String
          ? DateTime.parse(a.updatedAt ?? '').microsecondsSinceEpoch
          : DateTime.parse(a.createdAt ?? '').microsecondsSinceEpoch;
    });
}

@riverpod
class Pets extends _$Pets {
  @override
  FutureOr<Map<String, Pet>> build() async {
    return _fetch();
  }

  Future<Pet> save(Pet pet) async {
    state = const AsyncValue.loading();

    final rep = ref.read(petRepositoryProvider);
    final savedPet = await rep.save(pet);

    state = await AsyncValue.guard(() async => _fetch());
    return savedPet;
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
    final especieRepository = ref.read(especieRepositoryProvider);
    var especies = await especieRepository.findAll();

    final rep = ref.read(petRepositoryProvider);
    var pets = await rep.findAll();

    return pets.map(
      (key, value) => MapEntry(key, value..especie = especies[value.especieId]),
    );
  }
}
