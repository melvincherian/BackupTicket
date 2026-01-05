import 'package:backup_ticket/model/cart_model.dart';
import 'package:backup_ticket/services/cart_service.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final CartService _cartService = CartService();

  CartModel? _cart;
  bool _isLoading = false;
  String _errorMessage = '';

  CartModel? get cart => _cart;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get cartItemCount => _cart?.tickets.length ?? 0;
  double get cartTotal => _cart?.cartTotal ?? 0.0;

  // Add ticket to cart
  Future<bool> addToCart({
    required String userId,
    required String ticketId,
    required int quantity,
    required List<String> selectedSeats,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final request = AddToCartRequest(
      userId: userId,
      ticketId: ticketId,
      quantity: quantity,
      selectedSeats: selectedSeats,
    );

    final result = await _cartService.addToCart(request);

    _isLoading = false;

    if (result['success']) {
      // Refresh cart after adding
      await fetchCart(userId);
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  // Fetch cart
  Future<void> fetchCart(String userId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final result = await _cartService.getCart(userId);

    _isLoading = false;

    if (result['success']) {
      _cart = result['cart'];
    } else {
      _errorMessage = result['message'];
      _cart = null;
    }

    notifyListeners();
  }

  // Clear cart (local only)
  void clearCart() {
    _cart = null;
    _errorMessage = '';
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Get specific ticket from cart
  CartTicket? getTicketById(String ticketId) {
    if (_cart == null) return null;
    try {
      return _cart!.tickets.firstWhere((ticket) => ticket.ticketId == ticketId);
    } catch (e) {
      return null;
    }
  }

  // Check if ticket is in cart
  bool isTicketInCart(String ticketId) {
    if (_cart == null) return false;
    return _cart!.tickets.any((ticket) => ticket.ticketId == ticketId);
  }
}