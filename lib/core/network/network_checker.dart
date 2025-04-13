import 'package:http/http.dart' as http;

/// A utility class that verifies actual internet connectivity by making
/// a lightweight HTTP request to a CORS-safe public endpoint.
///
/// Defaults to https://httpstat.us/200, which returns a 200 OK response
/// and is accessible from all platforms, including Flutter Web.
///
/// Returns `true` if the response status is 200 within 5 seconds.
class NetworkChecker {
  final String testUrl;

  NetworkChecker({this.testUrl = 'https://httpstat.us/200'});

  Future<bool> get hasConnection async {
    try {
      final response = await http.get(Uri.parse(testUrl)).timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
