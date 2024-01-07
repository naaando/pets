import 'package:flutter/material.dart';
import 'package:pets/models/espaco.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'space_provider.g.dart';

@riverpod
class Spaces extends _$Spaces {
  @override
  FutureOr<Map<String, Espaco>> build() async {
    return _fetch();
  }

  // Future<Pet> save(Pet pet, [XFile? image]) async {
  //   state = const AsyncValue.loading();

  //   final rep = ref.read(petRepositoryProvider);

  //   try {
  //     var savedPet = await rep.save(pet);

  //     if (image != null) {
  //       final imageUrl = await updateProfilePicture(
  //         savedPet,
  //         image,
  //         invalidateSelf: false,
  //       );

  //       savedPet = savedPet.copyWith(imagemUrl: imageUrl);
  //     }

  //     return savedPet;
  //   } finally {
  //     ref.invalidateSelf();
  //   }
  // }

  // Future<String?> updateProfilePicture(Pet pet, XFile file,
  //     {bool invalidateSelf = true}) async {
  //   final rep = ref.read(petRepositoryProvider);
  //   final imgUrl = await rep.updateProfilePicture(pet, file);

  //   if (invalidateSelf) {
  //     ref.invalidateSelf();
  //     await future;
  //   }

  //   return imgUrl;
  // }

  // Future<void> remove(pet) async {
  //   final rep = ref.read(petRepositoryProvider);
  //   await rep.remove(pet);

  //   ref.invalidateSelf();
  //   await future;
  // }

  FutureOr<Map<String, Espaco>> _fetch() async {
    final httpClient = ref.read(httpClientProvider);
    var json = await httpClient.getJson('api/espacos');

    // ignore: prefer_for_elements_to_map_fromiterable
    return Map<String, Espaco>.fromIterable(
      json,
      key: (json) => json['id'],
      value: (json) => Espaco.fromJson(json),
    );
  }
}
