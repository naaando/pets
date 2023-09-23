// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'especie_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$especieRepositoryHash() => r'39aa8d9e71e4931e37eb3cba3418963a2ba568ce';

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
String _$especiesHash() => r'55c05068d748f0543444cf9cc44734a538749c31';

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
