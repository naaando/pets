import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
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
