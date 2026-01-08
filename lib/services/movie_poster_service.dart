import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_poster_model.dart';

class MoviePosterService {
  static const String _baseUrl = "http://31.97.206.144:8127";

  Future<List<MoviePoster>> fetchMoviePosters() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/api/admin/allmovienames"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['movies'];

      return list.map((e) => MoviePoster.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load movie posters");
    }
  }
}
