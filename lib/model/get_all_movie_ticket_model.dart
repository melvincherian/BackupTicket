class MovieTicket {
  final String id;
  final MovieInfo movieId;
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

  MovieTicket({
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

  factory MovieTicket.fromJson(Map<String, dynamic> json) {
    return MovieTicket(
      id: json['_id'],
      movieId: MovieInfo.fromJson(json['movieId']),
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
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class MovieInfo {
  final String id;
  final String movieName;

  MovieInfo({
    required this.id,
    required this.movieName,
  });

  factory MovieInfo.fromJson(Map<String, dynamic> json) {
    return MovieInfo(
      id: json['_id'],
      movieName: json['MovieName'],
    );
  }
}