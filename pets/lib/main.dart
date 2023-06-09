import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pets/app.dart';

void main() {
  initializeDateFormatting();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
