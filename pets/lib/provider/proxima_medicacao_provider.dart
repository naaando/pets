import 'package:pets/models/medicacao.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/repository/proxima_medicacao_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'proxima_medicacao_provider.g.dart';

@riverpod
ProximaMedicacaoRepository proximaMedicacaoRepository(
    ProximaMedicacaoRepositoryRef ref) {
  return ProximaMedicacaoRepository(ref.watch(httpClientProvider));
}

@riverpod
class ProximasMedicacoes extends _$ProximasMedicacoes {
  @override
  FutureOr<Map<String, Medicacao>> build() async {
    return _fetch();
  }

  Future<void> save(Medicacao medicacao) async {
    throw UnimplementedError();
    // final rep = ref.read(medicacaoRepositoryProvider);
    // await rep.save(medicacao);

    // state = const AsyncValue.loading();
    // state = await AsyncValue.guard(() async => _fetch());
  }

  Future<void> remove(medicacao) async {
    throw UnimplementedError();
    // final rep = ref.read(medicacaoRepositoryProvider);
    // await rep.remove(medicacao);

    // state = const AsyncValue.loading();
    // state = await AsyncValue.guard(() async => _fetch());
  }

  FutureOr<Map<String, Medicacao>> _fetch() async {
    final rep = ref.read(proximaMedicacaoRepositoryProvider);
    return await rep.findAll();
  }
}
