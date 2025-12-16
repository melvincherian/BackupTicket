
class ApiConstants {
  // Base URL
  static const String baseUrl = 'http://31.97.206.144:8127';
  
  // Auth Endpoints
  static const String register = '$baseUrl/api/auth/register';
  static const String verifyotp='$baseUrl/api/auth/verify-otp';
  static const String login='$baseUrl/api/auth/login';
  static const String ongoingMovies='$baseUrl/api/admin/ongoingmovies';
  static const String notification='$baseUrl/api/auth/mynotification/:userId';
  static const String createMovie='$baseUrl/api/admin/createmovie/:userId';
  static const String getmovienames='$baseUrl/api/admin/allmovienames';

}