// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacina_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$vacinaRepositoryHash() => r'f42828cffcc1723ec14e8e9b8c12217d4f24ab4e';

/// See also [vacinaRepository].
@ProviderFor(vacinaRepository)
final vacinaRepositoryProvider = AutoDisposeProvider<VacinaRepository>.internal(
  vacinaRepository,
  name: r'vacinaRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$vacinaRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VacinaRepositoryRef = AutoDisposeProviderRef<VacinaRepository>;
String _$vacinasHash() => r'e0ee2023b4fd1fa60cd96e55f1805cbda1311a56';

/// See also [Vacinas].
@ProviderFor(Vacinas)
final vacinasProvider =
    AutoDisposeAsyncNotifierProvider<Vacinas, Map<String, Vacina>>.internal(
  Vacinas.new,
  name: r'vacinasProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$vacinasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Vacinas = AutoDisposeAsyncNotifier<Map<String, Vacina>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
