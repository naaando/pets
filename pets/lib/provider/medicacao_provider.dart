import 'package:pets/models/medicacao.dart';
import 'package:pets/provider/alarm_provider.dart';
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

  Future<void> save(Medicacao medicacao, String? proximaData) async {
    final rep = ref.read(medicacaoRepositoryProvider);

    var medicacaoSalva = await rep.save(medicacao);
    await updateAlarms(medicacaoSalva);

    if (proximaData != null) {
      await rep.save(Medicacao.proximaDose(medicacaoSalva!, proximaData));
    }

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

  Future<void> updateAlarms(Medicacao? medicacaoSalva) async {
    if (medicacaoSalva == null || medicacaoSalva.completado) {
      return;
    }

    var alarmProviderRef = ref.read(alarmsProvider.notifier);

    int alarmId = medicacaoSalva.id!;

    alarmProviderRef.add(
      alarmId,
      medicacaoSalva.nome,
      medicacaoSalva.nome,
      DateTime.parse(medicacaoSalva.quando!),
    );
  }
}
