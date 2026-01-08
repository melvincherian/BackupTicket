import 'package:backup_ticket/model/purchased_ticket_models.dart';
import 'package:backup_ticket/services/purchased_ticket_service.dart';
import 'package:flutter/material.dart';


class PurchasedTicketProvider extends ChangeNotifier {
  final PurchasedTicketService _service = PurchasedTicketService();

  bool isLoading = false;
  String? errorMessage;
  List<PurchasedOrder> orders = [];

  Future<void> fetchPurchasedTickets(String userId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      orders = await _service.fetchPurchasedTickets(userId);
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh(String userId) async {
    await fetchPurchasedTickets(userId);
  }
}
