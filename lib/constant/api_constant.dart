
class ApiConstants {
  // Base URL
  static const String baseUrl = 'http://31.97.206.144:8127';
  static const String register = '$baseUrl/api/auth/register';
  static const String verifyotp='$baseUrl/api/auth/verify-otp';
  static const String login='$baseUrl/api/auth/login';
  static const String ongoingMovies='$baseUrl/api/admin/ongoingmovies';
  static const String notification='$baseUrl/api/auth/mynotification/:userId';
  static const String createMovie='$baseUrl/api/admin/createmovie/:userId';
  static const String getmovienames='$baseUrl/api/admin/allmovienames';
  static const String singleMovieticket='$baseUrl/api/admin/singlemovieticket/:ticketId';
  static const String allmovietickets='$baseUrl/api/admin/allmovieticekts/:userId';
  static const String addtoCart='$baseUrl/api/auth/addtocart';
  static const String getCart='$baseUrl/api/auth/getcart/:userId';
  static const String postedTicktes='$baseUrl/api/auth/mypostedticket/:userId';
  static const String updateProfile='$baseUrl/api/auth/update-profile/:userId';
  static const String forgotPassword='$baseUrl/api/auth/forgot-password';
  static const String resetpassword='$baseUrl/api/auth/reset-password';
  static const String purchasemovieticket='$baseUrl/api/auth/purchasedmovietickets/:userId';
  
  
}