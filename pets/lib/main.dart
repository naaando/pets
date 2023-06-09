import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pets/app.dart';

void main() {
  initializeDateFormatting('pt_BR');
  Jiffy.setLocale('pt_BR');

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
