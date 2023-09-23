// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicacao_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$medicacaoRepositoryHash() =>
    r'6c5b4417bc8cafd3a69d3927f7973163a7ca6f47';

/// See also [medicacaoRepository].
@ProviderFor(medicacaoRepository)
final medicacaoRepositoryProvider =
    AutoDisposeProvider<MedicacaoRepository>.internal(
  medicacaoRepository,
  name: r'medicacaoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$medicacaoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MedicacaoRepositoryRef = AutoDisposeProviderRef<MedicacaoRepository>;
String _$medicacoesHash() => r'2d0119199a51bff60b2698623e4ee38956a1ad59';

/// See also [Medicacoes].
@ProviderFor(Medicacoes)
final medicacoesProvider = AutoDisposeAsyncNotifierProvider<Medicacoes,
    Map<String, Medicacao>>.internal(
  Medicacoes.new,
  name: r'medicacoesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$medicacoesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Medicacoes = AutoDisposeAsyncNotifier<Map<String, Medicacao>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
