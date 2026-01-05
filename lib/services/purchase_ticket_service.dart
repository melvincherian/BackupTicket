import 'dart:convert';

import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:http/http.dart' as http;

class PurchasedTicketResponse {
  final bool success;
  final String message;
  final List<OrderModel> orders;

  PurchasedTicketResponse({
    required this.success,
    required this.message,
    required this.orders,
  });

  factory PurchasedTicketResponse.fromJson(Map<String, dynamic> json) {
    return PurchasedTicketResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      orders:
          (json['orders'] as List<dynamic>?)
              ?.map((order) => OrderModel.fromJson(order))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }
}

class OrderModel {
  final String orderId;
  final String transactionId;
  final int totalAmount;
  final String paymentStatus;
  final String razorpayStatus;
  final String orderStatus;
  final DateTime createdAt;
  final List<TicketModel> tickets;

  OrderModel({
    required this.orderId,
    required this.transactionId,
    required this.totalAmount,
    required this.paymentStatus,
    required this.razorpayStatus,
    required this.orderStatus,
    required this.createdAt,
    required this.tickets,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] ?? '',
      transactionId: json['transactionId'] ?? '',
      totalAmount: json['totalAmount'] ?? 0,
      paymentStatus: json['paymentStatus'] ?? '',
      razorpayStatus: json['razorpayStatus'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      tickets:
          (json['tickets'] as List<dynamic>?)
              ?.map((ticket) => TicketModel.fromJson(ticket))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'transactionId': transactionId,
      'totalAmount': totalAmount,
      'paymentStatus': paymentStatus,
      'razorpayStatus': razorpayStatus,
      'orderStatus': orderStatus,
      'createdAt': createdAt.toIso8601String(),
      'tickets': tickets.map((ticket) => ticket.toJson()).toList(),
    };
  }
}

class TicketModel {
  final String ticketId;
  final String movieName;
  final DateTime showDate;
  final String showTime;
  final String ticketCategory;
  final List<String> selectedSeats;
  final int pricePerTicket;
  final String ticketImage;
  final int quantity;
  final String id;

  TicketModel({
    required this.ticketId,
    required this.movieName,
    required this.showDate,
    required this.showTime,
    required this.ticketCategory,
    required this.selectedSeats,
    required this.pricePerTicket,
    required this.ticketImage,
    required this.quantity,
    required this.id,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketId: json['ticketId'] ?? '',
      movieName: json['MovieName'] ?? '',
      showDate: DateTime.parse(json['showDate']),
      showTime: json['showTime'] ?? '',
      ticketCategory: json['ticketCategory'] ?? '',
      selectedSeats:
          (json['selectedSeats'] as List<dynamic>?)
              ?.map((seat) => seat.toString())
              .toList() ??
          [],
      pricePerTicket: json['pricePerTicket'] ?? 0,
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
      'pricePerTicket': pricePerTicket,
      'ticketImage': ticketImage,
      'quantity': quantity,
      '_id': id,
    };
  }

  // Helper method to get full image URL
  String get fullImageUrl {
    if (ticketImage.startsWith('http')) {
      return ticketImage;
    }
    return '${ApiConstants.baseUrl}$ticketImage';
  }
}

// lib/services/ticket_service.dart

class TicketService {
  Future<PurchasedTicketResponse> getPurchasedTickets() async {
    try {
      // Get user data to extract userId
      final user = await SharedPrefsHelper.getUser();
      if (user == null) {
        throw Exception('User not found. Please login again.');
      }

      // Get token for authentication
      final token = await SharedPrefsHelper.getToken();
      if (token == null) {
        throw Exception('Authentication token not found. Please login again.');
      }

      // Build the URL with userId
      final url = ApiConstants.purchasemovieticket.replaceAll(
        ':userId',
        user.id,
      );

      // Make the API call
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status code for purchased ticket ${response.statusCode}');
      print(
        'Response bodyyyyyyyyyyy code for purchased ticket ${response.body}',
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return PurchasedTicketResponse.fromJson(jsonResponse);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else if (response.statusCode == 404) {
        throw Exception('No purchased tickets found.');
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ??
            'Failed to fetch purchased tickets';
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
