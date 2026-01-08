// // lib/services/movie_ticket_service.dart

// import 'dart:convert';
// import 'dart:io';
// import 'package:backup_ticket/constant/api_constant.dart';
// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/model/create_movie_ticket_model.dart';
// import 'package:http/http.dart' as http;

// class MovieTicketService {
//   // Create movie ticket
//   static Future<CreateMovieTicketModel> createMovieTicket({
//     required String userId,
//     required String movieId,
//     required String fullName,
//     required String phoneNumber,
//     required String email,
//     required String movieName,
//     required String language,
//     required String theatrePlace,
//     required DateTime showDate,
//     required String showTime,
//     required String ticketCategory,
//     required int noOfTickets,
//     required List<String> selectedSeats,
//     required int pricePerTicket,
//     required int totalPrice,
//     required String qrCodeLink,
//     required bool termsAndConditionsAccepted,
//     File? ticketImage,
//   }) async {
//     try {
//       final token = await SharedPrefsHelper.getToken();

//       if (token == null) {
//         throw Exception('No authentication token found');
//       }

//       final uri = Uri.parse(
//         ApiConstants.createMovie.replaceAll(':userId', userId),
//       );
//       var request = http.MultipartRequest('POST', uri);

//       // Add headers
//       request.headers['Authorization'] = 'Bearer $token';

//       // Add form fields
//       request.fields['movieId'] = movieId;
//       request.fields['fullName'] = fullName;
//       request.fields['phoneNumber'] = phoneNumber;
//       request.fields['email'] = email;
//       request.fields['MovieName'] = movieName;
//       request.fields['language'] = language;
//       request.fields['theatrePlace'] = theatrePlace;
//       request.fields['showDate'] = showDate.toIso8601String().split('T')[0];
//       request.fields['showTime'] = showTime;
//       request.fields['ticketCategory'] = ticketCategory;
//       request.fields['noOfTickets'] = noOfTickets.toString();
//       request.fields['selectedSeats'] = jsonEncode(selectedSeats);
//       request.fields['pricePerTicket'] = pricePerTicket.toString();
//       request.fields['totalPrice'] = totalPrice.toString();
//       request.fields['qrCodeLink'] = qrCodeLink;
//       request.fields['termsAndConditionsAccepted'] = termsAndConditionsAccepted
//           .toString();

//       // Add ticket image if provided
//       if (ticketImage != null) {
//         request.files.add(
//           await http.MultipartFile.fromPath('ticketImage', ticketImage.path),
//         );
//       }

//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       print('response status code for create movie ${response.statusCode}');
//       print('response bodyyyyyyyyyyyyyy for create movie ${response.body}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final jsonData = jsonDecode(response.body);
//         return CreateMovieTicketModel.fromJson(jsonData['ticket'] ?? jsonData);
//       } else {
//         final errorData = jsonDecode(response.body);
//         throw Exception(
//           errorData['message'] ?? 'Failed to create movie ticket',
//         );
//       }
//     } catch (e) {
//       throw Exception('Error creating movie ticket: $e');
//     }
//   }

//   // Get all movie names
//   static Future<List<MovieName>> getMovieNames() async {
//     try {
//       final token = await SharedPrefsHelper.getToken();

//       if (token == null) {
//         throw Exception('No authentication token found');
//       }

//       final response = await http.get(
//         Uri.parse(ApiConstants.getmovienames),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       print('response status code for get movie name ${response.statusCode}');
//       print('response bodyyyyyyyyyyyyyy for get movie name ${response.body}');

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         final movieNamesResponse = MovieNamesResponse.fromJson(jsonData);
//         return movieNamesResponse.movies;
//       } else {
//         final errorData = jsonDecode(response.body);
//         throw Exception(errorData['message'] ?? 'Failed to fetch movie names');
//       }
//     } catch (e) {
//       throw Exception('Error fetching movie names: $e');
//     }
//   }
// }












import 'dart:convert';
import 'dart:io';

import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/create_movie_ticket_model.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class MovieTicketService {
  // --------------------------------------------------
  // CREATE MOVIE TICKET
  // --------------------------------------------------
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
    required String ticketType,
        File? qrImage,
            required String screen,
  }) async {
    try {
      final token = await SharedPrefsHelper.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final uri = Uri.parse(
        ApiConstants.createMovie.replaceAll(':userId', userId),
      );

      final request = http.MultipartRequest('POST', uri);

      // ---------------- HEADERS ----------------
      request.headers['Authorization'] = 'Bearer $token';

      // ---------------- FIELDS ----------------
      request.fields.addAll({
        'movieId': movieId,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'email': email,
        'MovieName': movieName,
        'language': language,
        'theatrePlace': theatrePlace,
        'showDate': showDate.toIso8601String().split('T')[0],
        'showTime': showTime,
        'ticketCategory': ticketCategory,
        'noOfTickets': noOfTickets.toString(),
        'selectedSeats': jsonEncode(selectedSeats),
        'pricePerTicket': pricePerTicket.toString(),
        'totalPrice': totalPrice.toString(),
        'qrCodeLink': qrCodeLink,
        'termsAndConditionsAccepted':
            termsAndConditionsAccepted.toString(),
             'ticketType': ticketType,
               'screen': screen,

      });

      // ---------------- FILE (FIXED MIME TYPE) ----------------
      if (qrImage != null) {
        final mimeType =
            lookupMimeType(qrImage.path) ?? 'image/jpeg';
        final mimeSplit = mimeType.split('/');

        request.files.add(
          await http.MultipartFile.fromPath(
            'qrCode',
            qrImage.path,
            contentType: MediaType(
              mimeSplit[0],
              mimeSplit[1],
            ),
          ),
        );
      }


            if (ticketImage != null) {
        final mimeType =
            lookupMimeType(ticketImage.path) ?? 'image/jpeg';
        final mimeSplit = mimeType.split('/');

        request.files.add(
          await http.MultipartFile.fromPath(
            'ticketImage',
            ticketImage.path,
            contentType: MediaType(
              mimeSplit[0],
              mimeSplit[1],
            ),
          ),
        );
      }

      // ==================================================
      // 🔍 PRINT COMPLETE PAYLOAD BEFORE SENDING
      // ==================================================
      print('========== CREATE MOVIE TICKET REQUEST ==========');
      print('➡️ URL: ${request.url}');

      print('\n🧾 Headers:');
      request.headers.forEach((k, v) => print('   $k: $v'));

      print('\n📝 Fields:');
      request.fields.forEach((k, v) => print('   $k: $v'));

      if (request.files.isNotEmpty) {
        print('\n📎 Files:');
        for (final file in request.files) {
          print('   fieldName : ${file.field}');
          print('   fileName  : ${file.filename}');
          print('   fileSize  : ${file.length} bytes');
          print('   mimeType  : ${file.contentType}');
        }
      } else {
        print('\n📎 Files: None');
      }

      print('=================================================');

      // ---------------- SEND REQUEST ----------------
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print(
          '✅ response status code for create movie: ${response.statusCode}');
      print('📦 response body for create movie: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        return CreateMovieTicketModel.fromJson(
          jsonData['ticket'] ?? jsonData,
        );
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

  // --------------------------------------------------
  // GET MOVIE NAMES
  // --------------------------------------------------
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

      print(
          '✅ response status code for get movie names: ${response.statusCode}');
      print('📦 response body for get movie names: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final movieNamesResponse =
            MovieNamesResponse.fromJson(jsonData);
        return movieNamesResponse.movies;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
          errorData['message'] ?? 'Failed to fetch movie names',
        );
      }
    } catch (e) {
      throw Exception('Error fetching movie names: $e');
    }
  }
}