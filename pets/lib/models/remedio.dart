import 'package:pets/models/pet.dart';
import 'package:pets/models/tipo_remedio.dart';

class Remedio {
  String? id;
  Pet? animal;
  String? nome;
  num? dose;
  String? administrado;
  TipoRemedio? tipoRemedio;

  Remedio({
    this.id,
    this.animal,
    this.nome,
    this.dose,
    this.administrado,
    this.tipoRemedio,
  });

  factory Remedio.fromJson(Map<String, dynamic> json,
      {Pet? animal, TipoRemedio? tipoRemedio}) {
    return Remedio(
      id: json['id'],
      nome: json['nome'] ?? '',
      dose: json['dose'],
      administrado: json['administrado'],
      animal: animal,
      tipoRemedio: tipoRemedio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'animal': animal!.id,
      'nome': nome,
      'dose': dose,
      'administrado': administrado,
      'tipoRemedio': tipoRemedio,
    };
  }
}
