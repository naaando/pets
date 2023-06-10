import 'package:pets/config.dart';

class Pet {
  String? id;
  String nome;
  bool? castrado;
  String? dateCreated;
  String? dateUpdated;
  String? especie;
  String? fotoPerfil;
  String? mae;
  String? nascimento;
  String? castracao;
  String? pai;
  String? raca;
  String? sexo;
  String? userCreated;
  String? userUpdated;
  String? espaco;
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
      this.especie,
      this.fotoPerfil,
      this.nascimento,
      this.castracao,
      this.mae,
      this.pai,
      this.sexo,
      this.raca,
      this.espaco,
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
      especie: json['especie'],
      fotoPerfil: json['foto_perfil'],
      mae: json['mae'],
      nascimento: json['nascimento'],
      castracao: json['castracao'],
      obito: json['obito'],
      pai: json['pai'],
      raca: json['raca'],
      sexo: json['sexo'],
      espaco: json['espaco'],
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
      'especie': especie,
      'foto_perfil': fotoPerfil,
      'mae': mae,
      'nascimento': nascimento,
      'castracao': castracao,
      'obito': obito,
      'pai': pai,
      'raca': raca,
      'sexo': sexo,
      'espaco': espaco,
      'user_created': userCreated,
      'user_updated': userUpdated,
    }..removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));
  }
}
