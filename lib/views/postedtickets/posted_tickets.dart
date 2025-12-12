// // // // // import 'package:flutter/material.dart';

// // // // // class PostedTickets extends StatefulWidget {
// // // // //   const PostedTickets({super.key});

// // // // //   @override
// // // // //   State<PostedTickets> createState() => _PostedTicketsState();
// // // // // }

// // // // // class _PostedTicketsState extends State<PostedTickets>
// // // // //     with SingleTickerProviderStateMixin {
// // // // //   late TabController _tabController;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _tabController = TabController(length: 2, vsync: this);
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _tabController.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.grey[50],
// // // // //       appBar: AppBar(
// // // // //         backgroundColor: Colors.white,
// // // // //         elevation: 0,
// // // // //         title: const Text(
// // // // //           'My Posted Tickets',
// // // // //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
// // // // //         ),
// // // // //         leading: IconButton(
// // // // //           onPressed: () {
// // // // //             Navigator.of(context).pop();
// // // // //           },
// // // // //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
// // // // //         ),
// // // // //       ),
// // // // //       body: Column(
// // // // //         children: [
// // // // //           Container(
// // // // //             margin: const EdgeInsets.all(16.0),
// // // // //             decoration: BoxDecoration(
// // // // //               color: Colors.grey[200],
// // // // //               borderRadius: BorderRadius.circular(25),
// // // // //             ),
// // // // //             child: TabBar(
// // // // //               controller: _tabController,
// // // // //               indicator: BoxDecoration(
// // // // //                 color: const Color(0xFF1976D2),
// // // // //                 borderRadius: BorderRadius.circular(25),
// // // // //               ),
// // // // //               indicatorSize: TabBarIndicatorSize.tab,
// // // // //               labelColor: Colors.white,
// // // // //               unselectedLabelColor: Colors.grey[600],
// // // // //               labelStyle: const TextStyle(
// // // // //                 fontWeight: FontWeight.w600,
// // // // //                 fontSize: 14,
// // // // //               ),
// // // // //               unselectedLabelStyle: const TextStyle(
// // // // //                 fontWeight: FontWeight.w500,
// // // // //                 fontSize: 14,
// // // // //               ),
// // // // //               dividerColor: Colors.transparent, 
// // // // //               overlayColor: MaterialStateProperty.all(
// // // // //                 Colors.transparent,
// // // // //               ), // Remove tap effects
// // // // //               splashFactory: NoSplash.splashFactory, // Remove splash animation
// // // // //               tabs: [
// // // // //                 Tab(
// // // // //                   child: Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // // //                     mainAxisSize: MainAxisSize.min,
// // // // //                     children: [
// // // // //                       Icon(Icons.movie, size: 20),
// // // // //                       SizedBox(width: 8),
// // // // //                       Text('Movies'),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ),
// // // // //                 Tab(
// // // // //                   child: Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // // //                     mainAxisSize: MainAxisSize.min,
// // // // //                     children: [
// // // // //                       Icon(Icons.directions_bus, size: 20),
// // // // //                       SizedBox(width: 8),
// // // // //                       Text('Bus'),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),

// // // // //           // Tab Bar View
// // // // //           Expanded(
// // // // //             child: TabBarView(
// // // // //               controller: _tabController,
// // // // //               children: [
// // // // //                 // Movies Tab
// // // // //                 _buildMoviesTab(),

