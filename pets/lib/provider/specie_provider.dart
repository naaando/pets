import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pets/models/specie.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:pets/repository/specie_repository.dart';

final specieRepositoryProvider =
    ChangeNotifierProvider<SpecieRepository>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  final token = ref.watch(tokenProvider);

  return SpecieRepository(httpClient, token);
});

final speciesProvider = FutureProvider<Map<String, Specie>>(
    (ref) => ref.watch(specieRepositoryProvider).findAll());

final specieProvider = FutureProvider.family<Specie?, String>(
    (ref, id) async => ref.watch(specieRepositoryProvider).find(id));
