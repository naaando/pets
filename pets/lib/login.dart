import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/user.dart';
import 'package:pets/provider/user_provider.dart';

googleSignIn(WidgetRef ref) async {
  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        '323626532097-mo9lg5m12rojsb1h6n3c940sjoifu93u.apps.googleusercontent.com',
    scopes: [
      'openid',
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  await googleSignIn.signIn();

  var authentication = await googleSignIn.currentUser?.authentication;
  var authHeaders = await googleSignIn.currentUser?.authHeaders;

  Dio dio = Dio();
  dio.options.headers.addAll(authHeaders!);
  dio.options.headers['idToken'] = '${authentication?.idToken}';

  var sanctumToken =
      await dio.get('http://10.0.2.2:9999/api/auth/google-idtoken');

  await ref
      .read(userRepositoryProvider.notifier)
      .setUserWithSanctumToken(sanctumToken.data);
}
