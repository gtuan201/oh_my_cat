import 'dart:io' show Platform;

class PlatformCheck {
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;

  static String get platformName {
    if (isAndroid) return 'Android';
    if (isIOS) return 'iOS';
    return 'Unknown';
  }

  static bool get isMobile => isAndroid || isIOS;

  static void runForPlatform({
    required Function() android,
    required Function() iOS,
    Function()? other,
  }) {
    if (isAndroid) {
      android();
    } else if (isIOS) {
      iOS();
    } else if (other != null) {
      other();
    }
  }
}