// // // // //                 // Bus Tab
// // // // //                 _buildBusTab(),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildMoviesTab() {
// // // // //     return ListView.builder(
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // // //       itemCount: 3,
// // // // //       itemBuilder: (context, index) {
// // // // //         return _buildMovieTicketCard(context);
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   Widget _buildBusTab() {
// // // // //     return ListView(
// // // // //       children: [
       
// // // // //         _buildBusTicketCard(
// // // // //           companyName: 'Orange Travels',
// // // // //           badgeText: 'AC',
// // // // //           badgeColor: const Color(0xFFE3F2FD),
// // // // //           badgeTextColor: const Color(0xFF1976D2),
// // // // //           fromCity: 'Hyderabad',
// // // // //           toCity: 'Kalvakole',
// // // // //           departureTime: '08:00',
// // // // //           arrivalTime: '11:30',
// // // // //           price: '₹ 200',
// // // // //           seats: 'Seat : L11',
// // // // //         ),
// // // // //         _buildBusTicketCard(
// // // // //           companyName: 'Orange Travels',
// // // // //           badgeText: 'AC',
// // // // //           badgeColor: const Color(0xFFE3F2FD),
// // // // //           badgeTextColor: const Color(0xFF1976D2),
// // // // //           fromCity: 'Hyderabad',
// // // // //           toCity: 'Kalvakole',
// // // // //           departureTime: '08:00',
// // // // //           arrivalTime: '11:30',
// // // // //           price: '₹ 200',
// // // // //           seats: 'Seat : L11',
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _buildMovieTicketCard(BuildContext context) {
// // // // //     return Container(
// // // // //       margin: const EdgeInsets.only(bottom: 12),
// // // // //       padding: const EdgeInsets.all(12),
// // // // //       decoration: BoxDecoration(
// // // // //         color: Colors.white,
// // // // //         borderRadius: BorderRadius.circular(12),
// // // // //         boxShadow: [
// // // // //           BoxShadow(
// // // // //             color: Colors.grey.withOpacity(0.1),
// // // // //             spreadRadius: 1,
// // // // //             blurRadius: 8,
// // // // //             offset: const Offset(0, 2),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       child: Row(
// // // // //         children: [
// // // // //           // Movie Poster
// // // // //           Container(
// // // // //             width: 60,
// // // // //             height: 80,
// // // // //             decoration: BoxDecoration(
// // // // //               color: Colors.grey[300],
// // // // //               borderRadius: BorderRadius.circular(6),
// // // // //               image: const DecorationImage(
// // // // //                 image: AssetImage('assets/kubera.png'),
// // // // //                 fit: BoxFit.cover,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(width: 12),

// // // // //           // Movie Details
// // // // //           Expanded(
// // // // //             child: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 const Text(
// // // // //                   'Kuberaa',
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 16,
// // // // //                     fontWeight: FontWeight.w600,
// // // // //                     color: Colors.black87,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(height: 4),
// // // // //                 const Text(
// // // // //                   '3D • Telugu',
// // // // //                   style: TextStyle(fontSize: 12, color: Colors.grey),
// // // // //                 ),
// // // // //                 const SizedBox(height: 4),
// // // // //                 const Text(
// // // // //                   '4 Aug, 8:30 PM',
// // // // //                   style: TextStyle(fontSize: 14, color: Colors.black),
// // // // //                 ),
// // // // //                 const SizedBox(height: 2),
// // // // //                 const Text(
// // // // //                   'INOX: GVK One, Hyderabad',
// // // // //                   style: TextStyle(fontSize: 12, color: Colors.grey),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),

// // // // //           // Price and Menu
// // // // //           Column(
// // // // //             crossAxisAlignment: CrossAxisAlignment.end,
// // // // //             children: [
// // // // //               IconButton(
// // // // //                 onPressed: () {},
// // // // //                 icon: const Icon(Icons.more_vert, color: Colors.grey),
// // // // //                 constraints: const BoxConstraints(),
// // // // //                 padding: EdgeInsets.zero,
// // // // //               ),
// // // // //               const Text(
// // // // //                 '₹ 200',
// // // // //                 style: TextStyle(
// // // // //                   fontSize: 18,
// // // // //                   fontWeight: FontWeight.w600,
// // // // //                   color: Colors.black87,
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildBusTicketCard({
// // // // //     required String companyName,
// // // // //     required String badgeText,
// // // // //     required Color badgeColor,
// // // // //     required Color badgeTextColor,
// // // // //     required String fromCity,
// // // // //     required String toCity,
// // // // //     required String departureTime,
// // // // //     required String arrivalTime,
// // // // //     required String price,
// // // // //     required String seats,
// // // // //   }) {
// // // // //     return Container(
// // // // //       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// // // // //       child: ClipPath(
// // // // //         clipper: TicketClipper(),
// // // // //         child: Container(
// // // // //           decoration: BoxDecoration(
// // // // //             color: Colors.white,
// // // // //             boxShadow: [
// // // // //               BoxShadow(
// // // // //                 color: Colors.grey.withOpacity(0.1),
// // // // //                 spreadRadius: 1,
// // // // //                 blurRadius: 6,
// // // // //                 offset: const Offset(0, 2),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //           child: Padding(
// // // // //             padding: const EdgeInsets.all(16.0),
// // // // //             child: Column(
// // // // //               children: [
// // // // //                 // Company name and badge row
// // // // //                 Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                   children: [
// // // // //                     Row(
// // // // //                       children: [
// // // // //                         const Icon(
// // // // //                           Icons.directions_bus,
// // // // //                           size: 20,
// // // // //                           color: Colors.black87,
// // // // //                         ),
// // // // //                         const SizedBox(width: 8),
// // // // //                         Text(
// // // // //                           companyName,
// // // // //                           style: const TextStyle(
// // // // //                             fontSize: 16,
// // // // //                             fontWeight: FontWeight.w600,
// // // // //                             color: Colors.black87,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                     Container(
// // // // //                       padding: const EdgeInsets.symmetric(
// // // // //                         horizontal: 8,
// // // // //                         vertical: 4,
// // // // //                       ),
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: badgeColor,
// // // // //                         borderRadius: BorderRadius.circular(12),
// // // // //                       ),
// // // // //                       child: Text(
// // // // //                         badgeText,
// // // // //                         style: TextStyle(
// // // // //                           color: badgeTextColor,
// // // // //                           fontSize: 12,
// // // // //                           fontWeight: FontWeight.w500,
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),

// // // // //                 const SizedBox(height: 16),

// // // // //                 // Route and time row
// // // // //                 Row(
// // // // //                   children: [
// // // // //                     // Departure
// // // // //                     Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           fromCity,
// // // // //                           style: TextStyle(
// // // // //                             color: Colors.grey[600],
// // // // //                             fontSize: 12,
// // // // //                           ),
// // // // //                         ),
// // // // //                         Text(
// // // // //                           departureTime,
// // // // //                           style: const TextStyle(
// // // // //                             fontSize: 18,
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                             color: Colors.black87,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),

// // // // //                     // Route line with bus icon
// // // // //                     Expanded(
// // // // //                       child: Container(
// // // // //                         margin: const EdgeInsets.symmetric(horizontal: 16),
// // // // //                         child: Row(
// // // // //                           children: [
// // // // //                             Container(
// // // // //                               width: 8,
// // // // //                               height: 8,
// // // // //                               decoration: const BoxDecoration(
// // // // //                                 color: Color(0xFF4A90E2),
// // // // //                                 shape: BoxShape.circle,
// // // // //                               ),
// // // // //                             ),
// // // // //                             Expanded(
// // // // //                               child: Container(
// // // // //                                 height: 2,
// // // // //                                 color: const Color(0xFF4A90E2),
// // // // //                                 child: Row(
// // // // //                                   mainAxisAlignment: MainAxisAlignment.center,
// // // // //                                   children: [
// // // // //                                     Container(
// // // // //                                       padding: const EdgeInsets.all(4),
// // // // //                                       decoration: const BoxDecoration(
// // // // //                                         color: Color(0xFF4A90E2),
// // // // //                                         shape: BoxShape.circle,
// // // // //                                       ),
// // // // //                                       child: const Icon(
// // // // //                                         Icons.directions_bus,
// // // // //                                         color: Colors.white,
// // // // //                                         size: 16,
// // // // //                                       ),
// // // // //                                     ),
// // // // //                                   ],
// // // // //                                 ),
// // // // //                               ),
// // // // //                             ),
// // // // //                             Container(
// // // // //                               width: 8,
// // // // //                               height: 8,
// // // // //                               decoration: const BoxDecoration(
// // // // //                                 color: Color(0xFF4A90E2),
// // // // //                                 shape: BoxShape.circle,
// // // // //                               ),
// // // // //                             ),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),

// // // // //                     // Arrival
// // // // //                     Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.end,
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           toCity,
// // // // //                           style: TextStyle(
// // // // //                             color: Colors.grey[600],
// // // // //                             fontSize: 12,
// // // // //                           ),
// // // // //                         ),
// // // // //                         Text(
// // // // //                           arrivalTime,
// // // // //                           style: const TextStyle(
// // // // //                             fontSize: 18,
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                             color: Colors.black87,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),

// // // // //                 const SizedBox(height: 16),

// // // // //                 // Divider
// // // // //                 Container(height: 1, color: Colors.grey[200]),

// // // // //                 const SizedBox(height: 12),

// // // // //                 // Price and select row
// // // // //                 Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                   children: [
// // // // //                     Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           price,
// // // // //                           style: const TextStyle(
// // // // //                             fontSize: 20,
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                             color: Colors.black87,
// // // // //                           ),
// // // // //                         ),
// // // // //                         Text(
// // // // //                           seats,
// // // // //                           style: const TextStyle(
// // // // //                             color: Color(0xFF4A90E2),
// // // // //                             fontSize: 12,
// // // // //                             fontWeight: FontWeight.w500,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                     const Row(
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           'Select',
// // // // //                           style: TextStyle(
// // // // //                             color: Color(0xFF4A90E2),
// // // // //                             fontSize: 16,
// // // // //                             fontWeight: FontWeight.w600,
// // // // //                           ),
// // // // //                         ),
// // // // //                         SizedBox(width: 4),
// // // // //                         Icon(
// // // // //                           Icons.arrow_forward_ios,
// // // // //                           color: Color(0xFF4A90E2),
// // // // //                           size: 14,
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class TicketClipper extends CustomClipper<Path> {
// // // // //   @override
// // // // //   Path getClip(Size size) {
// // // // //     Path path = Path();
// // // // //     double circleRadius = 12.0;
// // // // //     double middleY = size.height / 2;

// // // // //     // Start from top left, with rounded corner
// // // // //     path.moveTo(12, 0);
// // // // //     path.lineTo(size.width - 12, 0);
// // // // //     path.quadraticBezierTo(size.width, 0, size.width, 12);

// // // // //     // Right side - go down to middle, create semicircle cut
// // // // //     path.lineTo(size.width, middleY - circleRadius);
// // // // //     path.arcToPoint(
// // // // //       Offset(size.width, middleY + circleRadius),
// // // // //       radius: Radius.circular(circleRadius),
// // // // //       clockwise: false,
// // // // //     );

// // // // //     // Continue down right side
// // // // //     path.lineTo(size.width, size.height - 12);
// // // // //     path.quadraticBezierTo(
// // // // //       size.width,
// // // // //       size.height,
// // // // //       size.width - 12,
// // // // //       size.height,
// // // // //     );

// // // // //     // Bottom side
// // // // //     path.lineTo(12, size.height);
// // // // //     path.quadraticBezierTo(0, size.height, 0, size.height - 12);

// // // // //     // Left side - go up to middle, create semicircle cut
// // // // //     path.lineTo(0, middleY + circleRadius);
// // // // //     path.arcToPoint(
// // // // //       Offset(0, middleY - circleRadius),
// // // // //       radius: Radius.circular(circleRadius),
// // // // //       clockwise: false,
// // // // //     );

// // // // //     // Continue up left side
// // // // //     path.lineTo(0, 12);
// // // // //     path.quadraticBezierTo(0, 0, 12, 0);

// // // // //     path.close();
// // // // //     return path;
// // // // //   }

// // // // //   @override
// // // // //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // // // // }
















// // // // // import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// // // // // import 'package:flutter/material.dart';

// // // // // class PostedTickets extends StatefulWidget {
// // // // //   const PostedTickets({super.key});

// // // // //   @override
// // // // //   State<PostedTickets> createState() => _PostedTicketsState();
// // // // // }

// // // // // class _PostedTicketsState extends State<PostedTickets>
// // // // //     with SingleTickerProviderStateMixin {
// // // // //   late TabController _tabController;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _tabController = TabController(length: 2, vsync: this);
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _tabController.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.grey[50],
// // // // //       appBar: AppBar(
// // // // //         backgroundColor: Colors.white,
// // // // //         elevation: 0,
// // // // //         title: const Text(
// // // // //           'My Posted Tickets',
// // // // //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
// // // // //         ),
// // // // //         leading: IconButton(
// // // // //           onPressed: () {
// // // // //             Navigator.of(context).pop();
// // // // //           },
// // // // //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
// // // // //         ),
// // // // //       ),
// // // // //       body: Column(
// // // // //         children: [
// // // // //           Container(
// // // // //             margin: const EdgeInsets.all(16.0),
// // // // //             decoration: BoxDecoration(
// // // // //               color: Colors.grey[200],
// // // // //               borderRadius: BorderRadius.circular(25),
// // // // //             ),
// // // // //             child: TabBar(
// // // // //               controller: _tabController,
// // // // //               indicator: BoxDecoration(
// // // // //                 color: const Color(0xFF1976D2),
// // // // //                 borderRadius: BorderRadius.circular(25),
// // // // //               ),
// // // // //               indicatorSize: TabBarIndicatorSize.tab,
// // // // //               labelColor: Colors.white,
// // // // //               unselectedLabelColor: Colors.grey[600],
// // // // //               labelStyle: const TextStyle(
// // // // //                 fontWeight: FontWeight.w600,
// // // // //                 fontSize: 14,
// // // // //               ),
// // // // //               unselectedLabelStyle: const TextStyle(
// // // // //                 fontWeight: FontWeight.w500,
// // // // //                 fontSize: 14,
// // // // //               ),
// // // // //               dividerColor: Colors.transparent, 
// // // // //               overlayColor: MaterialStateProperty.all(
// // // // //                 Colors.transparent,
// // // // //               ), // Remove tap effects
// // // // //               splashFactory: NoSplash.splashFactory, // Remove splash animation
// // // // //               tabs: [
// // // // //                 Tab(
// // // // //                   child: Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // // //                     mainAxisSize: MainAxisSize.min,
// // // // //                     children: [
// // // // //                       Icon(Icons.movie, size: 20),
// // // // //                       SizedBox(width: 8),
// // // // //                       Text('Movies'),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ),
// // // // //                 Tab(
// // // // //                   child: Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // // //                     mainAxisSize: MainAxisSize.min,
// // // // //                     children: [
// // // // //                       Icon(Icons.directions_bus, size: 20),
// // // // //                       SizedBox(width: 8),
// // // // //                       Text('Bus'),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),

// // // // //           // Tab Bar View
// // // // //           Expanded(
// // // // //             child: TabBarView(
// // // // //               controller: _tabController,
// // // // //               children: [
// // // // //                 // Movies Tab
// // // // //                 _buildMoviesTab(),

// // // // //                 // Bus Tab
// // // // //                 _buildBusTab(),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildMoviesTab() {
// // // // //     return ListView.builder(
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // // //       itemCount: 3,
// // // // //       itemBuilder: (context, index) {
// // // // //         return _buildMovieTicketCard(context, index);
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   Widget _buildBusTab() {
// // // // //     return ListView(
// // // // //       children: [
       
// // // // //         _buildBusTicketCard(
// // // // //           companyName: 'Orange Travels',
// // // // //           badgeText: 'AC',
// // // // //           badgeColor: const Color(0xFFE3F2FD),
// // // // //           badgeTextColor: const Color(0xFF1976D2),
// // // // //           fromCity: 'Hyderabad',
// // // // //           toCity: 'Kalvakole',
// // // // //           departureTime: '08:00',
// // // // //           arrivalTime: '11:30',
// // // // //           price: '₹ 200',
// // // // //           seats: 'Seat : L11',
// // // // //         ),
// // // // //         _buildBusTicketCard(
// // // // //           companyName: 'Orange Travels',
// // // // //           badgeText: 'AC',
// // // // //           badgeColor: const Color(0xFFE3F2FD),
// // // // //           badgeTextColor: const Color(0xFF1976D2),
// // // // //           fromCity: 'Hyderabad',
// // // // //           toCity: 'Kalvakole',
// // // // //           departureTime: '08:00',
// // // // //           arrivalTime: '11:30',
// // // // //           price: '₹ 200',
// // // // //           seats: 'Seat : L11',
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _buildMovieTicketCard(BuildContext context, int index) {
// // // // //     return Container(
// // // // //       margin: const EdgeInsets.only(bottom: 12),
// // // // //       padding: const EdgeInsets.all(12),
// // // // //       decoration: BoxDecoration(
// // // // //         color: Colors.white,
// // // // //         borderRadius: BorderRadius.circular(12),
// // // // //         boxShadow: [
// // // // //           BoxShadow(
// // // // //             color: Colors.grey.withOpacity(0.1),
// // // // //             spreadRadius: 1,
// // // // //             blurRadius: 8,
// // // // //             offset: const Offset(0, 2),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       child: Row(
// // // // //         children: [
// // // // //           // Movie Poster
// // // // //           Container(
// // // // //             width: 60,
// // // // //             height: 80,
// // // // //             decoration: BoxDecoration(
// // // // //               color: Colors.grey[300],
// // // // //               borderRadius: BorderRadius.circular(6),
// // // // //               image: const DecorationImage(
// // // // //                 image: AssetImage('assets/kubera.png'),
// // // // //                 fit: BoxFit.cover,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(width: 12),

// // // // //           // Movie Details
// // // // //           Expanded(
// // // // //             child: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 const Text(
// // // // //                   'Kuberaa',
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 16,
// // // // //                     fontWeight: FontWeight.w600,
// // // // //                     color: Colors.black87,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(height: 4),
// // // // //                 const Text(
// // // // //                   '3D • Telugu',
// // // // //                   style: TextStyle(fontSize: 12, color: Colors.grey),
// // // // //                 ),
// // // // //                 const SizedBox(height: 4),
// // // // //                 const Text(
// // // // //                   '4 Aug, 8:30 PM',
// // // // //                   style: TextStyle(fontSize: 14, color: Colors.black),
// // // // //                 ),
// // // // //                 const SizedBox(height: 2),
// // // // //                 const Text(
// // // // //                   'INOX: GVK One, Hyderabad',
// // // // //                   style: TextStyle(fontSize: 12, color: Colors.grey),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),

// // // // //           // Price and Menu
// // // // //           Column(
// // // // //             crossAxisAlignment: CrossAxisAlignment.end,
// // // // //             children: [
// // // // //               PopupMenuButton<String>(
// // // // //                 onSelected: (value) {
// // // // //                   _handleMenuAction(context, value, index);
// // // // //                 },
// // // // //                 itemBuilder: (BuildContext context) => [
// // // // //                   const PopupMenuItem<String>(
// // // // //                     value: 'edit',
// // // // //                     child: Row(
// // // // //                       children: [
// // // // //                         Icon(Icons.edit, size: 18, color: Colors.blue),
// // // // //                         SizedBox(width: 8),
// // // // //                         Text('Edit'),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                   const PopupMenuItem<String>(
// // // // //                     value: 'delete',
// // // // //                     child: Row(
// // // // //                       children: [
// // // // //                         Icon(Icons.delete, size: 18, color: Colors.red),
// // // // //                         SizedBox(width: 8),
// // // // //                         Text('Delete', style: TextStyle(color: Colors.red)),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //                 icon: const Icon(Icons.more_vert, color: Colors.grey),
// // // // //                 padding: EdgeInsets.zero,
// // // // //                 constraints: const BoxConstraints(),
// // // // //               ),
// // // // //               const SizedBox(height: 8),
// // // // //               const Text(
// // // // //                 '₹ 200',
// // // // //                 style: TextStyle(
// // // // //                   fontSize: 18,
// // // // //                   fontWeight: FontWeight.w600,
// // // // //                   color: Colors.black87,
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   void _handleMenuAction(BuildContext context, String action, int index) {
// // // // //     switch (action) {
// // // // //       case 'edit':
// // // // //         _showEditDialog(context, index);
// // // // //         break;
// // // // //       case 'delete':
// // // // //         _showDeleteDialog(context, index);
// // // // //         break;
// // // // //     }
// // // // //   }

// // // // //   // void _showEditDialog(BuildContext context, int index) {
// // // // //   //   showDialog(
// // // // //   //     context: context,
// // // // //   //     builder: (BuildContext context) {
// // // // //   //       return AlertDialog(
// // // // //   //         title: const Text('Edit Ticket'),
// // // // //   //         content: const Text('Edit functionality will be implemented here.'),
// // // // //   //         actions: [
// // // // //   //           TextButton(
// // // // //   //             onPressed: () {
// // // // //   //               Navigator.of(context).pop();
// // // // //   //             },
// // // // //   //             child: const Text('Cancel'),
// // // // //   //           ),
// // // // //   //           ElevatedButton(
// // // // //   //             onPressed: () {
// // // // //   //                                               Navigator.push(context, MaterialPageRoute(builder: (context)=>SellMovieTicket()));

// // // // //   //               // Navigator.of(context).pop();
// // // // //   //               // // Implement edit functionality
// // // // //   //               // ScaffoldMessenger.of(context).showSnackBar(
// // // // //   //               //   SnackBar(content: Text('Edit ticket at index $index')),
// // // // //   //               // );
// // // // //   //             },
// // // // //   //             child: const Text('Save'),
// // // // //   //           ),
// // // // //   //         ],
// // // // //   //       );
// // // // //   //     },
// // // // //   //   );
// // // // //   // }


// // // // //   void _showEditDialog(BuildContext context, int index) {
// // // // //   Navigator.push(
// // // // //     context,
// // // // //     MaterialPageRoute(builder: (context) => SellMovieTicket()),
// // // // //   );
// // // // // }


// // // // //   void _showDeleteDialog(BuildContext context, int index) {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (BuildContext context) {
// // // // //         return AlertDialog(
// // // // //           title: const Text('Delete Ticket'),
// // // // //           content: const Text('Are you sure you want to delete this ticket? This action cannot be undone.'),
// // // // //           actions: [
// // // // //             TextButton(
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //               },
// // // // //               child: const Text('Cancel'),
// // // // //             ),
// // // // //             ElevatedButton(
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop();
// // // // //                 // Implement delete functionality
// // // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // // //                   SnackBar(
// // // // //                     content: Text('Ticket at index $index deleted'),
// // // // //                     backgroundColor: Colors.red,
// // // // //                   ),
// // // // //                 );
// // // // //               },
// // // // //               style: ElevatedButton.styleFrom(
// // // // //                 backgroundColor: Colors.red,
// // // // //                 foregroundColor: Colors.white,
// // // // //               ),
// // // // //               child: const Text('Delete'),
// // // // //             ),
// // // // //           ],
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   Widget _buildBusTicketCard({
// // // // //     required String companyName,
// // // // //     required String badgeText,
// // // // //     required Color badgeColor,
// // // // //     required Color badgeTextColor,
// // // // //     required String fromCity,
// // // // //     required String toCity,
// // // // //     required String departureTime,
// // // // //     required String arrivalTime,
// // // // //     required String price,
// // // // //     required String seats,
// // // // //   }) {
// // // // //     return Container(
// // // // //       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// // // // //       child: ClipPath(
// // // // //         clipper: TicketClipper(),
// // // // //         child: Container(
// // // // //           decoration: BoxDecoration(
// // // // //             color: Colors.white,
// // // // //             boxShadow: [
// // // // //               BoxShadow(
// // // // //                 color: Colors.grey.withOpacity(0.1),
// // // // //                 spreadRadius: 1,
// // // // //                 blurRadius: 6,
// // // // //                 offset: const Offset(0, 2),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //           child: Padding(
// // // // //             padding: const EdgeInsets.all(16.0),
// // // // //             child: Column(
// // // // //               children: [
// // // // //                 // Company name and badge row
// // // // //                 Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                   children: [
// // // // //                     Row(
// // // // //                       children: [
// // // // //                         const Icon(
// // // // //                           Icons.directions_bus,
// // // // //                           size: 20,
// // // // //                           color: Colors.black87,
// // // // //                         ),
// // // // //                         const SizedBox(width: 8),
// // // // //                         Text(
// // // // //                           companyName,
// // // // //                           style: const TextStyle(
// // // // //                             fontSize: 16,
// // // // //                             fontWeight: FontWeight.w600,
// // // // //                             color: Colors.black87,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                     Container(
// // // // //                       padding: const EdgeInsets.symmetric(
// // // // //                         horizontal: 8,
// // // // //                         vertical: 4,
// // // // //                       ),
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: badgeColor,
// // // // //                         borderRadius: BorderRadius.circular(12),
// // // // //                       ),
// // // // //                       child: Text(
// // // // //                         badgeText,
// // // // //                         style: TextStyle(
// // // // //                           color: badgeTextColor,
// // // // //                           fontSize: 12,
// // // // //                           fontWeight: FontWeight.w500,
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),

// // // // //                 const SizedBox(height: 16),

// // // // //                 // Route and time row
// // // // //                 Row(
// // // // //                   children: [
// // // // //                     // Departure
// // // // //                     Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           fromCity,
// // // // //                           style: TextStyle(
// // // // //                             color: Colors.grey[600],
// // // // //                             fontSize: 12,
// // // // //                           ),
// // // // //                         ),
// // // // //                         Text(
// // // // //                           departureTime,
// // // // //                           style: const TextStyle(
// // // // //                             fontSize: 18,
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                             color: Colors.black87,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),

// // // // //                     // Route line with bus icon
// // // // //                     Expanded(
// // // // //                       child: Container(
// // // // //                         margin: const EdgeInsets.symmetric(horizontal: 16),
// // // // //                         child: Row(
// // // // //                           children: [
// // // // //                             Container(
// // // // //                               width: 8,
// // // // //                               height: 8,
// // // // //                               decoration: const BoxDecoration(
// // // // //                                 color: Color(0xFF4A90E2),
// // // // //                                 shape: BoxShape.circle,
// // // // //                               ),
// // // // //                             ),
// // // // //                             Expanded(
// // // // //                               child: Container(
// // // // //                                 height: 2,
// // // // //                                 color: const Color(0xFF4A90E2),
// // // // //                                 child: Row(
// // // // //                                   mainAxisAlignment: MainAxisAlignment.center,
// // // // //                                   children: [
// // // // //                                     Container(
// // // // //                                       padding: const EdgeInsets.all(4),
// // // // //                                       decoration: const BoxDecoration(
// // // // //                                         color: Color(0xFF4A90E2),
// // // // //                                         shape: BoxShape.circle,
// // // // //                                       ),
// // // // //                                       child: const Icon(
// // // // //                                         Icons.directions_bus,
// // // // //                                         color: Colors.white,
// // // // //                                         size: 16,
// // // // //                                       ),
// // // // //                                     ),
// // // // //                                   ],
// // // // //                                 ),
// // // // //                               ),
// // // // //                             ),
// // // // //                             Container(
// // // // //                               width: 8,
// // // // //                               height: 8,
// // // // //                               decoration: const BoxDecoration(
// // // // //                                 color: Color(0xFF4A90E2),
// // // // //                                 shape: BoxShape.circle,
// // // // //                               ),
// // // // //                             ),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),

// // // // //                     // Arrival
// // // // //                     Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.end,
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           toCity,
// // // // //                           style: TextStyle(
// // // // //                             color: Colors.grey[600],
// // // // //                             fontSize: 12,
// // // // //                           ),
// // // // //                         ),
// // // // //                         Text(
// // // // //                           arrivalTime,
// // // // //                           style: const TextStyle(
// // // // //                             fontSize: 18,
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                             color: Colors.black87,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),

// // // // //                 const SizedBox(height: 16),

// // // // //                 // Divider
// // // // //                 Container(height: 1, color: Colors.grey[200]),

// // // // //                 const SizedBox(height: 12),

// // // // //                 // Price and select row
// // // // //                 Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                   children: [
// // // // //                     Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           price,
// // // // //                           style: const TextStyle(
// // // // //                             fontSize: 20,
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                             color: Colors.black87,
// // // // //                           ),
// // // // //                         ),
// // // // //                         Text(
// // // // //                           seats,
// // // // //                           style: const TextStyle(
// // // // //                             color: Color(0xFF4A90E2),
// // // // //                             fontSize: 12,
// // // // //                             fontWeight: FontWeight.w500,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                     const Row(
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           'Select',
// // // // //                           style: TextStyle(
// // // // //                             color: Color(0xFF4A90E2),
// // // // //                             fontSize: 16,
// // // // //                             fontWeight: FontWeight.w600,
// // // // //                           ),
// // // // //                         ),
// // // // //                         SizedBox(width: 4),
// // // // //                         Icon(
// // // // //                           Icons.arrow_forward_ios,
// // // // //                           color: Color(0xFF4A90E2),
// // // // //                           size: 14,
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class TicketClipper extends CustomClipper<Path> {
// // // // //   @override
// // // // //   Path getClip(Size size) {
// // // // //     Path path = Path();
// // // // //     double circleRadius = 12.0;
// // // // //     double middleY = size.height / 2;

// // // // //     // Start from top left, with rounded corner
// // // // //     path.moveTo(12, 0);
// // // // //     path.lineTo(size.width - 12, 0);
// // // // //     path.quadraticBezierTo(size.width, 0, size.width, 12);

// // // // //     // Right side - go down to middle, create semicircle cut
// // // // //     path.lineTo(size.width, middleY - circleRadius);
// // // // //     path.arcToPoint(
// // // // //       Offset(size.width, middleY + circleRadius),
// // // // //       radius: Radius.circular(circleRadius),
// // // // //       clockwise: false,
// // // // //     );

// // // // //     // Continue down right side
// // // // //     path.lineTo(size.width, size.height - 12);
// // // // //     path.quadraticBezierTo(
// // // // //       size.width,
// // // // //       size.height,
// // // // //       size.width - 12,
// // // // //       size.height,
// // // // //     );

// // // // //     // Bottom side
// // // // //     path.lineTo(12, size.height);
// // // // //     path.quadraticBezierTo(0, size.height, 0, size.height - 12);

// // // // //     // Left side - go up to middle, create semicircle cut
// // // // //     path.lineTo(0, middleY + circleRadius);
// // // // //     path.arcToPoint(
// // // // //       Offset(0, middleY - circleRadius),
// // // // //       radius: Radius.circular(circleRadius),
// // // // //       clockwise: false,
// // // // //     );

// // // // //     // Continue up left side
// // // // //     path.lineTo(0, 12);
// // // // //     path.quadraticBezierTo(0, 0, 12, 0);

// // // // //     path.close();
// // // // //     return path;
// // // // //   }

// // // // //   @override
// // // // //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // // // // }

















// // // // import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// // // // import 'package:flutter/material.dart';

// // // // class PostedTickets extends StatefulWidget {
// // // //   const PostedTickets({super.key});

// // // //   @override
// // // //   State<PostedTickets> createState() => _PostedTicketsState();
// // // // }

// // // // class _PostedTicketsState extends State<PostedTickets> {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.grey[50],
// // // //       appBar: AppBar(
// // // //         backgroundColor: Colors.white,
// // // //         elevation: 0,
// // // //         title: const Text(
// // // //           'My Posted Tickets',
// // // //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
// // // //         ),
// // // //         leading: IconButton(
// // // //           onPressed: () {
// // // //             Navigator.of(context).pop();
// // // //           },
// // // //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
// // // //         ),
// // // //       ),
// // // //       body: ListView.builder(
// // // //         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
// // // //         itemCount: 3,
// // // //         itemBuilder: (context, index) {
// // // //           return _buildMovieTicketCard(context, index);
// // // //         },
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildMovieTicketCard(BuildContext context, int index) {
// // // //     return Container(
// // // //       margin: const EdgeInsets.only(bottom: 12),
// // // //       padding: const EdgeInsets.all(12),
// // // //       decoration: BoxDecoration(
// // // //         color: Colors.white,
// // // //         borderRadius: BorderRadius.circular(12),
// // // //         boxShadow: [
// // // //           BoxShadow(
// // // //             color: Colors.grey.withOpacity(0.1),
// // // //             spreadRadius: 1,
// // // //             blurRadius: 8,
// // // //             offset: const Offset(0, 2),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       child: Row(
// // // //         children: [
// // // //           // Movie Poster
// // // //           Container(
// // // //             width: 60,
// // // //             height: 80,
// // // //             decoration: BoxDecoration(
// // // //               color: Colors.grey[300],
// // // //               borderRadius: BorderRadius.circular(6),
// // // //               image: const DecorationImage(
// // // //                 image: AssetImage('assets/kubera.png'),
// // // //                 fit: BoxFit.cover,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(width: 12),

// // // //           // Movie Details
// // // //           Expanded(
// // // //             child: Column(
// // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // //               children: [
// // // //                 const Text(
// // // //                   'Kuberaa',
// // // //                   style: TextStyle(
// // // //                     fontSize: 16,
// // // //                     fontWeight: FontWeight.w600,
// // // //                     color: Colors.black87,
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(height: 4),
// // // //                 const Text(
// // // //                   '3D • Telugu',
// // // //                   style: TextStyle(fontSize: 12, color: Colors.grey),
// // // //                 ),
// // // //                 const SizedBox(height: 4),
// // // //                 const Text(
// // // //                   '4 Aug, 8:30 PM',
// // // //                   style: TextStyle(fontSize: 14, color: Colors.black),
// // // //                 ),
// // // //                 const SizedBox(height: 2),
// // // //                 const Text(
// // // //                   'INOX: GVK One, Hyderabad',
// // // //                   style: TextStyle(fontSize: 12, color: Colors.grey),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),

// // // //           // Price and Menu
// // // //           Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.end,
// // // //             children: [
// // // //               PopupMenuButton<String>(
// // // //                 onSelected: (value) {
// // // //                   _handleMenuAction(context, value, index);
// // // //                 },
// // // //                 itemBuilder: (BuildContext context) => [
// // // //                   const PopupMenuItem<String>(
// // // //                     value: 'edit',
// // // //                     child: Row(
// // // //                       children: [
// // // //                         Icon(Icons.edit, size: 18, color: Colors.blue),
// // // //                         SizedBox(width: 8),
// // // //                         Text('Edit'),
// // // //                       ],
// // // //                     ),
// // // //                   ),
// // // //                   const PopupMenuItem<String>(
// // // //                     value: 'delete',
// // // //                     child: Row(
// // // //                       children: [
// // // //                         Icon(Icons.delete, size: 18, color: Colors.red),
// // // //                         SizedBox(width: 8),
// // // //                         Text('Delete', style: TextStyle(color: Colors.red)),
// // // //                       ],
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //                 icon: const Icon(Icons.more_vert, color: Colors.grey),
// // // //                 padding: EdgeInsets.zero,
// // // //                 constraints: const BoxConstraints(),
// // // //               ),
// // // //               const SizedBox(height: 8),
// // // //               const Text(
// // // //                 '₹ 200',
// // // //                 style: TextStyle(
// // // //                   fontSize: 18,
// // // //                   fontWeight: FontWeight.w600,
// // // //                   color: Colors.black87,
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _handleMenuAction(BuildContext context, String action, int index) {
// // // //     switch (action) {
// // // //       case 'edit':
// // // //         _showEditDialog(context, index);
// // // //         break;
// // // //       case 'delete':
// // // //         _showDeleteDialog(context, index);
// // // //         break;
// // // //     }
// // // //   }

// // // //   void _showEditDialog(BuildContext context, int index) {
// // // //     Navigator.push(
// // // //       context,
// // // //       MaterialPageRoute(builder: (context) => SellMovieTicket()),
// // // //     );
// // // //   }

// // // //   void _showDeleteDialog(BuildContext context, int index) {
// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (BuildContext context) {
// // // //         return AlertDialog(
// // // //           title: const Text('Delete Ticket'),
// // // //           content: const Text('Are you sure you want to delete this ticket? This action cannot be undone.'),
// // // //           actions: [
// // // //             TextButton(
// // // //               onPressed: () {
// // // //                 Navigator.of(context).pop();
// // // //               },
// // // //               child: const Text('Cancel'),
// // // //             ),
// // // //             ElevatedButton(
// // // //               onPressed: () {
// // // //                 Navigator.of(context).pop();
// // // //                 // Implement delete functionality
// // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // //                   SnackBar(
// // // //                     content: Text('Ticket at index $index deleted'),
// // // //                     backgroundColor: Colors.red,
// // // //                   ),
// // // //                 );
// // // //               },
// // // //               style: ElevatedButton.styleFrom(
// // // //                 backgroundColor: Colors.red,
// // // //                 foregroundColor: Colors.white,
// // // //               ),
// // // //               child: const Text('Delete'),
// // // //             ),
// // // //           ],
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // // }

















// // // import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// // // import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// // // import 'package:backup_ticket/model/movie_ticket_model.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';

// // // class PostedTickets extends StatefulWidget {
// // //   const PostedTickets({super.key});

// // //   @override
// // //   State<PostedTickets> createState() => _PostedTicketsState();
// // // }

// // // class _PostedTicketsState extends State<PostedTickets> {
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // Load tickets when screen initializes
// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       Provider.of<MovieTicketProvider>(context, listen: false).fetchAllTickets();
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[50],
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         title: const Text(
// // //           'My Posted Tickets',
// // //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
// // //         ),
// // //         leading: IconButton(
// // //           onPressed: () {
// // //             Navigator.of(context).pop();
// // //           },
// // //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
// // //         ),
// // //         actions: [
// // //           // IconButton(
// // //           //   onPressed: () {
// // //           //     Provider.of<MovieTicketProvider>(context, listen: false).fetchAllTickets();
// // //           //   },
// // //           //   icon: const Icon(Icons.refresh, color: Colors.black87),
// // //           // ),
// // //         ],
// // //       ),
// // //       body: Consumer<MovieTicketProvider>(
// // //         builder: (context, provider, child) {
// // //           if (provider.isLoading) {
// // //             return const Center(
// // //               child: CircularProgressIndicator(),
// // //             );
// // //           }

// // //           if (provider.error != null) {
// // //             return Center(
// // //               child: Column(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: [
// // //                   Icon(
// // //                     Icons.error_outline,
// // //                     size: 64,
// // //                     color: Colors.grey[400],
// // //                   ),
// // //                   const SizedBox(height: 16),
// // //                   Text(
// // //                     'Error loading tickets',
// // //                     style: TextStyle(
// // //                       fontSize: 18,
// // //                       fontWeight: FontWeight.w500,
// // //                       color: Colors.grey[600],
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 8),
// // //                   Text(
// // //                     provider.error!,
// // //                     textAlign: TextAlign.center,
// // //                     style: TextStyle(
// // //                       fontSize: 14,
// // //                       color: Colors.grey[500],
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 16),
// // //                   ElevatedButton(
// // //                     onPressed: () {
// // //                       provider.fetchAllTickets();
// // //                     },
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: const Color(0xFF214194),
// // //                     ),
// // //                     child: const Text(
// // //                       'Retry',
// // //                       style: TextStyle(color: Colors.white),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             );
// // //           }

// // //           if (provider.tickets.isEmpty) {
// // //             return Center(
// // //               child: Column(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: [
// // //                   Icon(
// // //                     Icons.local_movies_outlined,
// // //                     size: 64,
// // //                     color: Colors.grey[400],
// // //                   ),
// // //                   const SizedBox(height: 16),
// // //                   Text(
// // //                     'No tickets posted yet',
// // //                     style: TextStyle(
// // //                       fontSize: 18,
// // //                       fontWeight: FontWeight.w500,
// // //                       color: Colors.grey[600],
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 8),
// // //                   Text(
// // //                     'Your posted movie tickets will appear here',
// // //                     style: TextStyle(
// // //                       fontSize: 14,
// // //                       color: Colors.grey[500],
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 24),
// // //                   ElevatedButton.icon(
// // //                     onPressed: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => const SellMovieTicket(),
// // //                         ),
// // //                       ).then((_) {
// // //                         // Refresh tickets when returning from sell screen
// // //                         provider.fetchAllTickets();
// // //                       });
// // //                     },
// // //                     icon: const Icon(Icons.add, color: Colors.white),
// // //                     label: const Text(
// // //                       'Post a Ticket',
// // //                       style: TextStyle(color: Colors.white),
// // //                     ),
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: const Color(0xFF214194),
// // //                       padding: const EdgeInsets.symmetric(
// // //                         horizontal: 24,
// // //                         vertical: 12,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             );
// // //           }

// // //           return RefreshIndicator(
// // //             onRefresh: () async {
// // //               await provider.fetchAllTickets();
// // //             },
// // //             child: ListView.builder(
// // //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
// // //               itemCount: provider.tickets.length,
// // //               itemBuilder: (context, index) {
// // //                 return _buildMovieTicketCard(context, provider.tickets[index], index);
// // //               },
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: () {
// // //           Navigator.push(
// // //             context,
// // //             MaterialPageRoute(
// // //               builder: (context) => const SellMovieTicket(),
// // //             ),
// // //           ).then((_) {
// // //             // Refresh tickets when returning from sell screen
// // //             Provider.of<MovieTicketProvider>(context, listen: false).fetchAllTickets();
// // //           });
// // //         },
// // //         backgroundColor: const Color(0xFF214194),
// // //         child: const Icon(Icons.add, color: Colors.white),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildMovieTicketCard(BuildContext context, MovieTicket ticket, int index) {
// // //     // Format the date
// // //     String formattedDate = '${ticket.showDate.day} ${_getMonthName(ticket.showDate.month)}, ${ticket.showTime}';
    
// // //     return Container(
// // //       margin: const EdgeInsets.only(bottom: 12),
// // //       padding: const EdgeInsets.all(12),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.grey.withOpacity(0.1),
// // //             spreadRadius: 1,
// // //             blurRadius: 8,
// // //             offset: const Offset(0, 2),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           // Movie Poster/Image
// // //           Container(
// // //             width: 60,
// // //             height: 80,
// // //             decoration: BoxDecoration(
// // //               color: Colors.grey[300],
// // //               borderRadius: BorderRadius.circular(6),
// // //             ),
// // //             child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
// // //                 ? ClipRRect(
// // //                     borderRadius: BorderRadius.circular(6),
// // //                     child: Image.network(
// // //                       ticket.ticketImageUrl!,
// // //                       fit: BoxFit.cover,
// // //                       loadingBuilder: (context, child, loadingProgress) {
// // //                         if (loadingProgress == null) return child;
// // //                         return Center(
// // //                           child: CircularProgressIndicator(
// // //                             value: loadingProgress.expectedTotalBytes != null
// // //                                 ? loadingProgress.cumulativeBytesLoaded /
// // //                                     loadingProgress.expectedTotalBytes!
// // //                                 : null,
// // //                             strokeWidth: 2,
// // //                           ),
// // //                         );
// // //                       },
// // //                       errorBuilder: (context, error, stackTrace) {
// // //                         return const Icon(
// // //                           Icons.local_movies,
// // //                           color: Colors.grey,
// // //                           size: 32,
// // //                         );
// // //                       },
// // //                     ),
// // //                   )
// // //                 : const Icon(
// // //                     Icons.local_movies,
// // //                     color: Colors.grey,
// // //                     size: 32,
// // //                   ),
// // //           ),
// // //           const SizedBox(width: 12),

// // //           // Movie Details
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   ticket.movieName,
// // //                   style: const TextStyle(
// // //                     fontSize: 16,
// // //                     fontWeight: FontWeight.w600,
// // //                     color: Colors.black87,
// // //                   ),
// // //                   maxLines: 1,
// // //                   overflow: TextOverflow.ellipsis,
// // //                 ),
// // //                 const SizedBox(height: 4),
// // //                 Text(
// // //                   '${ticket.ticketType} • ${ticket.numberOfTickets} ticket${ticket.numberOfTickets > 1 ? 's' : ''}',
// // //                   style: const TextStyle(fontSize: 12, color: Colors.grey),
// // //                 ),
// // //                 const SizedBox(height: 4),
// // //                 Text(
// // //                   formattedDate,
// // //                   style: const TextStyle(fontSize: 14, color: Colors.black),
// // //                 ),
// // //                 const SizedBox(height: 2),
// // //                 Text(
// // //                   ticket.theatrePlace,
// // //                   style: const TextStyle(fontSize: 12, color: Colors.grey),
// // //                   maxLines: 1,
// // //                   overflow: TextOverflow.ellipsis,
// // //                 ),
// // //               ],
// // //             ),
// // //           ),

// // //           // Price and Menu
// // //           Column(
// // //             crossAxisAlignment: CrossAxisAlignment.end,
// // //             children: [
// // //               // PopupMenuButton<String>(
// // //               //   onSelected: (value) {
// // //               //     _handleMenuAction(context, value, ticket);
// // //               //   },
// // //               //   itemBuilder: (BuildContext context) => [
// // //               //     const PopupMenuItem<String>(
// // //               //       value: 'edit',
// // //               //       child: Row(
// // //               //         children: [
// // //               //           Icon(Icons.edit, size: 18, color: Colors.blue),
// // //               //           SizedBox(width: 8),
// // //               //           Text('Edit'),
// // //               //         ],
// // //               //       ),
// // //               //     ),
// // //               //     const PopupMenuItem<String>(
// // //               //       value: 'delete',
// // //               //       child: Row(
// // //               //         children: [
// // //               //           Icon(Icons.delete, size: 18, color: Colors.red),
// // //               //           SizedBox(width: 8),
// // //               //           Text('Delete', style: TextStyle(color: Colors.red)),
// // //               //         ],
// // //               //       ),
// // //               //     ),
// // //               //   ],
// // //               //   icon: const Icon(Icons.more_vert, color: Colors.grey),
// // //               //   padding: EdgeInsets.zero,
// // //               //   constraints: const BoxConstraints(),
// // //               // ),
// // //               const SizedBox(height: 8),
// // //               Text(
// // //                 '₹ ${ticket.totalPrice.toStringAsFixed(0)}',
// // //                 style: const TextStyle(
// // //                   fontSize: 18,
// // //                   fontWeight: FontWeight.w600,
// // //                   color: Colors.black87,
// // //                 ),
// // //               ),
// // //               Text(
// // //                 '₹ ${ticket.pricePerTicket.toStringAsFixed(0)} each',
// // //                 style: const TextStyle(
// // //                   fontSize: 10,
// // //                   color: Colors.grey,
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   void _handleMenuAction(BuildContext context, String action, MovieTicket ticket) {
// // //     switch (action) {
// // //       case 'edit':
// // //         _showEditDialog(context, ticket);
// // //         break;
// // //       case 'delete':
// // //         _showDeleteDialog(context, ticket);
// // //         break;
// // //     }
// // //   }

// // //   void _showEditDialog(BuildContext context, MovieTicket ticket) {
// // //     // Navigate to edit screen (you might want to create an edit version of SellMovieTicket)
// // //     Navigator.push(
// // //       context,
// // //       MaterialPageRoute(
// // //         builder: (context) => const SellMovieTicket(), // Pass ticket data for editing
// // //       ),
// // //     ).then((_) {
// // //       // Refresh tickets when returning from edit screen
// // //       Provider.of<MovieTicketProvider>(context, listen: false).fetchAllTickets();
// // //     });
// // //   }

// // //   void _showDeleteDialog(BuildContext context, MovieTicket ticket) {
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: const Text('Delete Ticket'),
// // //           content: Text(
// // //             'Are you sure you want to delete "${ticket.movieName}" ticket? This action cannot be undone.',
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () {
// // //                 Navigator.of(context).pop();
// // //               },
// // //               child: const Text('Cancel'),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: () async {
// // //                 Navigator.of(context).pop();
                
// // //                 // Show loading
// // //                 showDialog(
// // //                   context: context,
// // //                   barrierDismissible: false,
// // //                   builder: (context) => const Center(
// // //                     child: CircularProgressIndicator(),
// // //                   ),
// // //                 );

// // //                 try {
// // //                   final provider = Provider.of<MovieTicketProvider>(context, listen: false);
// // //                   await provider.deleteMovieTicket(ticket.id!);
                  
// // //                   Navigator.of(context).pop(); // Close loading dialog
                  
// // //                   ScaffoldMessenger.of(context).showSnackBar(
// // //                     SnackBar(
// // //                       content: Text('${ticket.movieName} ticket deleted successfully'),
// // //                       backgroundColor: Colors.green,
// // //                     ),
// // //                   );
// // //                 } catch (e) {
// // //                   Navigator.of(context).pop(); // Close loading dialog
                  
// // //                   ScaffoldMessenger.of(context).showSnackBar(
// // //                     SnackBar(
// // //                       content: Text('Error deleting ticket: $e'),
// // //                       backgroundColor: Colors.red,
// // //                     ),
// // //                   );
// // //                 }
// // //               },
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: Colors.red,
// // //                 foregroundColor: Colors.white,
// // //               ),
// // //               child: const Text('Delete'),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   String _getMonthName(int month) {
// // //     const months = [
// // //       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
// // //       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
// // //     ];
// // //     return months[month - 1];
// // //   }
// // // }













// // import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// // import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// // import 'package:backup_ticket/model/movie_ticket_model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // class PostedTickets extends StatefulWidget {
// //   const PostedTickets({super.key});

// //   @override
// //   State<PostedTickets> createState() => _PostedTicketsState();
// // }

// // class _PostedTicketsState extends State<PostedTickets> {
// //   List<MovieTicket> _userTickets = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Load current user tickets when screen initializes
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _loadUserTickets();
// //     });
// //   }

// //   Future<void> _loadUserTickets() async {
// //     final provider = Provider.of<MovieTicketProvider>(context, listen: false);
// //     final userTickets = await provider.fetchCurrentUserTickets();
// //     setState(() {
// //       _userTickets = userTickets;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         title: const Text(
// //           'My Posted Tickets',
// //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
// //         ),
// //         leading: IconButton(
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
// //         ),
// //         // actions: [
// //         //   IconButton(
// //         //     onPressed: () {
// //         //       _loadUserTickets();
// //         //     },
// //         //     icon: const Icon(Icons.refresh, color: Colors.black87),
// //         //   ),
// //         // ],
// //       ),
// //       body: Consumer<MovieTicketProvider>(
// //         builder: (context, provider, child) {
// //           if (provider.isLoading) {
// //             return const Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }

// //           if (provider.error != null) {
// //             return Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Icon(
// //                     Icons.error_outline,
// //                     size: 64,
// //                     color: Colors.grey[400],
// //                   ),
// //                   const SizedBox(height: 16),
// //                   Text(
// //                     'Error loading tickets',
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w500,
// //                       color: Colors.grey[600],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   Text(
// //                     provider.error!,
// //                     textAlign: TextAlign.center,
// //                     style: TextStyle(
// //                       fontSize: 14,
// //                       color: Colors.grey[500],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 16),
// //                   ElevatedButton(
// //                     onPressed: () {
// //                       _loadUserTickets();
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFF214194),
// //                     ),
// //                     child: const Text(
// //                       'Retry',
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           }

// //           if (_userTickets.isEmpty) {
// //             return Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Icon(
// //                     Icons.local_movies_outlined,
// //                     size: 64,
// //                     color: Colors.grey[400],
// //                   ),
// //                   const SizedBox(height: 16),
// //                   Text(
// //                     'No tickets posted yet',
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w500,
// //                       color: Colors.grey[600],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   Text(
// //                     'Your posted movie tickets will appear here',
// //                     style: TextStyle(
// //                       fontSize: 14,
// //                       color: Colors.grey[500],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 24),
// //                   ElevatedButton.icon(
// //                     onPressed: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => const SellMovieTicket(),
// //                         ),
// //                       ).then((_) {
// //                         // Refresh tickets when returning from sell screen
// //                         _loadUserTickets();
// //                       });
// //                     },
// //                     icon: const Icon(Icons.add, color: Colors.white),
// //                     label: const Text(
// //                       'Post a Ticket',
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFF214194),
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 24,
// //                         vertical: 12,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           }

// //           return RefreshIndicator(
// //             onRefresh: () async {
// //               await _loadUserTickets();
// //             },
// //             child: ListView.builder(
// //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
// //               itemCount: _userTickets.length,
// //               itemBuilder: (context, index) {
// //                 return _buildMovieTicketCard(context, _userTickets[index], index);
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(
// //               builder: (context) => const SellMovieTicket(),
// //             ),
// //           ).then((_) {
// //             // Refresh tickets when returning from sell screen
// //             _loadUserTickets();
// //           });
// //         },
// //         backgroundColor: const Color(0xFF214194),
// //         child: const Icon(Icons.add, color: Colors.white),
// //       ),
// //     );
// //   }

// //   Widget _buildMovieTicketCard(BuildContext context, MovieTicket ticket, int index) {
// //     // Format the date
// //     String formattedDate = '${ticket.showDate.day} ${_getMonthName(ticket.showDate.month)}, ${ticket.showTime}';
    
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       padding: const EdgeInsets.all(12),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.1),
// //             spreadRadius: 1,
// //             blurRadius: 8,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           // Movie Poster/Image
// //           Container(
// //             width: 60,
// //             height: 80,
// //             decoration: BoxDecoration(
// //               color: Colors.grey[300],
// //               borderRadius: BorderRadius.circular(6),
// //             ),
// //             child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
// //                 ? ClipRRect(
// //                     borderRadius: BorderRadius.circular(6),
// //                     child: Image.network(
// //                       ticket.ticketImageUrl!,
// //                       fit: BoxFit.cover,
// //                       loadingBuilder: (context, child, loadingProgress) {
// //                         if (loadingProgress == null) return child;
// //                         return Center(
// //                           child: CircularProgressIndicator(
// //                             value: loadingProgress.expectedTotalBytes != null
// //                                 ? loadingProgress.cumulativeBytesLoaded /
// //                                     loadingProgress.expectedTotalBytes!
// //                                 : null,
// //                             strokeWidth: 2,
// //                           ),
// //                         );
// //                       },
// //                       errorBuilder: (context, error, stackTrace) {
// //                         return const Icon(
// //                           Icons.local_movies,
// //                           color: Colors.grey,
// //                           size: 32,
// //                         );
// //                       },
// //                     ),
// //                   )
// //                 : const Icon(
// //                     Icons.local_movies,
// //                     color: Colors.grey,
// //                     size: 32,
// //                   ),
// //           ),
// //           const SizedBox(width: 12),

// //           // Movie Details
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   ticket.movieName,
// //                   style: const TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.black87,
// //                   ),
// //                   maxLines: 1,
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //                 const SizedBox(height: 4),
// //                 Text(
// //                   '${ticket.ticketType} • ${ticket.numberOfTickets} ticket${ticket.numberOfTickets > 1 ? 's' : ''}',
// //                   style: const TextStyle(fontSize: 12, color: Colors.grey),
// //                 ),
// //                 const SizedBox(height: 4),
// //                 Text(
// //                   formattedDate,
// //                   style: const TextStyle(fontSize: 14, color: Colors.black),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   ticket.theatrePlace,
// //                   style: const TextStyle(fontSize: 12, color: Colors.grey),
// //                   maxLines: 1,
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Price and Menu
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.end,
// //             children: [
// //               // PopupMenuButton<String>(
// //               //   onSelected: (value) {
// //               //     _handleMenuAction(context, value, ticket);
// //               //   },
// //               //   itemBuilder: (BuildContext context) => [
// //               //     const PopupMenuItem<String>(
// //               //       value: 'edit',
// //               //       child: Row(
// //               //         children: [
// //               //           Icon(Icons.edit, size: 18, color: Colors.blue),
// //               //           SizedBox(width: 8),
// //               //           Text('Edit'),
// //               //         ],
// //               //       ),
// //               //     ),
// //               //     const PopupMenuItem<String>(
// //               //       value: 'delete',
// //               //       child: Row(
// //               //         children: [
// //               //           Icon(Icons.delete, size: 18, color: Colors.red),
// //               //           SizedBox(width: 8),
// //               //           Text('Delete', style: TextStyle(color: Colors.red)),
// //               //         ],
// //               //       ),
// //               //     ),
// //               //   ],
// //               //   icon: const Icon(Icons.more_vert, color: Colors.grey),
// //               //   padding: EdgeInsets.zero,
// //               //   constraints: const BoxConstraints(),
// //               // ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 '₹ ${ticket.totalPrice.toStringAsFixed(0)}',
// //                 style: const TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.w600,
// //                   color: Colors.black87,
// //                 ),
// //               ),
// //               Text(
// //                 '₹ ${ticket.pricePerTicket.toStringAsFixed(0)} each',
// //                 style: const TextStyle(
// //                   fontSize: 10,
// //                   color: Colors.grey,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // void _handleMenuAction(BuildContext context, String action, MovieTicket ticket) {
// //   //   switch (action) {
// //   //     case 'edit':
// //   //       _showEditDialog(context, ticket);
// //   //       break;
// //   //     case 'delete':
// //   //       _showDeleteDialog(context, ticket);
// //   //       break;
// //   //   }
// //   // }

// //   void _showEditDialog(BuildContext context, MovieTicket ticket) {
// //     // Navigate to edit screen (you might want to create an edit version of SellMovieTicket)
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => const SellMovieTicket(), // Pass ticket data for editing
// //       ),
// //     ).then((_) {
// //       // Refresh tickets when returning from edit screen
// //       _loadUserTickets();
// //     });
// //   }

// //   void _showDeleteDialog(BuildContext context, MovieTicket ticket) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text('Delete Ticket'),
// //           content: Text(
// //             'Are you sure you want to delete "${ticket.movieName}" ticket? This action cannot be undone.',
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: const Text('Cancel'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 Navigator.of(context).pop();
                
// //                 // Show loading
// //                 showDialog(
// //                   context: context,
// //                   barrierDismissible: false,
// //                   builder: (context) => const Center(
// //                     child: CircularProgressIndicator(),
// //                   ),
// //                 );

// //                 try {
// //                   final provider = Provider.of<MovieTicketProvider>(context, listen: false);
// //                   await provider.deleteMovieTicket(ticket.id!);
                  
// //                   Navigator.of(context).pop(); // Close loading dialog
                  
// //                   // Refresh user tickets after deletion
// //                   _loadUserTickets();
                  
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     SnackBar(
// //                       content: Text('${ticket.movieName} ticket deleted successfully'),
// //                       backgroundColor: Colors.green,
// //                     ),
// //                   );
// //                 } catch (e) {
// //                   Navigator.of(context).pop(); // Close loading dialog
                  
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     SnackBar(
// //                       content: Text('Error deleting ticket: $e'),
// //                       backgroundColor: Colors.red,
// //                     ),
// //                   );
// //                 }
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.red,
// //                 foregroundColor: Colors.white,
// //               ),
// //               child: const Text('Delete'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   String _getMonthName(int month) {
// //     const months = [
// //       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
// //       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
// //     ];
// //     return months[month - 1];
// //   }
// // }




















// import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
// import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:backup_ticket/provider/selltickets/sell_bus_ticket_provider.dart';
// import 'package:backup_ticket/model/movie_ticket_model.dart';
// import 'package:backup_ticket/model/bus_ticket_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class PostedTickets extends StatefulWidget {
//   const PostedTickets({super.key});

//   @override
//   State<PostedTickets> createState() => _PostedTicketsState();
// }

// class _PostedTicketsState extends State<PostedTickets> with SingleTickerProviderStateMixin {
//   List<MovieTicket> _userMovieTickets = [];
//   List<BusTicket> _userBusTickets = [];
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
    
//     // Load tickets when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadUserMovieTickets();
//       _loadUserBusTickets();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadUserMovieTickets() async {
//     final provider = Provider.of<MovieTicketProvider>(context, listen: false);
//     final userTickets = await provider.fetchCurrentUserTickets();
//     setState(() {
//       _userMovieTickets = userTickets;
//     });
//   }

//   Future<void> _loadUserBusTickets() async {
//     final provider = Provider.of<BusTicketProvider>(context, listen: false);
//     await provider.fetchMyTickets();
//     setState(() {
//       _userBusTickets = provider.tickets;
//     });
//   }

//   Future<void> _refreshAllTickets() async {
//     await Future.wait([
//       _loadUserMovieTickets(),
//       _loadUserBusTickets(),
//     ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'My Posted Tickets',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
//         ),
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: const Color(0xFF214194),
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: const Color(0xFF214194),
//           indicatorWeight: 3,
//           tabs: const [
//             Tab(
//               icon: Icon(Icons.local_movies),
//               text: 'Movie Tickets',
//             ),
//             Tab(
//               icon: Icon(Icons.directions_bus),
//               text: 'Bus Tickets',
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildMovieTicketsTab(),
//           _buildBusTicketsTab(),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddTicketDialog();
//         },
//         backgroundColor: const Color(0xFF214194),
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }

//   // Movie Tickets Tab
//   Widget _buildMovieTicketsTab() {
//     return Consumer<MovieTicketProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (provider.error != null) {
//           return _buildErrorView(
//             message: 'Error loading movie tickets',
//             error: provider.error!,
//             onRetry: _loadUserMovieTickets,
//           );
//         }

//         if (_userMovieTickets.isEmpty) {
//           return _buildEmptyView(
//             icon: Icons.local_movies_outlined,
//             message: 'No movie tickets posted yet',
//             subtitle: 'Your posted movie tickets will appear here',
//             onAddPressed: () => _navigateToSellMovieTicket(),
//           );
//         }

//         return RefreshIndicator(
//           onRefresh: _loadUserMovieTickets,
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//             itemCount: _userMovieTickets.length,
//             itemBuilder: (context, index) {
//               return _buildMovieTicketCard(context, _userMovieTickets[index]);
//             },
//           ),
//         );
//       },
//     );
//   }

//   // Bus Tickets Tab
//   Widget _buildBusTicketsTab() {
//     return Consumer<BusTicketProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (_userBusTickets.isEmpty) {
//           return _buildEmptyView(
//             icon: Icons.directions_bus_outlined,
//             message: 'No bus tickets posted yet',
//             subtitle: 'Your posted bus tickets will appear here',
//             onAddPressed: () => _navigateToSellBusTicket(),
//           );
//         }

//         return RefreshIndicator(
//           onRefresh: _loadUserBusTickets,
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//             itemCount: _userBusTickets.length,
//             itemBuilder: (context, index) {
//               return _buildBusTicketCard(context, _userBusTickets[index]);
//             },
//           ),
//         );
//       },
//     );
//   }

//   // Movie Ticket Card
//   Widget _buildMovieTicketCard(BuildContext context, MovieTicket ticket) {
//     String formattedDate = '${ticket.showDate.day} ${_getMonthName(ticket.showDate.month)}, ${ticket.showTime}';
    
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Movie Poster
//           Container(
//             width: 60,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(6),
//                     child: Image.network(
//                       ticket.ticketImageUrl!,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return const Icon(Icons.local_movies, color: Colors.grey, size: 32);
//                       },
//                     ),
//                   )
//                 : const Icon(Icons.local_movies, color: Colors.grey, size: 32),
//           ),
//           const SizedBox(width: 12),

//           // Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   ticket.movieName,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${ticket.ticketType} • ${ticket.numberOfTickets} ticket${ticket.numberOfTickets > 1 ? 's' : ''}',
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   formattedDate,
//                   style: const TextStyle(fontSize: 14, color: Colors.black),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   ticket.theatrePlace,
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),

//           // Price
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               const SizedBox(height: 8),
//               Text(
//                 '₹ ${ticket.totalPrice.toStringAsFixed(0)}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//               Text(
//                 '₹ ${ticket.pricePerTicket.toStringAsFixed(0)} each',
//                 style: const TextStyle(fontSize: 10, color: Colors.grey),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Bus Ticket Card
//   Widget _buildBusTicketCard(BuildContext context, BusTicket ticket) {
//     String formatted = '${ticket.dateOfJourney.day} ${_getMonthName(ticket.dateOfJourney.month)}';
//     // String formattedDate = '${ticket.dateOfJourney.day} ${_getMonthName(ticket.dateOfJourney.month)}';
    
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Bus Icon/Image
//           Container(
//             width: 60,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(6),
//                     child: Image.network(
//                       ticket.ticketImageUrl!,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return const Icon(Icons.directions_bus, color: Colors.grey, size: 32);
//                       },
//                     ),
//                   )
//                 : const Icon(Icons.directions_bus, color: Colors.grey, size: 32),
//           ),
//           const SizedBox(width: 12),

//           // Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   ticket.busName,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${ticket.ticketType} • ${ticket.busName} seat${ticket.numberOfTickets > 1 ? 's' : ''}',
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '$formatted, ${ticket.dateOfJourney}',
//                   style: const TextStyle(fontSize: 14, color: Colors.black),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   '${ticket.pickupPoint} → ${ticket.dropPoint}',
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),

//           // Price
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               const SizedBox(height: 8),
//               Text(
//                 '₹ ${ticket.totalPrice.toStringAsFixed(0)}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//               Text(
//                 '₹ ${ticket.pricePerTicket.toStringAsFixed(0)} each',
//                 style: const TextStyle(fontSize: 10, color: Colors.grey),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Empty View
//   Widget _buildEmptyView({
//     required IconData icon,
//     required String message,
//     required String subtitle,
//     required VoidCallback onAddPressed,
//   }) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 64, color: Colors.grey[400]),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             subtitle,
//             style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: onAddPressed,
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text(
//               'Post a Ticket',
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF214194),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Error View
//   Widget _buildErrorView({
//     required String message,
//     required String error,
//     required VoidCallback onRetry,
//   }) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             error,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: onRetry,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF214194),
//             ),
//             child: const Text('Retry', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   // Show dialog to choose ticket type
//   void _showAddTicketDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add Ticket'),
//           content: const Text('What type of ticket would you like to post?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _navigateToSellBusTicket();
//               },
//               icon: const Icon(Icons.directions_bus, size: 18),
//               label: const Text('Bus Ticket'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF214194),
//                 foregroundColor: Colors.white,
//               ),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _navigateToSellMovieTicket();
//               },
//               icon: const Icon(Icons.local_movies, size: 18),
//               label: const Text('Movie Ticket'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF214194),
//                 foregroundColor: Colors.white,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _navigateToSellMovieTicket() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const SellMovieTicket(),
//       ),
//     ).then((_) {
//       _loadUserMovieTickets();
//     });
//   }

//   void _navigateToSellBusTicket() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const SellBusTicket(),
//       ),
//     ).then((_) {
//       _loadUserBusTickets();
//     });
    
//     // Temporary - show snackbar
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Navigate to SellBusTicket screen'),
//         backgroundColor: Color(0xFF214194),
//       ),
//     );
//   }

//   String _getMonthName(int month) {
//     const months = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return months[month - 1];
//   }
// }
















// import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
// import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:backup_ticket/provider/selltickets/sell_bus_ticket_provider.dart';
// import 'package:backup_ticket/model/movie_ticket_model.dart';
// import 'package:backup_ticket/model/bus_ticket_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class PostedTickets extends StatefulWidget {
//   const PostedTickets({super.key});

//   @override
//   State<PostedTickets> createState() => _PostedTicketsState();
// }

// class _PostedTicketsState extends State<PostedTickets> with SingleTickerProviderStateMixin {
//   List<MovieTicket> _userMovieTickets = [];
//   List<BusTicket> _userBusTickets = [];
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
    
//     // Load tickets when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadUserMovieTickets();
//       _loadUserBusTickets();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadUserMovieTickets() async {
//     final provider = Provider.of<MovieTicketProvider>(context, listen: false);
//     final userTickets = await provider.fetchCurrentUserTickets();
//     setState(() {
//       _userMovieTickets = userTickets;
//     });
//   }

//   Future<void> _loadUserBusTickets() async {
//     try {
//       final provider = Provider.of<BusTicketProvider>(context, listen: false);
//       await provider.fetchMyTickets();
//       if (mounted) {
//         setState(() {
//           _userBusTickets = provider.tickets;
//         });
//       }
//     } catch (e) {
//       debugPrint('Error loading bus tickets: $e');
//     }
//   }

//   Future<void> _refreshAllTickets() async {
//     await Future.wait([
//       _loadUserMovieTickets(),
//       _loadUserBusTickets(),
//     ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'My Posted Tickets',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
//         ),
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: const Color(0xFF214194),
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: const Color(0xFF214194),
//           indicatorWeight: 3,
//           tabs: const [
//             Tab(
//               icon: Icon(Icons.local_movies),
//               text: 'Movie Tickets',
//             ),
//             Tab(
//               icon: Icon(Icons.directions_bus),
//               text: 'Bus Tickets',
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildMovieTicketsTab(),
//           _buildBusTicketsTab(),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddTicketDialog();
//         },
//         backgroundColor: const Color(0xFF214194),
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }

//   // Movie Tickets Tab
//   Widget _buildMovieTicketsTab() {
//     return Consumer<MovieTicketProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (provider.error != null) {
//           return _buildErrorView(
//             message: 'Error loading movie tickets',
//             error: provider.error!,
//             onRetry: _loadUserMovieTickets,
//           );
//         }

//         if (_userMovieTickets.isEmpty) {
//           return _buildEmptyView(
//             icon: Icons.local_movies_outlined,
//             message: 'No movie tickets posted yet',
//             subtitle: 'Your posted movie tickets will appear here',
//             onAddPressed: () => _navigateToSellMovieTicket(),
//           );
//         }

//         return RefreshIndicator(
//           onRefresh: _loadUserMovieTickets,
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//             itemCount: _userMovieTickets.length,
//             itemBuilder: (context, index) {
//               return _buildMovieTicketCard(context, _userMovieTickets[index]);
//             },
//           ),
//         );
//       },
//     );
//   }

//   // Bus Tickets Tab
//   Widget _buildBusTicketsTab() {
//     return Consumer<BusTicketProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         // Use provider.tickets instead of local state for real-time updates
//         final tickets = provider.tickets;

//         if (tickets.isEmpty) {
//           return _buildEmptyView(
//             icon: Icons.directions_bus_outlined,
//             message: 'No bus tickets posted yet',
//             subtitle: 'Your posted bus tickets will appear here',
//             onAddPressed: () => _navigateToSellBusTicket(),
//           );
//         }

//         return RefreshIndicator(
//           onRefresh: _loadUserBusTickets,
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//             itemCount: tickets.length,
//             itemBuilder: (context, index) {
//               return _buildBusTicketCard(context, tickets[index]);
//             },
//           ),
//         );
//       },
//     );
//   }

//   // Movie Ticket Card
//   Widget _buildMovieTicketCard(BuildContext context, MovieTicket ticket) {
//     String formattedDate = '${ticket.showDate.day} ${_getMonthName(ticket.showDate.month)}, ${ticket.showTime}';
    
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Movie Poster
//           Container(
//             width: 60,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(6),
//                     child: Image.network(
//                       ticket.ticketImageUrl!,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return const Icon(Icons.local_movies, color: Colors.grey, size: 32);
//                       },
//                     ),
//                   )
//                 : const Icon(Icons.local_movies, color: Colors.grey, size: 32),
//           ),
//           const SizedBox(width: 12),

//           // Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   ticket.movieName,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${ticket.ticketType} • ${ticket.numberOfTickets} ticket${ticket.numberOfTickets > 1 ? 's' : ''}',
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   formattedDate,
//                   style: const TextStyle(fontSize: 14, color: Colors.black),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   ticket.theatrePlace,
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),

//           // Price
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               const SizedBox(height: 8),
//               Text(
//                 '₹ ${ticket.totalPrice.toStringAsFixed(0)}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//               // Text(
//               //   '₹ ${ticket.pricePerTicket.toStringAsFixed(0)} each',
//               //   style: const TextStyle(fontSize: 10, color: Colors.grey),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Bus Ticket Card
//   Widget _buildBusTicketCard(BuildContext context, BusTicket ticket) {
//     String formattedDate = '${ticket.dateOfJourney.day} ${_getMonthName(ticket.dateOfJourney.month)} ${ticket.dateOfJourney.year}';
    
//     // Format time properly - remove seconds if present
//     String formattedTime = ticket.dropPoint;
//     if (formattedTime.contains(':')) {
//       List<String> timeParts = formattedTime.split(':');
//       if (timeParts.length >= 2) {
//         // Take only hours and minutes, ignore seconds
//         formattedTime = '${timeParts[0]}:${timeParts[1]}';
//       }
//     }
    
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Bus Icon/Image
//           Container(
//             width: 60,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(6),
//                     child: Image.network(
//                       ticket.ticketImageUrl!,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return const Icon(Icons.directions_bus, color: Colors.grey, size: 32);
//                       },
//                     ),
//                   )
//                 : const Icon(Icons.directions_bus, color: Colors.grey, size: 32),
//           ),
//           const SizedBox(width: 12),

//           // Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   ticket.busName,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${ticket.ticketType} • ${ticket.busName} seat${ticket.numberOfTickets > 1 ? 's' : ''}',
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '$formattedDate, $formattedTime',
//                   style: const TextStyle(fontSize: 14, color: Colors.black),
//                 ),
//                    Text(
//                   '${ticket.boardingTime}',
//                   style: const TextStyle(fontSize: 14, color: Colors.black),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   '${ticket.pickupPoint} → ${ticket.dropPoint}',
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),

//           // Price
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               const SizedBox(height: 8),
//               Text(
//                 '₹ ${ticket.totalPrice.toStringAsFixed(0)}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//               // Text(
//               //   '₹ ${ticket.pricePerTicket.toStringAsFixed(0)} each',
//               //   style: const TextStyle(fontSize: 10, color: Colors.grey),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Empty View
//   Widget _buildEmptyView({
//     required IconData icon,
//     required String message,
//     required String subtitle,
//     required VoidCallback onAddPressed,
//   }) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 64, color: Colors.grey[400]),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             subtitle,
//             style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: onAddPressed,
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text(
//               'Post a Ticket',
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF214194),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Error View
//   Widget _buildErrorView({
//     required String message,
//     required String error,
//     required VoidCallback onRetry,
//   }) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             error,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: onRetry,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF214194),
//             ),
//             child: const Text('Retry', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   // Show dialog to choose ticket type
//   void _showAddTicketDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add Ticket'),
//           content: const Text('What type of ticket would you like to post?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _navigateToSellBusTicket();
//               },
//               icon: const Icon(Icons.directions_bus, size: 18),
//               label: const Text('Bus Ticket'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF214194),
//                 foregroundColor: Colors.white,
//               ),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _navigateToSellMovieTicket();
//               },
//               icon: const Icon(Icons.local_movies, size: 18),
//               label: const Text('Movie Ticket'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF214194),
//                 foregroundColor: Colors.white,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _navigateToSellMovieTicket() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const SellMovieTicket(),
//       ),
//     ).then((_) {
//       _loadUserMovieTickets();
//     });
//   }

//   void _navigateToSellBusTicket() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const SellBusTicket(),
//       ),
//     ).then((_) {
//       _loadUserBusTickets();
//     });
//   }

//   String _getMonthName(int month) {
//     const months = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return months[month - 1];
//   }
// }














import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
import 'package:backup_ticket/provider/selltickets/sell_bus_ticket_provider.dart';
import 'package:backup_ticket/model/movie_ticket_model.dart';
import 'package:backup_ticket/model/bus_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostedTickets extends StatefulWidget {
  const PostedTickets({super.key});

  @override
  State<PostedTickets> createState() => _PostedTicketsState();
}

