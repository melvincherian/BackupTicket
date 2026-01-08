// import 'dart:convert';
// import 'package:backup_ticket/constant/api_constant.dart';
// import 'package:backup_ticket/model/ongoing_movie_model.dart';
// import 'package:http/http.dart' as http;

// class MovieService {
//   Future<OngoingMoviesResponse> getOngoingMovies() async {
//     try {
//       final response = await http.get(
//         Uri.parse(ApiConstants.ongoingMovies),
//         headers: {
//           'Content-Type': 'application/json',
//           // Add authorization header if needed
//           // 'Authorization': 'Bearer $token',
//         },
//       );

//       print('response status code for ongoing movies ${response.statusCode}');
//       print('response  bodyyyyyyyyy for ongoing movies ${response.body}');

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         return OngoingMoviesResponse.fromJson(jsonData);
//       } else {
//         throw Exception(
//           'Failed to load ongoing movies: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       throw Exception('Error fetching ongoing movies: $e');
//     }
//   }
// }














import 'dart:convert';
import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/model/ongoing_movie_model.dart';
import 'package:http/http.dart' as http;

class MovieService {
  Future<OngoingMoviesResponse> getOngoingMovies() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.ongoingMovies),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(
          'response status code for ongoing movies ${response.statusCode}');
      print('response body for ongoing movies ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return OngoingMoviesResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load ongoing movies: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching ongoing movies: $e');
    }
  }
}
