import 'package:pets/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_provider.g.dart';

@riverpod
HttpClient httpClient(HttpClientRef ref) {
  return HttpClient();
}
