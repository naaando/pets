import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/config.dart';
import 'package:pets/provider/user_provider.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

googleSignIn(WidgetRef ref) async {
  GoogleSignIn googleSignIn = GoogleSignIn(
    serverClientId:
        '323626532097-tnpc95mi6bvjrtkk3sfhpcmkkc1kjlmo.apps.googleusercontent.com',
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

  final userRepository = await ref.read(userRepositoryProvider.future);
  userRepository.setUserWithSanctumToken(sanctumToken.data);
}

facebookSignIn(WidgetRef ref) async {
  final facebook = FacebookAuth.instance;
  final result = await facebook.login();

  Dio dio = Dio();
  dio.options.headers['access_token'] = result.accessToken;

  // var sanctumToken =
  await dio.getUri(baseUri.replace(path: '/api/auth/facebook'));

  // final userRepository = await ref.read(userRepositoryProvider.future);
  // userRepository.setUserWithSanctumToken(sanctumToken.data);
}
