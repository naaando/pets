import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/especie.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/repository/especie_repository.dart';

final especieRepositoryProvider =
    ChangeNotifierProvider<EspecieRepository>((ref) {
  final httpClient = ref.watch(httpClientProvider);

  return EspecieRepository(httpClient);
});

final especiesProvider = FutureProvider<Map<String, Especie>>(
    (ref) => ref.watch(especieRepositoryProvider).findAll());

final especieProvider = FutureProvider.family<Especie?, String>(
    (ref, id) async => ref.watch(especieRepositoryProvider).find(id));