class _PostedTicketsState extends State<PostedTickets> with SingleTickerProviderStateMixin {
  List<MovieTicket> _userMovieTickets = [];
  List<BusTicket> _userBusTickets = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Load tickets when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserMovieTickets();
      _loadUserBusTickets();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadUserMovieTickets() async {
    final provider = Provider.of<MovieTicketProvider>(context, listen: false);
    final userTickets = await provider.fetchCurrentUserTickets();
    setState(() {
      _userMovieTickets = userTickets;
    });
  }

  Future<void> _loadUserBusTickets() async {
    try {
      final provider = Provider.of<BusTicketProvider>(context, listen: false);
      await provider.fetchMyTickets();
      if (mounted) {
        setState(() {
          _userBusTickets = provider.tickets;
        });
      }
    } catch (e) {
      debugPrint('Error loading bus tickets: $e');
    }
  }

  Future<void> _refreshAllTickets() async {
    await Future.wait([
      _loadUserMovieTickets(),
      _loadUserBusTickets(),
    ]);
  }

  // Delete Movie Ticket
  Future<void> _deleteMovieTicket(MovieTicket ticket) async {
    // Check if ticket is sold or not available for deletion
    // Only pending tickets can be deleted
    bool canDelete = ticket.status == TicketStatus.pending;
    
    if (!canDelete) {
      _showCannotDeleteDialog('This ticket has already been sold or is no longer available for deletion.');
      return;
    }

    // Show confirmation dialog
    bool? confirm = await _showDeleteConfirmationDialog('movie');
    if (confirm != true) return;

    try {
      final provider = Provider.of<MovieTicketProvider>(context, listen: false);
      
      // Show loading indicator
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );
      }

