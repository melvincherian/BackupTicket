// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/views/navbar/navbar_screen.dart';
// import 'package:backup_ticket/views/splash/movie_ticket_screen.dart';
// import 'package:flutter/material.dart';
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _scaleController;
//   late AnimationController _fadeController;
//   late AnimationController _slideController;
  
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
    
//     // Initialize animation controllers
//     _scaleController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
    
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
    
//     _slideController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );

//     // Create animations
//     _scaleAnimation = Tween<double>(
//       begin: 0.5,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _scaleController,
//       curve: Curves.elasticOut,
//     ));

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     ));

//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _slideController,
//       curve: Curves.easeOutCubic,
//     ));

//     // Start animations with delays
//     _startAnimations();
//   }

//   void _startAnimations() async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     _scaleController.forward();
    
//     await Future.delayed(const Duration(milliseconds: 200));
//     _fadeController.forward();
    
//     await Future.delayed(const Duration(milliseconds: 100));
//     _slideController.forward();
    
//     // Wait for animations to complete
//     await Future.delayed(const Duration(milliseconds: 2000));
    
//     // Check login status and navigate accordingly
//     if (mounted) {
//       await _checkLoginAndNavigate();
//     }
//   }

//   Future<void> _checkLoginAndNavigate() async {
//     try {
//       final isLoggedIn = await UserPreferences.isLoggedIn();
      
//       if (mounted) {
//         if (isLoggedIn) {
//           // User is logged in, navigate to navbar screen
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//               builder: (context) => const NavbarScreen(), // Replace with your actual navbar screen
//             ),
//           );
//         } else {
//           // User is not logged in, navigate to movie ticket screen
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//               builder: (context) => const MovieTicketsScreen(),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       // Handle any errors by navigating to movie ticket screen as fallback
//       if (mounted) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => const MovieTicketsScreen(),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _scaleController.dispose();
//     _fadeController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF2E5BFF), // Bright blue
//               Color(0xFF1E3A8A), // Darker blue
//             ],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Animated Logo Container
//               AnimatedBuilder(
//                 animation: _scaleAnimation,
//                 builder: (context, child) {
//                   return Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: ClipOval(
//                         child: Image.asset(
//                           'assets/splash.png', // Replace with your asset path
//                           width: 120,
//                           height: 120,
//                           fit: BoxFit.contain,
//                           errorBuilder: (context, error, stackTrace) {
//                             // Fallback if image fails to load
//                             return const Icon(
//                               Icons.delivery_dining,
//                               size: 60,
//                               color: Color(0xFF2E5BFF),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
              
//               const SizedBox(height: 40),
              
//               // You can add animated app name here if needed
              
//               const SizedBox(height: 60),
              
//               // Animated Loading Indicator
//               FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: SizedBox(
//                   width: 40,
//                   height: 40,
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       Colors.white.withOpacity(0.8),
//                     ),
//                     strokeWidth: 3,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


















import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/views/auth/login_screen.dart';
import 'package:backup_ticket/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Create animations
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations with delays
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _scaleController.forward();

    await Future.delayed(const Duration(milliseconds: 200));
    _fadeController.forward();

    await Future.delayed(const Duration(milliseconds: 100));
    _slideController.forward();

    // Wait for animations to complete
    await Future.delayed(const Duration(milliseconds: 2000));

    // Check login status and navigate accordingly
    if (mounted) {
      await _checkLoginAndNavigate();
    }
  }

  Future<void> _checkLoginAndNavigate() async {
    try {
      final isLoggedIn = await UserPreferences.isLoggedIn();

      if (mounted) {
        if (isLoggedIn) {
          // User is logged in, navigate to navbar screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const NavbarScreen(),
            ),
          );
        } else {
          // User is not logged in, navigate to onboarding screens
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const OnboardingScreen(),
            ),
          );
        }
      }
    } catch (e) {
      // Handle any errors by navigating to onboarding screen as fallback
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E5BFF),
              Color(0xFF1E3A8A),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Logo Container
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/splash.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.delivery_dining,
                              size: 60,
                              color: Color(0xFF2E5BFF),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 60),
              // Animated Loading Indicator
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.8),
                    ),
                    strokeWidth: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Onboarding Screen with PageView
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      image: 'assets/firstscreen.png',
      title: 'Movie Tickets',
      mainText: 'Buy ',
      highlightText: 'Unused\nTickets ',
      endText: 'Easily',
      description: 'Explore last-minute deals from\nreal users in your city.',
    ),
    OnboardingData(
      image: 'assets/bus.png',
      title: 'Bus Ticket',
      mainText: 'Sell Your  ',
      highlightText: 'Extra\nTickets ',
      endText: '',
      description: 'Sell your unused tickets and earn\nback your money in minutes',
    ),
    OnboardingData(
      image: 'assets/train.png',
      title: 'Train Ticket',
      mainText: '',
      highlightText: 'Safe&Quick\n',
      endText: 'Transactions ',
      description: 'Secure & Verified ticket exchange',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  void _skipToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skipToLogin,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Color(0xFF2E5BFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(data: _pages[index]);
                },
              ),
            ),

            // Page indicators and next button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page indicators
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color(0xFF2E5BFF)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  // Next button
                  GestureDetector(
                    onTap: _nextPage,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4F75FF), Color(0xFF2E5BFF)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2E5BFF).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        _currentPage == _pages.length - 1
                            ? Icons.check
                            : Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Onboarding page widget
class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        // Main content area with background
        Expanded(
          flex: 3,
          child: Container(
            width: 400,
            height: 360,
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/movie.png'),
                          fit: BoxFit.contain,
                          alignment: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(200, 100),
                          bottomRight: Radius.elliptical(200, 100),
                        ),
                      ),
                    ),
                  ),
                ),

                // Content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        child: Image.asset(
                          data.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Title
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            data.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        // Bottom section
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 32, height: 1.2),
                    children: [
                      if (data.mainText.isNotEmpty)
                        TextSpan(
                          text: data.mainText,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      TextSpan(
                        text: data.highlightText,
                        style: const TextStyle(
                          color: Color(0xFF214194),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (data.endText.isNotEmpty)
                        TextSpan(
                          text: data.endText,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  data.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Data model for onboarding pages
class OnboardingData {
  final String image;
  final String title;
  final String mainText;
  final String highlightText;
  final String endText;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.mainText,
    required this.highlightText,
    required this.endText,
    required this.description,
  });
}