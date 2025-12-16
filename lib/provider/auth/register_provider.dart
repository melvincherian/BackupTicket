// lib/providers/auth_provider.dart

import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/user_model.dart';
import 'package:backup_ticket/services/register_service.dart';
import 'package:flutter/material.dart';


class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  bool _isLoading = false;
  String? _errorMessage;
  RegisterResponse? _registerResponse;
  User? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  RegisterResponse? get registerResponse => _registerResponse;
  User? get currentUser => _currentUser;

  // Register user
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    String referralCode = '',
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = RegisterRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
        referralCode: referralCode,
      );

      _registerResponse = await _authService.register(request);
      
      if (_registerResponse!.success) {
        // Save data to SharedPreferences
        await SharedPrefsHelper.saveRegistrationData(_registerResponse!);
        _currentUser = _registerResponse!.user;
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = _registerResponse!.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
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
      debugPrint('Error loading user: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    await SharedPrefsHelper.clearAll();
    _currentUser = null;
    _registerResponse = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}