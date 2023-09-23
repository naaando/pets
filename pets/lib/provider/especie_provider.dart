import 'package:pets/models/especie.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/repository/especie_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'especie_provider.g.dart';

@riverpod
Raw<EspecieRepository> especieRepository(EspecieRepositoryRef ref) {
  return EspecieRepository(ref.read(httpClientProvider));
}

@Riverpod()
class Especies extends _$Especies {
  @override
  FutureOr<Map<String, Especie>> build() async {
    return _fetch();
  }

  FutureOr<Map<String, Especie>> _fetch() async {
    final rep = ref.read(especieRepositoryProvider);
    return await rep.findAll();
  }
}
