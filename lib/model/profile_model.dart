// lib/model/user_model.dart
class ProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? profileImage;
  final String? profileImageId;
  final String referralCode;
  final String? usedReferralCode;
  final String? referredBy;
  final int referralCount;
  final List<dynamic> notifications;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      profileImage: json['profileImage']?.toString(),
      profileImageId: json['profileImageId']?.toString(),
      referralCode: json['referralCode']?.toString() ?? '',
      usedReferralCode: json['usedReferralCode']?.toString(),
      referredBy: json['referredBy']?.toString(),
      // Safe parsing for referralCount - handles both int and string
      referralCount: _parseInt(json['referralCount']),
      notifications: json['notifications'] ?? [],
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
    );
  }

  // Helper method to safely parse integers
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  // Helper method to safely parse DateTime
  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'profileImageId': profileImageId,
      'referralCode': referralCode,
      'usedReferralCode': usedReferralCode,
      'referredBy': referredBy,
      'referralCount': referralCount,
      'notifications': notifications,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Copy with method for easy updates
  ProfileModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profileImage,
    String? profileImageId,
    String? referralCode,
    String? usedReferralCode,
    String? referredBy,
    int? referralCount,
    List<dynamic>? notifications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      profileImageId: profileImageId ?? this.profileImageId,
      referralCode: referralCode ?? this.referralCode,
      usedReferralCode: usedReferralCode ?? this.usedReferralCode,
      referredBy: referredBy ?? this.referredBy,
      referralCount: referralCount ?? this.referralCount,
      notifications: notifications ?? this.notifications,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}