import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pets/http_client.dart';

final httpClientProvider = Provider((ref) {
  return HttpClient();
});
