import 'package:backup_ticket/services/purchase_ticket_service.dart';
import 'package:flutter/material.dart';


class TicketProvider with ChangeNotifier {
  final TicketService _ticketService = TicketService();

  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Get all purchased tickets
  Future<void> fetchPurchasedTickets() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _ticketService.getPurchasedTickets();
      _orders = response.orders;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _orders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get orders by status
  List<OrderModel> getOrdersByStatus(String status) {
    return _orders.where((order) => order.orderStatus == status).toList();
  }

  // Get completed orders
  List<OrderModel> get completedOrders => getOrdersByStatus('completed');

  // Get pending orders
  List<OrderModel> get pendingOrders => getOrdersByStatus('pending');

  // Get total number of tickets
  int get totalTickets {
    int total = 0;
    for (var order in _orders) {
      for (var ticket in order.tickets) {
        total += ticket.selectedSeats.length;
      }
    }
    return total;
  }

  // Get total amount spent
  int get totalAmountSpent {
    return _orders.fold(0, (sum, order) => sum + order.totalAmount);
  }

  // Clear orders (useful for logout)
  void clearOrders() {
    _orders = [];
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  // Refresh tickets
  Future<void> refreshTickets() async {
    await fetchPurchasedTickets();
  }
}