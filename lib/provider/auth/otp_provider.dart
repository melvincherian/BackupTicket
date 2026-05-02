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

















// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/services/otp_service.dart';
// import 'package:backup_ticket/views/firebase/firebase_otp_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';                  // NEW
// import 'package:flutter/material.dart';

// class OtpProvider with ChangeNotifier {
//   final OtpService _otpService = OtpService();
//   final FirebaseOtpService _firebaseOtpService = FirebaseOtpService(); // NEW

//   bool _isLoading = false;
//   String? _errorMessage;
//   bool _isVerified = false;

//   // ── NEW: Firebase state ────────────────────────────────────────────────────
//   String? _firebaseVerificationId;
//   String? _phoneNumber;
//   bool _isFirebaseOtpSent = false;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   bool get isVerified => _isVerified;
//   bool get isFirebaseOtpSent => _isFirebaseOtpSent; // NEW

//   // ── NEW: Send OTP via Firebase ─────────────────────────────────────────────
//   Future<bool> sendFirebaseOtp(String phoneNumber) async {
//     _isLoading = true;
//     _errorMessage = null;
//     _isFirebaseOtpSent = false;
//     notifyListeners();

//     try {
//       final verificationId = await _firebaseOtpService.sendOtp(
//         phoneNumber: phoneNumber,
//         onAutoVerified: (PhoneAuthCredential credential) {
//           // Android auto-retrieved the SMS — store verificationId automatically
//           _firebaseVerificationId = credential.verificationId;
//           notifyListeners();
//         },
//       );

//       _phoneNumber = phoneNumber;
//       _firebaseVerificationId = verificationId;
//       _isFirebaseOtpSent = true;
//       _isLoading = false;
//       notifyListeners();
//       return true;
//     } catch (e) {
//       _errorMessage = e.toString().replaceAll('Exception: ', '');
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // ── EXISTING: Verify OTP — now supports Firebase flow too ─────────────────
//   Future<bool> verifyOtp({
//     required String otp,
//     required String token,
//     bool useFirebase = false, // NEW optional flag
//   }) async {
//     _isLoading = true;
//     _errorMessage = null;
//     _isVerified = false;
//     notifyListeners();

//     try {
//       String otpToSend = otp;

//       // NEW: If Firebase flow, confirm with Firebase first and get ID token
//       if (useFirebase) {
//         if (_firebaseVerificationId == null) {
//           throw Exception('OTP session expired. Please request a new OTP.');
//         }
//         otpToSend = await _firebaseOtpService.verifyOtpAndGetIdToken(
//           verificationId: _firebaseVerificationId!,
//           otp: otp,
//         );
//         _firebaseVerificationId = null; // consumed — clear for safety
//       }

//       // EXISTING: Send otp (or Firebase ID token) to your backend
//       final response = await _otpService.verifyOtp(
//         otp: otpToSend,
//         token: token,
//       );

//       if (response.success) {
//         await SharedPrefsHelper.saveToken(response.token);
//         await SharedPrefsHelper.setLoggedIn(true);

//         _isVerified = true;
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _errorMessage = response.message;
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } on FirebaseAuthException catch (e) {
//       // NEW: Firebase-specific error messages
//       _errorMessage = _mapFirebaseVerifyError(e);
//       _isLoading = false;
//       _isVerified = false;
//       notifyListeners();
//       return false;
//     } catch (e) {
//       _errorMessage = e.toString().replaceAll('Exception: ', '');
//       _isLoading = false;
//       _isVerified = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // ── EXISTING: Resend OTP — now supports Firebase resend too ───────────────
//   Future<bool> resendOtp(String token, {bool useFirebase = false}) async { // NEW optional flag
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       // NEW: Firebase resend path
//       if (useFirebase) {
//         if (_phoneNumber == null) {
//           throw Exception('Phone number not found. Please go back and try again.');
//         }
//         final verificationId = await _firebaseOtpService.sendOtp(
//           phoneNumber: _phoneNumber!,
//           onAutoVerified: (PhoneAuthCredential credential) {
//             _firebaseVerificationId = credential.verificationId;
//             notifyListeners();
//           },
//         );
//         _firebaseVerificationId = verificationId; // replace with new ID
//         _isFirebaseOtpSent = true;
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       }

//       // EXISTING: Backend resend path (unchanged)
//       await _otpService.resendOtp(token);
//       _isLoading = false;
//       notifyListeners();
//       return true;
//     } catch (e) {
//       _errorMessage = e.toString().replaceAll('Exception: ', '');
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // ── NEW: Firebase verify error mapper ──────────────────────────────────────
//   String _mapFirebaseVerifyError(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'invalid-verification-code':
//         return 'The OTP entered is incorrect. Please try again.';
//       case 'session-expired':
//         return 'OTP session expired. Please request a new one.';
//       case 'invalid-verification-id':
//         return 'Invalid OTP session. Please request a new OTP.';
//       default:
//         return e.message ?? 'OTP verification failed. Please try again.';
//     }
//   }

//   // ── EXISTING: Unchanged ────────────────────────────────────────────────────
//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   void reset() {
//     _isLoading = false;
//     _errorMessage = null;
//     _isVerified = false;
//     _firebaseVerificationId = null; // NEW — also reset Firebase state
//     _phoneNumber = null;            // NEW
//     _isFirebaseOtpSent = false;     // NEW
//     notifyListeners();
//   }
// }