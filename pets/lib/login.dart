import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/provider/user_provider.dart';

googleLogin(WidgetRef ref) async {
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

  ref.read(userProvider.notifier).update((state) => googleSignIn.currentUser);
}
