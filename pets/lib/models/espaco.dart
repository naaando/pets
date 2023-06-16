import 'package:isar/isar.dart';
import 'package:pets/fasthash.dart';

part 'espaco.g.dart';

@collection
class Espaco {
  final String id;

  Id get isarId => fastHash(id);

  String nome;

  Espaco({required this.id, required this.nome});

  factory Espaco.fromJson(Map<String, dynamic> json) {
    return Espaco(
      id: json['id'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    }..removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));
  }
}
