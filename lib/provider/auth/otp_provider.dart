// lib/providers/otp_provider.dart
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/services/otp_service.dart';
import 'package:flutter/material.dart';


class OtpProvider with ChangeNotifier {
  final OtpService _otpService = OtpService();

  bool _isLoading = false;
  String? _errorMessage;
  bool _isVerified = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isVerified => _isVerified;

  // Verify OTP
  Future<bool> verifyOtp({
    required String otp,
    required String token,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _isVerified = false;
    notifyListeners();

    try {
      final response = await _otpService.verifyOtp(
        otp: otp,
        token: token,
      );

      if (response.success) {
        await SharedPrefsHelper.saveToken(response.token);
        await SharedPrefsHelper.setLoggedIn(true);
        
        _isVerified = true;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      _isVerified = false;
      notifyListeners();
      return false;
    }
  }

  // Resend OTP
  Future<bool> resendOtp(String token) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _otpService.resendOtp(token);
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

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Reset state
  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _isVerified = false;
    notifyListeners();
  }
}