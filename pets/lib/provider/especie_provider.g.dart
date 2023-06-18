// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'especie_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$especieRepositoryHash() => r'2d353140615b9e56e0e5fdc1c754a543b6d5df16';

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
