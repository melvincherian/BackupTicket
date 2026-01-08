// class OngoingMovie {
//   final String id;
//   final MovieId movieId;
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
//   final String ticketImage;
//   final String qrCodeLink;
//   final bool termsAndConditionsAccepted;
//   final String status;
//   final String userId;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   OngoingMovie({
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

//   factory OngoingMovie.fromJson(Map<String, dynamic> json) {
//     return OngoingMovie(
//       id: json['_id'] ?? '',
//       movieId: MovieId.fromJson(json['movieId'] ?? {}),
//       fullName: json['fullName'] ?? '',
//       phoneNumber: json['phoneNumber'] ?? '',
//       email: json['email'] ?? '',
//       movieName: json['MovieName'] ?? '',
//       language: json['language'] ?? '',
//       theatrePlace: json['theatrePlace'] ?? '',
//       showDate: DateTime.parse(json['showDate']),
//       showTime: json['showTime'] ?? '',
//       ticketCategory: json['ticketCategory'] ?? '',
//       noOfTickets: json['noOfTickets'] ?? 0,
//       selectedSeats: List<String>.from(json['selectedSeats'] ?? []),
//       pricePerTicket: json['pricePerTicket'] ?? 0,
//       totalPrice: json['totalPrice'] ?? 0,
//       ticketImage: json['ticketImage'] ?? '',
//       qrCodeLink: json['qrCodeLink'] ?? '',
//       termsAndConditionsAccepted: json['termsAndConditionsAccepted'] ?? false,
//       status: json['status'] ?? '',
//       userId: json['userId'] ?? '',
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
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

// class MovieId {
//   final String id;
//   final String movieName;

//   MovieId({
//     required this.id,
//     required this.movieName,
//   });

//   factory MovieId.fromJson(Map<String, dynamic> json) {
//     return MovieId(
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

// class OngoingMoviesResponse {
//   final String message;
//   final List<OngoingMovie> movies;

//   OngoingMoviesResponse({
//     required this.message,
//     required this.movies,
//   });

//   factory OngoingMoviesResponse.fromJson(Map<String, dynamic> json) {
//     return OngoingMoviesResponse(
//       message: json['message'] ?? '',
//       movies: (json['movies'] as List<dynamic>?)
//               ?.map((movie) => OngoingMovie.fromJson(movie))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'movies': movies.map((movie) => movie.toJson()).toList(),
//     };
//   }
// }




















class OngoingMovie {
  final String id;
  final MovieId movieId;
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
  final String ticketImage;
  final String qrCodeLink;
  final bool termsAndConditionsAccepted;
  final String status;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  OngoingMovie({
    required this.id,
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
    required this.ticketImage,
    required this.qrCodeLink,
    required this.termsAndConditionsAccepted,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// ✅ Convenience getter for poster image
  String get posterImage => movieId.image;

  factory OngoingMovie.fromJson(Map<String, dynamic> json) {
    return OngoingMovie(
      id: json['_id'] ?? '',
      movieId: MovieId.fromJson(json['movieId'] ?? {}),
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      movieName: json['MovieName'] ?? '',
      language: json['language'] ?? '',
      theatrePlace: json['theatrePlace'] ?? '',
      showDate: DateTime.parse(json['showDate']),
      showTime: json['showTime'] ?? '',
      ticketCategory: json['ticketCategory'] ?? '',
      noOfTickets: json['noOfTickets'] ?? 0,
      selectedSeats:
          List<String>.from(json['selectedSeats'] ?? const []),
      pricePerTicket: json['pricePerTicket'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      ticketImage: json['ticketImage'] ?? '',
      qrCodeLink: json['qrCodeLink'] ?? '',
      termsAndConditionsAccepted:
          json['termsAndConditionsAccepted'] ?? false,
      status: json['status'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'movieId': movieId.toJson(),
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
      'ticketImage': ticketImage,
      'qrCodeLink': qrCodeLink,
      'termsAndConditionsAccepted':
          termsAndConditionsAccepted,
      'status': status,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class MovieId {
  final String id;
  final String movieName;
  final String image;

  MovieId({
    required this.id,
    required this.movieName,
    required this.image,
  });

  factory MovieId.fromJson(Map<String, dynamic> json) {
    return MovieId(
      id: json['_id'] ?? '',
      movieName: json['MovieName'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'MovieName': movieName,
      'image': image,
    };
  }
}

class OngoingMoviesResponse {
  final String message;
  final List<OngoingMovie> movies;

  OngoingMoviesResponse({
    required this.message,
    required this.movies,
  });

  factory OngoingMoviesResponse.fromJson(Map<String, dynamic> json) {
    return OngoingMoviesResponse(
      message: json['message'] ?? '',
      movies: (json['tickets'] as List<dynamic>?)
              ?.map((e) => OngoingMovie.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'movies': movies.map((e) => e.toJson()).toList(),
    };
  }
}
