// // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // class MovieTicket {
// // // //   final String? id;
// // // //   final String fullName;
// // // //   final String phoneNumber;
// // // //   final String email;
// // // //   final String gender;
// // // //   final String movieName;
// // // //   final String theatrePlace;
// // // //   final DateTime showDate;
// // // //   final String showTime;
// // // //   final double pricePerTicket;
// // // //   final String ticketType;
// // // //   final int numberOfTickets;
// // // //   final double totalPrice;
// // // //   final String? ticketImageUrl;
// // // //   final String? qrCodeImageUrl; 
// // // //   final bool agreeToTerms;
// // // //   final DateTime createdAt;
// // // //   final String status;
  
// // // //   MovieTicket({
// // // //     this.id,
// // // //     required this.fullName,
// // // //     required this.phoneNumber,
// // // //     required this.email,
// // // //     required this.gender,
// // // //     required this.movieName,
// // // //     required this.theatrePlace,
// // // //     required this.showDate,
// // // //     required this.showTime,
// // // //     required this.pricePerTicket,
// // // //     required this.ticketType,
// // // //     required this.numberOfTickets,
// // // //     required this.totalPrice,
// // // //     this.ticketImageUrl,
// // // //     this.qrCodeImageUrl, // New QR code field
// // // //     required this.agreeToTerms,
// // // //     required this.createdAt,
// // // //     this.status = 'pending',
// // // //   });

// // // //   // Convert MovieTicket to Map for Firestore
// // // //   Map<String, dynamic> toMap() {
// // // //     return {
// // // //       'fullName': fullName,
// // // //       'phoneNumber': phoneNumber,
// // // //       'email': email,
// // // //       'gender': gender,
// // // //       'movieName': movieName,
// // // //       'theatrePlace': theatrePlace,
// // // //       'showDate': Timestamp.fromDate(showDate),
// // // //       'showTime': showTime,
// // // //       'pricePerTicket': pricePerTicket,
// // // //       'ticketType': ticketType,
// // // //       'numberOfTickets': numberOfTickets,
// // // //       'totalPrice': totalPrice,
// // // //       'ticketImageUrl': ticketImageUrl,
// // // //       'qrCodeImageUrl': qrCodeImageUrl, // New QR code field
// // // //       'agreeToTerms': agreeToTerms,
// // // //       'createdAt': Timestamp.fromDate(createdAt),
// // // //       'status': status,
// // // //     };
// // // //   }

// // // //   // Create MovieTicket from Firestore document
// // // //   factory MovieTicket.fromMap(Map<String, dynamic> map, String documentId) {
// // // //     return MovieTicket(
// // // //       id: documentId,
// // // //       fullName: map['fullName'] ?? '',
// // // //       phoneNumber: map['phoneNumber'] ?? '',
// // // //       email: map['email'] ?? '',
// // // //       gender: map['gender'] ?? '',
// // // //       movieName: map['movieName'] ?? '',
// // // //       theatrePlace: map['theatrePlace'] ?? '',
// // // //       showDate: (map['showDate'] as Timestamp).toDate(),
// // // //       showTime: map['showTime'] ?? '',
// // // //       pricePerTicket: (map['pricePerTicket'] ?? 0.0).toDouble(),
// // // //       ticketType: map['ticketType'] ?? '',
// // // //       numberOfTickets: map['numberOfTickets'] ?? 0,
// // // //       totalPrice: (map['totalPrice'] ?? 0.0).toDouble(),
// // // //       ticketImageUrl: map['ticketImageUrl'],
// // // //       qrCodeImageUrl: map['qrCodeImageUrl'], // New QR code field
// // // //       agreeToTerms: map['agreeToTerms'] ?? false,
// // // //       createdAt: (map['createdAt'] as Timestamp).toDate(),
// // // //       status: map['status'] ?? 'pending',
// // // //     );
// // // //   }

