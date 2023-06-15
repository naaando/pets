import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/user.dart';
import 'package:pets/repository/user_repository.dart';

final userRepositoryProvider = ChangeNotifierProvider<UserRepository>((ref) {
  return UserRepository();
});

final userProvider =
    FutureProvider<User?>((ref) => ref.watch(userRepositoryProvider).getUser());
