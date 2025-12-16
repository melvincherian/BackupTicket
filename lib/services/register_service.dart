// lib/services/auth_service.dart

import 'dart:convert';
import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/model/user_model.dart';
import 'package:http/http.dart' as http;


class AuthService {
  // Register user
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.register),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );


      print('response status code for registration ${response.statusCode}');
            print('response bodyyyyyyyyyyyy for registration ${response.body}');


      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return RegisterResponse.fromJson(jsonResponse);
      } else {
        // Handle error response
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  // Add other auth methods as needed
  // Future<LoginResponse> login(LoginRequest request) async { }
  // Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest request) async { }
}