import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/user.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/repository/user_repository.dart';

final userRepositoryProvider = ChangeNotifierProvider<UserRepository>((ref) {
  final httpClient = ref.watch(httpClientProvider);

  return UserRepository(httpClient);
});

final userProvider =
    FutureProvider<User?>((ref) => ref.watch(userRepositoryProvider).getUser());
