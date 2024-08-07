import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
  // Ensure that plugin services are initialized so that `availableCameras()`
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Google Mobile Ads SDK
  MobileAds.instance.initialize();

  // Initialize the timezone
  String locale = Platform.localeName;
  initializeDateFormatting(locale);
  Jiffy.setLocale(locale);
  await _configureLocalTimeZone();

  // Initialize notifications
  await notificationsInitializer();

  // Initialize FastCachedImageConfig
  await FastCachedImageConfig.init();

  // Lambda to run the app
  appRunner() => runApp(const ProviderScope(child: App()));

  // Use Sentry on release mode
  if (kReleaseMode) {
    await SentryFlutter.init(
      (options) => options..addIntegration(LoggingIntegration()),
      appRunner: appRunner,
    );
  } else {
    appRunner();
  }
}
