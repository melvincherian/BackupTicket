// lib/services/auth_service.dart

import 'dart:convert';
import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/model/user_model.dart';
import 'package:http/http.dart' as http;

class LoginService {
  // Login request model
  static Future<RegisterResponse> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber, 'password': password}),
      );

      print('response status code for login ${response.statusCode}');
      print('response bodyyyyyyyyyyyyyyy for login ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return RegisterResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Login error: ${e.toString()}');
    }
  }
}
