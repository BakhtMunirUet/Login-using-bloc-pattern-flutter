import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  static SharedPreferences _preferences;

  static String signupUser = "Signup";

  static _initValues() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  static Future<bool> saveUser(String key, String value) async {
    await _initValues();
    return await _preferences.setString(key, value);
  }

  static Future<String> getStringPreferences(String key) async {
    await _initValues();
    return _preferences.getString(key);
  }

  static Future<bool> deletePref(String key) async {
    await _initValues();
    return await _preferences.remove(key);
  }
}
