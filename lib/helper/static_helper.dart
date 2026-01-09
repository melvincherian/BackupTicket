import 'package:shared_preferences/shared_preferences.dart';

// Add your UserPreferences class here or import it
class UserPreferences {
  static const String _keyUserId = 'userId';
  static const String _keyName = 'name';
  static const String _keyMobileNumber = 'mobileNumber';
  static const String _keyEmail = 'email';

  // Save user details
  static Future saveUser({
    required String userId,
    required String name,
    required String mobileNumber,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyMobileNumber, mobileNumber);
    await prefs.setString(_keyEmail, email);
  }

  // Getters
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  static Future<String?> getMobileNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyMobileNumber);  
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final userId = await getUserId();
    return userId != null && userId.isNotEmpty;
  }

  // Clear user details
  static Future clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyName);
    await prefs.remove(_keyMobileNumber);
    await prefs.remove(_keyEmail);
  }
}
