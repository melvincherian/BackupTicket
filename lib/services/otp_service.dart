// lib/services/otp_service.dart
import 'dart:convert';
import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class OtpService {
  // Verify OTP
  Future<OtpVerificationResponse> verifyOtp({
    required String otp,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.verifyotp),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'otp': otp,
          'token': token,
        }),
      );

      print('response status code for verify otppppppppppppppp ${response.statusCode}');
            print('response bodyyyyyyyyyyyyyyyy for verify otppppppppppppppp ${response.body}');


      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return OtpVerificationResponse.fromJson(data);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'OTP verification failed');
      }
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }

  // Verify OTP and save data
  Future<bool> verifyAndSaveOtp({
    required String otp,
    required String token,
  }) async {
    try {
      final response = await verifyOtp(otp: otp, token: token);
      
      // Save the new auth token
      await SharedPrefsHelper.saveToken(response.token);
      
      // Set logged in status
      await SharedPrefsHelper.setLoggedIn(true);
      
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Resend OTP (if you have this endpoint)
  Future<void> resendOtp(String token) async {
    try {
      // Implement resend OTP logic if available
      // This is a placeholder
      throw UnimplementedError('Resend OTP endpoint not defined');
    } catch (e) {
      throw Exception('Failed to resend OTP: $e');
    }
  }
}

// Model for OTP Verification Response
class OtpVerificationResponse {
  final bool success;
  final String message;
  final String token;

  OtpVerificationResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
    };
  }
}