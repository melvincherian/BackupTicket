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


















// lib/models/movie_ticket_model.dart

class CreateMovieTicketModel {
  final String? id;
  final String movieId;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String movieName;
  final String language;
  final String theatrePlace;
  final DateTime showDate;
  final String showTime;
  final String ticketCategory;
  final int noOfTickets;
  final List<String> selectedSeats;
  final int pricePerTicket;
  final int totalPrice;
  final String? ticketImage;
  final String qrCodeLink;
  final bool termsAndConditionsAccepted;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CreateMovieTicketModel({
    this.id,
    required this.movieId,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.movieName,
    required this.language,
    required this.theatrePlace,
    required this.showDate,
    required this.showTime,
    required this.ticketCategory,
    required this.noOfTickets,
    required this.selectedSeats,
    required this.pricePerTicket,
    required this.totalPrice,
    this.ticketImage,
    required this.qrCodeLink,
    required this.termsAndConditionsAccepted,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateMovieTicketModel.fromJson(Map<String, dynamic> json) {
    return CreateMovieTicketModel(
      id: json['_id'],
      movieId: json['movieId'] is Map ? json['movieId']['_id'] : json['movieId'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      movieName: json['MovieName'],
      language: json['language'],
      theatrePlace: json['theatrePlace'],
      showDate: DateTime.parse(json['showDate']),
      showTime: json['showTime'],
      ticketCategory: json['ticketCategory'],
      noOfTickets: json['noOfTickets'],
      selectedSeats: List<String>.from(json['selectedSeats']),
      pricePerTicket: json['pricePerTicket'],
      totalPrice: json['totalPrice'],
      ticketImage: json['ticketImage'],
      qrCodeLink: json['qrCodeLink'],
      termsAndConditionsAccepted: json['termsAndConditionsAccepted'],
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'movieId': movieId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'MovieName': movieName,
      'language': language,
      'theatrePlace': theatrePlace,
      'showDate': showDate.toIso8601String(),
      'showTime': showTime,
      'ticketCategory': ticketCategory,
      'noOfTickets': noOfTickets,
      'selectedSeats': selectedSeats,
      'pricePerTicket': pricePerTicket,
      'totalPrice': totalPrice,
      if (ticketImage != null) 'ticketImage': ticketImage,
      'qrCodeLink': qrCodeLink,
      'termsAndConditionsAccepted': termsAndConditionsAccepted,
      if (status != null) 'status': status,
    };
  }
}

class MovieTicketResponse {
  final String message;
  final List<CreateMovieTicketModel> tickets;

  MovieTicketResponse({
    required this.message,
    required this.tickets,
  });

  factory MovieTicketResponse.fromJson(Map<String, dynamic> json) {
    return MovieTicketResponse(
      message: json['message'],
      tickets: (json['tickets'] as List)
          .map((ticket) => CreateMovieTicketModel.fromJson(ticket))
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
      id: json['_id'],
      movieName: json['MovieName'],
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
      message: json['message'] ?? 'Success',
      movies: (json['movies'] as List)
          .map((movie) => MovieName.fromJson(movie))
          .toList(),
    );
  }
}