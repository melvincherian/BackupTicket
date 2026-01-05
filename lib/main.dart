import 'package:backup_ticket/provider/auth/auth_provider.dart';
import 'package:backup_ticket/provider/auth/login_provider.dart';
import 'package:backup_ticket/provider/auth/otp_provider.dart';
import 'package:backup_ticket/provider/auth/register_provider.dart';
import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
import 'package:backup_ticket/provider/cart/cart_provider.dart';
import 'package:backup_ticket/provider/forgot/forgot_password_provider.dart';
import 'package:backup_ticket/provider/movie/get_movie_ticket_provider.dart';
import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
import 'package:backup_ticket/provider/movie/movie_ticket_provider.dart';
import 'package:backup_ticket/provider/navbar/navbar_provider.dart';
import 'package:backup_ticket/provider/ongoing/ongoing_movie_provider.dart';
import 'package:backup_ticket/provider/profile/profile_provider.dart';
import 'package:backup_ticket/provider/purchaseticket/purchase_ticket_provider.dart';
import 'package:backup_ticket/provider/selltickets/sell_bus_ticket_provider.dart';
import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
import 'package:backup_ticket/views/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => OtpProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => MovieTicketProvider()),
        ChangeNotifierProvider(create: (context) => UserProfileProvider()),
        ChangeNotifierProvider(create: (context) => BusTicketProvider()),
        ChangeNotifierProvider(create: (context) => MovieCategoryProvider()),
        ChangeNotifierProvider(create: (context) => OngoingMoviesProvider()),
        ChangeNotifierProvider(create: (context) => MovieTicketProviderapi()),
        ChangeNotifierProvider(create: (context) => GetMovieTicketProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => PasswordProvider()),
        ChangeNotifierProvider(create: (context) => TicketProvider()),
      ],
      child: MaterialApp(
        title: 'Backup Ticket',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
