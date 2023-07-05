import 'package:pets/config.dart';

class Pet {
  String? id;
  String nome;
  bool? castrado;
  String? dateCreated;
  String? dateUpdated;
  String? especieId;
  String? imagem;
  String? mae;
  String? nascimento;
  String? castracao;
  String? pai;
  String? raca;
  String? sexo;
  String? userCreated;
  String? userUpdated;
  String? espacoId;
  String? obito;
  Uri? imagemUrl;

  Pet(
      {this.id,
      this.nome = '',
      this.castrado,
      this.dateUpdated,
      this.dateCreated,
      this.especieId,
      this.imagem,
      this.imagemUrl,
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
      imagem: json['imagem'],
      imagemUrl:
          json['imagem_url'] != null ? Uri.parse(json['imagem_url']) : null,
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
      'imagem': imagem,
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
