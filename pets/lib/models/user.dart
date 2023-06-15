import 'package:isar/isar.dart';
import 'package:pets/fasthash.dart';
import 'package:pets/models/espaco.dart';

part 'user.g.dart';

@collection
class User {
  String? id;
  Id get isarId => fastHash(id!);
  String? accessToken;
  String? name;
  String? email;
  String? iss;
  String? sub;
  String? picture;
  String? locale;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  final espacos = IsarLinks<Espaco>();

  User({
    this.accessToken,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.iss,
    this.sub,
    this.picture,
    this.locale,
  });
}
