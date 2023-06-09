import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider((ref) {
  var client = http.Client();
  return client;
});
