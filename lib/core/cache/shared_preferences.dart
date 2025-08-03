import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveData(String key, dynamic value) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is List<String>) {
      return await sharedPreferences.setStringList(key, value);
    } else {
      return false;
    }
  }

  static String? getToken(String key) {
    return sharedPreferences.getString(key);

  }

  static bool? getRememberMe(String key) {
    return sharedPreferences.getBool(key);

  }

  static Future<bool> deleteToken(String key) async {
    return await sharedPreferences.remove(key);
  }
}
