// import 'package:backup_ticket/views/notifications/notification_screen.dart';
// import 'package:flutter/material.dart';

// class TrainScreen extends StatelessWidget {
//   const TrainScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(90),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           flexibleSpace: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(25),
//               bottomRight: Radius.circular(25),
//             ),
//             child: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//               child: SafeArea(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Left side (location)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: const [
//                             Icon(Icons.send, color: Colors.white, size: 18),
//                             SizedBox(width: 5),
//                             Text(
//                               "Hyderabad, Telangana..",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Icon(
//                               Icons.keyboard_arrow_down,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 2),
//                         const Text(
//                           "       Hyderabad, Telangana, India",
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       ],
//                     ),

//                     // Right side (notification)
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 4,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
//                         },
//                         child: const Icon(
//                           Icons.notifications_none,
//                           color: Colors.black87,
//                           size: 22,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Center(
//         child: Text('Coming Soon',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
//       ),
//     );
//   }
// }

// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/views/notifications/notification_screen.dart';
// import 'package:flutter/material.dart';

// class TrainScreen extends StatefulWidget {
//   const TrainScreen({super.key});

//   @override
//   State<TrainScreen> createState() => _TrainScreenState();
// }

// class _TrainScreenState extends State<TrainScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _trainAnimation;
//   late Animation<double> _fadeAnimation;

//   String _userName = "Guest";

//   @override
//   void initState() {
//     _loadUserName();

//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat();

//     _trainAnimation = Tween<double>(
//       begin: -0.3,
//       end: 1.3,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

//     _fadeAnimation = Tween<double>(
//       begin: 0.5,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _loadUserName() async {
//     final name = await UserPreferences.getName();
//     if (mounted && name != null && name.isNotEmpty) {
//       setState(() {
//         _userName = name;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(90),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           flexibleSpace: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(25),
//               bottomRight: Radius.circular(25),
//             ),
//             child: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//               child: SafeArea(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Row(
//                         //   children: const [
//                         //     Icon(Icons.send, color: Colors.white, size: 18),
//                         //     SizedBox(width: 5),
//                         //     Text(
//                         //       "Hyderabad, Telangana..",
//                         //       style: TextStyle(
//                         //         color: Colors.white,
//                         //         fontSize: 16,
//                         //         fontWeight: FontWeight.w600,
//                         //       ),
//                         //     ),
//                         //     Icon(
//                         //       Icons.keyboard_arrow_down,
//                         //       color: Colors.white,
//                         //       size: 20,
//                         //     ),
//                         //   ],
//                         // ),
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.person,
//                               color: Colors.white,
//                               size: 18,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               "Hello, $_userName",
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),

//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 4,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => NotificationScreen(),
//                             ),
//                           );
//                         },
//                         child: const Icon(
//                           Icons.notifications_none,
//                           color: Colors.black87,
//                           size: 22,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue.shade50, Colors.white],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Train Animation
//               SizedBox(
//                 height: 120,
//                 child: Stack(
//                   children: [
//                     // Train tracks
//                     Positioned(
//                       bottom: 20,
//                       left: 0,
//                       right: 0,
//                       child: CustomPaint(
//                         size: Size(MediaQuery.of(context).size.width, 4),
//                         painter: TrackPainter(),
//                       ),
//                     ),
//                     // Animated train
//                     AnimatedBuilder(
//                       animation: _trainAnimation,
//                       builder: (context, child) {
//                         return Positioned(
//                           left:
//                               MediaQuery.of(context).size.width *
//                               _trainAnimation.value,
//                           bottom: 20,
//                           child: FadeTransition(
//                             opacity: _fadeAnimation,
//                             child: Icon(
//                               Icons.train,
//                               size: 60,
//                               color: Color(0xFF1976D2),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 40),
//               // Coming Soon Badge
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 8,
//                 ),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text(
//                   'COMING SOON',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const SizedBox(height: 12),

//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TrackPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.grey.shade400
//       ..strokeWidth = 3
//       ..style = PaintingStyle.stroke;

//     // Draw two parallel lines for tracks
//     canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);
//     canvas.drawLine(Offset(0, 8), Offset(size.width, 8), paint);

