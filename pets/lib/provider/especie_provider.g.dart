// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'especie_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$especieRepositoryHash() => r'71750c3f6d8e020bba821bed393aa017cf8f1e78';

/// See also [especieRepository].
@ProviderFor(especieRepository)
final especieRepositoryProvider =
    AutoDisposeProvider<EspecieRepository>.internal(
  especieRepository,
  name: r'especieRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$especieRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EspecieRepositoryRef = AutoDisposeProviderRef<EspecieRepository>;
String _$especiesHash() => r'60ea5da4a66fd8d89cfa305bd0d71335e4b9a6fb';

/// See also [Especies].
@ProviderFor(Especies)
final especiesProvider =
    AutoDisposeAsyncNotifierProvider<Especies, Map<String, Especie>>.internal(
  Especies.new,
  name: r'especiesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$especiesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Especies = AutoDisposeAsyncNotifier<Map<String, Especie>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
