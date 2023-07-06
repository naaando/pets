// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxima_medicacao_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$proximaMedicacaoRepositoryHash() =>
    r'8771836b154ff661a518088a4e413f1829ccd4db';

/// See also [proximaMedicacaoRepository].
@ProviderFor(proximaMedicacaoRepository)
final proximaMedicacaoRepositoryProvider =
    AutoDisposeProvider<ProximaMedicacaoRepository>.internal(
  proximaMedicacaoRepository,
  name: r'proximaMedicacaoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$proximaMedicacaoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProximaMedicacaoRepositoryRef
    = AutoDisposeProviderRef<ProximaMedicacaoRepository>;
String _$proximasMedicacoesHash() =>
    r'2e3dca043aa543aba2f80fdea31f6e1b16ac19ff';

/// See also [ProximasMedicacoes].
@ProviderFor(ProximasMedicacoes)
final proximasMedicacoesProvider = AutoDisposeAsyncNotifierProvider<
    ProximasMedicacoes, Map<String, Medicacao>>.internal(
  ProximasMedicacoes.new,
  name: r'proximasMedicacoesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$proximasMedicacoesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProximasMedicacoes = AutoDisposeAsyncNotifier<Map<String, Medicacao>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
