// lib/providers/profile_provider.dart
import 'dart:io';
import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/services/profile_service.dart';
import 'package:flutter/material.dart';
import '../../model/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  // Load user data from shared preferences
  Future<void> loadUser() async {
    try {
      _user = await SharedPrefsHelper.getUser();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  // Update profile
  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    File? profileImage,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
      notifyListeners();

      // Get current user ID
      if (_user == null) {
        await loadUser();
      }

      if (_user == null) {
        throw Exception('User not found. Please login again.');
      }

      // Call service
      final response = await _profileService.updateProfile(
        userId: _user!.id,
        firstName: firstName,
        lastName: lastName,
        profileImage: profileImage,
      );

      print('useeeeeeeeeeeeeeeeridddddddddddddddd ${_user!.id}');
      print('first nameeeeeeeee $firstName');
      print('last naeemmeeeeeeeee $lastName');
      print('imaeeeeeeeeeeeeegggggggggee $profileImage');

      // Update local user data
      _user = response.user;
      _successMessage = response.message;
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

  // Clear messages
  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  // Refresh user data
  Future<void> refreshUser() async {
    await loadUser();
  }

  // Get profile image URL
  String? getProfileImageUrl() {
    if (_user?.profileImage != null) {
      // If it's already a full URL, return it
      if (_user!.profileImage!.startsWith('http')) {
        return _user!.profileImage;
      }
      // Otherwise, construct the full URL
      return '${ApiConstants.baseUrl}/${_user!.profileImage!.replaceAll('\\', '/')}';
    }
    return null;
  }

  // Clear all data (logout)
  Future<void> clearUser() async {
    _user = null;
    _errorMessage = null;
    _successMessage = null;
    await SharedPrefsHelper.clearAll();
    notifyListeners();
  }
}
