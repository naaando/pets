class Especie {
  String id;
  String especie;

  Especie({required this.id, required this.especie});

  factory Especie.fromJson(Map<String, dynamic> json) {
    return Especie(
      id: json['id'],
      especie: json['especie'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'especie': especie,
    }..removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));
  }
}
