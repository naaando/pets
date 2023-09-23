import 'package:image_picker/image_picker.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/especie_provider.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/repository/pet_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pet_provider.g.dart';

@riverpod
PetRepository petRepository(PetRepositoryRef ref) {
  return PetRepository(ref.read(httpClientProvider));
}

// ordered per updatedAt
@riverpod
Future<List<Pet>> petsOrderedByUpdate(PetsOrderedByUpdateRef ref) async {
  final pets = ref.watch(petsProvider);

  return pets.when(
    data: (pets) => pets.values.toList()
      ..sort(
        (a, b) => a.updatedAt is String
            ? DateTime.parse(a.updatedAt ?? '').microsecondsSinceEpoch
            : DateTime.parse(a.createdAt ?? '').microsecondsSinceEpoch,
      ),
    error: (e, s) => throw e,
    loading: () => [],
  );
}

@riverpod
class Pets extends _$Pets {
  @override
  FutureOr<Map<String, Pet>> build() async {
    return _fetch();
  }

  Future<Pet> save(Pet pet, [XFile? image]) async {
    state = const AsyncValue.loading();

    final rep = ref.read(petRepositoryProvider);
    var savedPet = await rep.save(pet);

    if (image != null) {
      final imageUrl = await updateProfilePicture(savedPet, image);
      savedPet = savedPet.copyWith(imagemUrl: imageUrl);
    }

    ref.invalidateSelf();
    await future;
    return savedPet;
  }

  Future<String?> updateProfilePicture(Pet pet, XFile file) async {
    final rep = ref.read(petRepositoryProvider);
    final imgUrl = await rep.updateProfilePicture(pet, file);

    ref.invalidateSelf();
    await future;

    return imgUrl;
  }

  Future<void> remove(pet) async {
    final rep = ref.read(petRepositoryProvider);
    await rep.remove(pet);

    ref.invalidateSelf();
    await future;
  }

  FutureOr<Map<String, Pet>> _fetch() async {
    final especieRepository = ref.read(especieRepositoryProvider);
    var especies = await especieRepository.findAll();

    final rep = ref.read(petRepositoryProvider);
    var pets = await rep.findAll();

    return pets.map(
      (key, value) =>
          MapEntry(key, value.copyWith(especie: especies[value.especieId])),
    );
  }
}
