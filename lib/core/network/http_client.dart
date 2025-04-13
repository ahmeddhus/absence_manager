import 'dart:convert';

import 'package:absence_manager/config/api_config.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final http.Client _client;

  HttpClient({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> get(String endpoint) async {
    final response = await _client.get(Uri.parse('${ApiConfig.baseUrl}$endpoint'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw HttpException(response.statusCode, response.body);
    }
  }

  Future<dynamic> getUri(Uri uri) async {
    final url = '${ApiConfig.baseUrl}${uri.path}?${uri.query}';
    final response = await _client.get(Uri.parse(url));

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
