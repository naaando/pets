import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/remedio.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:pets/provider/tipo_remedio_provider.dart';
import 'package:pets/repository/remedio_repository.dart';

final remedioRepositoryProvider =
    ChangeNotifierProvider<RemedioRepository>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  final tipoRemedioRepository = ref.watch(tipoRemedioRepositoryProvider);
  final petRepository = ref.watch(petRepositoryProvider);

  return RemedioRepository(httpClient, petRepository, tipoRemedioRepository);
});

final remediosProvider = FutureProvider<Map<String, Remedio>>(
    (ref) => ref.watch(remedioRepositoryProvider).findAll());
