
// import 'package:backup_ticket/model/ongoing_movie_model.dart';
// import 'package:backup_ticket/services/ongoing_movie_service.dart';
// import 'package:flutter/foundation.dart';

// enum MovieState { initial, loading, success, error }

// class OngoingMoviesProvider extends ChangeNotifier {
//   final MovieService _movieService = MovieService();

//   MovieState _state = MovieState.initial;
//   List<OngoingMovie> _movies = [];
//   String _errorMessage = '';

//   MovieState get state => _state;
//   List<OngoingMovie> get movies => _movies;
//   String get errorMessage => _errorMessage;

//   Future<void> fetchOngoingMovies() async {
//     _state = MovieState.loading;
//     notifyListeners();

//     try {
//       final response = await _movieService.getOngoingMovies();
//       _movies = response.movies;
//       _state = MovieState.success;
//       _errorMessage = '';
//     } catch (e) {
//       _state = MovieState.error;
//       _errorMessage = e.toString();
//       _movies = [];
//     }

//     notifyListeners();
//   }

//   void resetState() {
//     _state = MovieState.initial;
//     _movies = [];
//     _errorMessage = '';
//     notifyListeners();
//   }
// }



















import 'package:flutter/foundation.dart';
import 'package:backup_ticket/model/ongoing_movie_model.dart';
import 'package:backup_ticket/services/ongoing_movie_service.dart';

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
      final now = DateTime.now();

      _movies = response.movies.where((movie) {
        try {
          /// 1️⃣ showDate is already DateTime (UTC)
          final localShowDate = movie.showDate.toLocal();

          /// 2️⃣ Extract hour & minute from showTime (HH:mm)
          final timeParts = movie.showTime.split(':');
          final hour = int.parse(timeParts[0]);
          final minute = int.parse(timeParts[1]);

          /// 3️⃣ Combine date + time
          final showDateTime = DateTime(
            localShowDate.year,
            localShowDate.month,
            localShowDate.day,
            hour,
            minute,
          );

          /// 4️⃣ Keep only upcoming shows
          return showDateTime.isAfter(now);
        } catch (e) {
          debugPrint('Date filter error: $e');
          return false;
        }
      }).toList();

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
