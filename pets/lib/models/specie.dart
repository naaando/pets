class Specie {
  String id;
  String especie;

  Specie({required this.id, required this.especie});

  factory Specie.fromJson(Map<String, dynamic> json) {
    return Specie(
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