      // Call delete method from provider (you need to implement this in your provider)
      await provider.deleteTicket(ticket.id.toString());

      // Close loading dialog
      if (mounted) Navigator.of(context).pop();

      // Reload tickets
      await _loadUserMovieTickets();

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ticket deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if open
      if (mounted) Navigator.of(context).pop();
      
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete ticket: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Delete Bus Ticket
  Future<void> _deleteBusTicket(BusTicket ticket) async {
    // Check if ticket is sold - only 'active' status tickets can be deleted
    bool canDelete = ticket.status == 'active';
    
    if (!canDelete) {
      _showCannotDeleteDialog('This ticket has already been sold or is no longer available for deletion.');
      return;
    }

    // Show confirmation dialog
    bool? confirm = await _showDeleteConfirmationDialog('bus');
    if (confirm != true) return;

    try {
      final provider = Provider.of<BusTicketProvider>(context, listen: false);
      
      // Show loading indicator
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );
      }

      // Call delete method from provider
      await provider.deleteTicket(ticket.id.toString());

      // Close loading dialog
      if (mounted) Navigator.of(context).pop();

      // Reload tickets
      await _loadUserBusTickets();

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ticket deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if open
      if (mounted) Navigator.of(context).pop();
      
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete ticket: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Show confirmation dialog
  Future<bool?> _showDeleteConfirmationDialog(String ticketType) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Ticket'),
          content: Text('Are you sure you want to delete this $ticketType ticket? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Show cannot delete dialog
  void _showCannotDeleteDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cannot Delete'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Posted Tickets',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF214194),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF214194),
          indicatorWeight: 3,
          tabs: const [
            Tab(
              icon: Icon(Icons.local_movies),
              text: 'Movie Tickets',
            ),
            Tab(
              icon: Icon(Icons.directions_bus),
              text: 'Bus Tickets',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMovieTicketsTab(),
          _buildBusTicketsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTicketDialog();
        },
        backgroundColor: const Color(0xFF214194),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Movie Tickets Tab
  Widget _buildMovieTicketsTab() {
    return Consumer<MovieTicketProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return _buildErrorView(
            message: 'Error loading movie tickets',
            error: provider.error!,
            onRetry: _loadUserMovieTickets,
          );
        }

        if (_userMovieTickets.isEmpty) {
          return _buildEmptyView(
            icon: Icons.local_movies_outlined,
            message: 'No movie tickets posted yet',
            subtitle: 'Your posted movie tickets will appear here',
            onAddPressed: () => _navigateToSellMovieTicket(),
          );
        }

        return RefreshIndicator(
          onRefresh: _loadUserMovieTickets,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            itemCount: _userMovieTickets.length,
            itemBuilder: (context, index) {
              return _buildMovieTicketCard(context, _userMovieTickets[index]);
            },
          ),
        );
      },
    );
  }

  // Bus Tickets Tab
  Widget _buildBusTicketsTab() {
    return Consumer<BusTicketProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Use provider.tickets instead of local state for real-time updates
        final tickets = provider.tickets;

        if (tickets.isEmpty) {
          return _buildEmptyView(
            icon: Icons.directions_bus_outlined,
            message: 'No bus tickets posted yet',
            subtitle: 'Your posted bus tickets will appear here',
            onAddPressed: () => _navigateToSellBusTicket(),
          );
        }

        return RefreshIndicator(
          onRefresh: _loadUserBusTickets,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              return _buildBusTicketCard(context, tickets[index]);
            },
          ),
        );
      },
    );
  }

  // Movie Ticket Card
  Widget _buildMovieTicketCard(BuildContext context, MovieTicket ticket) {
    String formattedDate = '${ticket.showDate.day} ${_getMonthName(ticket.showDate.month)}, ${ticket.showTime}';
    bool canDelete = ticket.status == TicketStatus.pending;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Movie Poster
              Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          ticket.ticketImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.local_movies, color: Colors.grey, size: 32);
                          },
                        ),
                      )
                    : const Icon(Icons.local_movies, color: Colors.grey, size: 32),
              ),
              const SizedBox(width: 12),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.movieName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${ticket.ticketType} • ${ticket.numberOfTickets} ticket${ticket.numberOfTickets > 1 ? 's' : ''}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      ticket.theatrePlace,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    '₹ ${ticket.totalPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Delete button (only show if status is pending)
          if (canDelete) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () => _deleteMovieTicket(ticket),
                icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                label: const Text(
                  'Delete Ticket',
                  style: TextStyle(color: Colors.red),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(ticket.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getStatusIcon(ticket.status),
                    size: 16,
                    color: _getStatusColor(ticket.status),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _getStatusText(ticket.status),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStatusColor(ticket.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Bus Ticket Card
  Widget _buildBusTicketCard(BuildContext context, BusTicket ticket) {
    String formattedDate = '${ticket.dateOfJourney.day} ${_getMonthName(ticket.dateOfJourney.month)} ${ticket.dateOfJourney.year}';
    bool canDelete = ticket.status == 'active';
    
    // Format time properly - remove seconds if present
    String formattedTime = ticket.dropPoint;
    if (formattedTime.contains(':')) {
      List<String> timeParts = formattedTime.split(':');
      if (timeParts.length >= 2) {
        formattedTime = '${timeParts[0]}:${timeParts[1]}';
      }
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Bus Icon/Image
              Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          ticket.ticketImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.directions_bus, color: Colors.grey, size: 32);
                          },
                        ),
                      )
                    : const Icon(Icons.directions_bus, color: Colors.grey, size: 32),
              ),
              const SizedBox(width: 12),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.busName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${ticket.ticketType} • ${ticket.busName} seat${ticket.numberOfTickets > 1 ? 's' : ''}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$formattedDate, $formattedTime',
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    Text(
                      '${ticket.boardingTime}',
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${ticket.pickupPoint} → ${ticket.dropPoint}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    '₹ ${ticket.totalPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Delete button (only show if status is active)
          if (canDelete) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () => _deleteBusTicket(ticket),
                icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                label: const Text(
                  'Delete Ticket',
                  style: TextStyle(color: Colors.red),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getBusStatusColor(ticket.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getBusStatusIcon(ticket.status),
                    size: 16,
                    color: _getBusStatusColor(ticket.status),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _getBusStatusText(ticket.status),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getBusStatusColor(ticket.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Empty View
  Widget _buildEmptyView({
    required IconData icon,
    required String message,
    required String subtitle,
    required VoidCallback onAddPressed,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Post a Ticket',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF214194),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  // Error View
  Widget _buildErrorView({
    required String message,
    required String error,
    required VoidCallback onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF214194),
            ),
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Show dialog to choose ticket type
  void _showAddTicketDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Ticket'),
          content: const Text('What type of ticket would you like to post?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToSellBusTicket();
              },
              icon: const Icon(Icons.directions_bus, size: 18),
              label: const Text('Bus Ticket'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF214194),
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToSellMovieTicket();
              },
              icon: const Icon(Icons.local_movies, size: 18),
              label: const Text('Movie Ticket'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF214194),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToSellMovieTicket() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SellMovieTicket(),
      ),
    ).then((_) {
      _loadUserMovieTickets();
    });
  }

  void _navigateToSellBusTicket() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SellBusTicket(),
      ),
    ).then((_) {
      _loadUserBusTickets();
    });
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  // Helper methods for Movie Ticket Status
  Color _getStatusColor(TicketStatus status) {
    switch (status) {
      case TicketStatus.pending:
        return Colors.orange;
      case TicketStatus.confirmed:
        return Colors.blue;
      case TicketStatus.accepted:
        return Colors.green;
      case TicketStatus.sold:
        return Colors.green;
      case TicketStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(TicketStatus status) {
    switch (status) {
      case TicketStatus.pending:
        return Icons.pending;
      case TicketStatus.confirmed:
        return Icons.check_circle_outline;
      case TicketStatus.accepted:
        return Icons.check_circle;
      case TicketStatus.sold:
        return Icons.check_circle;
      case TicketStatus.cancelled:
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  String _getStatusText(TicketStatus status) {
    switch (status) {
      case TicketStatus.pending:
        return 'Pending';
      case TicketStatus.confirmed:
        return 'Confirmed';
      case TicketStatus.accepted:
        return 'Accepted';
      case TicketStatus.sold:
        return 'Sold';
      case TicketStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  // Helper methods for Bus Ticket Status
  Color _getBusStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.orange;
      case 'sold':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getBusStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Icons.pending;
      case 'sold':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  String _getBusStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Active';
      case 'sold':
        return 'Sold';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}