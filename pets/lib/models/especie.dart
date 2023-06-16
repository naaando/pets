class Especie {
  String id;
  String nome;

  Especie({required this.id, required this.nome});

  factory Especie.fromJson(Map<String, dynamic> json) {
    return Especie(
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
