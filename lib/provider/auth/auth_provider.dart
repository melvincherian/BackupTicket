import 'dart:convert';

import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';


enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

enum OTPStatus {
  initial,
  codeSent,
  verifying,
  verified,
  error,
}

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthStatus _authStatus = AuthStatus.initial;
  OTPStatus _otpStatus = OTPStatus.initial;
  User? _user;
  UserModel? _currentUserData;
  String? _verificationId;
  String? _errorMessage;
  bool _isLoading = false;

  // Temporary storage for signup data
  String? _tempName;
  String? _tempEmail;
  String? _tempPhoneNumber;

  // Getters
  AuthStatus get authStatus => _authStatus;
  OTPStatus get otpStatus => _otpStatus;
  User? get user => _user;
  UserModel? get currentUserData => _currentUserData;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _authStatus == AuthStatus.authenticated;
  String? get verificationId => _verificationId;

  // Constructor - listen to auth state changes
  AuthProvider() {
    _init();
  }

  void _init() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      _user = user;
      if (user != null) {
        _authStatus = AuthStatus.authenticated;
        _loadUserData();
      } else {
        _authStatus = AuthStatus.unauthenticated;
        _currentUserData = null;
      }
      notifyListeners();
    });
  }

  // Load user data from local storage or Firestore
  Future<void> _loadUserData() async {
    try {
      if (_user != null) {
        // First try to load from local storage
        _currentUserData = await _getCurrentUserDataFromLocal();
        
        // If not found locally, fetch from Firestore
        if (_currentUserData == null) {
          _currentUserData = await _getUserDataFromFirestore(_user!.uid);
          
          // Save to local storage if found in Firestore
          if (_currentUserData != null) {
            await _saveUserDataLocally(_currentUserData!);
          }
        }
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to load user data: ${e.toString()}');
    }
  }

  // Sign up with phone number
  Future<void> signUpWithPhoneNumber({
    required String name,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      // Store temporary data for later use
      _tempName = name;
      _tempEmail = email;
      _tempPhoneNumber = phoneNumber;

      // Check if phone number is already registered
      bool phoneExists = await _isPhoneNumberRegistered(phoneNumber);
      if (phoneExists) {
        throw Exception('Phone number is already registered');
      }

      // Check if email is already registered
      bool emailExists = await _isEmailRegistered(email);
      if (emailExists) {
        throw Exception('Email is already registered');
      }

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }



String _hashPassword(String password) {
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  return digest.toString();
}



Future<void> saveUserWithoutAuth({
  required String name,
  required String email,
  required String phoneNumber,
  required String password, // Added password parameter
  String? referralCodeEntered,
}) async {
  try {
    _setLoading(true);
    _clearError();

    // Check duplicates
    bool phoneExists = await _isPhoneNumberRegistered(phoneNumber);
    if (phoneExists) throw Exception('Phone number is already registered');

    bool emailExists = await _isEmailRegistered(email);
    if (emailExists) throw Exception('Email is already registered');

    // Generate a unique user ID
    String userId = DateTime.now().millisecondsSinceEpoch.toString();

    // Generate referral code for this user
    String myReferralCode = "${name.substring(0, 3).toUpperCase()}${userId.substring(7)}";

    String? referrerId;

    // If user entered a referral code → find who owns it
    if (referralCodeEntered != null && referralCodeEntered.isNotEmpty) {
      final query = await _firestore
          .collection('users')
          .where('referralCode', isEqualTo: referralCodeEntered)
          .get();

      if (query.docs.isEmpty) {
        throw Exception("Invalid referral code");
      }

      referrerId = query.docs.first.id;

      // Prevent self-referral
      if (referrerId == userId) {
        throw Exception("You cannot use your own referral code");
      }
    }

    // Hash the password before storing
    String hashedPassword = _hashPassword(password);

    // Create user model with password
    UserModel userModel = UserModel(
      id: userId,
      name: name,
      email: email,
      mobileNumber: phoneNumber,
      password: hashedPassword, // Store hashed password
      wallet: 0,
      referralCode: myReferralCode,
      referredBy: referrerId,
      locations: [],
    );

    // Save new user
    await _firestore.collection('users').doc(userId).set(userModel.toJson());

    // Reward: If referredBy exists → Add ₹50 to THIS user
    if (referrerId != null) {
      await _firestore.collection('users').doc(userId).update({
        "wallet": FieldValue.increment(50),
      });
    }

    // Save locally (don't save password locally)
    await UserPreferences.saveUser(
      userId: userId,
      name: name,
      email: email,
      mobileNumber: phoneNumber,
    );

    _currentUserData = userModel;
    notifyListeners();

  } catch (e) {
    _setError(e.toString());
    throw e;
  } finally {
    _setLoading(false);
  }
}

// Future<void> saveUserWithoutAuth({
//   required String name,
//   required String email,
//   required String phoneNumber,
//   String? referralCodeEntered, // <-- NEW
// }) async {
//   try {
//     _setLoading(true);
//     _clearError();

//     // Check duplicates
//     bool phoneExists = await _isPhoneNumberRegistered(phoneNumber);
//     if (phoneExists) throw Exception('Phone number is already registered');

//     bool emailExists = await _isEmailRegistered(email);
//     if (emailExists) throw Exception('Email is already registered');

//     // Generate a unique user ID
//     String userId = DateTime.now().millisecondsSinceEpoch.toString();

//     // 1. Generate referral code for this user
//     String myReferralCode = "${name.substring(0, 3).toUpperCase()}${userId.substring(7)}";

//     String? referrerId;

//     // 2. If user entered a referral code → find who owns it
//     if (referralCodeEntered != null && referralCodeEntered.isNotEmpty) {
//       final query = await _firestore
//           .collection('users')
//           .where('referralCode', isEqualTo: referralCodeEntered)
//           .get();

//       if (query.docs.isEmpty) {
//         throw Exception("Invalid referral code");
//       }

//       referrerId = query.docs.first.id;

//       // (Optional) Prevent self-referral
//       if (referrerId == userId) {
//         throw Exception("You cannot use your own referral code");
//       }
//     }

//     // Create user model
//     UserModel userModel = UserModel(
//       id: userId,
//       name: name,
//       email: email,
//       mobileNumber: phoneNumber,
//       wallet: 0,
//       referralCode: myReferralCode,
//       referredBy: referrerId,
//       locations: [],
//     );

//     // Save new user
//     await _firestore.collection('users').doc(userId).set(userModel.toJson());

//     // 3. Reward: If referredBy exists → Add ₹50 to THIS user
//     if (referrerId != null) {
//       await _firestore.collection('users').doc(userId).update({
//         "wallet": FieldValue.increment(50),
//       });
//     }

//     // Save locally
//     await UserPreferences.saveUser(
//       userId: userId,
//       name: name,
//       email: email,
//       mobileNumber: phoneNumber,
//     );

//     _currentUserData = userModel;
//     notifyListeners();

//   } catch (e) {
//     _setError(e.toString());
//     throw e;
//   } finally {
//     _setLoading(false);
//   }
// }



  // Add this method to your AuthProvider class

// Save user data directly without authentication
// Future<void> saveUserWithoutAuth({
//   required String name,
//   required String email,
//   required String phoneNumber,
// }) async {
//   try {
//     _setLoading(true);
//     _clearError();

//     // Check if phone number is already registered
//     bool phoneExists = await _isPhoneNumberRegistered(phoneNumber);
//     if (phoneExists) {
//       throw Exception('Phone number is already registered');
//     }

//     // Check if email is already registered
//     bool emailExists = await _isEmailRegistered(email);
//     if (emailExists) {
//       throw Exception('Email is already registered');
//     }

//     // Generate a unique user ID
//     String userId = DateTime.now().millisecondsSinceEpoch.toString();
    
//     // Create user model
//     UserModel userModel = UserModel(
//       id: userId,
//       name: name,
//       email: email,
//       mobileNumber: phoneNumber,
//        locations: [],
//     );

//     // Save to Firestore
//     await _firestore.collection('users').doc(userId).set(userModel.toJson());

//     // Save to local storage
//     await UserPreferences.saveUser(
//       userId: userId,
//       name: name,
//       email: email,
//       mobileNumber: phoneNumber,
//     );

//     _currentUserData = userModel;
//     notifyListeners();

//   } catch (e) {
//     _setError(e.toString());
//     throw e; // Re-throw to handle in UI
//   } finally {
//     _setLoading(false);
//   }
// }


// Add this method to your AuthProvider class

// Login user with phone number (without OTP)
Future<bool> loginWithPhoneNumber(String phoneNumber) async {
  try {
    _setLoading(true);
    _clearError();

    // Check if phone number exists in Firestore
    QuerySnapshot query = await _firestore
        .collection('users')
        .where('mobileNumber', isEqualTo: phoneNumber)
        .get();

    if (query.docs.isEmpty) {
      throw Exception('Phone number not registered. Please sign up first.');
    }

    // Get user data
    Map<String, dynamic> userData = query.docs.first.data() as Map<String, dynamic>;
    UserModel userModel = UserModel.fromJson(userData);

    // Save user data locally
    await UserPreferences.saveUser(
      userId: userModel.id,
      name: userModel.name,
      email: userModel.email,
      mobileNumber: userModel.mobileNumber,
    );

    // Update current user data
    _currentUserData = userModel;
    _authStatus = AuthStatus.authenticated;
    
    notifyListeners();
    return true;

  } catch (e) {
    _setError(e.toString());
    return false;
  } finally {
    _setLoading(false);
  }
}




Future<void> updatePassword({
  required String phoneNumber,
  required String newPassword,
}) async {
  try {
    _setLoading(true);
    _clearError();

    // Find user by phone number
    QuerySnapshot query = await _firestore
        .collection('users')
        .where('mobileNumber', isEqualTo: phoneNumber)
        .get();

    if (query.docs.isEmpty) {
      throw Exception('Phone number not registered');
    }

    String userId = query.docs.first.id;

    // Hash the new password
    String hashedPassword = _hashPassword(newPassword);

    // Update password in Firestore
    await _firestore.collection('users').doc(userId).update({
      'password': hashedPassword,
    });

    // If this is the current user, update local data
    if (_currentUserData?.id == userId) {
      _currentUserData = UserModel(
        id: _currentUserData!.id,
        name: _currentUserData!.name,
        email: _currentUserData!.email,
        mobileNumber: _currentUserData!.mobileNumber,
        password: hashedPassword,
        wallet: _currentUserData!.wallet,
        referralCode: _currentUserData!.referralCode,
        referredBy: _currentUserData!.referredBy,
        locations: _currentUserData!.locations,
        // profileImage: _currentUserData!.profileImage,
      );
    }

    notifyListeners();

  } catch (e) {
    _setError(e.toString());
    throw e;
  } finally {
    _setLoading(false);
  }
}



  

  // Sign in with phone number (for existing users)
  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    try {
      _setLoading(true);
      _clearError();

      // Check if phone number exists
      bool phoneExists = await _isPhoneNumberRegistered(phoneNumber);
      if (!phoneExists) {
        throw Exception('Phone number not registered');
      }

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Verify OTP
  Future<void> verifyOTP(String smsCode) async {
    try {
      _setOTPStatus(OTPStatus.verifying);
      _clearError();

      if (_verificationId == null) {
        throw Exception('Verification ID not found');
      }

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      // If this is a new user (signup), save the user data
      if (userCredential.additionalUserInfo?.isNewUser == true || _tempName != null) {
        await _saveNewUserData(
          userCredential.user!,
          _tempName ?? '',
          _tempEmail ?? '',
          _tempPhoneNumber ?? '',
        );
      }

      _setOTPStatus(OTPStatus.verified);
      _clearTempData();

    } on FirebaseAuthException catch (e) {
      _setError(_handleAuthException(e));
      _setOTPStatus(OTPStatus.error);
    } catch (e) {
      _setError('OTP verification failed: ${e.toString()}');
      _setOTPStatus(OTPStatus.error);
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    if (_tempPhoneNumber != null) {
      if (_tempName != null) {
        // This is a signup flow
        await signUpWithPhoneNumber(
          name: _tempName!,
          email: _tempEmail!,
          phoneNumber: _tempPhoneNumber!,
        );
      } else {
        // This is a sign in flow
        await signInWithPhoneNumber(_tempPhoneNumber!);
      }
    }
  }
// Sign out
  Future<void> signOut() async {
    try {
      _setLoading(true);
      // await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      await UserPreferences.clearUser();
      _currentUserData = null;
      _clearTempData();
      _authStatus = AuthStatus.unauthenticated;
    } catch (e) {
      _setError('Sign out failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    required String name,
    required String email,
    required String mobileNumber,
    List<Location>? locations,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      if (_user == null) {
        throw Exception('User not authenticated');
      }

      // Update display name
      await _user!.updateDisplayName(name);

      // Create updated user model
      UserModel updatedUser = UserModel(
        id: _user!.uid,
        name: name,
        email: email,
        mobileNumber: mobileNumber,
        locations: locations ?? _currentUserData?.locations ?? [],
      );

      // Update in Firestore
      await _saveUserToFirestore(updatedUser);

      // Update local data
      await _saveUserDataLocally(updatedUser);
      _currentUserData = updatedUser;

      notifyListeners();
    } catch (e) {
      _setError('Profile update failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      _setLoading(true);
      
      if (_user != null) {
        // Delete user document from Firestore
        await _firestore.collection('users').doc(_user!.uid).delete();
        
        // Delete user from Firebase Auth
        await _user!.delete();
        
        // Clear local data
        await UserPreferences.clearUser();
        _currentUserData = null;
        _authStatus = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _setError('Account deletion failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Phone verification callbacks
  void _verificationCompleted(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      // If this is a new user (signup), save the user data
      if (_tempName != null) {
        await _saveNewUserData(
          userCredential.user!,
          _tempName!,
          _tempEmail!,
          _tempPhoneNumber!,
        );
      }
      
      _setOTPStatus(OTPStatus.verified);
      _clearTempData();
    } catch (e) {
      _setError('Auto-verification failed: ${e.toString()}');
    }
  }

  void _verificationFailed(FirebaseAuthException e) {
    _setError(_handleAuthException(e));
    _setOTPStatus(OTPStatus.error);
  }

  void _codeSent(String verificationId, int? resendToken) {
    _verificationId = verificationId;
    _setOTPStatus(OTPStatus.codeSent);
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    _verificationId = verificationId;
  }

  // Private helper methods
  Future<void> _saveNewUserData(User user, String name, String email, String phoneNumber) async {
    UserModel userModel = UserModel(
      id: user.uid,
      name: name,
      email: email,
      mobileNumber: phoneNumber,
      locations: [],
    );

    await _saveUserToFirestore(userModel);
    await _saveUserDataLocally(userModel);
    _currentUserData = userModel;
    notifyListeners();
  }

  Future<void> _saveUserToFirestore(UserModel userModel) async {
    await _firestore.collection('users').doc(userModel.id).set(userModel.toJson());
  }

  Future<void> _saveUserDataLocally(UserModel userModel) async {
    await UserPreferences.saveUser(
      userId: userModel.id,
      name: userModel.name,
      mobileNumber: userModel.mobileNumber,
      email: userModel.email,
    );
  }

  Future<UserModel?> _getCurrentUserDataFromLocal() async {
    String? userId = await UserPreferences.getUserId();
    String? name = await UserPreferences.getName();
    String? email = await UserPreferences.getEmail();
    String? mobileNumber = await UserPreferences.getMobileNumber();

    if (userId != null && name != null) {
      return UserModel(
        id: userId,
        name: name,
        email: email ?? '',
        mobileNumber: mobileNumber ?? '',
        locations: [],
      );
    }
    return null;
  }

  Future<UserModel?> _getUserDataFromFirestore(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch user data: ${e.toString()}');
    }
  }

  Future<bool> _isPhoneNumberRegistered(String phoneNumber) async {
    try {
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('mobileNumber', isEqualTo: phoneNumber)
          .get();
      
      return query.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check phone number: ${e.toString()}');
    }
  }

  Future<bool> _isEmailRegistered(String email) async {
    try {
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      
      return query.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check email: ${e.toString()}');
    }
  }

  // State management methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    _authStatus = AuthStatus.error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    if (_authStatus == AuthStatus.error) {
      _authStatus = _user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  void _setOTPStatus(OTPStatus status) {
    _otpStatus = status;
    notifyListeners();
  }

  void _clearTempData() {
    _tempName = null;
    _tempEmail = null;
    _tempPhoneNumber = null;
    _verificationId = null;
  }

  void resetOTPStatus() {
    _otpStatus = OTPStatus.initial;
    notifyListeners();
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'The phone number format is invalid.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-verification-code':
        return 'The verification code entered is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'operation-not-allowed':
        return 'Phone authentication is not enabled.';
      case 'credential-already-in-use':
        return 'This phone number is already associated with another account.';
      default:
        return e.message ?? 'An authentication error occurred.';
    }
  }
}