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
String _$userHash() => r'1bfd2b3002ed41899fdd76706c644fe3494a644b';

/// See also [user].
@ProviderFor(user)
final userProvider = AutoDisposeFutureProvider<User?>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRef = AutoDisposeFutureProviderRef<User?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
