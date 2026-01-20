import 'dart:io';
import 'package:flutter/foundation.dart';

class UserAgentService {
  /// Получить User Agent для мобильного устройства
  static String getMobileUserAgent() {
    // Получаем версию приложения из pubspec.yaml (можно передать как параметр)
    const appVersion = '1.0.1';
    
    if (Platform.isIOS) {
      // Для iOS используем стандартный формат Safari
      return 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 AnimalWorldApp/$appVersion';
    } else if (Platform.isAndroid) {
      // Для Android используем стандартный формат Chrome
      return 'Mozilla/5.0 (Linux; Android 13; SM-G991B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36 AnimalWorldApp/$appVersion';
    } else {
      // Для других платформ (например, при разработке на macOS/Windows)
      return 'Mozilla/5.0 (Linux; Android 13; SM-G991B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36 AnimalWorldApp/$appVersion';
    }
  }
}