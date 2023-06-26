import 'package:pets/models/medicacao.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/repository/medicacao_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medicacao_provider.g.dart';

@riverpod
MedicacaoRepository medicacaoRepository(MedicacaoRepositoryRef ref) {
  return MedicacaoRepository(ref.watch(httpClientProvider));
}

@riverpod
class Medicacoes extends _$Medicacoes {
  @override
  FutureOr<Map<String, Medicacao>> build() async {
    return _fetch();
  }

  Future<void> save(Medicacao medicacao) async {
    final rep = ref.read(medicacaoRepositoryProvider);
    await rep.save(medicacao);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => _fetch());
  }

  Future<void> remove(medicacao) async {
    final rep = ref.read(medicacaoRepositoryProvider);
    await rep.remove(medicacao);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => _fetch());
  }

  FutureOr<Map<String, Medicacao>> _fetch() async {
    final rep = ref.read(medicacaoRepositoryProvider);
    return await rep.findAll();
  }
}