// // // //   // Create a copy of MovieTicket with updated fields
// // // //   MovieTicket copyWith({
// // // //     String? id,
// // // //     String? fullName,
// // // //     String? phoneNumber,
// // // //     String? email,
// // // //     String? gender,
// // // //     String? movieName,
// // // //     String? theatrePlace,
// // // //     DateTime? showDate,
// // // //     String? showTime,
// // // //     double? pricePerTicket,
// // // //     String? ticketType,
// // // //     int? numberOfTickets,
// // // //     double? totalPrice,
// // // //     String? ticketImageUrl,
// // // //     String? qrCodeImageUrl, // New QR code field
// // // //     bool? agreeToTerms,
// // // //     DateTime? createdAt,
// // // //     String? status,
// // // //   }) {
// // // //     return MovieTicket(
// // // //       id: id ?? this.id,
// // // //       fullName: fullName ?? this.fullName,
// // // //       phoneNumber: phoneNumber ?? this.phoneNumber,
// // // //       email: email ?? this.email,
// // // //       gender: gender ?? this.gender,
// // // //       movieName: movieName ?? this.movieName,
// // // //       theatrePlace: theatrePlace ?? this.theatrePlace,
// // // //       showDate: showDate ?? this.showDate,
// // // //       showTime: showTime ?? this.showTime,
// // // //       pricePerTicket: pricePerTicket ?? this.pricePerTicket,
// // // //       ticketType: ticketType ?? this.ticketType,
// // // //       numberOfTickets: numberOfTickets ?? this.numberOfTickets,
// // // //       totalPrice: totalPrice ?? this.totalPrice,
// // // //       ticketImageUrl: ticketImageUrl ?? this.ticketImageUrl,
// // // //       qrCodeImageUrl: qrCodeImageUrl ?? this.qrCodeImageUrl, // New QR code field
// // // //       agreeToTerms: agreeToTerms ?? this.agreeToTerms,
// // // //       createdAt: createdAt ?? this.createdAt,
// // // //       status: status ?? this.status,
// // // //     );
// // // //   }
// // // // }











// // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // class MovieTicket {
// // //   final String? id;
// // //   final String fullName;
// // //   final String phoneNumber;
// // //   final String email;
// // //   final String gender;
// // //   final String movieName;
// // //   final String theatrePlace;
// // //   final DateTime showDate;
// // //   final String showTime;
// // //   final double pricePerTicket;
// // //   final String ticketType;
// // //   final int numberOfTickets;
// // //   final double totalPrice;
// // //   final String? ticketImageUrl;
// // //   final String? qrCodeImageUrl; 
// // //   final bool agreeToTerms;
// // //   final DateTime createdAt;
// // //   final String status;

// // //   // ✅ New fields
// // //   final double? latitude;
// // //   final double? longitude;
  
// // //   MovieTicket({
// // //     this.id,
// // //     required this.fullName,
// // //     required this.phoneNumber,
// // //     required this.email,
// // //     required this.gender,
// // //     required this.movieName,
// // //     required this.theatrePlace,
// // //     required this.showDate,
// // //     required this.showTime,
// // //     required this.pricePerTicket,
// // //     required this.ticketType,
// // //     required this.numberOfTickets,
// // //     required this.totalPrice,
// // //     this.ticketImageUrl,
// // //     this.qrCodeImageUrl,
// // //     required this.agreeToTerms,
// // //     required this.createdAt,
// // //     this.status = 'pending',

// // //     // ✅ New params
// // //     this.latitude,
// // //     this.longitude,
// // //   });

// // //   // Convert MovieTicket to Map for Firestore
// // //   Map<String, dynamic> toMap() {
// // //     return {
// // //       'fullName': fullName,
// // //       'phoneNumber': phoneNumber,
// // //       'email': email,
// // //       'gender': gender,
// // //       'movieName': movieName,
// // //       'theatrePlace': theatrePlace,
// // //       'showDate': Timestamp.fromDate(showDate),
// // //       'showTime': showTime,
// // //       'pricePerTicket': pricePerTicket,
// // //       'ticketType': ticketType,
// // //       'numberOfTickets': numberOfTickets,
// // //       'totalPrice': totalPrice,
// // //       'ticketImageUrl': ticketImageUrl,
// // //       'qrCodeImageUrl': qrCodeImageUrl,
// // //       'agreeToTerms': agreeToTerms,
// // //       'createdAt': Timestamp.fromDate(createdAt),
// // //       'status': status,

