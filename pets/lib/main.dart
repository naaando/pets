import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/app.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import 'notifications.dart';

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('pt_BR');
  Jiffy.setLocale('pt_BR');
  await _configureLocalTimeZone();

  await notificationsInitializer();

  await FastCachedImageConfig.init();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
