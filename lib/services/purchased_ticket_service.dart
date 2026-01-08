import 'dart:convert';
import 'package:backup_ticket/model/purchased_ticket_models.dart';
import 'package:http/http.dart' as http;

class PurchasedTicketService {
  static const _baseUrl = 'http://31.97.206.144:8127';

  Future<List<PurchasedOrder>> fetchPurchasedTickets(String userId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/auth/purchasedmovietickets/$userId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load purchased tickets');
    }

    final body = json.decode(response.body);

    if (body['success'] != true) {
      throw Exception(body['message'] ?? 'Something went wrong');
    }

    return (body['orders'] as List)
        .map((e) => PurchasedOrder.fromJson(e))
        .toList();
  }
}