// // //       // ✅ New fields
// // //       'latitude': latitude,
// // //       'longitude': longitude,
// // //     };
// // //   }

// // //   // Create MovieTicket from Firestore document
// // //   factory MovieTicket.fromMap(Map<String, dynamic> map, String documentId) {
// // //     return MovieTicket(
// // //       id: documentId,
// // //       fullName: map['fullName'] ?? '',
// // //       phoneNumber: map['phoneNumber'] ?? '',
// // //       email: map['email'] ?? '',
// // //       gender: map['gender'] ?? '',
// // //       movieName: map['movieName'] ?? '',
// // //       theatrePlace: map['theatrePlace'] ?? '',
// // //       showDate: (map['showDate'] as Timestamp).toDate(),
// // //       showTime: map['showTime'] ?? '',
// // //       pricePerTicket: (map['pricePerTicket'] ?? 0.0).toDouble(),
// // //       ticketType: map['ticketType'] ?? '',
// // //       numberOfTickets: map['numberOfTickets'] ?? 0,
// // //       totalPrice: (map['totalPrice'] ?? 0.0).toDouble(),
// // //       ticketImageUrl: map['ticketImageUrl'],
// // //       qrCodeImageUrl: map['qrCodeImageUrl'],
// // //       agreeToTerms: map['agreeToTerms'] ?? false,
// // //       createdAt: (map['createdAt'] as Timestamp).toDate(),
// // //       status: map['status'] ?? 'pending',

// // //       // ✅ Handle null safety & conversion
// // //       latitude: (map['latitude'] as num?)?.toDouble(),
// // //       longitude: (map['longitude'] as num?)?.toDouble(),
// // //     );
// // //   }

// // //   // Create a copy of MovieTicket with updated fields
// // //   MovieTicket copyWith({
// // //     String? id,
// // //     String? fullName,
// // //     String? phoneNumber,
// // //     String? email,
// // //     String? gender,
// // //     String? movieName,
// // //     String? theatrePlace,
// // //     DateTime? showDate,
// // //     String? showTime,
// // //     double? pricePerTicket,
// // //     String? ticketType,
// // //     int? numberOfTickets,
// // //     double? totalPrice,
// // //     String? ticketImageUrl,
// // //     String? qrCodeImageUrl,
// // //     bool? agreeToTerms,
// // //     DateTime? createdAt,
// // //     String? status,

// // //     // ✅ New fields
// // //     double? latitude,
// // //     double? longitude,
// // //   }) {
// // //     return MovieTicket(
// // //       id: id ?? this.id,
// // //       fullName: fullName ?? this.fullName,
// // //       phoneNumber: phoneNumber ?? this.phoneNumber,
// // //       email: email ?? this.email,
// // //       gender: gender ?? this.gender,
// // //       movieName: movieName ?? this.movieName,
// // //       theatrePlace: theatrePlace ?? this.theatrePlace,
// // //       showDate: showDate ?? this.showDate,
// // //       showTime: showTime ?? this.showTime,
// // //       pricePerTicket: pricePerTicket ?? this.pricePerTicket,
// // //       ticketType: ticketType ?? this.ticketType,
// // //       numberOfTickets: numberOfTickets ?? this.numberOfTickets,
// // //       totalPrice: totalPrice ?? this.totalPrice,
// // //       ticketImageUrl: ticketImageUrl ?? this.ticketImageUrl,
// // //       qrCodeImageUrl: qrCodeImageUrl ?? this.qrCodeImageUrl,
// // //       agreeToTerms: agreeToTerms ?? this.agreeToTerms,
// // //       createdAt: createdAt ?? this.createdAt,
// // //       status: status ?? this.status,

