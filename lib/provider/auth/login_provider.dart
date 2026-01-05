// // lib/providers/auth_provider.dart

// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/model/user_model.dart';
// import 'package:backup_ticket/services/login_service.dart';
// import 'package:flutter/material.dart';

// class LoginProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;
//   RegisterResponse? _loginResponse;
//   User? _currentUser;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   RegisterResponse? get loginResponse => _loginResponse;
//   User? get currentUser => _currentUser;

//   // Login method
//   Future<bool> login({
//     required String phoneNumber,
//     required String password,
//   }) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       final response = await LoginService.login(
//         phoneNumber: phoneNumber,
//         password: password,
//       );

//       _loginResponse = response;
//       _currentUser = response.user;

//       // Save data to SharedPreferences
//       await SharedPrefsHelper.saveToken(response.token);
//       await SharedPrefsHelper.saveOtp(response.otp);
//       await SharedPrefsHelper.saveUser(response.user);

//       _isLoading = false;
//       notifyListeners();
//       return true;
//     } catch (e) {
//       _errorMessage = e.toString().replaceAll('Exception: ', '');
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // Load user from SharedPreferences
//   Future<void> loadUser() async {
//     try {
//       final user = await SharedPrefsHelper.getUser();
//       if (user != null) {
//         _currentUser = user;
//         notifyListeners();
//       }
//     } catch (e) {
//       _errorMessage = e.toString();
//       notifyListeners();
//     }
//   }

//   // Check if user is logged in
//   Future<bool> checkLoginStatus() async {
//     return await SharedPrefsHelper.isLoggedIn();
//   }

//   // Logout method
//   Future<void> logout() async {
//     await SharedPrefsHelper.clearAll();
//     _currentUser = null;
//     _loginResponse = null;
//     _errorMessage = null;
//     notifyListeners();
//   }

//   // Clear error message
//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }
// }














// lib/providers/auth_provider.dart

import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/user_model.dart';
import 'package:backup_ticket/services/login_service.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  RegisterResponse? _loginResponse;
  User? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  RegisterResponse? get loginResponse => _loginResponse;
  User? get currentUser => _currentUser;

  // Login method
  Future<bool> login({
    required String phoneNumber,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await LoginService.login(
        phoneNumber: phoneNumber,
        password: password,
      );

      _loginResponse = response;
      _currentUser = response.user;

      // Save data to SharedPreferences
      await SharedPrefsHelper.saveToken(response.token);
      await SharedPrefsHelper.saveOtp(response.otp);
      await SharedPrefsHelper.saveUser(response.user);
      // ✅ THIS WAS MISSING - Set logged in status to true
      await SharedPrefsHelper.setLoggedIn(true);

      // Optional: Debug print to verify
      print('✅ Login successful');
      print('✅ User: ${response.user.fullName}');
      print('✅ Token saved: ${await SharedPrefsHelper.getToken() != null}');
      print('✅ Is logged in: ${await SharedPrefsHelper.isLoggedIn()}');

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Load user from SharedPreferences
  Future<void> loadUser() async {
    try {
      final user = await SharedPrefsHelper.getUser();
      if (user != null) {
        _currentUser = user;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Check if user is logged in
  Future<bool> checkLoginStatus() async {
    return await SharedPrefsHelper.isLoggedIn();
  }

  // Logout method
  Future<void> logout() async {
    await SharedPrefsHelper.clearAll();
    _currentUser = null;
    _loginResponse = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}