// class PurchasedOrder {
//   final String orderId;
//   final String transactionId;
//   final int totalAmount;
//   final String paymentStatus;
//   final String razorpayStatus;
//   final String orderStatus;
//   final DateTime createdAt;
//   final String pdfUrl;
//   final List<PurchasedTicketWrapper> tickets;

//   PurchasedOrder({
//     required this.orderId,
//     required this.transactionId,
//     required this.totalAmount,
//     required this.paymentStatus,
//     required this.razorpayStatus,
//     required this.orderStatus,
//     required this.createdAt,
//     required this.pdfUrl,
//     required this.tickets,
//   });

//   factory PurchasedOrder.fromJson(Map<String, dynamic> json) {
//     return PurchasedOrder(
//       orderId: json['orderId'],
//       transactionId: json['transactionId'],
//       totalAmount: json['totalAmount'],
//       paymentStatus: json['paymentStatus'],
//       razorpayStatus: json['razorpayStatus'],
//       orderStatus: json['orderStatus'],
//       createdAt: DateTime.parse(json['createdAt']),
//       pdfUrl: json['pdfUrl'],
//       tickets: (json['tickets'] as List)
//           .map((e) => PurchasedTicketWrapper.fromJson(e))
//           .toList(),
//     );
//   }
// }



class PurchasedOrder {
  final String orderId;
  final String transactionId;
  final double totalAmount;
  final String paymentStatus;
  final String razorpayStatus;
  final String orderStatus;
  final DateTime createdAt;
  final String pdfUrl;
  final List<PurchasedTicketWrapper> tickets;

  PurchasedOrder({
    required this.orderId,
    required this.transactionId,
    required this.totalAmount,
    required this.paymentStatus,
    required this.razorpayStatus,
    required this.orderStatus,
    required this.createdAt,
    required this.pdfUrl,
    required this.tickets,
  });

  factory PurchasedOrder.fromJson(Map<String, dynamic> json) {
    return PurchasedOrder(
      orderId: json['orderId']?.toString() ?? '',
      transactionId: json['transactionId']?.toString() ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      paymentStatus: json['paymentStatus'] ?? '',
      razorpayStatus: json['razorpayStatus'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      pdfUrl: json['pdfUrl'] ?? '',
      tickets: (json['tickets'] as List? ?? [])
          .map((e) => PurchasedTicketWrapper.fromJson(e))
          .toList(),
    );
  }
}

class PurchasedTicketWrapper {
  final Ticket ticket;
  final Movie movie;

  PurchasedTicketWrapper({
    required this.ticket,
    required this.movie,
  });

  factory PurchasedTicketWrapper.fromJson(Map<String, dynamic> json) {
    return PurchasedTicketWrapper(
      ticket: Ticket.fromJson(json['ticket']),
      movie: Movie.fromJson(json['movie']),
    );
  }
}

// class Ticket {
//   final String ticketId;
//   final String movieName;
//   final DateTime showDate;
//   final String showTime;
//   final String ticketCategory;
//   final List<String> selectedSeats;
//   final int pricePerTicket;
//   final int totalPrice;
//   final String ticketImage;
//   final int quantity;
//   final String language;
//   final String theatrePlace;
//     final String status;


//   Ticket({
//     required this.ticketId,
//     required this.movieName,
//     required this.showDate,
//     required this.showTime,
//     required this.ticketCategory,
//     required this.selectedSeats,
//     required this.pricePerTicket,
//     required this.totalPrice,
//     required this.ticketImage,
//     required this.quantity,
//     required this.language,
//     required this.theatrePlace,
//         required this.status,

//   });

//   factory Ticket.fromJson(Map<String, dynamic> json) {
//     return Ticket(
//       ticketId: json['ticketId'],
//       movieName: json['MovieName'],
//       showDate: DateTime.parse(json['showDate']),
//       showTime: json['showTime'],
//       ticketCategory: json['ticketCategory'],
//       selectedSeats: List<String>.from(json['selectedSeats']),
//       pricePerTicket: json['pricePerTicket'],
//       totalPrice: json['totalPrice'],
//       ticketImage: json['ticketImage'],
//       quantity: json['quantity'],
//       language: json['language'],
//       theatrePlace: json['theatrePlace'],
//             status: json['status'],

//     );
//   }

//   String get fullImageUrl =>
//       'http://31.97.206.144:8127$ticketImage';
// }



class Ticket {
  final String ticketId;
  final String movieName;
  final DateTime showDate;
  final String showTime;
  final String ticketCategory;
  final String ticketType;          // ✅ NEW
  final String screen;              // ✅ NEW
  final List<String> selectedSeats;
  final int pricePerTicket;
  final int totalPrice;
  final int platformCharge;         // ✅ NEW
  final int gst;                    // ✅ NEW
  final int totalAmountWithCharges; // ✅ NEW
  final String ticketImage;
  final String qrCode;              // ✅ NEW
  final String qrCodeLink;           // ✅ NEW
  final int quantity;
  final String language;
  final String theatrePlace;
  final String status;
  final int soldCount;              // ✅ NEW
  final int remainingCount;         // ✅ NEW

  Ticket({
    required this.ticketId,
    required this.movieName,
    required this.showDate,
    required this.showTime,
    required this.ticketCategory,
    required this.ticketType,
    required this.screen,
    required this.selectedSeats,
    required this.pricePerTicket,
    required this.totalPrice,
    required this.platformCharge,
    required this.gst,
    required this.totalAmountWithCharges,
    required this.ticketImage,
    required this.qrCode,
    required this.qrCodeLink,
    required this.quantity,
    required this.language,
    required this.theatrePlace,
    required this.status,
    required this.soldCount,
    required this.remainingCount,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      ticketId: json['ticketId']?.toString() ?? '',
      movieName: json['MovieName']?.toString() ?? '',
      showDate: DateTime.tryParse(json['showDate'] ?? '') ?? DateTime.now(),
      showTime: json['showTime']?.toString() ?? '',
      ticketCategory: json['ticketCategory']?.toString() ?? '',
      ticketType: json['ticketType']?.toString() ?? '',        // ✅
      screen: json['screen']?.toString() ?? '',                // ✅
      selectedSeats: (json['selectedSeats'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      pricePerTicket: (json['pricePerTicket'] as num?)?.toInt() ?? 0,
      totalPrice: (json['totalPrice'] as num?)?.toInt() ?? 0,
      platformCharge: (json['platformCharge'] as num?)?.toInt() ?? 0,
      gst: (json['gst'] as num?)?.toInt() ?? 0,
      totalAmountWithCharges:
          (json['totalAmountWithCharges'] as num?)?.toInt() ?? 0,
      ticketImage: json['ticketImage']?.toString() ?? '',
      qrCode: json['qrCode']?.toString() ?? '',
      qrCodeLink: json['qrCodeLink']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      language: json['language']?.toString() ?? '',
      theatrePlace: json['theatrePlace']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      soldCount: (json['soldCount'] as num?)?.toInt() ?? 0,
      remainingCount: (json['remainingCount'] as num?)?.toInt() ?? 0,
    );
  }

  String get fullImageUrl =>
      'http://31.97.206.144:8127$ticketImage';

  String get fullQrUrl =>
      'http://31.97.206.144:8127$qrCode';
}



class Movie {
  final String movieId;
  final String movieName;
  final String image;

  Movie({
    required this.movieId,
    required this.movieName,
    required this.image,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieId: json['movieId'],
      movieName: json['MovieName'],
      image: json['image'],
    );
  }

  String get fullImageUrl =>
      'http://31.97.206.144:8127$image';
}
