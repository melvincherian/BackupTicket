// // lib/models/ticket_model.dart

// class MovieTicketResponse {
//   final String message;
//   final List<CreateMovieTicketModel> tickets;

//   MovieTicketResponse({
//     required this.message,
//     required this.tickets,
//   });

//   factory MovieTicketResponse.fromJson(Map<String, dynamic> json) {
//     return MovieTicketResponse(
//       message: json['message'] ?? '',
//       tickets: (json['tickets'] as List<dynamic>?)
//               ?.map((ticket) => CreateMovieTicketModel.fromJson(ticket))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'tickets': tickets.map((ticket) => ticket.toJson()).toList(),
//     };
//   }
// }

// class CreateMovieTicketModel {
//   final String id;
//   final MovieInfo movieId;
//   final String fullName;
//   final String phoneNumber;
//   final String email;
//   final String movieName;
//   final String language;
//   final String theatrePlace;
//   final DateTime showDate;
//   final String showTime;
//   final String ticketCategory;
//   final int noOfTickets;
//   final List<String> selectedSeats;
//   final double pricePerTicket;
//   final double totalPrice;
//   final String ticketImage;
//   final String qrCodeLink;
//   final bool termsAndConditionsAccepted;
//   final String status;
//   final String userId;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   CreateMovieTicketModel({
//     required this.id,
//     required this.movieId,
//     required this.fullName,
//     required this.phoneNumber,
//     required this.email,
//     required this.movieName,
//     required this.language,
//     required this.theatrePlace,
//     required this.showDate,
//     required this.showTime,
//     required this.ticketCategory,
//     required this.noOfTickets,
//     required this.selectedSeats,
//     required this.pricePerTicket,
//     required this.totalPrice,
//     required this.ticketImage,
//     required this.qrCodeLink,
//     required this.termsAndConditionsAccepted,
//     required this.status,
//     required this.userId,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory CreateMovieTicketModel.fromJson(Map<String, dynamic> json) {
//     return CreateMovieTicketModel(
//       id: json['_id'] ?? '',
//       movieId: MovieInfo.fromJson(json['movieId'] ?? {}),
//       fullName: json['fullName'] ?? '',
//       phoneNumber: json['phoneNumber'] ?? '',
//       email: json['email'] ?? '',
//       movieName: json['MovieName'] ?? '',
//       language: json['language'] ?? '',
//       theatrePlace: json['theatrePlace'] ?? '',
//       showDate: DateTime.parse(json['showDate'] ?? DateTime.now().toIso8601String()),
//       showTime: json['showTime'] ?? '',
//       ticketCategory: json['ticketCategory'] ?? '',
//       noOfTickets: json['noOfTickets'] ?? 0,
//       selectedSeats: List<String>.from(json['selectedSeats'] ?? []),
//       pricePerTicket: (json['pricePerTicket'] ?? 0).toDouble(),
//       totalPrice: (json['totalPrice'] ?? 0).toDouble(),
//       ticketImage: json['ticketImage'] ?? '',
//       qrCodeLink: json['qrCodeLink'] ?? '',
//       termsAndConditionsAccepted: json['termsAndConditionsAccepted'] ?? false,
//       status: json['status'] ?? 'pending',
//       userId: json['userId'] ?? '',
//       createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
//       updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'movieId': movieId.toJson(),
//       'fullName': fullName,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'MovieName': movieName,
//       'language': language,
//       'theatrePlace': theatrePlace,
//       'showDate': showDate.toIso8601String(),
//       'showTime': showTime,
//       'ticketCategory': ticketCategory,
//       'noOfTickets': noOfTickets,
//       'selectedSeats': selectedSeats,
//       'pricePerTicket': pricePerTicket,
//       'totalPrice': totalPrice,
//       'ticketImage': ticketImage,
//       'qrCodeLink': qrCodeLink,
//       'termsAndConditionsAccepted': termsAndConditionsAccepted,
//       'status': status,
//       'userId': userId,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

