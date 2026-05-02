import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseOtpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> sendOtp({
    required String phoneNumber,
    required Function(PhoneAuthCredential) onAutoVerified,
  }) async {
    final completer = Completer<String>();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      verificationCompleted: (PhoneAuthCredential credential) {
        onAutoVerified(credential);
        if (!completer.isCompleted) {
          completer.complete(credential.verificationId ?? '');
        }
      },

      verificationFailed: (FirebaseAuthException e) {
        if (!completer.isCompleted) {
          completer.completeError(_mapError(e));
        }
      },

      codeSent: (String verificationId, int? resendToken) {
        if (!completer.isCompleted) {
          completer.complete(verificationId);
        }
      },

      codeAutoRetrievalTimeout: (String verificationId) {
      },

      timeout: const Duration(seconds: 60),
    );

    return completer.future;
  }

  /// Verifies the OTP and returns Firebase ID token to send to your backend.
  Future<String> verifyOtpAndGetIdToken({
    required String verificationId,
    required String otp,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    final userCredential = await _auth.signInWithCredential(credential);
    final idToken = await userCredential.user?.getIdToken();
    if (idToken == null) throw Exception('Failed to get Firebase ID token.');
    return idToken;
  }

  String _mapError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'Invalid phone number. Include country code (e.g. +91).';
      case 'too-many-requests':
        return 'Too many requests. Please wait and try again.';
      case 'quota-exceeded':
        return 'SMS quota exceeded. Try again later.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      default:
        return e.message ?? 'Failed to send OTP. Please try again.';
    }
  }
}