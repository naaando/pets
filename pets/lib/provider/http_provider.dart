import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pets/http_client.dart';

final httpClientProvider = Provider((ref) {
  const token = 'AfXaHy0-1h1ELUsRZUafMsOFPBXPb9HF';
  return HttpClient(http.Client(), token);
});
