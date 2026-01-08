// lib/providers/movie_ticket_provider.dart

import 'dart:io';
import 'package:backup_ticket/model/create_movie_ticket_model.dart';
import 'package:backup_ticket/services/create_movie_service.dart';
import 'package:flutter/material.dart';

class MovieTicketProviderapi extends ChangeNotifier {
  List<MovieName> _movieNames = [];
  CreateMovieTicketModel? _createdTicket;

  bool _isLoading = false;
  bool _isCreating = false;
  String? _errorMessage;

  List<MovieName> get movieNames => _movieNames;
  CreateMovieTicketModel? get createdTicket => _createdTicket;
  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  String? get errorMessage => _errorMessage;

  // Create movie ticket
  Future<bool> createMovieTicket({
    required String userId,
    required String movieId,
    required String fullName,
    required String phoneNumber,
    required String email,
    required String movieName,
    required String language,
    required String theatrePlace,
    required DateTime showDate,
    required String showTime,
    required String ticketCategory,
    required int noOfTickets,
    required List<String> selectedSeats,
    required int pricePerTicket,
    required int totalPrice,
    required String qrCodeLink,
    required bool termsAndConditionsAccepted,
    File? ticketImage,
        File? qrImage,
            required String screen,

    required String ticketType


  }) async {
    _isCreating = true;
    _errorMessage = null;
    notifyListeners();

    try {

      print('bhgbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');

            print('imaaaaaaaaaaaaaaaaaaaaaaaaaaaaageeeeeeeeeeeeeeeeeeeeeeeeeem$ticketImage');

      _createdTicket = await MovieTicketService.createMovieTicket(
        userId: userId,
        movieId: movieId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        movieName: movieName,
        language: language,
        theatrePlace: theatrePlace,
        showDate: showDate,
        showTime: showTime,
        ticketCategory: ticketCategory,
        noOfTickets: noOfTickets,
        selectedSeats: selectedSeats,
        pricePerTicket: pricePerTicket,
        totalPrice: totalPrice,
        qrCodeLink: qrCodeLink,
        termsAndConditionsAccepted: termsAndConditionsAccepted,
        ticketImage: ticketImage,
        screen: screen,
        ticketType: ticketType,
        qrImage: qrImage,
      );



      _isCreating = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isCreating = false;
      notifyListeners();
      return false;
    }
  }

  // Get all movie names
  Future<bool> fetchMovieNames() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _movieNames = await MovieTicketService.getMovieNames();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Clear created ticket
  void clearCreatedTicket() {
    _createdTicket = null;
    notifyListeners();
  }

  // Reset provider
  void reset() {
    _movieNames = [];
    _createdTicket = null;
    _isLoading = false;
    _isCreating = false;
    _errorMessage = null;
    notifyListeners();
  }
}
