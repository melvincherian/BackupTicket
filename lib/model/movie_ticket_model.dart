
import 'package:cloud_firestore/cloud_firestore.dart';

enum TicketStatus {
  pending,
  confirmed,
  accepted,
  cancelled,
  sold,
}

class MovieTicket {
  final String? id;
  final String fullName;
  final String phoneNumber;
  final String email;
  // final String gender;
  final String movieName;
  final String? language; // NEW FIELD: Language (optional)
  final String theatrePlace;
  final DateTime showDate;
  final String showTime;
  final double pricePerTicket;
  final String ticketCategory;
  final String ticketType;
  final int numberOfTickets;
  final List<String> seatNumbers;
  final double totalPrice;
  final String? ticketImageUrl;
  final String? qrCodeImageUrl;
  final bool agreeToTerms;
  final DateTime createdAt;
  final TicketStatus status;
  final double? latitude;
  final double? longitude;

  MovieTicket({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    // required this.gender,
    required this.movieName,
    this.language, // NEW FIELD: Language (optional)
    required this.theatrePlace,
    required this.showDate,
    required this.showTime,
    required this.pricePerTicket,
    required this.ticketCategory,
    required this.ticketType,
    required this.numberOfTickets,
    required this.seatNumbers,
    required this.totalPrice,
    this.ticketImageUrl,
    this.qrCodeImageUrl,
    required this.agreeToTerms,
    required this.createdAt,
    this.status = TicketStatus.pending,
    this.latitude,
    this.longitude,
  });

  // ------------------------------------------------------
  // Convert MovieTicket to Map
  // ------------------------------------------------------
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      // 'gender': gender,
      'movieName': movieName,
      'language': language, // NEW FIELD: Add to map
      'theatrePlace': theatrePlace,
      'showDate': Timestamp.fromDate(showDate),
      'showTime': showTime,
      'pricePerTicket': pricePerTicket,
      'ticketCategory': ticketCategory,
      'ticketType': ticketType,
      'numberOfTickets': numberOfTickets,
      'seatNumbers': seatNumbers,
      'totalPrice': totalPrice,
      'ticketImageUrl': ticketImageUrl,
      'qrCodeImageUrl': qrCodeImageUrl,
      'agreeToTerms': agreeToTerms,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status.name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // ------------------------------------------------------
  // Create MovieTicket from Firestore
  // ------------------------------------------------------
  factory MovieTicket.fromMap(Map<String, dynamic> map, String documentId) {
    return MovieTicket(
      id: documentId,
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      // gender: map['gender'] ?? '',
      movieName: map['movieName'] ?? '',
      language: map['language'], // NEW FIELD: Get from map (nullable)
      theatrePlace: map['theatrePlace'] ?? '',
      showDate: (map['showDate'] as Timestamp).toDate(),
      showTime: map['showTime'] ?? '',
      pricePerTicket: (map['pricePerTicket'] ?? 0.0).toDouble(),
      ticketCategory: map['ticketCategory'] ?? '',
      ticketType: map['ticketType'] ?? '',
      numberOfTickets: map['numberOfTickets'] ?? 0,
      seatNumbers: List<String>.from(map['seatNumbers'] ?? []),
      totalPrice: (map['totalPrice'] ?? 0.0).toDouble(),
      ticketImageUrl: map['ticketImageUrl'],
      qrCodeImageUrl: map['qrCodeImageUrl'],
      agreeToTerms: map['agreeToTerms'] ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      status: TicketStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TicketStatus.pending,
      ),
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
    );
  }

  // ------------------------------------------------------
  // CopyWith for updating values
  // ------------------------------------------------------
  MovieTicket copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? gender,
    String? movieName,
    String? language, // NEW FIELD: Add to copyWith
    String? theatrePlace,
    DateTime? showDate,
    String? showTime,
    double? pricePerTicket,
    String? ticketCategory,
    String? ticketType,
    int? numberOfTickets,
    List<String>? seatNumbers,
    double? totalPrice,
    String? ticketImageUrl,
    String? qrCodeImageUrl,
    bool? agreeToTerms,
    DateTime? createdAt,
    TicketStatus? status,
    double? latitude,
    double? longitude,
  }) {
    return MovieTicket(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      // gender: gender ?? this.gender,
      movieName: movieName ?? this.movieName,
      language: language ?? this.language, // NEW FIELD
      theatrePlace: theatrePlace ?? this.theatrePlace,
      showDate: showDate ?? this.showDate,
      showTime: showTime ?? this.showTime,
      pricePerTicket: pricePerTicket ?? this.pricePerTicket,
      ticketCategory: ticketCategory ?? this.ticketCategory,
      ticketType: ticketType ?? this.ticketType,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      seatNumbers: seatNumbers ?? this.seatNumbers,
      totalPrice: totalPrice ?? this.totalPrice,
      ticketImageUrl: ticketImageUrl ?? this.ticketImageUrl,
      qrCodeImageUrl: qrCodeImageUrl ?? this.qrCodeImageUrl,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}