// // //       // ✅
// // //       latitude: latitude ?? this.latitude,
// // //       longitude: longitude ?? this.longitude,
// // //     );
// // //   }
// // // }















// // import 'package:cloud_firestore/cloud_firestore.dart';

// // // ------------------------------------------------------
// // // ENUM
// // // ------------------------------------------------------
// // enum TicketStatus {
// //   pending,
// //   confirmed,
// //   accepted,
// //   cancelled,
// //   sold,
// // }

// // class MovieTicket {
// //   final String? id;
// //   final String fullName;
// //   final String phoneNumber;
// //   final String email;
// //   final String gender;
// //   final String movieName;
// //   final String theatrePlace;
// //   final DateTime showDate;
// //   final String showTime;
// //   final double pricePerTicket;
// //   final String ticketType;
// //   final int numberOfTickets;
// //   final double totalPrice;
// //   final String? ticketImageUrl;
// //   final String? qrCodeImageUrl;
// //   final bool agreeToTerms;
// //   final DateTime createdAt;

// //   // ⭐ Enum field
// //   final TicketStatus status;

// //   // ⭐ New fields
// //   final double? latitude;
// //   final double? longitude;

// //   MovieTicket({
// //     this.id,
// //     required this.fullName,
// //     required this.phoneNumber,
// //     required this.email,
// //     required this.gender,
// //     required this.movieName,
// //     required this.theatrePlace,
// //     required this.showDate,
// //     required this.showTime,
// //     required this.pricePerTicket,
// //     required this.ticketType,
// //     required this.numberOfTickets,
// //     required this.totalPrice,
// //     this.ticketImageUrl,
// //     this.qrCodeImageUrl,
// //     required this.agreeToTerms,
// //     required this.createdAt,

// //     // ⭐ Default enum = pending
// //     this.status = TicketStatus.pending,

// //     this.latitude,
// //     this.longitude,
// //   });

// //   // ------------------------------------------------------
// //   // Convert MovieTicket to Map
// //   // ------------------------------------------------------
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'fullName': fullName,
// //       'phoneNumber': phoneNumber,
// //       'email': email,
// //       'gender': gender,
// //       'movieName': movieName,
// //       'theatrePlace': theatrePlace,
// //       'showDate': Timestamp.fromDate(showDate),
// //       'showTime': showTime,
// //       'pricePerTicket': pricePerTicket,
// //       'ticketType': ticketType,
// //       'numberOfTickets': numberOfTickets,
// //       'totalPrice': totalPrice,
// //       'ticketImageUrl': ticketImageUrl,
// //       'qrCodeImageUrl': qrCodeImageUrl,
// //       'agreeToTerms': agreeToTerms,
// //       'createdAt': Timestamp.fromDate(createdAt),

// //       // ⭐ Save enum as string
// //       'status': status.name,
// //       'latitude': latitude,
// //       'longitude': longitude,
// //     };
// //   }

// //   // ------------------------------------------------------
// //   // Create MovieTicket from Firestore
// //   // ------------------------------------------------------
// //   factory MovieTicket.fromMap(Map<String, dynamic> map, String documentId) {
// //     return MovieTicket(
// //       id: documentId,
// //       fullName: map['fullName'] ?? '',
// //       phoneNumber: map['phoneNumber'] ?? '',
// //       email: map['email'] ?? '',
// //       gender: map['gender'] ?? '',
// //       movieName: map['movieName'] ?? '',
// //       theatrePlace: map['theatrePlace'] ?? '',
// //       showDate: (map['showDate'] as Timestamp).toDate(),
// //       showTime: map['showTime'] ?? '',
// //       pricePerTicket: (map['pricePerTicket'] ?? 0.0).toDouble(),
// //       ticketType: map['ticketType'] ?? '',
// //       numberOfTickets: map['numberOfTickets'] ?? 0,
// //       totalPrice: (map['totalPrice'] ?? 0.0).toDouble(),
// //       ticketImageUrl: map['ticketImageUrl'],
// //       qrCodeImageUrl: map['qrCodeImageUrl'],
// //       agreeToTerms: map['agreeToTerms'] ?? false,
// //       createdAt: (map['createdAt'] as Timestamp).toDate(),

