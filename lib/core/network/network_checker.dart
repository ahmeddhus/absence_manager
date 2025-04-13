import 'package:http/http.dart' as http;

class NetworkChecker {
  final String testUrl;

  NetworkChecker({this.testUrl = 'https://www.google.com'});

  Future<bool> get hasConnection async {
    try {
      final response = await http.get(Uri.parse(testUrl)).timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
