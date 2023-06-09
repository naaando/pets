import 'dart:convert';

import 'package:http/http.dart';

class HttpClient {
  final String token;
  final Client httpClient;

  HttpClient(this.httpClient, this.token);

  Map<String, String>? get headers => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return httpClient.get(Uri.http('10.0.2.2:8055', path, queryParameters),
        headers: headers);
  }

  Future<Response> post(String path, {dynamic body}) {
    return httpClient.post(Uri.http('10.0.2.2:8055', path),
        headers: headers, body: body);
  }

  Future<Response> patch(String path, {dynamic body}) {
    return httpClient.patch(Uri.http('10.0.2.2:8055', path),
        headers: headers, body: body);
  }

  Future<Response> delete(String path) {
    return httpClient.delete(Uri.http('10.0.2.2:8055', path), headers: headers);
  }

  Future<dynamic> getJson(String path,
      {Map<String, dynamic>? queryParameters}) async {
    var res = await get(path, queryParameters: queryParameters);
    return jsonDecode(res.body)['data'];
  }

  Future<dynamic> postJson(String path, Map<String, dynamic> body) async {
    var res = await post(path, body: jsonEncode(body));
    return jsonDecode(res.body)['data'];
  }

  Future<dynamic> patchJson(String path, Map<String, dynamic> body) async {
    var res = await patch(path, body: jsonEncode(body));
    return jsonDecode(res.body)['data'];
  }
}
