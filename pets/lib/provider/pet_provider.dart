import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pets/models/pet.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:pets/repository/pet_repository.dart';

final petRepositoryProvider = ChangeNotifierProvider<PetRepository>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  final token = ref.watch(tokenProvider);

  return PetRepository(httpClient, token);
});

final petFormStateProvider =
    StateProvider<GlobalKey<FormState>>((ref) => GlobalKey<FormState>());

final petsProvider = FutureProvider<Map<String, Pet>>(
    (ref) => ref.watch(petRepositoryProvider).findAll());

final petProvider = FutureProvider.family<Pet?, String>(
    (ref, id) async => ref.watch(petRepositoryProvider).find(id));

final filteredPetsProvider = FutureProvider<List<Pet>>((ref) {
  return ref.watch(petsProvider).when(
      data: (pets) =>
          pets.values.toList()..sort((a, b) => a.nome.compareTo(b.nome)),
      error: (err, stackTrace) => [],
      loading: () => []);
});
