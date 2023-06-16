import 'package:pets/config.dart';

class Pet {
  String? id;
  String nome;
  bool? castrado;
  String? dateCreated;
  String? dateUpdated;
  String? especieId;
  String? fotoPerfil;
  String? mae;
  String? nascimento;
  String? castracao;
  String? pai;
  String? raca;
  String? sexo;
  String? userCreated;
  String? userUpdated;
  String espacoId;
  String? obito;

  Uri? get fotoPerfilUrl => fotoPerfil != null
      ? baseUriWithAccessToken.replace(
          path: 'assets/$fotoPerfil',
          queryParameters: {
              'key': 'thumb',
              ...baseUriWithAccessToken.queryParameters
            })
      : null;

  Pet(
      {this.id,
      this.nome = '',
      this.castrado,
      this.dateUpdated,
      this.dateCreated,
      this.especieId,
      this.fotoPerfil,
      this.nascimento,
      this.castracao,
      this.mae,
      this.pai,
      this.sexo,
      this.raca,
      required this.espacoId,
      this.obito,
      this.userCreated,
      this.userUpdated});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      nome: json['nome'] ?? '',
      castrado: json['castrado'],
      dateCreated: json['date_created'],
      dateUpdated: json['date_updated'],
      especieId: json['especie_id'],
      fotoPerfil: json['foto_perfil'],
      mae: json['mae'],
      nascimento: json['nascimento'],
      castracao: json['castracao'],
      obito: json['obito'],
      pai: json['pai'],
      raca: json['raca'],
      sexo: json['sexo'],
      espacoId: json['espaco_id'],
      userCreated: json['user_created'],
      userUpdated: json['user_updated'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'castrado': castrado,
      'date_created': dateCreated,
      'date_updated': dateUpdated,
      'especie_id': especieId,
      'foto_perfil': fotoPerfil,
      'mae': mae,
      'nascimento': nascimento,
      'castracao': castracao,
      'obito': obito,
      'pai': pai,
      'raca': raca,
      'sexo': sexo,
      'espaco_id': espacoId,
      'user_created': userCreated,
      'user_updated': userUpdated,
    }..removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));
  }
}
