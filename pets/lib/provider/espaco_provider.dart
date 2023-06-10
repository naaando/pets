import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/espaco.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/repository/espaco_repository.dart';

final espacoRepositoryProvider =
    ChangeNotifierProvider<EspacoRepository>((ref) {
  final httpClient = ref.watch(httpClientProvider);

  return EspacoRepository(httpClient);
});

final espacosProvider = FutureProvider<Map<String, Espaco>>(
    (ref) => ref.watch(espacoRepositoryProvider).findAll());

final espacoProvider = FutureProvider.family<Espaco?, String>(
    (ref, id) async => ref.watch(espacoRepositoryProvider).find(id));
