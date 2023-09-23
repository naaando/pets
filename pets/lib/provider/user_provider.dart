import 'package:pets/models/user.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/provider/isar_provider.dart';
import 'package:pets/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod()
Raw<Future<UserRepository>> userRepository(UserRepositoryRef ref) async {
  final httpClient = ref.watch(httpClientProvider);
  final isar = await ref.watch(isarProvider.future);

  return UserRepository(httpClient, isar);
}

@Riverpod()
class LoggedUser extends _$LoggedUser {
  @override
  FutureOr<User?> build() async {
    final rep = await ref.watch(userRepositoryProvider);

    rep.addListener(() {
      state = AsyncValue.data(rep.user);
    });

    return await rep.getUser();
  }
}
