import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String isLoggedInKey = 'is_logged_in';
  static const String userEmailKey = 'user_email';

  Future<void> setLogin(bool value, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, value);
    await prefs.setString(userEmailKey, email);
  }

  Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }
}
