import 'package:pets/config.dart';

class Pet {
  String id;
  String nome;
  bool? castrado;
  String? dateCreated;
  String? dateUpdated;
  String? especie;
  String? fotoPerfil;
  String? mae;
  String? nascimento;
  String? pai;
  String? raca;
  String? sexo;
  String? userCreated;
  String? userUpdated;
  String? espaco;

  Uri? get fotoPerfilUrl =>
      fotoPerfil != null ? baseUri.replace(path: 'assets/$fotoPerfil') : null;

  Pet(
      {required this.id,
      required this.nome,
      required this.castrado,
      required this.dateUpdated,
      required this.dateCreated,
      required this.especie,
      required this.fotoPerfil,
      required this.nascimento,
      required this.mae,
      required this.pai,
      required this.sexo,
      required this.raca,
      required this.espaco,
      required this.userCreated,
      required this.userUpdated});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      nome: json['nome'],
      castrado: json['castrado'],
      dateCreated: json['date_created'],
      dateUpdated: json['date_updated'],
      especie: json['especie'],
      fotoPerfil: json['foto_perfil'],
      mae: json['mae'],
      nascimento: json['nascimento'],
      pai: json['pai'],
      raca: json['raca'],
      sexo: json['sexo'],
      espaco: json['espaco'],
      userCreated: json['user_created'],
      userUpdated: json['user_updated'],
    );
  }
}
