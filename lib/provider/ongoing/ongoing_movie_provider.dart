import 'package:backup_ticket/model/ongoing_movie_model.dart';
import 'package:backup_ticket/services/ongoing_movie_service.dart';
import 'package:flutter/foundation.dart';

enum MovieState { initial, loading, success, error }

class OngoingMoviesProvider extends ChangeNotifier {
  final MovieService _movieService = MovieService();

  MovieState _state = MovieState.initial;
  List<OngoingMovie> _movies = [];
  String _errorMessage = '';

  MovieState get state => _state;
  List<OngoingMovie> get movies => _movies;
  String get errorMessage => _errorMessage;

  Future<void> fetchOngoingMovies() async {
    _state = MovieState.loading;
    notifyListeners();

    try {
      final response = await _movieService.getOngoingMovies();
      _movies = response.movies;
      _state = MovieState.success;
      _errorMessage = '';
    } catch (e) {
      _state = MovieState.error;
      _errorMessage = e.toString();
      _movies = [];
    }

    notifyListeners();
  }

  void resetState() {
    _state = MovieState.initial;
    _movies = [];
    _errorMessage = '';
    notifyListeners();
  }
}