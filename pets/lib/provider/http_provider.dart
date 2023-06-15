import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pets/http_client.dart';

final httpClientProvider = Provider((ref) {
  return HttpClient();
});
