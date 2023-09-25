import 'package:pets/models/Medicacao/medicacao.dart';
import 'package:pets/provider/medicacao_provider.dart';
import 'package:pets/provider/pet_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eventos_provider.g.dart';

@riverpod
Future<List<Medicacao>> eventos(EventosRef ref) async {
  var pets = await ref.watch(petsProvider.future);
  var medicacoes = await ref.watch(medicacoesProvider.future);

  return medicacoes.values
      .map((value) => value.copyWith(pet: pets[value.petId]))
      .toList();
}
