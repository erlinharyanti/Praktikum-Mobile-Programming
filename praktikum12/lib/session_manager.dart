import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String KEY_USERNAME = "username";

  // Simpan username saat login
  static Future<void> saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_USERNAME, username);
  }

  // Ambil username
  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USERNAME);
  }

  // Logout / hapus session
  static Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(KEY_USERNAME);
  }
}