// class MovieInfo {
//   final String id;
//   final String movieName;

//   MovieInfo({
//     required this.id,
//     required this.movieName,
//   });

//   factory MovieInfo.fromJson(Map<String, dynamic> json) {
//     return MovieInfo(
//       id: json['_id'] ?? '',
//       movieName: json['MovieName'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'MovieName': movieName,
//     };
//   }
// }

// // Request model for creating tickets
// class CreateTicketRequest {
//   final String movieId;
//   final String fullName;
//   final String phoneNumber;
//   final String email;
//   final String movieName;
//   final String language;
//   final String theatrePlace;
//   final String showDate;
//   final String showTime;
//   final String ticketCategory;
//   final String noOfTickets;
//   final String selectedSeats; // JSON string format: ["A1","A2"]
//   final String pricePerTicket;
//   final String totalPrice;
//   final String qrCodeLink;
//   final String termsAndConditionsAccepted;
//   final String? ticketImagePath; // Local file path

//   CreateTicketRequest({
//     required this.movieId,
//     required this.fullName,
//     required this.phoneNumber,
//     required this.email,
//     required this.movieName,
//     required this.language,
//     required this.theatrePlace,
//     required this.showDate,
//     required this.showTime,
//     required this.ticketCategory,
//     required this.noOfTickets,
//     required this.selectedSeats,
//     required this.pricePerTicket,
//     required this.totalPrice,
//     required this.qrCodeLink,
//     required this.termsAndConditionsAccepted,
//     this.ticketImagePath,
//   });

//   Map<String, String> toFormData() {
//     return {
//       'movieId': movieId,
//       'fullName': fullName,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'MovieName': movieName,
//       'language': language,
//       'theatrePlace': theatrePlace,
//       'showDate': showDate,
//       'showTime': showTime,
//       'ticketCategory': ticketCategory,
//       'noOfTickets': noOfTickets,
//       'selectedSeats': selectedSeats,
//       'pricePerTicket': pricePerTicket,
//       'totalPrice': totalPrice,
//       'qrCodeLink': qrCodeLink,
//       'termsAndConditionsAccepted': termsAndConditionsAccepted,
//     };
//   }
// }


















// // lib/models/movie_ticket_model.dart

// class CreateMovieTicketModel {
//   final String? id;
//   final String movieId;
//   final String fullName;
//   final String phoneNumber;
//   final String email;
//   final String movieName;
//   final String language;
//   final String theatrePlace;
//   final DateTime showDate;
//   final String showTime;
//   final String ticketCategory;
//   final int noOfTickets;
//   final List<String> selectedSeats;
//   final int pricePerTicket;
//   final int totalPrice;
//   final String? ticketImage;
//   final String qrCodeLink;
//   final bool termsAndConditionsAccepted;
//   final String? status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   CreateMovieTicketModel({
//     this.id,
//     required this.movieId,
//     required this.fullName,
//     required this.phoneNumber,
//     required this.email,
//     required this.movieName,
//     required this.language,
//     required this.theatrePlace,
//     required this.showDate,
//     required this.showTime,
//     required this.ticketCategory,
//     required this.noOfTickets,
//     required this.selectedSeats,
//     required this.pricePerTicket,
//     required this.totalPrice,
//     this.ticketImage,
//     required this.qrCodeLink,
//     required this.termsAndConditionsAccepted,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory CreateMovieTicketModel.fromJson(Map<String, dynamic> json) {
//     return CreateMovieTicketModel(
//       id: json['_id'],
//       movieId: json['movieId'] is Map ? json['movieId']['_id'] : json['movieId'],
//       fullName: json['fullName'],
//       phoneNumber: json['phoneNumber'],
//       email: json['email'],
//       movieName: json['MovieName'],
//       language: json['language'],
//       theatrePlace: json['theatrePlace'],
//       showDate: DateTime.parse(json['showDate']),
//       showTime: json['showTime'],
//       ticketCategory: json['ticketCategory'],
//       noOfTickets: json['noOfTickets'],
//       selectedSeats: List<String>.from(json['selectedSeats']),
//       pricePerTicket: json['pricePerTicket'],
//       totalPrice: json['totalPrice'],
//       ticketImage: json['ticketImage'],
//       qrCodeLink: json['qrCodeLink'],
//       termsAndConditionsAccepted: json['termsAndConditionsAccepted'],
//       status: json['status'],
//       createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
//       updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       if (id != null) '_id': id,
//       'movieId': movieId,
//       'fullName': fullName,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'MovieName': movieName,
//       'language': language,
//       'theatrePlace': theatrePlace,
//       'showDate': showDate.toIso8601String(),
//       'showTime': showTime,
//       'ticketCategory': ticketCategory,
//       'noOfTickets': noOfTickets,
//       'selectedSeats': selectedSeats,
//       'pricePerTicket': pricePerTicket,
//       'totalPrice': totalPrice,
//       if (ticketImage != null) 'ticketImage': ticketImage,
//       'qrCodeLink': qrCodeLink,
//       'termsAndConditionsAccepted': termsAndConditionsAccepted,
//       if (status != null) 'status': status,
//     };
//   }
// }

