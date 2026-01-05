// lib/services/profile_service.dart
import 'dart:io';
import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../model/user_model.dart';

class ProfileService {
  final Dio _dio = Dio();

  ProfileService() {
    // _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<UpdateProfileResponse> updateProfile({
    required String userId,
    required String firstName,
    required String lastName,
    File? profileImage,
  }) async {
    try {
      print('fssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
      // Get token from shared preferences
      final token = await SharedPrefsHelper.getToken();
      
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      // Prepare form data
      final formData = FormData.fromMap({
        'firstName': firstName,
        'lastName': lastName,
      });
      
      // Add profile image if provided
      if (profileImage != null) {
        String fileName = profileImage.path.split('/').last;
        
        // Determine content type based on file extension
        String contentType = 'image/jpeg';
        if (fileName.toLowerCase().endsWith('.png')) {
          contentType = 'image/png';
        } else if (fileName.toLowerCase().endsWith('.jpg') || 
                   fileName.toLowerCase().endsWith('.jpeg')) {
          contentType = 'image/jpeg';
        }

        formData.files.add(
          MapEntry(
            'profileImage',
            await MultipartFile.fromFile(
              profileImage.path,
              filename: fileName,
              contentType: MediaType.parse(contentType),
            ),
          ),
        );
      }

      // Build the URL with userId
      final url = ApiConstants.updateProfile.replaceAll(':userId', userId);

      // Make API call
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );


      print('Response status code for update profileeeeeeeeeeeeeee ${response.statusCode} ');
            // print('Response bodyyyyyyyyyyyyyyyyyyyyyyy for update profileeeeeeeeeeeee ${response.data} ');


      if (response.statusCode == 200) {
        final updateResponse = UpdateProfileResponse.fromJson(response.data);
        
        // Save updated user data to shared preferences
        await SharedPrefsHelper.saveUser(updateResponse.user);
        
        return updateResponse;
      } else {
        throw Exception('Failed to update profile: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to update profile'
        );
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }
}

// Response model
class UpdateProfileResponse {
  final bool success;
  final String message;
  final User user;

  UpdateProfileResponse({
    required this.success,
    required this.message,
    required this.user,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'user': user.toJson(),
    };
  }
}   