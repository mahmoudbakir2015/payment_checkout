import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? pref;
  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future putDataBool({
    required bool value,
    required String key,
  }) async {
    return pref!.setBool(
      key,
      value,
    );
  }

  static bool? getDataBool({
    required String key,
  }) {
    return pref?.getBool(
      key,
    );
  }

  static String? getData({
    required String key,
  }) {
    return pref?.getString(
      key,
    );
  }

  static Future<dynamic> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) {
      return await pref?.setInt(key, value);
    }
    if (value is bool) {
      return await pref?.setBool(key, value);
    }
    if (value is String) {
      return await pref?.setString(key, value);
    }
    return await pref?.setDouble(key, value);
  }

  static Future<bool?> removeData({
    required String key,
  }) async {
    return await pref?.remove(key);
  }

  static Future<bool?> clearData({
    required String key,
  }) async {
    return await pref?.clear();
  }
}