// class MovieTicketResponse {
//   final String message;
//   final List<CreateMovieTicketModel> tickets;

//   MovieTicketResponse({
//     required this.message,
//     required this.tickets,
//   });

//   factory MovieTicketResponse.fromJson(Map<String, dynamic> json) {
//     return MovieTicketResponse(
//       message: json['message'],
//       tickets: (json['tickets'] as List)
//           .map((ticket) => CreateMovieTicketModel.fromJson(ticket))
//           .toList(),
//     );
//   }
// }

// class MovieName {
//   final String id;
//   final String movieName;

//   MovieName({
//     required this.id,
//     required this.movieName,
//   });

//   factory MovieName.fromJson(Map<String, dynamic> json) {
//     return MovieName(
//       id: json['_id'],
//       movieName: json['MovieName'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'MovieName': movieName,
//     };
//   }
// }

// class MovieNamesResponse {
//   final String message;
//   final List<MovieName> movies;

//   MovieNamesResponse({
//     required this.message,
//     required this.movies,
//   });

//   factory MovieNamesResponse.fromJson(Map<String, dynamic> json) {
//     return MovieNamesResponse(
//       message: json['message'] ?? 'Success',
//       movies: (json['movies'] as List)
//           .map((movie) => MovieName.fromJson(movie))
//           .toList(),
//     );
//   }
// }
















