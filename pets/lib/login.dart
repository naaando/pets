import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/config.dart';
import 'package:pets/http_client.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

googleSignIn(WidgetRef ref) async {
  GoogleSignIn googleSignIn = GoogleSignIn(
    serverClientId:
        '323626532097-j524lnkhnrmm3rq2i62dnk2qi70on3np.apps.googleusercontent.com',
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
      await dio.getUri(baseUri.replace(path: '/api/auth/google-idtoken'));

  final userRepository = await ref.read(userRepositoryProvider);
  userRepository.setUserWithSanctumToken(sanctumToken.data);
}

facebookSignIn(WidgetRef ref) async {
  final facebook = FacebookAuth.instance;
  final result = await facebook.login();

  Dio dio = Dio(baseOptions);

  var sanctumToken = await dio.postUri(
      baseUri.replace(path: '/api/auth/facebook'),
      data: result.accessToken);

  final userRepository = await ref.read(userRepositoryProvider);
  userRepository.setUserWithSanctumToken(sanctumToken.data);
}
