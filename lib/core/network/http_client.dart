import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient {
  static const String _baseUrl = 'https://absence-api-nestjs-production.up.railway.app';

  final http.Client _client;

  HttpClient({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> get(String endpoint) async {
    final response = await _client.get(Uri.parse('$_baseUrl$endpoint'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw HttpException(response.statusCode, response.body);
    }
  }

  void dispose() {
    _client.close();
  }
}

class HttpException implements Exception {
  final int statusCode;
  final String responseBody;

  HttpException(this.statusCode, this.responseBody);

  @override
  String toString() => 'HttpException($statusCode): $responseBody';
}
