import 'package:flutter/material.dart';
import '../../model/movie_poster_model.dart';
import '../../services/movie_poster_service.dart';

enum MoviePosterState { idle, loading, success, error }

class MoviePosterProvider extends ChangeNotifier {
  final MoviePosterService _service = MoviePosterService();

  MoviePosterState state = MoviePosterState.idle;
  List<MoviePoster> posters = [];
  String? error;

  Future<void> fetchMoviePosters() async {
    state = MoviePosterState.loading;
    notifyListeners();

    try {
      posters = await _service.fetchMoviePosters();
      state = MoviePosterState.success;
    } catch (e) {
      error = e.toString();
      state = MoviePosterState.error;
    }

    notifyListeners();
  }
}
