// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petRepositoryHash() => r'5f00d589bf10e1535654d641c9f9f443f6283cc0';

/// See also [petRepository].
@ProviderFor(petRepository)
final petRepositoryProvider = AutoDisposeProvider<PetRepository>.internal(
  petRepository,
  name: r'petRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$petRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PetRepositoryRef = AutoDisposeProviderRef<PetRepository>;
String _$petsOrderedByUpdateHash() =>
    r'bc87d500f9808e78dce386b4946671544b515804';

/// See also [petsOrderedByUpdate].
@ProviderFor(petsOrderedByUpdate)
final petsOrderedByUpdateProvider =
    AutoDisposeFutureProvider<List<Pet>>.internal(
  petsOrderedByUpdate,
  name: r'petsOrderedByUpdateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$petsOrderedByUpdateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PetsOrderedByUpdateRef = AutoDisposeFutureProviderRef<List<Pet>>;
String _$petsHash() => r'cce1dcb2e3c319da8d8fe7cd864a04f8c995e13b';

/// See also [Pets].
@ProviderFor(Pets)
final petsProvider =
    AutoDisposeAsyncNotifierProvider<Pets, Map<String, Pet>>.internal(
  Pets.new,
  name: r'petsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$petsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Pets = AutoDisposeAsyncNotifier<Map<String, Pet>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
