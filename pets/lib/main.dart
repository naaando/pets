import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pets/app.dart';

void main() async {
  initializeDateFormatting('pt_BR');
  Jiffy.setLocale('pt_BR');

  WidgetsFlutterBinding.ensureInitialized();

  String storageLocation = (await getApplicationDocumentsDirectory()).path;
  await FastCachedImageConfig.init(
      subDir: storageLocation, clearCacheAfter: const Duration(days: 15));

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
