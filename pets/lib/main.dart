import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/app.dart';

void main() async {
  initializeDateFormatting('pt_BR');
  Jiffy.setLocale('pt_BR');

  WidgetsFlutterBinding.ensureInitialized();

  await FastCachedImageConfig.init();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
