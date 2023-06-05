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
      dateCreated: json['dateCreated'],
      dateUpdated: json['dateUpdated'],
      especie: json['especie'],
      fotoPerfil: json['fotoPerfil'],
      mae: json['mae'],
      nascimento: json['nascimento'],
      pai: json['pai'],
      raca: json['raca'],
      sexo: json['sexo'],
      espaco: json['espaco'],
      userCreated: json['userCreated'],
      userUpdated: json['userUpdated'],
    );
  }
}
