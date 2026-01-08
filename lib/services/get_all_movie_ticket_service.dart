// // import 'dart:convert';
// // import 'package:backup_ticket/constant/api_constant.dart';
// // import 'package:backup_ticket/model/get_all_movie_ticket_model.dart';
// // import 'package:http/http.dart' as http;


// // class MovieTicketService {
// //   // Get single movie ticket
// //   Future<MovieTicket> getSingleMovieTicket(String ticketId) async {
// //     try {
// //       final url = ApiConstants.singleMovieticket.replaceAll(':ticketId', ticketId);
// //       final response = await http.get(
// //         Uri.parse(url),
// //         headers: {
// //           'Content-Type': 'application/json',
// //         },
// //       );

// //       print('response status code for single movie ticket ${response.statusCode}');
// //             print('response bodyyyyyyyyyyyyy for single movie ticket ${response.body}');


// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         return MovieTicket.fromJson(data['ticket']);
// //       } else {
// //         throw Exception('Failed to fetch movie ticket: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Error fetching movie ticket: $e');
// //     }
// //   }

// //   // Get all movie tickets
// //   Future<List<MovieTicket>> getAllMovieTickets() async {
// //     try {
// //       final response = await http.get(
// //         Uri.parse(ApiConstants.allmovietickets),
// //         headers: {
// //           'Content-Type': 'application/json',
// //         },
// //       );

// //          print('response status code for all movies ${response.statusCode}');
// //             print('response bodyyyyyyyyyyyyy for all movies ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         final List<dynamic> ticketsJson = data['tickets'];
// //         return ticketsJson.map((json) => MovieTicket.fromJson(json)).toList();
// //       } else {
// //         throw Exception('Failed to fetch movie tickets: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Error fetching movie tickets: $e');
// //     }
// //   }
// // }














// import 'dart:convert';
// import 'package:backup_ticket/constant/api_constant.dart';
// import 'package:backup_ticket/model/get_all_movie_ticket_model.dart';
// import 'package:http/http.dart' as http;


// class MovieTicketService {
//   // Get single movie ticket
//   Future<MovieTicket> getSingleMovieTicket(String ticketId) async {
//     try {
//       final url = ApiConstants.singleMovieticket.replaceAll(':ticketId', ticketId);
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       print('response status code for single movie ticket ${response.statusCode}');
//       print('response bodyyyyyyyyyyyyy for single movie ticket ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return MovieTicket.fromJson(data['ticket']);
//       } else {
//         throw Exception('Failed to fetch movie ticket: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching movie ticket: $e');
//     }
//   }

//   // Get all movie tickets with userId parameter
//   Future<List<MovieTicket>> getAllMovieTickets(String userId) async {
//     try {
//       // Build URL with query parameter
//       final uri = Uri.parse(ApiConstants.allmovietickets).replace(
//         queryParameters: {'userId': userId},
//       );

//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       print('response status code for all movies ${response.statusCode}');
//       print('response bodyyyyyyyyyyyyy for all movies ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final List<dynamic> ticketsJson = data['tickets'];
//         return ticketsJson.map((json) => MovieTicket.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to fetch movie tickets: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching movie tickets: $e');
//     }
//   }
// }















import 'dart:convert';
import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/model/get_all_movie_ticket_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class MovieTicketService {
  // Get single movie ticket
  Future<MovieTicket> getSingleMovieTicket(String ticketId) async {
    try {
      final url = ApiConstants.singleMovieticket.replaceAll(':ticketId', ticketId);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('response status code for single movie ticket ${response.statusCode}');
      print('response bodyyyyyyyyyyyyy for single movie ticket ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieTicket.fromJson(data['ticket']);
      } else {
        throw Exception('Failed to fetch movie ticket: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching movie ticket: $e');
    }
  }

  // Get all movie tickets with userId
Future<List<MovieTicket>> getAllMovieTickets(
  String movieId,
  DateTime showDate,
) async {
  try {
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(showDate);

    print('Fetching tickets for date: $formattedDate');

    final url =
        '${ApiConstants.allmovietickets}'
        '?movienameId=$movieId'
        '&showDate=$formattedDate';

    print('Final URL: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('response status code for all movies ${response.statusCode}');
    print('response bodyyyyyyyyyyyyy for all movies ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> ticketsJson = data['tickets'] ?? [];
      return ticketsJson
          .map((e) => MovieTicket.fromJson(e))
          .toList();
    } else {
      throw Exception(
        'Failed to fetch movie tickets: ${response.statusCode}',
      );
    }
  } catch (e) {
    throw Exception('Error fetching movie tickets: $e');
  }
}




  
}