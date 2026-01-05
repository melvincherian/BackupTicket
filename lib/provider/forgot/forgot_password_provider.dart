// lib/providers/password_provider.dart
import 'package:backup_ticket/services/forgot_password_service.dart';
import 'package:flutter/material.dart';


class PasswordProvider with ChangeNotifier {
  final PasswordService _passwordService = PasswordService();

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  String? _resetToken;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  String? get resetToken => _resetToken;

  // Clear messages
  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  // Forgot Password - Send OTP
  Future<bool> forgotPassword(String phoneNumber) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final result = await _passwordService.forgotPassword(phoneNumber);

      if (result['success']) {
        _successMessage = result['message'];
        
        // Store token if available for reset password
        if (result['data']['token'] != null) {
          _resetToken = result['data']['token'];
        }
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Reset Password
  Future<bool> resetPassword({
    required String token,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    // Validate passwords match
    if (newPassword != confirmNewPassword) {
      _errorMessage = 'Passwords do not match';
      notifyListeners();
      return false;
    }

    // Validate password strength
    if (newPassword.length < 8) {
      _errorMessage = 'Password must be at least 8 characters long';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final result = await _passwordService.resetPassword(
        token: token,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );

      if (result['success']) {
        _successMessage = result['message'];
        _resetToken = null; // Clear token after successful reset
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Reset provider state
  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _successMessage = null;
    _resetToken = null;
    notifyListeners();
  }
}