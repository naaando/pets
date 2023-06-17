// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petRepositoryHash() => r'8c0abecd0007dea0f0ce790d87a77d72227c68f7';

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
String _$petsHash() => r'01e80b8adc5ddef49c231fdff63c10e6ea13978a';

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
