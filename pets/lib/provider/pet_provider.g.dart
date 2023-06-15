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
String _$petsHash() => r'58ccdb2d79472d925c3dde83003bc2c5eea1e5e8';

/// See also [pets].
@ProviderFor(pets)
final petsProvider = AutoDisposeFutureProvider<Map<String, Pet>>.internal(
  pets,
  name: r'petsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$petsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PetsRef = AutoDisposeFutureProviderRef<Map<String, Pet>>;
String _$petHash() => r'c5927728bc35423493d1fffe61b47ea1c2951e3f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef PetRef = AutoDisposeFutureProviderRef<Pet?>;

/// See also [pet].
@ProviderFor(pet)
const petProvider = PetFamily();

/// See also [pet].
class PetFamily extends Family<AsyncValue<Pet?>> {
  /// See also [pet].
  const PetFamily();

  /// See also [pet].
  PetProvider call(
    String id,
  ) {
    return PetProvider(
      id,
    );
  }

  @override
  PetProvider getProviderOverride(
    covariant PetProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'petProvider';
}

/// See also [pet].
class PetProvider extends AutoDisposeFutureProvider<Pet?> {
  /// See also [pet].
  PetProvider(
    this.id,
  ) : super.internal(
          (ref) => pet(
            ref,
            id,
          ),
          from: petProvider,
          name: r'petProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$petHash,
          dependencies: PetFamily._dependencies,
          allTransitiveDependencies: PetFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is PetProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
