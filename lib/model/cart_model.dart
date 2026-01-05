class CartModel {
  final String id;
  final String userId;
  final List<CartTicket> tickets;
  final double cartTotal;
  final double totalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartModel({
    required this.id,
    required this.userId,
    required this.tickets,
    required this.cartTotal,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      tickets: (json['tickets'] as List<dynamic>?)
              ?.map((ticket) => CartTicket.fromJson(ticket))
              .toList() ??
          [],
      cartTotal: (json['cartTotal'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'tickets': tickets.map((ticket) => ticket.toJson()).toList(),
      'cartTotal': cartTotal,
      'totalAmount': totalAmount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  CartModel copyWith({
    String? id,
    String? userId,
    List<CartTicket>? tickets,
    double? cartTotal,
    double? totalAmount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tickets: tickets ?? this.tickets,
      cartTotal: cartTotal ?? this.cartTotal,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CartTicket {
  final String ticketId;
  final String movieName;
  final DateTime showDate;
  final String showTime;
  final String ticketCategory;
  final List<String> selectedSeats;
  final int noOfTickets;
  final double pricePerTicket;
  final double subTotal;
  final String ticketImage;
  final int quantity;
  final String id;

  CartTicket({
    required this.ticketId,
    required this.movieName,
    required this.showDate,
    required this.showTime,
    required this.ticketCategory,
    required this.selectedSeats,
    required this.noOfTickets,
    required this.pricePerTicket,
    required this.subTotal,
    required this.ticketImage,
    required this.quantity,
    required this.id,
  });

  factory CartTicket.fromJson(Map<String, dynamic> json) {
    return CartTicket(
      ticketId: json['ticketId'] ?? '',
      movieName: json['MovieName'] ?? '',
      showDate: DateTime.parse(json['showDate']),
      showTime: json['showTime'] ?? '',
      ticketCategory: json['ticketCategory'] ?? '',
      selectedSeats: List<String>.from(json['selectedSeats'] ?? []),
      noOfTickets: json['noOfTickets'] ?? 0,
      pricePerTicket: (json['pricePerTicket'] ?? 0).toDouble(),
      subTotal: (json['subTotal'] ?? 0).toDouble(),
      ticketImage: json['ticketImage'] ?? '',
      quantity: json['quantity'] ?? 0,
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'MovieName': movieName,
      'showDate': showDate.toIso8601String(),
      'showTime': showTime,
      'ticketCategory': ticketCategory,
      'selectedSeats': selectedSeats,
      'noOfTickets': noOfTickets,
      'pricePerTicket': pricePerTicket,
      'subTotal': subTotal,
      'ticketImage': ticketImage,
      'quantity': quantity,
      '_id': id,
    };
  }

  CartTicket copyWith({
    String? ticketId,
    String? movieName,
    DateTime? showDate,
    String? showTime,
    String? ticketCategory,
    List<String>? selectedSeats,
    int? noOfTickets,
    double? pricePerTicket,
    double? subTotal,
    String? ticketImage,
    int? quantity,
    String? id,
  }) {
    return CartTicket(
      ticketId: ticketId ?? this.ticketId,
      movieName: movieName ?? this.movieName,
      showDate: showDate ?? this.showDate,
      showTime: showTime ?? this.showTime,
      ticketCategory: ticketCategory ?? this.ticketCategory,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      noOfTickets: noOfTickets ?? this.noOfTickets,
      pricePerTicket: pricePerTicket ?? this.pricePerTicket,
      subTotal: subTotal ?? this.subTotal,
      ticketImage: ticketImage ?? this.ticketImage,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
    );
  }
}

class AddToCartRequest {
  final String userId;
  final String ticketId;
  final int quantity;
  final List<String> selectedSeats;

  AddToCartRequest({
    required this.userId,
    required this.ticketId,
    required this.quantity,
    required this.selectedSeats,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'ticketId': ticketId,
      'quantity': quantity,
      'selectedSeats': selectedSeats,
    };
  }
}