// //       // ⭐ Convert saved string back to enum
// //       status: TicketStatus.values.firstWhere(
// //         (e) => e.name == map['status'],
// //         orElse: () => TicketStatus.pending,
// //       ),

// //       latitude: (map['latitude'] as num?)?.toDouble(),
// //       longitude: (map['longitude'] as num?)?.toDouble(),
// //     );
// //   }

// //   // ------------------------------------------------------
// //   // CopyWith for updating values
// //   // ------------------------------------------------------
// //   MovieTicket copyWith({
// //     String? id,
// //     String? fullName,
// //     String? phoneNumber,
// //     String? email,
// //     String? gender,
// //     String? movieName,
// //     String? theatrePlace,
// //     DateTime? showDate,
// //     String? showTime,
// //     double? pricePerTicket,
// //     String? ticketType,
// //     int? numberOfTickets,
// //     double? totalPrice,
// //     String? ticketImageUrl,
// //     String? qrCodeImageUrl,
// //     bool? agreeToTerms,
// //     DateTime? createdAt,

// //     // ⭐ enum parameter
// //     TicketStatus? status,

// //     double? latitude,
// //     double? longitude,
// //   }) {
// //     return MovieTicket(
// //       id: id ?? this.id,
// //       fullName: fullName ?? this.fullName,
// //       phoneNumber: phoneNumber ?? this.phoneNumber,
// //       email: email ?? this.email,
// //       gender: gender ?? this.gender,
// //       movieName: movieName ?? this.movieName,
// //       theatrePlace: theatrePlace ?? this.theatrePlace,
// //       showDate: showDate ?? this.showDate,
// //       showTime: showTime ?? this.showTime,
// //       pricePerTicket: pricePerTicket ?? this.pricePerTicket,
// //       ticketType: ticketType ?? this.ticketType,
// //       numberOfTickets: numberOfTickets ?? this.numberOfTickets,
// //       totalPrice: totalPrice ?? this.totalPrice,
// //       ticketImageUrl: ticketImageUrl ?? this.ticketImageUrl,
// //       qrCodeImageUrl: qrCodeImageUrl ?? this.qrCodeImageUrl,
// //       agreeToTerms: agreeToTerms ?? this.agreeToTerms,
// //       createdAt: createdAt ?? this.createdAt,
// //       status: status ?? this.status,
// //       latitude: latitude ?? this.latitude,
// //       longitude: longitude ?? this.longitude,
// //     );
// //   }
// // }


















// import 'package:cloud_firestore/cloud_firestore.dart';

// // ------------------------------------------------------
// // ENUM
// // ------------------------------------------------------
// enum TicketStatus {
//   pending,
//   confirmed,
//   accepted,
//   cancelled,
//   sold,
// }

// class MovieTicket {
//   final String? id;
//   final String fullName;
//   final String phoneNumber;
//   final String email;
//   final String gender;
//   final String movieName;
//   final String theatrePlace;
//   final DateTime showDate;
//   final String showTime;
//   final double pricePerTicket;

//   // NEW
//   final String ticketCategory;

//   final String ticketType;
//   final int numberOfTickets;
//   final double totalPrice;
//   final String? ticketImageUrl;
//   final String? qrCodeImageUrl;
//   final bool agreeToTerms;
//   final DateTime createdAt;

//   // ENUM field
//   final TicketStatus status;

//   // NEW fields
//   final double? latitude;
//   final double? longitude;

//   MovieTicket({
//     this.id,
//     required this.fullName,
//     required this.phoneNumber,
//     required this.email,
//     required this.gender,
//     required this.movieName,
//     required this.theatrePlace,
//     required this.showDate,
//     required this.showTime,
//     required this.pricePerTicket,

