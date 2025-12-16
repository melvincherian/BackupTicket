

// lib/models/register_model.dart

class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String referralCode;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    this.referralCode = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'confirmPassword': confirmPassword,
      'referralCode': referralCode,
    };
  }
}

class RegisterResponse {
  final bool success;
  final String message;
  final String otp;
  final String token;
  final User user;

  RegisterResponse({
    required this.success,
    required this.message,
    required this.otp,
    required this.token,
    required this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      otp: json['otp'] ?? '',
      token: json['token'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'otp': otp,
      'token': token,
      'user': user.toJson(),
    };
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String? profileImage;
  final String? profileImageId;
  final String referralCode;
  final String? usedReferralCode;
  final String? referredBy;
  final int referralCount;
  final List<dynamic> notifications;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.profileImage,
    this.profileImageId,
    required this.referralCode,
    this.usedReferralCode,
    this.referredBy,
    required this.referralCount,
    required this.notifications,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      password: json['password'] ?? '',
      profileImage: json['profileImage'],
      profileImageId: json['profileImageId'],
      referralCode: json['referralCode'] ?? '',
      usedReferralCode: json['usedReferralCode'],
      referredBy: json['referredBy'],
      referralCount: json['referralCount'] ?? 0,
      notifications: json['notifications'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'profileImage': profileImage,
      'profileImageId': profileImageId,
      'referralCode': referralCode,
      'usedReferralCode': usedReferralCode,
      'referredBy': referredBy,
      'referralCount': referralCount,
      'notifications': notifications,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}