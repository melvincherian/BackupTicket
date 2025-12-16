// lib/services/movie_ticket_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/create_movie_ticket_model.dart';
import 'package:http/http.dart' as http;

class MovieTicketService {
  // Create movie ticket
  static Future<CreateMovieTicketModel> createMovieTicket({
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
  }) async {
    try {
      final token = await SharedPrefsHelper.getToken();

      if (token == null) {
        throw Exception('No authentication token found');
      }

      final uri = Uri.parse(
        ApiConstants.createMovie.replaceAll(':userId', userId),
      );
      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add form fields
      request.fields['movieId'] = movieId;
      request.fields['fullName'] = fullName;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['email'] = email;
      request.fields['MovieName'] = movieName;
      request.fields['language'] = language;
      request.fields['theatrePlace'] = theatrePlace;
      request.fields['showDate'] = showDate.toIso8601String().split('T')[0];
      request.fields['showTime'] = showTime;
      request.fields['ticketCategory'] = ticketCategory;
      request.fields['noOfTickets'] = noOfTickets.toString();
      request.fields['selectedSeats'] = jsonEncode(selectedSeats);
      request.fields['pricePerTicket'] = pricePerTicket.toString();
      request.fields['totalPrice'] = totalPrice.toString();
      request.fields['qrCodeLink'] = qrCodeLink;
      request.fields['termsAndConditionsAccepted'] = termsAndConditionsAccepted
          .toString();

      // Add ticket image if provided
      if (ticketImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('ticketImage', ticketImage.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('response status code for create movie ${response.statusCode}');
      print('response bodyyyyyyyyyyyyyy for create movie ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        return CreateMovieTicketModel.fromJson(jsonData['ticket'] ?? jsonData);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
          errorData['message'] ?? 'Failed to create movie ticket',
        );
      }
    } catch (e) {
      throw Exception('Error creating movie ticket: $e');
    }
  }

  // Get all movie names
  static Future<List<MovieName>> getMovieNames() async {
    try {
      final token = await SharedPrefsHelper.getToken();

      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse(ApiConstants.getmovienames),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('response status code for get movie name ${response.statusCode}');
      print('response bodyyyyyyyyyyyyyy for get movie name ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final movieNamesResponse = MovieNamesResponse.fromJson(jsonData);
        return movieNamesResponse.movies;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to fetch movie names');
      }
    } catch (e) {
      throw Exception('Error fetching movie names: $e');
    }
  }
}
