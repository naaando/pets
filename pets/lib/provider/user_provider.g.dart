// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'5e7defca55dc5131a3f5b80b063d6a9d3182d125';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider =
    AutoDisposeProvider<Future<UserRepository>>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepositoryRef = AutoDisposeProviderRef<Future<UserRepository>>;
String _$loggedUserHash() => r'1ac8cf8d35da6d6f3c0a24922526fe48e03611e5';

/// See also [LoggedUser].
@ProviderFor(LoggedUser)
final loggedUserProvider =
    AutoDisposeAsyncNotifierProvider<LoggedUser, User?>.internal(
  LoggedUser.new,
  name: r'loggedUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loggedUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoggedUser = AutoDisposeAsyncNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
