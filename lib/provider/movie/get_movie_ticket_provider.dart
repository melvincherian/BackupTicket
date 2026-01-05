// import 'package:backup_ticket/model/get_all_movie_ticket_model.dart';
// import 'package:flutter/material.dart';
// import '../../services/get_all_movie_ticket_service.dart';


// class GetMovieTicketProvider extends ChangeNotifier {
//   final MovieTicketService _service = MovieTicketService();

//   // Single ticket state
//   MovieTicket? _singleTicket;
//   bool _isLoadingSingle = false;
//   String? _singleTicketError;

//   // All tickets state
//   List<MovieTicket> _allTickets = [];
//   bool _isLoadingAll = false;
//   String? _allTicketsError;

//   // Getters
//   MovieTicket? get singleTicket => _singleTicket;
//   bool get isLoadingSingle => _isLoadingSingle;
//   String? get singleTicketError => _singleTicketError;

//   List<MovieTicket> get allTickets => _allTickets;
//   bool get isLoadingAll => _isLoadingAll;
//   String? get allTicketsError => _allTicketsError;

//   // Fetch single movie ticket
//   Future<void> fetchSingleMovieTicket(String ticketId) async {
//     _isLoadingSingle = true;
//     _singleTicketError = null;
//     notifyListeners();

//     try {
//       _singleTicket = await _service.getSingleMovieTicket(ticketId);
//       _isLoadingSingle = false;
//       notifyListeners();
//     } catch (e) {
//       _singleTicketError = e.toString();
//       _isLoadingSingle = false;
//       notifyListeners();
//     }
//   }

//   // Fetch all movie tickets
//   Future<void> fetchAllMovieTickets() async {
//     _isLoadingAll = true;
//     _allTicketsError = null;
//     notifyListeners();

//     try {
//       _allTickets = await _service.getAllMovieTickets();
//       _isLoadingAll = false;
//       notifyListeners();
//     } catch (e) {
//       _allTicketsError = e.toString();
//       _isLoadingAll = false;
//       notifyListeners();
//     }
//   }

//   // Clear single ticket
//   void clearSingleTicket() {
//     _singleTicket = null;
//     _singleTicketError = null;
//     notifyListeners();
//   }

//   // Clear all tickets
//   void clearAllTickets() {
//     _allTickets = [];
//     _allTicketsError = null;
//     notifyListeners();
//   }
// }














import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/get_all_movie_ticket_model.dart';
import 'package:flutter/material.dart';
import '../../services/get_all_movie_ticket_service.dart';


class GetMovieTicketProvider extends ChangeNotifier {
  final MovieTicketService _service = MovieTicketService();

  // Single ticket state
  MovieTicket? _singleTicket;
  bool _isLoadingSingle = false;
  String? _singleTicketError;

  // All tickets state
  List<MovieTicket> _allTickets = [];
  bool _isLoadingAll = false;
  String? _allTicketsError;

  // Getters
  MovieTicket? get singleTicket => _singleTicket;
  bool get isLoadingSingle => _isLoadingSingle;
  String? get singleTicketError => _singleTicketError;

  List<MovieTicket> get allTickets => _allTickets;
  bool get isLoadingAll => _isLoadingAll;
  String? get allTicketsError => _allTicketsError;

  // Fetch single movie ticket
  Future<void> fetchSingleMovieTicket(String ticketId) async {
    _isLoadingSingle = true;
    _singleTicketError = null;
    notifyListeners();

    try {
      _singleTicket = await _service.getSingleMovieTicket(ticketId);
      _isLoadingSingle = false;
      notifyListeners();
    } catch (e) {
      _singleTicketError = e.toString();
      _isLoadingSingle = false;
      notifyListeners();
    }
  }

  // Fetch all movie tickets with userId
  Future<void> fetchAllMovieTickets() async {
    _isLoadingAll = true;
    _allTicketsError = null;
    notifyListeners();

    try {
      // Get userId from SharedPreferences
      final user = await SharedPrefsHelper.getUser();
      
      if (user == null || user.id.isEmpty) {
        throw Exception('User not found. Please login again.');
      }

      _allTickets = await _service.getAllMovieTickets(user.id);
      _isLoadingAll = false;
      notifyListeners();
    } catch (e) {
      _allTicketsError = e.toString();
      _isLoadingAll = false;
      notifyListeners();
    }
  }

  // Alternative: Fetch all movie tickets with explicit userId parameter
  Future<void> fetchAllMovieTicketsWithUserId(String userId) async {
    _isLoadingAll = true;
    _allTicketsError = null;
    notifyListeners();

    try {
      _allTickets = await _service.getAllMovieTickets(userId);
      _isLoadingAll = false;
      notifyListeners();
    } catch (e) {
      _allTicketsError = e.toString();
      _isLoadingAll = false;
      notifyListeners();
    }
  }

  // Clear single ticket
  void clearSingleTicket() {
    _singleTicket = null;
    _singleTicketError = null;
    notifyListeners();
  }

  // Clear all tickets
  void clearAllTickets() {
    _allTickets = [];
    _allTicketsError = null;
    notifyListeners();
  }
}