class CreateMovieTicketModel {
  final String id;
  final String movieId;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String movieName;
  final String language;
  final String theatrePlace;
  final DateTime? showDate;
  final String showTime;
  final String ticketCategory;
  final int noOfTickets;
  final List<String> selectedSeats;
  final int pricePerTicket;
  final int totalPrice;
  final String? ticketImage;
  final String qrCodeLink;
  final bool termsAndConditionsAccepted;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CreateMovieTicketModel({
    required this.id,
    required this.movieId,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.movieName,
    required this.language,
    required this.theatrePlace,
    this.showDate,
    required this.showTime,
    required this.ticketCategory,
    required this.noOfTickets,
    required this.selectedSeats,
    required this.pricePerTicket,
    required this.totalPrice,
    this.ticketImage,
    required this.qrCodeLink,
    required this.termsAndConditionsAccepted,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  // --------------------------------------------------
  // SAFE FROM JSON (NO NULL → STRING ERRORS)
  // --------------------------------------------------
  factory CreateMovieTicketModel.fromJson(Map<String, dynamic> json) {
    return CreateMovieTicketModel(
      id: _string(json['_id']),
      movieId: _movieId(json['movieId']),
      fullName: _string(json['fullName']),
      phoneNumber: _string(json['phoneNumber']),
      email: _string(json['email']),
      movieName: _string(json['MovieName']),
      language: _string(json['language']),
      theatrePlace: _string(json['theatrePlace']),
      showDate: _date(json['showDate']),
      showTime: _string(json['showTime']),
      ticketCategory: _string(json['ticketCategory']),
      noOfTickets: _int(json['noOfTickets']),
      selectedSeats: _stringList(json['selectedSeats']),
      pricePerTicket: _int(json['pricePerTicket']),
      totalPrice: _int(json['totalPrice']),
      ticketImage: _image(json['ticketImage']),
      qrCodeLink: _string(json['qrCodeLink']),
      termsAndConditionsAccepted:
          _bool(json['termsAndConditionsAccepted']),
      status: _string(json['status'], defaultValue: 'pending'),
      createdAt: _date(json['createdAt']),
      updatedAt: _date(json['updatedAt']),
    );
  }

  // --------------------------------------------------
  // TO JSON
  // --------------------------------------------------
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'movieId': movieId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'MovieName': movieName,
      'language': language,
      'theatrePlace': theatrePlace,
      if (showDate != null)
        'showDate': showDate!.toIso8601String(),
      'showTime': showTime,
      'ticketCategory': ticketCategory,
      'noOfTickets': noOfTickets,
      'selectedSeats': selectedSeats,
      'pricePerTicket': pricePerTicket,
      'totalPrice': totalPrice,
      if (ticketImage != null) 'ticketImage': ticketImage,
      'qrCodeLink': qrCodeLink,
      'termsAndConditionsAccepted': termsAndConditionsAccepted,
      'status': status,
    };
  }

  // ==================================================
  // 🔐 SAFE HELPERS (NEVER RETURN NULL FOR STRING)
  // ==================================================

  static String _string(dynamic value, {String defaultValue = ''}) {
    if (value == null) return defaultValue;
    return value.toString();
  }

  static int _int(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static bool _bool(dynamic value) {
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    if (value is int) {
      return value == 1;
    }
    return false;
  }

  static DateTime? _date(dynamic value) {
    if (value == null) return null;
    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return null;
    }
  }

  static String _movieId(dynamic value) {
    if (value == null) return '';
    if (value is Map && value['_id'] != null) {
      return value['_id'].toString();
    }
    return value.toString();
  }

  static List<String> _stringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    if (value is String) {
      return [value];
    }
    return [];
  }

  static String? _image(dynamic value) {
    if (value == null) return null;
    if (value is Map && value['url'] != null) {
      return value['url'].toString();
    }
    return value.toString();
  }
}

// ==================================================
// MOVIE NAMES MODELS (SAFE)
// ==================================================

class MovieTicketResponse {
  final String message;
  final List<CreateMovieTicketModel> tickets;

  MovieTicketResponse({
    required this.message,
    required this.tickets,
  });

  factory MovieTicketResponse.fromJson(Map<String, dynamic> json) {
    return MovieTicketResponse(
      message: json['message']?.toString() ?? 'Success',
      tickets: (json['tickets'] as List? ?? [])
          .map((e) => CreateMovieTicketModel.fromJson(e))
          .toList(),
    );
  }
}

class MovieName {
  final String id;
  final String movieName;

  MovieName({
    required this.id,
    required this.movieName,
  });

  factory MovieName.fromJson(Map<String, dynamic> json) {
    return MovieName(
      id: json['_id']?.toString() ?? '',
      movieName: json['MovieName']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'MovieName': movieName,
    };
  }
}

class MovieNamesResponse {
  final String message;
  final List<MovieName> movies;

  MovieNamesResponse({
    required this.message,
    required this.movies,
  });

  factory MovieNamesResponse.fromJson(Map<String, dynamic> json) {
    return MovieNamesResponse(
      message: json['message']?.toString() ?? 'Success',
      movies: (json['movies'] as List? ?? [])
          .map((e) => MovieName.fromJson(e))
          .toList(),
    );
  }
}