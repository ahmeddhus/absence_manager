import 'package:absence_manager/config/api_config.dart';
import 'package:http/http.dart' as http;

/// A utility class that verifies actual internet connectivity by making
/// a lightweight HTTP request to the configured backend base URL.
class NetworkChecker {
  /// Returns `true` if the device can successfully reach the backend URL
  /// within a short timeout (1200ms). Otherwise, returns `false`.
  Future<bool> get hasConnection async {
    try {
      final response = await http
          .get(Uri.parse(ApiConfig.baseUrl))
          .timeout(const Duration(milliseconds: 1200));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
