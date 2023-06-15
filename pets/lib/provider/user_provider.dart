import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/models/user.dart';
import 'package:pets/provider/http_provider.dart';
import 'package:pets/provider/isar_provider.dart';
import 'package:pets/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod()
Future<UserRepository> userRepository(UserRepositoryRef ref) async {
  final httpClient = ref.watch(httpClientProvider);
  final isar = await ref.watch(isarProvider.future);

  return UserRepository(httpClient, isar);
}

@Riverpod()
Future<User?> user(UserRef ref) async {
  final userRepository = await ref.watch(userRepositoryProvider.future);
  return await userRepository.getUser();
}