//     // Draw sleepers (ties)
//     for (double i = 0; i < size.width; i += 30) {
//       canvas.drawLine(Offset(i, -4), Offset(i, 12), paint..strokeWidth = 2);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
// import 'package:backup_ticket/views/notifications/notification_screen.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// import 'package:provider/provider.dart';

// class TrainScreen extends StatefulWidget {
//   const TrainScreen({super.key});

//   @override
//   State<TrainScreen> createState() => _TrainScreenState();
// }

// class _TrainScreenState extends State<TrainScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _trainController;
//   late AnimationController _particleController;
//   late AnimationController _pulseController;

//   late Animation<double> _trainAnimation;
//   late Animation<double> _particleAnimation;
//   late Animation<double> _pulseAnimation;

//   String _userName = "Guest";

//   @override
//   void initState() {
//     super.initState();
//     _loadUserName();

//     // Train movement animation
//     _trainController = AnimationController(
//       duration: const Duration(milliseconds: 2500),
//       vsync: this,
//     )..repeat();

//     _trainAnimation = Tween<double>(begin: -0.2, end: 1.2).animate(
//       CurvedAnimation(parent: _trainController, curve: Curves.easeInOutCubic),
//     );

//     // Particle/speed lines animation
//     _particleController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat();

//     _particleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(_particleController);

//     // Pulse animation for badge
//     _pulseController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     )..repeat(reverse: true);

//     _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _trainController.dispose();
//     _particleController.dispose();
//     _pulseController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadUserName() async {
//     final name = await UserPreferences.getName();
//     if (mounted && name != null && name.isNotEmpty) {
//       setState(() {
//         _userName = name;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(90),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           flexibleSpace: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(25),
//               bottomRight: Radius.circular(25),
//             ),
//             child: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//               child: SafeArea(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Left side (profile image and name)
//                     Row(
//                       children: [
//                         // Profile Image
//                         Consumer<UserProfileProvider>(
//                           builder: (context, profileProvider, child) {
//                             return CircleAvatar(
//                               radius: 22,
//                               backgroundColor: Colors.white,
//                               child: CircleAvatar(
//                                 radius: 20,
//                                 backgroundImage:
//                                     profileProvider.profileImageUrl != null &&
//                                         profileProvider
//                                             .profileImageUrl!
//                                             .isNotEmpty
//                                     ? NetworkImage(
//                                         profileProvider.profileImageUrl!,
//                                       )
//                                     : null,
//                                 backgroundColor: Colors.grey[300],
//                                 child:
//                                     profileProvider.profileImageUrl == null ||
//                                         profileProvider.profileImageUrl!.isEmpty
//                                     ? const Icon(
//                                         Icons.person,
//                                         color: Colors.grey,
//                                         size: 24,
//                                       )
//                                     : null,
//                               ),
//                             );
//                           },
//                         ),
//                         const SizedBox(width: 12),
//                         // Name
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Hello,",
//                               style: TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             Text(
//                               _userName,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),

//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 4,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => NotificationScreen(),
//                             ),
//                           );
//                         },
//                         child: const Icon(
//                           Icons.notifications_none,
//                           color: Colors.black87,
//                           size: 22,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue.shade50, Colors.white],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Modern Train Animation Container
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     // Background glow effect
//                     Positioned.fill(
//                       child: AnimatedBuilder(
//                         animation: _trainAnimation,
//                         builder: (context, child) {
//                           return CustomPaint(
//                             painter: GlowPainter(
//                               position: _trainAnimation.value,
//                               color: Color(0xFF1976D2).withOpacity(0.1),
//                             ),
//                           );
//                         },
//                       ),
//                     ),

//                     // Modern tracks with perspective
//                     Positioned(
//                       bottom: 60,
//                       left: 0,
//                       right: 0,
//                       child: CustomPaint(
//                         size: Size(MediaQuery.of(context).size.width, 30),
//                         painter: ModernTrackPainter(),
//                       ),
//                     ),

