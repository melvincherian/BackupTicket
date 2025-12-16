
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserProfileProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // User data
  String? _userId;
  String? _name;
  String? _phoneNumber;
  String? _email;
  String? _profileImageUrl;
  
  // Loading states
  bool _isLoading = false;
  bool _isUpdating = false;
  bool _isDeleting = false;
  String? _errorMessage;

  // Getters
  String? get userId => _userId;
  String? get name => _name;
  String? get phoneNumber => _phoneNumber;
  String? get email => _email;
  String? get profileImageUrl => _profileImageUrl;
  bool get isLoading => _isLoading;
  bool get isUpdating => _isUpdating;
  bool get isDeleting => _isDeleting;
  String? get errorMessage => _errorMessage;

  // Save user profile to Firestore
  Future<void> saveUserProfile({
    required String userId,
    required String name,
    required String phoneNumber,
    required String email,
    String? profileImageUrl,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _firestore.collection('users').doc(userId).set({
        'userId': userId,
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'profileImageUrl': profileImageUrl ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update local data
      _userId = userId;
      _name = name;
      _phoneNumber = phoneNumber;
      _email = email;
      _profileImageUrl = profileImageUrl;

    } catch (e) {
      _errorMessage = 'Failed to save profile: ${e.toString()}';
      if (kDebugMode) {
        print('Error saving user profile: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load user profile from Firestore
  Future<void> loadUserProfile(String userId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        
        _userId = data['userId'] ?? '';
        _name = data['name'] ?? '';
        _phoneNumber = data['mobileNumber'] ?? '';
        _email = data['email'] ?? '';
        _profileImageUrl = data['profileImageUrl'] ?? '';
      } else {
        _errorMessage = 'User profile not found';
      }

    } catch (e) {
      _errorMessage = 'Failed to load profile: ${e.toString()}';
      if (kDebugMode) {
        print('Error loading user profile: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    required String userId,
    String? name,
    String? phoneNumber,
    String? email,
    String? profileImageUrl,
  }) async {
    try {
      _isUpdating = true;
      _errorMessage = null;
      notifyListeners();

      Map<String, dynamic> updateData = {
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (name != null) updateData['name'] = name;
      if (phoneNumber != null) updateData['phoneNumber'] = phoneNumber;
      if (email != null) updateData['email'] = email;
      if (profileImageUrl != null) updateData['profileImageUrl'] = profileImageUrl;

      await _firestore.collection('users').doc(userId).update(updateData);

      // Update local data
      if (name != null) _name = name;
      if (phoneNumber != null) _phoneNumber = phoneNumber;
      if (email != null) _email = email;
      if (profileImageUrl != null) _profileImageUrl = profileImageUrl;

    } catch (e) {
      _errorMessage = 'Failed to update profile: ${e.toString()}';
      if (kDebugMode) {
        print('Error updating user profile: $e');
      }
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  // Check if user profile exists
  Future<bool> doesUserProfileExist(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      return doc.exists;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking user profile: $e');
      }
      return false;
    }
  }

  // Delete user account
  Future<bool> deleteAccount(String userId) async {
    try {
      _isDeleting = true;
      _errorMessage = null;
      notifyListeners();

      // Delete user document from Firestore
      await _firestore.collection('users').doc(userId).delete();

      // Clear local data after successful deletion
      clearUserData();

      if (kDebugMode) {
        print('User account deleted successfully');
      }

      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete account: ${e.toString()}';
      if (kDebugMode) {
        print('Error deleting user account: $e');
      }
      return false;
    } finally {
      _isDeleting = false;
      notifyListeners();
    }
  }

  // Clear local data
  void clearUserData() {
    _userId = null;
    _name = null;
    _phoneNumber = null;
    _email = null;
    _profileImageUrl = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}