//     /// NEW FIELD
//     required this.ticketCategory,

//     required this.ticketType,
//     required this.numberOfTickets,
//     required this.totalPrice,
//     this.ticketImageUrl,
//     this.qrCodeImageUrl,
//     required this.agreeToTerms,
//     required this.createdAt,

//     // Default enum = pending
//     this.status = TicketStatus.pending,

//     this.latitude,
//     this.longitude,
//   });

//   // ------------------------------------------------------
//   // Convert MovieTicket to Map
//   // ------------------------------------------------------
//   Map<String, dynamic> toMap() {
//     return {
//       'fullName': fullName,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'gender': gender,
//       'movieName': movieName,
//       'theatrePlace': theatrePlace,
//       'showDate': Timestamp.fromDate(showDate),
//       'showTime': showTime,
//       'pricePerTicket': pricePerTicket,

//       /// NEW FIELD
//       'ticketCategory': ticketCategory,

//       'ticketType': ticketType,
//       'numberOfTickets': numberOfTickets,
//       'totalPrice': totalPrice,
//       'ticketImageUrl': ticketImageUrl,
//       'qrCodeImageUrl': qrCodeImageUrl,
//       'agreeToTerms': agreeToTerms,
//       'createdAt': Timestamp.fromDate(createdAt),

//       // Enum as string
//       'status': status.name,

//       'latitude': latitude,
//       'longitude': longitude,
//     };
//   }

//   // ------------------------------------------------------
//   // Create MovieTicket from Firestore
//   // ------------------------------------------------------
//   factory MovieTicket.fromMap(Map<String, dynamic> map, String documentId) {
//     return MovieTicket(
//       id: documentId,
//       fullName: map['fullName'] ?? '',
//       phoneNumber: map['phoneNumber'] ?? '',
//       email: map['email'] ?? '',
//       gender: map['gender'] ?? '',
//       movieName: map['movieName'] ?? '',
//       theatrePlace: map['theatrePlace'] ?? '',
//       showDate: (map['showDate'] as Timestamp).toDate(),
//       showTime: map['showTime'] ?? '',
//       pricePerTicket: (map['pricePerTicket'] ?? 0.0).toDouble(),

//       /// NEW FIELD
//       ticketCategory: map['ticketCategory'] ?? '',

//       ticketType: map['ticketType'] ?? '',
//       numberOfTickets: map['numberOfTickets'] ?? 0,
//       totalPrice: (map['totalPrice'] ?? 0.0).toDouble(),
//       ticketImageUrl: map['ticketImageUrl'],
//       qrCodeImageUrl: map['qrCodeImageUrl'],
//       agreeToTerms: map['agreeToTerms'] ?? false,
//       createdAt: (map['createdAt'] as Timestamp).toDate(),

//       status: TicketStatus.values.firstWhere(
//         (e) => e.name == map['status'],
//         orElse: () => TicketStatus.pending,
//       ),

//       latitude: (map['latitude'] as num?)?.toDouble(),
//       longitude: (map['longitude'] as num?)?.toDouble(),
//     );
//   }

//   // ------------------------------------------------------
//   // CopyWith for updating values
//   // ------------------------------------------------------
//   MovieTicket copyWith({
//     String? id,
//     String? fullName,
//     String? phoneNumber,
//     String? email,
//     String? gender,
//     String? movieName,
//     String? theatrePlace,
//     DateTime? showDate,
//     String? showTime,
//     double? pricePerTicket,
//     String? ticketType,

//     /// NEW FIELD
//     String? ticketCategory,