//                     // Speed particles/lines
//                     AnimatedBuilder(
//                       animation: _particleAnimation,
//                       builder: (context, child) {
//                         return CustomPaint(
//                           size: Size(MediaQuery.of(context).size.width, 200),
//                           painter: SpeedLinesPainter(
//                             progress: _particleAnimation.value,
//                           ),
//                         );
//                       },
//                     ),

//                     // Animated modern train
//                     AnimatedBuilder(
//                       animation: _trainAnimation,
//                       builder: (context, child) {
//                         final screenWidth = MediaQuery.of(context).size.width;
//                         final position = screenWidth * _trainAnimation.value;

//                         return Positioned(
//                           left: position - 40,
//                           bottom: 45,
//                           child: Transform.scale(
//                             scale:
//                                 1.0 +
//                                 (0.1 *
//                                     math.sin(_trainAnimation.value * math.pi)),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0xFF1976D2).withOpacity(0.3),
//                                     blurRadius: 20,
//                                     spreadRadius: 5,
//                                   ),
//                                 ],
//                               ),
//                               child: CustomPaint(
//                                 size: const Size(80, 60),
//                                 painter: ModernTrainPainter(),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),

//                     // Smoke/steam effect
//                     AnimatedBuilder(
//                       animation: _trainAnimation,
//                       builder: (context, child) {
//                         return CustomPaint(
//                           size: Size(MediaQuery.of(context).size.width, 200),
//                           painter: SmokePainter(
//                             trainPosition: _trainAnimation.value,
//                             animationValue: _particleAnimation.value,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 40),

//               // Pulsing "Coming Soon" Badge
//               ScaleTransition(
//                 scale: _pulseAnimation,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 32,
//                     vertical: 12,
//                   ),
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
//                     ),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xFF1976D2).withOpacity(0.4),
//                         blurRadius: 15,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.access_time, color: Colors.white, size: 18),
//                       const SizedBox(width: 8),
//                       const Text(
//                         'COMING SOON',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // Subtitle text
//               Text(
//                 'Train Booking Feature',
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),

//               const SizedBox(height: 8),

//               Text(
//                 'We\'re working on something amazing!',
//                 style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Modern Train Painter
// class ModernTrainPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..style = PaintingStyle.fill;

//     // Train body - gradient
//     final bodyRect = RRect.fromRectAndRadius(
//       Rect.fromLTWH(10, 20, 60, 35),
//       const Radius.circular(8),
//     );

//     paint.shader = LinearGradient(
//       colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     ).createShader(bodyRect.outerRect);

//     canvas.drawRRect(bodyRect, paint);

//     // Windows
//     paint.shader = null;
//     paint.color = Colors.white.withOpacity(0.9);
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(15, 25, 12, 10),
//         const Radius.circular(3),
//       ),
//       paint,
//     );
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(30, 25, 12, 10),
//         const Radius.circular(3),
//       ),
//       paint,
//     );
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(45, 25, 12, 10),
//         const Radius.circular(3),
//       ),
//       paint,
//     );

//     // Front of train
//     paint.color = Color(0xFF0D47A1);
//     final frontPath = Path()
//       ..moveTo(70, 30)
//       ..lineTo(78, 35)
//       ..lineTo(78, 45)
//       ..lineTo(70, 50)
//       ..close();
//     canvas.drawPath(frontPath, paint);

//     // Wheels
//     paint.color = Colors.black87;
//     canvas.drawCircle(Offset(25, 55), 6, paint);
//     canvas.drawCircle(Offset(45, 55), 6, paint);
//     canvas.drawCircle(Offset(65, 55), 6, paint);

//     // Wheel details
//     paint.color = Colors.grey.shade400;
//     canvas.drawCircle(Offset(25, 55), 3, paint);
//     canvas.drawCircle(Offset(45, 55), 3, paint);
//     canvas.drawCircle(Offset(65, 55), 3, paint);

//     // Light
//     paint.color = Colors.yellow.shade300;
//     canvas.drawCircle(Offset(75, 40), 3, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// // Modern Track Painter with perspective
// class ModernTrackPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     // Upper rail
//     paint.color = Colors.grey.shade400;
//     paint.strokeWidth = 4;
//     canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);

