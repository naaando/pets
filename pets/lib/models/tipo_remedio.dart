class TipoRemedio {
  String? id;
  String nome;
  num? doses;
  num? intervaloDias;

  TipoRemedio({
    this.id,
    required this.nome,
    required this.doses,
    this.intervaloDias,
  });

  factory TipoRemedio.fromJson(Map<String, dynamic> json) {
    return TipoRemedio(
      id: json['id'],
      nome: json['nome'],
      doses: json['doses'],
      intervaloDias: json['intervalo_dias'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'doses': doses,
      'intervalo_dias': intervaloDias,
    };
  }
}
