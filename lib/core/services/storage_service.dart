import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    return await _prefs.setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? getObject(String key) {
    final data = _prefs.getString(key);
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }
}
