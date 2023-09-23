// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'13be2bc918383d85a504ae5eedb6dfdb4bf57ed1';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider =
    AutoDisposeFutureProvider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepositoryRef = AutoDisposeFutureProviderRef<UserRepository>;
String _$loggedUserHash() => r'c1b1c030985e48baa5a39d75e88a270c81b1d895';

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
