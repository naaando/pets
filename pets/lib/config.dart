const String token = 'AfXaHy0-1h1ELUsRZUafMsOFPBXPb9HF';

final Uri baseUri = Uri.parse('http://10.0.2.2:9999/');

final Uri baseUriWithAccessToken =
    baseUri.replace(queryParameters: {'access_token': token});