//     int? numberOfTickets,
//     double? totalPrice,
//     String? ticketImageUrl,
//     String? qrCodeImageUrl,
//     bool? agreeToTerms,
//     DateTime? createdAt,
//     TicketStatus? status,
//     double? latitude,
//     double? longitude,
//   }) {
//     return MovieTicket(
//       id: id ?? this.id,
//       fullName: fullName ?? this.fullName,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       email: email ?? this.email,
//       gender: gender ?? this.gender,
//       movieName: movieName ?? this.movieName,
//       theatrePlace: theatrePlace ?? this.theatrePlace,
//       showDate: showDate ?? this.showDate,
//       showTime: showTime ?? this.showTime,
//       pricePerTicket: pricePerTicket ?? this.pricePerTicket,

//       /// NEW FIELD
//       ticketCategory: ticketCategory ?? this.ticketCategory,

//       ticketType: ticketType ?? this.ticketType,
//       numberOfTickets: numberOfTickets ?? this.numberOfTickets,
//       totalPrice: totalPrice ?? this.totalPrice,
//       ticketImageUrl: ticketImageUrl ?? this.ticketImageUrl,
//       qrCodeImageUrl: qrCodeImageUrl ?? this.qrCodeImageUrl,
//       agreeToTerms: agreeToTerms ?? this.agreeToTerms,
//       createdAt: createdAt ?? this.createdAt,
//       status: status ?? this.status,
//       latitude: latitude ?? this.latitude,
//       longitude: longitude ?? this.longitude,
//     );
//   }
// }















// import 'package:cloud_firestore/cloud_firestore.dart';

// // ------------------------------------------------------
// // ENUM
// // ------------------------------------------------------
// enum TicketStatus {
//   pending,
//   confirmed,
//   accepted,
//   cancelled,
//   sold,
// }

// class MovieTicket {
//   final String? id;
//   final String fullName;
//   final String phoneNumber;
//   final String email;
//   final String gender;
//   final String movieName;
//   final String theatrePlace;
//   final DateTime showDate;
//   final String showTime;
//   final double pricePerTicket;
//   final String ticketCategory;
//   final String ticketType;
//   final int numberOfTickets;
//   final List<String> seatNumbers; // NEW FIELD: Add seat numbers list
//   final double totalPrice;
//   final String? ticketImageUrl;
//   final String? qrCodeImageUrl;
//   final bool agreeToTerms;
//   final DateTime createdAt;
//   final TicketStatus status;
//   final double? latitude;
//   final double? longitude;

//   MovieTicket({
//     this.id,
//     required this.fullName,
//     required this.phoneNumber,
//     required this.email,
//     required this.gender,
//     required this.movieName,
//     required this.theatrePlace,
//     required this.showDate,
//     required this.showTime,
//     required this.pricePerTicket,
//     required this.ticketCategory,
//     required this.ticketType,
//     required this.numberOfTickets,
//     required this.seatNumbers, // NEW FIELD: Add seat numbers parameter
//     required this.totalPrice,
//     this.ticketImageUrl,
//     this.qrCodeImageUrl,
//     required this.agreeToTerms,
//     required this.createdAt,
//     this.status = TicketStatus.pending,
//     this.latitude,
//     this.longitude,
//   });

//   // ------------------------------------------------------
//   // Convert MovieTicket to Map
//   // ------------------------------------------------------
//   Map<String, dynamic> toMap() {
//     return {
//       'fullName': fullName,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'gender': gender,
//       'movieName': movieName,
//       'theatrePlace': theatrePlace,
//       'showDate': Timestamp.fromDate(showDate),
//       'showTime': showTime,
//       'pricePerTicket': pricePerTicket,
//       'ticketCategory': ticketCategory,
//       'ticketType': ticketType,
//       'numberOfTickets': numberOfTickets,
//       'seatNumbers': seatNumbers, // NEW FIELD: Add to map
//       'totalPrice': totalPrice,
//       'ticketImageUrl': ticketImageUrl,
//       'qrCodeImageUrl': qrCodeImageUrl,
//       'agreeToTerms': agreeToTerms,
//       'createdAt': Timestamp.fromDate(createdAt),
//       'status': status.name,
//       'latitude': latitude,
//       'longitude': longitude,
//     };
//   }

