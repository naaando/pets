import 'package:pets/models/vacina.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/repository/vacina_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vacina_provider.g.dart';

@riverpod
VacinaRepository vacinaRepository(VacinaRepositoryRef ref) {
  return VacinaRepository(ref.watch(httpClientProvider));
}

@riverpod
class Vacinas extends _$Vacinas {
  @override
  FutureOr<Map<String, Vacina>> build() async {
    return _fetch();
  }

  Future<void> save(Vacina vacina) async {
    final rep = ref.read(vacinaRepositoryProvider);
    await rep.save(vacina);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => _fetch());
  }

  Future<void> remove(vacina) async {
    final rep = ref.read(vacinaRepositoryProvider);
    await rep.remove(vacina);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => _fetch());
  }

  FutureOr<Map<String, Vacina>> _fetch() async {
    final rep = ref.read(vacinaRepositoryProvider);
    return await rep.findAll();
  }
}
