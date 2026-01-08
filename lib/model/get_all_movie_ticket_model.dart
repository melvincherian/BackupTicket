// class MovieTicket {
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
//   final int pricePerTicket;
//   final int totalPrice;
//   final String ticketImage;
//   final String qrCodeLink;
//   final bool termsAndConditionsAccepted;
//   final String status;
//   final String userId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//     final MovieInfo movie;


//   MovieTicket({
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
//     required this.movie
//   });

//   factory MovieTicket.fromJson(Map<String, dynamic> json) {
//     return MovieTicket(
//       id: json['_id'],
//       movieId: MovieInfo.fromJson(json['movieId']),
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
//       userId: json['userId'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
// movie: MovieInfo.fromJson(json['movie'] ?? {}),
//     );
//   }
// }

// class MovieInfo {
//   final String id;
//   final String movieName;
//     final String image;


//   MovieInfo({
//     required this.id,
//     required this.movieName,
//     required this.image
//   });

//   factory MovieInfo.fromJson(Map<String, dynamic> json) {
//     return MovieInfo(
//       id: json['_id'],
//       movieName: json['MovieName'],
//             image: json['image'],

//     );
//   }
// }




















// class MovieTicket {
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
//   final int pricePerTicket;
//   final int totalPrice;
//   final String ticketImage;
//   final String qrCodeLink;
//   final bool termsAndConditionsAccepted;
//   final String status;
//   final String userId;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   MovieTicket({
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

//   factory MovieTicket.fromJson(Map<String, dynamic> json) {
//     return MovieTicket(
//       id: json['_id']?.toString() ?? '',

//       movieId: MovieInfo.fromJson(
//         json['movieId'] is Map<String, dynamic> ? json['movieId'] : {},
//       ),

//       fullName: json['fullName']?.toString() ?? '',
//       phoneNumber: json['phoneNumber']?.toString() ?? '',
//       email: json['email']?.toString() ?? '',
//       movieName: json['MovieName']?.toString() ?? '',
//       language: json['language']?.toString() ?? '',
//       theatrePlace: json['theatrePlace']?.toString() ?? '',
//       showDate: _parseDate(json['showDate']),
//       showTime: json['showTime']?.toString() ?? '',
//       ticketCategory: json['ticketCategory']?.toString() ?? '',
//       noOfTickets: _parseInt(json['noOfTickets']),
//       selectedSeats: (json['selectedSeats'] is List)
//           ? List<String>.from(json['selectedSeats'].map((e) => e.toString()))
//           : [],
//       pricePerTicket: _parseInt(json['pricePerTicket']),
//       totalPrice: _parseInt(json['totalPrice']),
//       ticketImage: json['ticketImage']?.toString() ?? '',
//       qrCodeLink: json['qrCodeLink']?.toString() ?? '',
//       termsAndConditionsAccepted:
//           json['termsAndConditionsAccepted'] == true,
//       status: json['status']?.toString() ?? '',
//       userId: json['userId']?.toString() ?? '',
//       createdAt: _parseDate(json['createdAt']),
//       updatedAt: _parseDate(json['updatedAt']),
//     );
//   }

//   static int _parseInt(dynamic v) =>
//       v is int ? v : int.tryParse(v?.toString() ?? '') ?? 0;

//   static DateTime _parseDate(dynamic v) {
//     try {
//       return DateTime.parse(v.toString());
//     } catch (_) {
//       return DateTime.now();
//     }
//   }
// }




class MovieTicket {
  final String id;
  final MovieInfo movieId;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String movieName;
  final String language;
  final String theatrePlace;

  /// ✅ NEW
  final String screen;       // "Screen 1" / "Audi 2"
  final String ticketType;   // "Platinum", "Executive"

  final DateTime showDate;
  final String showTime;
  final String ticketCategory;
  final int noOfTickets;
  final List<String> selectedSeats;
  final int pricePerTicket;
  final int totalPrice;
  final String ticketImage;

  /// ✅ NEW
  final String qrCode;       // cropped QR image URL

  final String qrCodeLink;
  final bool termsAndConditionsAccepted;
  final String status;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  MovieTicket({
    required this.id,
    required this.movieId,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.movieName,
    required this.language,
    required this.theatrePlace,
    required this.screen,
    required this.ticketType,
    required this.showDate,
    required this.showTime,
    required this.ticketCategory,
    required this.noOfTickets,
    required this.selectedSeats,
    required this.pricePerTicket,
    required this.totalPrice,
    required this.ticketImage,
    required this.qrCode,
    required this.qrCodeLink,
    required this.termsAndConditionsAccepted,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MovieTicket.fromJson(Map<String, dynamic> json) {
    return MovieTicket(
      id: json['_id']?.toString() ?? '',

      movieId: MovieInfo.fromJson(
        json['movieId'] is Map<String, dynamic> ? json['movieId'] : {},
      ),

      fullName: json['fullName']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      movieName: json['MovieName']?.toString() ?? '',
      language: json['language']?.toString() ?? '',
      theatrePlace: json['theatrePlace']?.toString() ?? '',

      /// ✅ NEW (safe parsing)
      screen: json['screen']?.toString() ?? '',
      ticketType: json['ticketType']?.toString() ?? '',

      showDate: _parseDate(json['showDate']),
      showTime: json['showTime']?.toString() ?? '',
      ticketCategory: json['ticketCategory']?.toString() ?? '',
      noOfTickets: _parseInt(json['noOfTickets']),

      selectedSeats: (json['selectedSeats'] is List)
          ? List<String>.from(
              json['selectedSeats'].map((e) => e.toString()),
            )
          : [],

      pricePerTicket: _parseInt(json['pricePerTicket']),
      totalPrice: _parseInt(json['totalPrice']),
      ticketImage: json['ticketImage']?.toString() ?? '',

      /// ✅ NEW
      qrCode: json['qrCode']?.toString() ?? '',

      qrCodeLink: json['qrCodeLink']?.toString() ?? '',
      termsAndConditionsAccepted:
          json['termsAndConditionsAccepted'] == true,
      status: json['status']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
    );
  }

  static int _parseInt(dynamic v) =>
      v is int ? v : int.tryParse(v?.toString() ?? '') ?? 0;

  static DateTime _parseDate(dynamic v) {
    try {
      return DateTime.parse(v.toString());
    } catch (_) {
      return DateTime.now();
    }
  }
}




class MovieInfo {
  final String id;
  final String movieName;
  final String image;

  MovieInfo({
    required this.id,
    required this.movieName,
    required this.image,
  });

  factory MovieInfo.fromJson(Map<String, dynamic> json) {
    return MovieInfo(
      id: json['_id']?.toString() ?? '',
      movieName: json['MovieName']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }
}
