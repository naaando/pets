class Espaco {
  String id;
  String ambiente;

  Espaco({required this.id, required this.ambiente});

  factory Espaco.fromJson(Map<String, dynamic> json) {
    return Espaco(
      id: json['id'],
      ambiente: json['ambiente'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ambiente': ambiente,
    }..removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));
  }
}