//     // Lower rail
//     paint.strokeWidth = 5;
//     canvas.drawLine(Offset(0, 12), Offset(size.width, 12), paint);

//     // Sleepers with gradient effect
//     paint.style = PaintingStyle.fill;
//     for (double i = 0; i < size.width; i += 35) {
//       paint.color = Colors.grey.shade500.withOpacity(0.6);
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromLTWH(i, -3, 25, 18),
//           const Radius.circular(2),
//         ),
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// // Speed lines painter
// class SpeedLinesPainter extends CustomPainter {
//   final double progress;

//   SpeedLinesPainter({required this.progress});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..strokeWidth = 2
//       ..strokeCap = StrokeCap.round;

//     for (int i = 0; i < 6; i++) {
//       final opacity = (1 - ((progress + i * 0.15) % 1)).clamp(0.0, 1.0);
//       paint.color = Color(0xFF1976D2).withOpacity(opacity * 0.3);

//       final y = 100 + i * 15;
//       final startX = size.width * ((progress + i * 0.15) % 1);

//       canvas.drawLine(
//         Offset(startX, y.toDouble()),
//         Offset(startX - 40, y.toDouble()),
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(SpeedLinesPainter oldDelegate) => true;
// }

// // Glow effect painter
// class GlowPainter extends CustomPainter {
//   final double position;
//   final Color color;

//   GlowPainter({required this.position, required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..maskFilter = MaskFilter.blur(BlurStyle.normal, 30);

//     paint.color = color;
//     canvas.drawCircle(
//       Offset(size.width * position, size.height * 0.6),
//       60,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(GlowPainter oldDelegate) => true;
// }

// // Smoke/steam effect
// class SmokePainter extends CustomPainter {
//   final double trainPosition;
//   final double animationValue;

//   SmokePainter({required this.trainPosition, required this.animationValue});

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (trainPosition < 0 || trainPosition > 1) return;

//     final paint = Paint()..style = PaintingStyle.fill;

//     for (int i = 0; i < 3; i++) {
//       final offset = (animationValue + i * 0.3) % 1;
//       final opacity = (1 - offset) * 0.15;

//       paint.color = Colors.grey.shade400.withOpacity(opacity);

//       final x = size.width * trainPosition - 20 - (offset * 40);
//       final y = 40 - (offset * 30);
//       final radius = 8 + (offset * 12);

//       canvas.drawCircle(Offset(x, y), radius, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(SmokePainter oldDelegate) => true;
// }