//   // ------------------------------------------------------
//   // Create MovieTicket from Firestore
//   // ------------------------------------------------------
//   factory MovieTicket.fromMap(Map<String, dynamic> map, String documentId) {
//     return MovieTicket(
//       id: documentId,
//       fullName: map['fullName'] ?? '',
//       phoneNumber: map['phoneNumber'] ?? '',
//       email: map['email'] ?? '',
//       gender: map['gender'] ?? '',
//       movieName: map['movieName'] ?? '',
//       theatrePlace: map['theatrePlace'] ?? '',
//       showDate: (map['showDate'] as Timestamp).toDate(),
//       showTime: map['showTime'] ?? '',
//       pricePerTicket: (map['pricePerTicket'] ?? 0.0).toDouble(),
//       ticketCategory: map['ticketCategory'] ?? '',
//       ticketType: map['ticketType'] ?? '',
//       numberOfTickets: map['numberOfTickets'] ?? 0,
//       seatNumbers: List<String>.from(map['seatNumbers'] ?? []), // NEW FIELD: Get from map
//       totalPrice: (map['totalPrice'] ?? 0.0).toDouble(),
//       ticketImageUrl: map['ticketImageUrl'],
//       qrCodeImageUrl: map['qrCodeImageUrl'],
//       agreeToTerms: map['agreeToTerms'] ?? false,
//       createdAt: (map['createdAt'] as Timestamp).toDate(),
//       status: TicketStatus.values.firstWhere(
//         (e) => e.name == map['status'],
//         orElse: () => TicketStatus.pending,
//       ),
//       latitude: (map['latitude'] as num?)?.toDouble(),
//       longitude: (map['longitude'] as num?)?.toDouble(),
//     );
//   }

//   // ------------------------------------------------------
//   // CopyWith for updating values
//   // ------------------------------------------------------
//   MovieTicket copyWith({
//     String? id,
//     String? fullName,
//     String? phoneNumber,
//     String? email,
//     String? gender,
//     String? movieName,
//     String? theatrePlace,
//     DateTime? showDate,
//     String? showTime,
//     double? pricePerTicket,
//     String? ticketCategory,
//     String? ticketType,
//     int? numberOfTickets,
//     List<String>? seatNumbers, // NEW FIELD: Add to copyWith
//     double? totalPrice,
//     String? ticketImageUrl,
//     String? qrCodeImageUrl,
//     bool? agreeToTerms,
//     DateTime? createdAt,
//     TicketStatus? status,
//     double? latitude,
//     double? longitude,
//   }) {
//     return MovieTicket(
//       id: id ?? this.id,
//       fullName: fullName ?? this.fullName,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       email: email ?? this.email,
//       gender: gender ?? this.gender,
//       movieName: movieName ?? this.movieName,
//       theatrePlace: theatrePlace ?? this.theatrePlace,
//       showDate: showDate ?? this.showDate,
//       showTime: showTime ?? this.showTime,
//       pricePerTicket: pricePerTicket ?? this.pricePerTicket,
//       ticketCategory: ticketCategory ?? this.ticketCategory,
//       ticketType: ticketType ?? this.ticketType,
//       numberOfTickets: numberOfTickets ?? this.numberOfTickets,
//       seatNumbers: seatNumbers ?? this.seatNumbers, // NEW FIELD
//       totalPrice: totalPrice ?? this.totalPrice,
//       ticketImageUrl: ticketImageUrl ?? this.ticketImageUrl,
//       qrCodeImageUrl: qrCodeImageUrl ?? this.qrCodeImageUrl,
//       agreeToTerms: agreeToTerms ?? this.agreeToTerms,
//       createdAt: createdAt ?? this.createdAt,
//       status: status ?? this.status,
//       latitude: latitude ?? this.latitude,
//       longitude: longitude ?? this.longitude,
//     );
//   }
// }













import 'package:cloud_firestore/cloud_firestore.dart';

// ------------------------------------------------------
// ENUM
// ------------------------------------------------------
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