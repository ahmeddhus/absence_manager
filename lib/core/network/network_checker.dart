import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  Future<bool> get hasConnection async {
    final results = await Connectivity().checkConnectivity();
    return results.contains(ConnectivityResult.none) == false;
  }

  Future<List<ConnectivityResult>> get connectivityResults async {
    return await Connectivity().checkConnectivity();
  }
}