import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
import 'package:backup_ticket/views/notifications/notification_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class TrainScreen extends StatefulWidget {
  const TrainScreen({super.key});

  @override
  State<TrainScreen> createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen>
    with TickerProviderStateMixin {
  late AnimationController _trainController;
  late AnimationController _particleController;
  late AnimationController _pulseController;
  late AnimationController _smokeController;

  late Animation<double> _trainAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _smokeAnimation;

  String _userName = "Guest";

  @override
  void initState() {
    super.initState();
    _loadUserName();

    // Train movement animation
    _trainController = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    )..repeat();

    _trainAnimation = Tween<double>(begin: -0.5, end: 1.5).animate(
      CurvedAnimation(parent: _trainController, curve: Curves.easeInOut),
    );

    // Particle/speed lines animation
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_particleController);

    // Pulse animation for badge
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Smoke animation
    _smokeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _smokeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _smokeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _trainController.dispose();
    _particleController.dispose();
    _pulseController.dispose();
    _smokeController.dispose();
    super.dispose();
  }

  Future<void> _loadUserName() async {
    final name = await UserPreferences.getName();
    if (mounted && name != null && name.isNotEmpty) {
      setState(() {
        _userName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side (profile image and name)
                    Row(
                      children: [
                        // Profile Image
                        Consumer<UserProfileProvider>(
                          builder: (context, profileProvider, child) {
                            return CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    profileProvider.profileImageUrl != null &&
                                        profileProvider
                                            .profileImageUrl!
                                            .isNotEmpty
                                    ? NetworkImage(
                                        profileProvider.profileImageUrl!,
                                      )
                                    : null,
                                backgroundColor: Colors.grey[300],
                                child:
                                    profileProvider.profileImageUrl == null ||
                                        profileProvider.profileImageUrl!.isEmpty
                                    ? const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                        size: 24,
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        // Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Hello,",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              _userName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Notification Bell
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.notifications_none,
                          color: Colors.black87,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Modern Train Animation Container
              Container(
                height: 250,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Background glow effect
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: _trainAnimation,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: GlowPainter(
                              position: _trainAnimation.value,
                              color: const Color(0xFF1976D2).withOpacity(0.1),
                            ),
                          );
                        },
                      ),
                    ),

                    // Modern tracks with perspective
                    Positioned(
                      bottom: 80,
                      left: 0,
                      right: 0,
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 30),
                        painter: ModernTrackPainter(),
                      ),
                    ),

                    // Speed particles/lines
                    AnimatedBuilder(
                      animation: _particleAnimation,
                      builder: (context, child) {
                        return CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, 250),
                          painter: SpeedLinesPainter(
                            progress: _particleAnimation.value,
                          ),
                        );
                      },
                    ),

                    // Smoke effect
                    AnimatedBuilder(
                      animation: _smokeAnimation,
                      builder: (context, child) {
                        return CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, 250),
                          painter: SmokePainter(
                            animationValue: _smokeAnimation.value,
                          ),
                        );
                      },
                    ),

                    // Animated full train
                    AnimatedBuilder(
                      animation: _trainAnimation,
                      builder: (context, child) {
                        final screenWidth = MediaQuery.of(context).size.width;
                        final position = screenWidth * _trainAnimation.value;

                        return Positioned(
                          left: position - 120, // Adjusted for full train width
                          bottom: 60,
                          child: Transform.scale(
                            scale:
                                1.0 +
                                (0.05 *
                                    math.sin(_trainAnimation.value * math.pi)),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF1976D2,
                                    ).withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: CustomPaint(
                                size: const Size(
                                  240,
                                  100,
                                ), // Larger size for full train
                                painter: FullTrainPainter(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Pulsing "Coming Soon" Badge
              ScaleTransition(
                scale: _pulseAnimation,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1976D2).withOpacity(0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'COMING SOON',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Subtitle text
              Text(
                'Train Booking Feature',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'We\'re working on something amazing!',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Full Train Painter with multiple carriages
class FullTrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw the full train with multiple carriages
    _drawLocomotive(canvas, size, paint);
    _drawCarriages(canvas, size, paint);
  }

  void _drawLocomotive(Canvas canvas, Size size, Paint paint) {
    // Locomotive body
    final locomotiveRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 30, 80, 50),
      const Radius.circular(10),
    );

    paint.shader = LinearGradient(
      colors: [const Color(0xFF1976D2), const Color(0xFF0D47A1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(locomotiveRect.outerRect);

    canvas.drawRRect(locomotiveRect, paint);

    // Front of locomotive
    paint.shader = null;
    paint.color = const Color(0xFF0D47A1);
    final frontPath = Path()
      ..moveTo(80, 35)
      ..lineTo(90, 45)
      ..lineTo(90, 65)
      ..lineTo(80, 75)
      ..close();
    canvas.drawPath(frontPath, paint);

    // Windows on locomotive
    paint.color = Colors.white.withOpacity(0.9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(15, 40, 20, 12),
        const Radius.circular(4),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(40, 40, 20, 12),
        const Radius.circular(4),
      ),
      paint,
    );

    // Headlight
    paint.color = Colors.yellow.shade300;
    canvas.drawCircle(const Offset(87, 55), 4, paint);

    // Locomotive wheels
    _drawWheels(canvas, 20, 80, paint);
    _drawWheels(canvas, 50, 80, paint);
  }

  void _drawCarriages(Canvas canvas, Size size, Paint paint) {
    final carriageColors = [
      const Color(0xFF2196F3),
      const Color(0xFF1976D2),
      const Color(0xFF1565C0),
    ];

    // Draw 3 carriages
    for (int i = 0; i < 3; i++) {
      final carriageX = 95 + (i * 50); // Adjusted spacing

      // Carriage body
      final carriageRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(carriageX.toDouble(), 35, 45, 45),
        const Radius.circular(8),
      );

      paint.shader = LinearGradient(
        colors: [carriageColors[i], carriageColors[i].withOpacity(0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(carriageRect.outerRect);

      canvas.drawRRect(carriageRect, paint);

      // Windows on carriage
      paint.shader = null;
      paint.color = Colors.white.withOpacity(0.9);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(carriageX + 8, 42, 12, 10),
          const Radius.circular(3),
        ),
        paint,
      );
      // canvas.drawRRect(
      //   RRect.fromRectAndRadius(
      //     Rect.fromLTWH(carriageX + 25, 42, 12, 10),
      //     const Radius.circular(3),
      //   )
      // );

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(carriageX + 25, 42, 12, 10),
          const Radius.circular(3),
        ),
        Paint()..color = Colors.black, // or any color you want
      );

      // Carriage wheels
      _drawWheels(canvas, carriageX + 12, 80, paint);
      _drawWheels(canvas, carriageX + 33, 80, paint);

      // Connection between carriages
      if (i > 0) {
        paint.color = Colors.grey.shade700;
        paint.strokeWidth = 2;
        canvas.drawLine(
          Offset(carriageX - 5, 55),
          Offset(carriageX - 10, 55),
          paint,
        );
      }
    }
  }

  void _drawWheels(Canvas canvas, double x, double y, Paint paint) {
    // Outer wheel
    paint.color = Colors.black87;
    canvas.drawCircle(Offset(x, y), 6, paint);

    // Inner wheel detail
    paint.color = Colors.grey.shade400;
    canvas.drawCircle(Offset(x, y), 3, paint);

    // Wheel hub
    paint.color = Colors.grey.shade300;
    canvas.drawCircle(Offset(x, y), 1.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Modern Track Painter with perspective
class ModernTrackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Upper rail
    paint.color = Colors.grey.shade400;
    paint.strokeWidth = 4;
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);

    // Lower rail
    paint.strokeWidth = 5;
    canvas.drawLine(const Offset(0, 12), Offset(size.width, 12), paint);

    // Sleepers with gradient effect
    paint.style = PaintingStyle.fill;
    for (double i = 0; i < size.width; i += 35) {
      paint.color = Colors.grey.shade500.withOpacity(0.6);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(i, -3, 25, 18),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Speed lines painter
class SpeedLinesPainter extends CustomPainter {
  final double progress;

  SpeedLinesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 8; i++) {
      final opacity = (1 - ((progress + i * 0.1) % 1)).clamp(0.0, 1.0);
      paint.color = const Color(0xFF1976D2).withOpacity(opacity * 0.25);

      final y = 120 + i * 15;
      final startX = size.width * ((progress + i * 0.1) % 1);

      canvas.drawLine(
        Offset(startX, y.toDouble()),
        Offset(startX - 60, y.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(SpeedLinesPainter oldDelegate) => true;
}

// Glow effect painter
class GlowPainter extends CustomPainter {
  final double position;
  final Color color;

  GlowPainter({required this.position, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..maskFilter = MaskFilter.blur(BlurStyle.normal, 40);

    paint.color = color;
    canvas.drawCircle(
      Offset(size.width * position, size.height * 0.6),
      80,
      paint,
    );
  }

  @override
  bool shouldRepaint(GlowPainter oldDelegate) => true;
}

// Smoke/steam effect
class SmokePainter extends CustomPainter {
  final double animationValue;

  SmokePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw multiple smoke particles
    for (int i = 0; i < 5; i++) {
      final offset = (animationValue + i * 0.2) % 1;
      final opacity = (1 - offset) * 0.2;

      // Position smoke coming from where the locomotive would be
      final trainPosition = 0.5; // Smoke comes from center of screen
      final x = size.width * trainPosition - 30 - (offset * 100);
      final y = 50 - (offset * 60);

      paint.color = Colors.grey.shade300.withOpacity(opacity);

      // Draw smoke cloud with multiple circles
      for (int j = 0; j < 3; j++) {
        final radius = (8 + j * 4) * (1 + offset * 2);
        canvas.drawCircle(Offset(x + j * 8, y + j * 5), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SmokePainter oldDelegate) => true;
}
