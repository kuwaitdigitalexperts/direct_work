import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  static Future<String?> getString(String key) async {
    try {
      final val = await _asyncPrefs.getString(key);
      if (val != null && val.isNotEmpty) return val;
    } catch (_) {}

    try {
      final legacy = await SharedPreferences.getInstance();
      final val = legacy.getString(key);
      if (val != null && val.isNotEmpty) return val;
    } catch (_) {}

    return null;
  }

  static Future<void> setString(String key, String value) async {
    try {
      await _asyncPrefs.setString(key, value);
    } catch (_) {}

    try {
      final legacy = await SharedPreferences.getInstance();
      await legacy.setString(key, value);
    } catch (_) {}
  }

  static Future<bool?> getBool(String key) async {
    try {
      final val = await _asyncPrefs.getBool(key);
      if (val != null) return val;
    } catch (_) {}

    try {
      final legacy = await SharedPreferences.getInstance();
      final val = legacy.getBool(key);
      if (val != null) return val;
    } catch (_) {}

    return null;
  }

  static Future<void> setBool(String key, bool value) async {
    try {
      await _asyncPrefs.setBool(key, value);
    } catch (_) {}

    try {
      final legacy = await SharedPreferences.getInstance();
      await legacy.setBool(key, value);
    } catch (_) {}
  }

  static Future<void> remove(String key) async {
    try {
      await _asyncPrefs.remove(key);
    } catch (_) {}

    try {
      final legacy = await SharedPreferences.getInstance();
      await legacy.remove(key);
    } catch (_) {}
  }
}
