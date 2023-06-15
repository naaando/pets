import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pets/models/user.dart';

class UserRepository extends ChangeNotifier {
  Isar? _isar;
  User? user;

  Future<Isar> getIsar() async {
    if (_isar != null) {
      return _isar!;
    }

    final dir = await getApplicationDocumentsDirectory();

    return _isar = await Isar.open(
      [UserSchema],
      directory: dir.path,
    );
  }

  Future<User?>? getUser() async {
    if (user != null) {
      return user;
    }

    final isar = await getIsar();
    user = await isar.users.where().findFirst();

    if (user != null && user?.accessToken != null) {
      setUserWithSanctumToken(user!.accessToken!);
    }

    return user;
  }

  Future<void> setUserWithSanctumToken(String sanctumToken) async {
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $sanctumToken';
    final userResponse = await dio.get('http://10.0.2.2:9999/api/user',
        options: Options(responseType: ResponseType.json));
    final userData = userResponse.data;

    user = User(
      name: userData['name'],
      email: userData['email'],
      iss: userData['iss'],
      sub: userData['sub'],
      picture: userData['picture'],
      locale: userData['locale'],
      emailVerifiedAt: userData['email_verified_at'] != null
          ? Jiffy.parse(userData['email_verified_at']).dateTime
          : null,
      createdAt: userData['created_at'] != null
          ? Jiffy.parse(userData['created_at']).dateTime
          : null,
      updatedAt: userData['updated_at'] != null
          ? Jiffy.parse(userData['updated_at']).dateTime
          : null,
    );

    final isar = await getIsar();

    return await isar.writeTxn(() async {
      await isar.users.clear();
      await isar.users.put(user!);
    });
  }
}
