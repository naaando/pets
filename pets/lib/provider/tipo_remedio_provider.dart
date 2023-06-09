import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/tipo_remedio.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:pets/repository/tipo_remedio_repository.dart';

final tipoRemedioRepositoryProvider =
    ChangeNotifierProvider<TipoRemedioRepository>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  final token = ref.watch(tokenProvider);

  return TipoRemedioRepository(httpClient, token);
});

final tiposRemedioProvider = FutureProvider<Map<String, TipoRemedio>>(
    (ref) => ref.watch(tipoRemedioRepositoryProvider).findAll());

final tipoRemedioProvider = FutureProvider.family<TipoRemedio?, String>(
    (ref, id) async => ref.watch(tipoRemedioRepositoryProvider).find(id));
