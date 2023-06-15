import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pets/http_client.dart';
import 'package:pets/models/user.dart';

class UserRepository extends ChangeNotifier {
  Isar? _isar;
  User? user;
  HttpClient httpClient;

  UserRepository(this.httpClient);

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

    if (user != null && user!.accessToken != null) {
      await setUserWithSanctumToken(user!.accessToken!);
      return user;
    }

    return null;
  }

  Future<void> setUserWithSanctumToken(String sanctumToken) async {
    httpClient.setAuthorizationToken(sanctumToken);
    final Response userResponse;

    try {
      userResponse = await httpClient.get('api/user');
    } catch (e) {
      handleUserFetchError();
      return;
    }

    final userData = userResponse.data['data'];

    user = User(
      accessToken: sanctumToken,
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

  handleUserFetchError() async {
    final isar = await getIsar();

    return await isar.writeTxn(() async {
      await isar.users.clear();
    });
  }
}
