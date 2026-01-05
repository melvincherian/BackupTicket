// lib/services/password_service.dart
import 'dart:convert';
import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:http/http.dart' as http;

class PasswordService {
  // Forgot Password - Send OTP
  Future<Map<String, dynamic>> forgotPassword(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.forgotPassword),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
        }),
      );

      final responseData = jsonDecode(response.body);


      print('Response status code for forgot password ${response.statusCode}');
            print('Response bodyyyyyyyyyy for forgot password ${response.body}');


      if (response.statusCode == 200 || response.statusCode == 201) {
        // Save token if provided in response
        if (responseData['token'] != null) {
          await SharedPrefsHelper.saveToken(responseData['token']);
        }
        
        return {
          'success': true,
          'message': responseData['message'] ?? 'OTP sent successfully',
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to send OTP',
          'error': responseData['error'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error occurred',
        'error': e.toString(),
      };
    }
  }

  // Reset Password
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.resetpassword),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'token': token,
          'newPassword': newPassword,
          'confirmNewPassword': confirmNewPassword,
        }),
      );

      final responseData = jsonDecode(response.body);

            print('Response status code for resettttttttt password ${response.statusCode}');
            print('Response bodyyyyyyyyyy for reset password ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Password reset successfully',
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to reset password',
          'error': responseData['error'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error occurred',
        'error': e.toString(),
      };
    }
  }
}