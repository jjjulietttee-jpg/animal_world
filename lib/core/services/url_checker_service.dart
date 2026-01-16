import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;


class UrlCheckerService {
  static const String targetUrl = 'https://freegamefonk.site/B7FVMPcs';

  static Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult.any(
        (result) =>
            result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi ||
            result == ConnectivityResult.ethernet,
      );
    } catch (e) {
      return false;
    }
  }

  static Future<bool> isUrlAvailable() async {
    try {
      final response = await http.get(
        Uri.parse(targetUrl),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response('Timeout', 408),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> shouldShowWebView() async {
    final hasInternet = await hasInternetConnection();
    if (!hasInternet) return false;

    final urlAvailable = await isUrlAvailable();
    return urlAvailable;
  }
}
