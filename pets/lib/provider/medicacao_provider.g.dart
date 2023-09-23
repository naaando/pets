// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicacao_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$medicacaoRepositoryHash() =>
    r'08940e3b1a3801966ee44db4a2586c72305e2212';

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
String _$medicacoesHash() => r'3329fe0340f2df799dbdc8ce8ef9b5a5bc3ee4cc';

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
