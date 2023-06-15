import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pets/models/espaco.dart';
import 'package:pets/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isar(IsarRef ref) async {
  final dir = await getApplicationSupportDirectory();

  return await Isar.open(
    [UserSchema, EspacoSchema],
    directory: dir.path,
  );
}
