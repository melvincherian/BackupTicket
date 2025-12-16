
// lib/utils/shared_prefs_helper.dart
import 'package:backup_ticket/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefsHelper {
  static const String _keyToken = 'auth_token';
  static const String _keyOtp = 'otp';
  static const String _keyUser = 'user_data';
  static const String _keyIsLoggedIn = 'is_logged_in';

  // Save token
  static Future<bool> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_keyToken, token);
  }

  // Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  // Save OTP
  static Future<bool> saveOtp(String otp) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_keyOtp, otp);
  }

  // Get OTP
  static Future<String?> getOtp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyOtp);
  }

  // Save user data
  static Future<bool> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    return await prefs.setString(_keyUser, userJson);
  }

  // Get user data
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_keyUser);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  // Save login status
  static Future<bool> setLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  // Check if logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Save complete registration response
  static Future<bool> saveRegistrationData(RegisterResponse response) async {
    final tokenSaved = await saveToken(response.token);
    final otpSaved = await saveOtp(response.otp);
    final userSaved = await saveUser(response.user);
    return tokenSaved && otpSaved && userSaved;
  }

  // Clear all data (logout)
  static Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  // Remove specific key
  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }
}