import 'package:dio/dio.dart';
import 'package:pets/config.dart';
import 'package:sentry_dio/sentry_dio.dart';

BaseOptions baseOptions = BaseOptions(
    baseUrl: baseUri.toString(),
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
    headers: {
      'Accept': 'application/json',
    });

class HttpClient {
  late Dio httpClient = Dio(baseOptions);

  HttpClient() {
    httpClient.addSentry();
  }

  setAuthorizationToken(String token) {
    httpClient.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return httpClient.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic body}) {
    return httpClient.post(path, data: body);
  }

  Future<Response> patch(String path, {dynamic body}) {
    return httpClient.patch(path, data: body);
  }

  Future<Response> delete(String path) {
    return httpClient.delete(path);
  }

  Future<dynamic> getJson(String path,
      {Map<String, dynamic>? queryParameters}) async {
    var res = await get(path, queryParameters: queryParameters);
    return res.data['data'];
  }

  Future<dynamic> postJson(String path, Map<String, dynamic> body) async {
    var res = await post(path, body: body);
    return res.data['data'];
  }

  Future<dynamic> patchJson(String path, Map<String, dynamic> body) async {
    var res = await patch(path, body: body);
    return res.data['data'];
  }
}
