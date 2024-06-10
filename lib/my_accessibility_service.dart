import 'package:flutter/services.dart';

class AccessibilityServiceManager {
  static const platform =
      MethodChannel('com.example.youtube_configuration_app/accessibility');

  static Future<bool> isAccessibilityServiceEnabled() async {
    try {
      final bool isEnabled =
          await platform.invokeMethod('isAccessibilityServiceEnabled');
      return isEnabled;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static void requestAccessibilityServicePermission() {
    platform.invokeMethod('requestAccessibilityServicePermission');
  }
}
