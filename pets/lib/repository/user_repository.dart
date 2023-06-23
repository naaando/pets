import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/http_client.dart';
import 'package:pets/models/espaco.dart';
import 'package:pets/models/user.dart';

class UserRepository extends ChangeNotifier {
  Isar isar;
  User? user;
  HttpClient httpClient;

  UserRepository(this.httpClient, this.isar);

  Future<User?>? getUser() async {
    if (user != null) {
      return user;
    }

    user = await isar.users.where().findFirst();

    if (user != null && user!.accessToken != null) {
      await setUserWithSanctumToken(user!.accessToken!);
      return user;
    }

    return null;
  }

  Future<void> setUserWithSanctumToken(String sanctumToken) async {
    debugPrint("Sanctum token $sanctumToken");
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
      id: userData['id'].toString(),
      name: userData['name'],
      email: userData['email'],
      iss: userData['iss'],
      sub: userData['sub'],
      picture: userData['picture'],
      locale: userData['locale'],
      espacoAtivoId: userData['espaco_ativo_id'],
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

    user!.espacoAtivo.value = Espaco.fromJson(userData['espaco_ativo']);

    await isar.writeTxn(() async {
      await isar.users.clear();
      await isar.users.put(user!);
    });

    notifyListeners();
  }

  Future<void> handleUserFetchError() async {
    user = null;
    notifyListeners();

    return await isar.writeTxn(() async {
      await isar.users.clear();
    });
  }
}
