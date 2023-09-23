import 'package:pets/models/medicacao.dart';
import 'package:pets/provider/alarm_provider.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:pets/repository/medicacao_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medicacao_provider.g.dart';

@riverpod
Raw<MedicacaoRepository> medicacaoRepository(MedicacaoRepositoryRef ref) {
  return MedicacaoRepository(ref.read(httpClientProvider));
}

@riverpod
class Medicacoes extends _$Medicacoes {
  @override
  FutureOr<Map<String, Medicacao>> build() async {
    return _fetch();
  }

  Future<Medicacao?> save(Medicacao medicacao, String? proximaData) async {
    final pets = await ref.read(petsProvider.future);
    final rep = ref.read(medicacaoRepositoryProvider);

    final medicacaoSalva = await rep.save(medicacao);
    medicacaoSalva?.pet = pets[medicacaoSalva.petId];
    await updateAlarms(medicacaoSalva);

    if (proximaData != null) {
      await rep.save(Medicacao.proximaDose(medicacaoSalva!, proximaData));
    }

    ref.invalidateSelf();
    await future;

    return medicacaoSalva;
  }

  Future<void> remove(medicacao) async {
    final rep = ref.read(medicacaoRepositoryProvider);
    await rep.remove(medicacao);

    ref.invalidateSelf();
    await future;
  }

  FutureOr<Map<String, Medicacao>> _fetch() async {
    final pets = await ref.read(petsProvider.future);
    final rep = ref.read(medicacaoRepositoryProvider);

    var medicacoes = await rep.findAll();

    return medicacoes.map(
      (key, value) => MapEntry(key, value..pet = pets[value.petId]),
    );
  }

  Future<void> updateAlarms(Medicacao? medicacaoSalva) async {
    if (medicacaoSalva == null || medicacaoSalva.completado) {
      return;
    }

    var alarmProviderRef = ref.read(alarmsProvider.notifier);

    int alarmId = medicacaoSalva.id!;

    alarmProviderRef.add(
      alarmId,
      "${medicacaoSalva.tipoExtenso}: ${medicacaoSalva.nome}",
      "de ${medicacaoSalva.pet?.nome}",
      DateTime.parse(medicacaoSalva.quando!),
    );
  }
}
