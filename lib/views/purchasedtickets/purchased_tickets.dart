// // // // import 'package:flutter/material.dart';

// // // // class PurchasedTickets extends StatefulWidget {
// // // //   const PurchasedTickets({super.key});

// // // //   @override
// // // //   State<PurchasedTickets> createState() => _PurchasedTicketsState();
// // // // }

// // // // class _PurchasedTicketsState extends State<PurchasedTickets>
// // // //     with SingleTickerProviderStateMixin {
// // // //   late TabController _tabController;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _tabController = TabController(length: 2, vsync: this);
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _tabController.dispose();
// // // //     super.dispose();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.grey[50],
// // // //       appBar: AppBar(
// // // //         backgroundColor: Colors.white,
// // // //         elevation: 0,
// // // //         title: const Text(
// // // //           'My Purchased Tickets',
// // // //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
// // // //         ),
// // // //         leading: IconButton(
// // // //           onPressed: () {
// // // //             Navigator.of(context).pop();
// // // //           },
// // // //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
// // // //         ),
// // // //         bottom: PreferredSize(
// // // //           preferredSize: const Size.fromHeight(60),
// // // //           child: Container(
// // // //             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// // // //             padding: const EdgeInsets.all(4),
// // // //             decoration: BoxDecoration(
// // // //               color: Colors.grey[200],
// // // //               borderRadius: BorderRadius.circular(30),
// // // //             ),
// // // //             child: TabBar(
// // // //               controller: _tabController,
// // // //               indicator: BoxDecoration(
// // // //                 color: const Color(0xFF4A90E2), // Blue color matching the image
// // // //                 borderRadius: BorderRadius.circular(26),
// // // //                 boxShadow: [
// // // //                   BoxShadow(
// // // //                     color: Colors.black.withOpacity(0.1),
// // // //                     blurRadius: 4,
// // // //                     offset: const Offset(0, 2),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               indicatorSize: TabBarIndicatorSize.tab,
// // // //               dividerColor: Colors.transparent,
// // // //               labelColor: Colors.white,
// // // //               unselectedLabelColor: Colors.grey[600],
// // // //               labelStyle: const TextStyle(
// // // //                 fontWeight: FontWeight.w600,
// // // //                 fontSize: 14,
// // // //               ),
// // // //               unselectedLabelStyle: const TextStyle(
// // // //                 fontWeight: FontWeight.w500,
// // // //                 fontSize: 14,
// // // //               ),
// // // //               overlayColor: MaterialStateProperty.all(Colors.transparent),
// // // //               splashFactory: NoSplash.splashFactory,
// // // //               tabs: [
// // // //                 Tab(
// // // //                   height: 40,
// // // //                   child: Row(
// // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // //                     children: [
// // // //                       Icon(Icons.movie, size: 18),
// // // //                       const SizedBox(width: 8),
// // // //                       const Text('Movies'),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //                 Tab(
// // // //                   height: 40,
// // // //                   child: Row(
// // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // //                     children: [
// // // //                       Icon(Icons.directions_bus, size: 18),
// // // //                       const SizedBox(width: 8),
// // // //                       const Text('Bus'),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //       body: TabBarView(
// // // //         controller: _tabController,
// // // //         children: [
// // // //           // Movies Tab
// // // //           ListView.builder(
// // // //             padding: const EdgeInsets.all(16.0),
// // // //             itemCount: 2,
// // // //             itemBuilder: (context, index) {
// // // //               return _buildMovieTicketCard(context);
// // // //             },
// // // //           ),
// // // //           // Bus Tab
// // // //           ListView.builder(
// // // //             padding: const EdgeInsets.all(16.0),
// // // //             itemCount: 2,
// // // //             itemBuilder: (context, index) {
// // // //               return _buildBusTicketCard(
// // // //                 companyName: 'Orange Travels',
// // // //                 badgeText: 'AC',
// // // //                 badgeColor: Color(0xFFE3F2FD),
// // // //                 badgeTextColor: Color(0xFF1976D2),
// // // //                 fromCity: 'Hyderabad',
// // // //                 toCity: 'Bangalore',
// // // //                 departureTime: '8:00',
// // // //                 arrivalTime: '11:30',
// // // //                 price: '₹ 850',
// // // //                 seats: 'Seat: 12A',
// // // //               );
// // // //             },
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildMovieTicketCard(BuildContext context) {
// // // //     return Container(
// // // //       margin: const EdgeInsets.only(bottom: 16),
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
// // // //       child: Column(
// // // //         children: [
// // // //           Padding(
// // // //             padding: const EdgeInsets.all(12),
// // // //             child: Row(
// // // //               children: [
// // // //                 // Movie Poster
// // // //                 Container(
// // // //                   width: 60,
// // // //                   height: 80,
// // // //                   decoration: BoxDecoration(
// // // //                     color: Colors.grey[300],
// // // //                     borderRadius: BorderRadius.circular(6),
// // // //                     image: const DecorationImage(
// // // //                       image: AssetImage('assets/kubera.png'),
// // // //                       fit: BoxFit.cover,
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(width: 12),

// // // //                 // Movie Details
// // // //                 Expanded(
// // // //                   child: Column(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       const Text(
// // // //                         'Kuberaa',
// // // //                         style: TextStyle(
// // // //                           fontSize: 16,
// // // //                           fontWeight: FontWeight.w600,
// // // //                           color: Colors.black87,
// // // //                         ),
// // // //                       ),
// // // //                       const SizedBox(height: 4),
// // // //                       const Text(
// // // //                         '3D • Telugu',
// // // //                         style: TextStyle(fontSize: 12, color: Colors.grey),
// // // //                       ),
// // // //                       const SizedBox(height: 4),
// // // //                       const Text(
// // // //                         '4 Aug, 8:30 PM',
// // // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // // //                       ),
// // // //                       const SizedBox(height: 2),
// // // //                       const Text(
// // // //                         'INOX: GVK One, Hyderabad',
// // // //                         style: TextStyle(fontSize: 12, color: Colors.grey),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ),

// // // //                 // Menu Icon
// // // //                 IconButton(
// // // //                   onPressed: () {},
// // // //                   icon: const Icon(Icons.more_vert, color: Colors.grey),
// // // //                   constraints: const BoxConstraints(),
// // // //                   padding: EdgeInsets.zero,
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //           Container(
// // // //             width: double.infinity,
// // // //             margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
// // // //             decoration: BoxDecoration(
// // // //               gradient: const LinearGradient(
// // // //                 colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
// // // //                 begin: Alignment.centerLeft,
// // // //                 end: Alignment.centerRight,
// // // //               ),
// // // //               borderRadius: BorderRadius.circular(8),
// // // //             ),
// // // //             child: ElevatedButton.icon(
// // // //               onPressed: () {
// // // //                 // Handle download ticket
// // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // //                   const SnackBar(
// // // //                     content: Text('Downloading ticket...'),
// // // //                     duration: Duration(seconds: 2),
// // // //                   ),
// // // //                 );
// // // //               },
// // // //               style: ElevatedButton.styleFrom(
// // // //                 backgroundColor: Colors.transparent, // Important for gradient
// // // //                 shadowColor: Colors.transparent, // Remove shadow if needed
// // // //                 padding: const EdgeInsets.symmetric(vertical: 12),
// // // //                 shape: RoundedRectangleBorder(
// // // //                   borderRadius: BorderRadius.circular(8),
// // // //                 ),
// // // //               ),
// // // //               icon: const Icon(Icons.save_alt, size: 20, color: Colors.white),
// // // //               label: const Text(
// // // //                 'Download Ticket',
// // // //                 style: TextStyle(
// // // //                   fontSize: 14,
// // // //                   fontWeight: FontWeight.w600,
// // // //                   color: Colors.white,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildBusTicketCard({
// // // //     required String companyName,
// // // //     required String badgeText,
// // // //     required Color badgeColor,
// // // //     required Color badgeTextColor,
// // // //     required String fromCity,
// // // //     required String toCity,
// // // //     required String departureTime,
// // // //     required String arrivalTime,
// // // //     required String price,
// // // //     required String seats,
// // // //   }) {
// // // //     return Container(
// // // //       margin: const EdgeInsets.only(bottom: 16),
// // // //       child: ClipPath(
// // // //         clipper: TicketClipper(),
// // // //         child: Container(
// // // //           decoration: BoxDecoration(
// // // //             color: Colors.white,
// // // //             boxShadow: [
// // // //               BoxShadow(
// // // //                 color: Colors.grey.withOpacity(0.1),
// // // //                 spreadRadius: 1,
// // // //                 blurRadius: 6,
// // // //                 offset: const Offset(0, 2),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           child: Column(
// // // //             children: [
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(16.0),
// // // //                 child: Column(
// // // //                   children: [
// // // //                     Row(
// // // //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                       children: [
// // // //                         Row(
// // // //                           children: [
// // // //                             const Icon(
// // // //                               Icons.directions_bus,
// // // //                               size: 20,
// // // //                               color: Colors.black87,
// // // //                             ),
// // // //                             const SizedBox(width: 8),
// // // //                             Text(
// // // //                               companyName,
// // // //                               style: const TextStyle(
// // // //                                 fontSize: 16,
// // // //                                 fontWeight: FontWeight.w600,
// // // //                                 color: Colors.black87,
// // // //                               ),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                         Row(
// // // //                           children: [
// // // //                             // SizedBox(width: 10,),
// // // //                             // AC / badge
// // // //                             Container(
// // // //                               padding: const EdgeInsets.symmetric(
// // // //                                 horizontal: 8,
// // // //                                 vertical: 4,
// // // //                               ),
// // // //                               decoration: BoxDecoration(
// // // //                                 color: badgeColor,
// // // //                                 borderRadius: BorderRadius.circular(12),
// // // //                               ),
// // // //                               child: Text(
// // // //                                 badgeText,
// // // //                                 style: TextStyle(
// // // //                                   color: badgeTextColor,
// // // //                                   fontSize: 12,
// // // //                                   fontWeight: FontWeight.w500,
// // // //                                 ),
// // // //                               ),
// // // //                             ),
// // // //                             const SizedBox(width: 8),
// // // //                             // 3 dots menu
// // // //                             GestureDetector(
// // // //                               onTap: () {
// // // //                                 // Handle menu action
// // // //                                 ScaffoldMessenger.of(context).showSnackBar(
// // // //                                   const SnackBar(
// // // //                                     content: Text('More options tapped'),
// // // //                                     duration: Duration(seconds: 1),
// // // //                                   ),
// // // //                                 );
// // // //                               },
// // // //                               child: const Icon(
// // // //                                 Icons.more_vert,
// // // //                                 color: Colors.black54,
// // // //                                 size: 20,
// // // //                               ),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       ],
// // // //                     ),

// // // //                     const SizedBox(height: 16),

// // // //                     // Route and time row
// // // //                     Row(
// // // //                       children: [
// // // //                         // Departure
// // // //                         Column(
// // // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // // //                           children: [
// // // //                             Text(
// // // //                               fromCity,
// // // //                               style: TextStyle(
// // // //                                 color: Colors.grey[600],
// // // //                                 fontSize: 12,
// // // //                               ),
// // // //                             ),
// // // //                             Text(
// // // //                               departureTime,
// // // //                               style: const TextStyle(
// // // //                                 fontSize: 18,
// // // //                                 fontWeight: FontWeight.bold,
// // // //                                 color: Colors.black87,
// // // //                               ),
// // // //                             ),
// // // //                           ],
// // // //                         ),

// // // //                         // Route line with bus icon
// // // //                         Expanded(
// // // //                           child: Container(
// // // //                             margin: const EdgeInsets.symmetric(horizontal: 16),
// // // //                             child: Row(
// // // //                               children: [
// // // //                                 Container(
// // // //                                   width: 8,
// // // //                                   height: 8,
// // // //                                   decoration: const BoxDecoration(
// // // //                                     color: Color(0xFF4A90E2),
// // // //                                     shape: BoxShape.circle,
// // // //                                   ),
// // // //                                 ),
// // // //                                 Expanded(
// // // //                                   child: Container(
// // // //                                     height: 2,
// // // //                                     decoration: const BoxDecoration(
// // // //                                       color: Color(0xFF4A90E2),
// // // //                                     ),
// // // //                                     child: Row(
// // // //                                       mainAxisAlignment:
// // // //                                           MainAxisAlignment.center,
// // // //                                       children: [
// // // //                                         Container(
// // // //                                           padding: const EdgeInsets.all(4),
// // // //                                           decoration: const BoxDecoration(
// // // //                                             color: Color(0xFF4A90E2),
// // // //                                             shape: BoxShape.circle,
// // // //                                           ),
// // // //                                           child: const Icon(
// // // //                                             Icons.directions_bus,
// // // //                                             color: Colors.white,
// // // //                                             size: 16,
// // // //                                           ),
// // // //                                         ),
// // // //                                       ],
// // // //                                     ),
// // // //                                   ),
// // // //                                 ),
// // // //                                 Container(
// // // //                                   width: 8,
// // // //                                   height: 8,
// // // //                                   decoration: const BoxDecoration(
// // // //                                     color: Color(0xFF4A90E2),
// // // //                                     shape: BoxShape.circle,
// // // //                                   ),
// // // //                                 ),
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                         ),

// // // //                         // Arrival
// // // //                         Column(
// // // //                           crossAxisAlignment: CrossAxisAlignment.end,
// // // //                           children: [
// // // //                             Text(
// // // //                               toCity,
// // // //                               style: TextStyle(
// // // //                                 color: Colors.grey[600],
// // // //                                 fontSize: 12,
// // // //                               ),
// // // //                             ),
// // // //                             Text(
// // // //                               arrivalTime,
// // // //                               style: const TextStyle(
// // // //                                 fontSize: 18,
// // // //                                 fontWeight: FontWeight.bold,
// // // //                                 color: Colors.black87,
// // // //                               ),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       ],
// // // //                     ),

// // // //                     const SizedBox(height: 16),

// // // //                     // Price and seats info
// // // //                   ],
// // // //                 ),
// // // //               ),

// // // //               // Download Button
// // // //               Container(
// // // //                 width: double.infinity,
// // // //                 margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
// // // //                 decoration: BoxDecoration(
// // // //                   gradient: const LinearGradient(
// // // //                     colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
// // // //                     begin: Alignment.centerLeft,
// // // //                     end: Alignment.centerRight,
// // // //                   ),
// // // //                   borderRadius: BorderRadius.circular(8),
// // // //                 ),
// // // //                 child: ElevatedButton.icon(
// // // //                   onPressed: () {
// // // //                     // Handle download ticket
// // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // //                       const SnackBar(
// // // //                         content: Text('Downloading ticket...'),
// // // //                         duration: Duration(seconds: 2),
// // // //                       ),
// // // //                     );
// // // //                   },
// // // //                   style: ElevatedButton.styleFrom(
// // // //                     backgroundColor:
// // // //                         Colors.transparent, // Important for gradient
// // // //                     shadowColor: Colors.transparent, // Remove shadow if needed
// // // //                     padding: const EdgeInsets.symmetric(vertical: 12),
// // // //                     shape: RoundedRectangleBorder(
// // // //                       borderRadius: BorderRadius.circular(8),
// // // //                     ),
// // // //                   ),
// // // //                   icon: const Icon(
// // // //                     Icons.save_alt,
// // // //                     size: 20,
// // // //                     color: Colors.white,
// // // //                   ),
// // // //                   label: const Text(
// // // //                     'Download Ticket',
// // // //                     style: TextStyle(
// // // //                       fontSize: 14,
// // // //                       fontWeight: FontWeight.w600,
// // // //                       color: Colors.white,
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class TicketClipper extends CustomClipper<Path> {
// // // //   @override
// // // //   Path getClip(Size size) {
// // // //     Path path = Path();
// // // //     double circleRadius = 12.0;
// // // //     double middleY = size.height / 2;

// // // //     // Start from top left, with rounded corner
// // // //     path.moveTo(12, 0);
// // // //     path.lineTo(size.width - 12, 0);
// // // //     path.quadraticBezierTo(size.width, 0, size.width, 12);

// // // //     // Right side - go down to middle, create semicircle cut
// // // //     path.lineTo(size.width, middleY - circleRadius);
// // // //     path.arcToPoint(
// // // //       Offset(size.width, middleY + circleRadius),
// // // //       radius: Radius.circular(circleRadius),
// // // //       clockwise: false,
// // // //     );

// // // //     // Continue down right side
// // // //     path.lineTo(size.width, size.height - 12);
// // // //     path.quadraticBezierTo(
// // // //       size.width,
// // // //       size.height,
// // // //       size.width - 12,
// // // //       size.height,
// // // //     );

// // // //     // Bottom side
// // // //     path.lineTo(12, size.height);
// // // //     path.quadraticBezierTo(0, size.height, 0, size.height - 12);

// // // //     // Left side - go up to middle, create semicircle cut
// // // //     path.lineTo(0, middleY + circleRadius);
// // // //     path.arcToPoint(
// // // //       Offset(0, middleY - circleRadius),
// // // //       radius: Radius.circular(circleRadius),
// // // //       clockwise: false,
// // // //     );

// // // //     // Continue up left side
// // // //     path.lineTo(0, 12);
// // // //     path.quadraticBezierTo(0, 0, 12, 0);

// // // //     path.close();
// // // //     return path;
// // // //   }

// // // //   @override
// // // //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // // // }

// // // import 'package:flutter/material.dart';

// // // class PurchasedTickets extends StatelessWidget {
// // //   const PurchasedTickets({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[50],
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         title: const Text(
// // //           'My Purchased Tickets',
// // //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
// // //         ),
// // //         leading: IconButton(
// // //           onPressed: () {
// // //             Navigator.of(context).pop();
// // //           },
// // //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
// // //         ),
// // //       ),
// // //       body: ListView.builder(
// // //         padding: const EdgeInsets.all(16.0),
// // //         itemCount: 2,
// // //         itemBuilder: (context, index) {
// // //           return _buildMovieTicketCard(context);
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildMovieTicketCard(BuildContext context) {
// // //     return Container(
// // //       margin: const EdgeInsets.only(bottom: 16),
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
// // //       child: Column(
// // //         children: [
// // //           Padding(
// // //             padding: const EdgeInsets.all(12),
// // //             child: Row(
// // //               children: [
// // //                 // Movie Poster
// // //                 Container(
// // //                   width: 60,
// // //                   height: 80,
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.grey[300],
// // //                     borderRadius: BorderRadius.circular(6),
// // //                     image: const DecorationImage(
// // //                       image: AssetImage('assets/kubera.png'),
// // //                       fit: BoxFit.cover,
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(width: 12),

// // //                 // Movie Details
// // //                 Expanded(
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       const Text(
// // //                         'Kuberaa',
// // //                         style: TextStyle(
// // //                           fontSize: 16,
// // //                           fontWeight: FontWeight.w600,
// // //                           color: Colors.black87,
// // //                         ),
// // //                       ),
// // //                       const SizedBox(height: 4),
// // //                       const Text(
// // //                         '3D • Telugu',
// // //                         style: TextStyle(fontSize: 12, color: Colors.grey),
// // //                       ),
// // //                       const SizedBox(height: 4),
// // //                       const Text(
// // //                         '4 Aug, 8:30 PM',
// // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // //                       ),
// // //                       const SizedBox(height: 2),
// // //                       const Text(
// // //                         'INOX: GVK One, Hyderabad',
// // //                         style: TextStyle(fontSize: 12, color: Colors.grey),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),

// // //                 // Menu Icon
// // //                 IconButton(
// // //                   onPressed: () {},
// // //                   icon: const Icon(Icons.more_vert, color: Colors.grey),
// // //                   constraints: const BoxConstraints(),
// // //                   padding: EdgeInsets.zero,
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           Container(
// // //             width: double.infinity,
// // //             margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
// // //             decoration: BoxDecoration(
// // //               gradient: const LinearGradient(
// // //                 colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
// // //                 begin: Alignment.centerLeft,
// // //                 end: Alignment.centerRight,
// // //               ),
// // //               borderRadius: BorderRadius.circular(8),
// // //             ),
// // //             child: ElevatedButton.icon(
// // //               onPressed: () {
// // //                 // Handle download ticket
// // //                 ScaffoldMessenger.of(context).showSnackBar(
// // //                   const SnackBar(
// // //                     content: Text('Downloading ticket...'),
// // //                     duration: Duration(seconds: 2),
// // //                   ),
// // //                 );
// // //               },
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: Colors.transparent, // Important for gradient
// // //                 shadowColor: Colors.transparent, // Remove shadow if needed
// // //                 padding: const EdgeInsets.symmetric(vertical: 12),
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(8),
// // //                 ),
// // //               ),
// // //               icon: const Icon(Icons.save_alt, size: 20, color: Colors.white),
// // //               label: const Text(
// // //                 'Download Ticket',
// // //                 style: TextStyle(
// // //                   fontSize: 14,
// // //                   fontWeight: FontWeight.w600,
// // //                   color: Colors.white,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:backup_ticket/helper/auth_helper.dart';

// // class PurchasedTickets extends StatelessWidget {
// //   const PurchasedTickets({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         title: const Text(
// //           'My Purchased Tickets',
// //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
// //         ),
// //         leading: IconButton(
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
// //         ),
// //       ),
// //       body: FutureBuilder<String?>(
// //         future: UserPreferences.getUserId(),
// //         builder: (context, userSnapshot) {
// //           if (userSnapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           final userId = userSnapshot.data;
// //           if (userId == null) {
// //             return const Center(
// //               child: Text('User not logged in'),
// //             );
// //           }

// //           return StreamBuilder<QuerySnapshot>(
// //             stream: FirebaseFirestore.instance
// //                 .collection('orders')
// //                 .where('userId', isEqualTo: userId)
// //                 .snapshots(),
// //             builder: (context, snapshot) {
// //               if (snapshot.connectionState == ConnectionState.waiting) {
// //                 return const Center(child: CircularProgressIndicator());
// //               }

// //               if (snapshot.hasError) {
// //                 return Center(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(
// //                         Icons.error_outline,
// //                         size: 64,
// //                         color: Colors.grey[400],
// //                       ),
// //                       const SizedBox(height: 16),
// //                       Text(
// //                         'Error loading tickets',
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.w500,
// //                           color: Colors.grey[600],
// //                         ),
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Text(
// //                         'Please try again later',
// //                         style: TextStyle(fontSize: 14, color: Colors.grey[500]),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               }

// //               final tickets = snapshot.data?.docs ?? [];

// //               if (tickets.isEmpty) {
// //                 return Center(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(
// //                         Icons.movie_outlined,
// //                         size: 80,
// //                         color: Colors.grey[400],
// //                       ),
// //                       const SizedBox(height: 16),
// //                       Text(
// //                         'No tickets purchased yet',
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.w500,
// //                           color: Colors.grey[600],
// //                         ),
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Text(
// //                         'Your purchased tickets will appear here',
// //                         style: TextStyle(fontSize: 14, color: Colors.grey[500]),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               }

// //               return ListView.builder(
// //                 padding: const EdgeInsets.all(16.0),
// //                 itemCount: tickets.length,
// //                 itemBuilder: (context, index) {
// //                   final ticketData = tickets[index].data() as Map<String, dynamic>;
// //                   return _buildMovieTicketCard(context, ticketData);
// //                 },
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildMovieTicketCard(BuildContext context, Map<String, dynamic> ticketData) {
// //     // Extract data from the order document
// //     final movieName = ticketData['movieName'] ?? 'Unknown Movie';
// //     final theatrePlace = ticketData['theatrePlace'] ?? 'Unknown Theatre';
// //     final showDate = ticketData['showDate']?.toString() ?? '';
// //     final showTime = ticketData['showTime'] ?? '';
// //     final totalPrice = ticketData['totalPrice'] ?? 0;
// //     final paymentMethod = ticketData['paymentMethod'] ?? 'Unknown';
// //     final status = ticketData['status'] ?? 'unknown';
// //     final qrCodeUrl = ticketData['qrCodeImageUrl'];
// //     final ticketImageUrl = ticketData['ticketImageUrl'];

// //     // Format the date and time for display
// //     String formattedDateTime = '';
// //     if (showDate.isNotEmpty && showTime.isNotEmpty) {
// //       try {
// //         // If showDate is a timestamp, convert it
// //         if (showDate.contains('T')) {
// //           final dateTime = DateTime.parse(showDate);
// //           formattedDateTime = '${dateTime.day} ${_getMonthName(dateTime.month)}, ${showTime}';
// //         } else {
// //           formattedDateTime = '$showDate, $showTime';
// //         }
// //       } catch (e) {
// //         formattedDateTime = '$showDate $showTime';
// //       }
// //     }

// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 16),
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
// //       child: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.all(12),
// //             child: Row(
// //               children: [
// //                 // Movie Poster
// //                 Container(
// //                   width: 60,
// //                   height: 80,
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey[300],
// //                     borderRadius: BorderRadius.circular(6),
// //                   ),
// //                   child: ClipRRect(
// //                     borderRadius: BorderRadius.circular(6),
// //                     child: ticketImageUrl != null && ticketImageUrl.isNotEmpty
// //                         ? Image.network(
// //                             ticketImageUrl,
// //                             fit: BoxFit.cover,
// //                             loadingBuilder: (context, child, loadingProgress) {
// //                               if (loadingProgress == null) return child;
// //                               return Container(
// //                                 color: Colors.grey[300],
// //                                 child: const Center(
// //                                   child: CircularProgressIndicator(strokeWidth: 2),
// //                                 ),
// //                               );
// //                             },
// //                             errorBuilder: (context, error, stackTrace) {
// //                               return Container(
// //                                 color: Colors.grey[300],
// //                                 child: const Icon(Icons.movie, color: Colors.grey),
// //                               );
// //                             },
// //                           )
// //                         : Container(
// //                             color: Colors.grey[300],
// //                             child: const Icon(Icons.movie, color: Colors.grey),
// //                           ),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 12),

// //                 // Movie Details
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         movieName,
// //                         style: const TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.w600,
// //                           color: Colors.black87,
// //                         ),
// //                         maxLines: 2,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Row(
// //                         children: [
// //                           // Container(
// //                           //   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //                           //   decoration: BoxDecoration(
// //                           //     color: status == 'confirmed' ? Colors.green : Colors.orange,
// //                           //     borderRadius: BorderRadius.circular(4),
// //                           //   ),
// //                           //   child: Text(
// //                           //     status.toUpperCase(),
// //                           //     style: const TextStyle(
// //                           //       fontSize: 10,
// //                           //       color: Colors.white,
// //                           //       fontWeight: FontWeight.bold,
// //                           //     ),
// //                           //   ),
// //                           // ),
// //                           // const SizedBox(width: 8),
// //                           // Text(
// //                           //   paymentMethod,
// //                           //   style: const TextStyle(fontSize: 12, color: Colors.grey),
// //                           // ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 4),
// //                       if (formattedDateTime.isNotEmpty)
// //                         Text(
// //                           formattedDateTime,
// //                           style: const TextStyle(fontSize: 14, color: Colors.black),
// //                         ),
// //                       const SizedBox(height: 2),
// //                       Text(
// //                         theatrePlace,
// //                         style: const TextStyle(fontSize: 12, color: Colors.grey),
// //                         maxLines: 1,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),

// //                          Text(
// //                         showTime,
// //                         style: const TextStyle(fontSize: 12, color: Colors.grey),
// //                         maxLines: 1,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Text(
// //                         '₹$totalPrice',
// //                         style: const TextStyle(
// //                           fontSize: 14,
// //                           fontWeight: FontWeight.bold,
// //                           color: Color(0xFF1976D2),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 // Menu Icon
// //                 PopupMenuButton<String>(
// //                   onSelected: (value) {
// //                     if (value == 'view_qr' && qrCodeUrl != null) {
// //                       _showQRCodeFullScreen(context, qrCodeUrl);
// //                     } else if (value == 'view_details') {
// //                       _showTicketDetails(context, ticketData);
// //                     }
// //                   },
// //                   itemBuilder: (context) => [
// //                     if (qrCodeUrl != null && qrCodeUrl.isNotEmpty)
// //                       const PopupMenuItem(
// //                         value: 'view_qr',
// //                         child: Row(
// //                           children: [
// //                             Icon(Icons.qr_code, size: 20),
// //                             SizedBox(width: 8),
// //                             Text('View QR Code'),
// //                           ],
// //                         ),
// //                       ),
// //                     const PopupMenuItem(
// //                       value: 'view_details',
// //                       child: Row(
// //                         children: [
// //                           Icon(Icons.info_outline, size: 20),
// //                           SizedBox(width: 8),
// //                           Text('View Details'),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                   icon: const Icon(Icons.more_vert, color: Colors.grey),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Container(
// //             width: double.infinity,
// //             margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
// //             decoration: BoxDecoration(
// //               gradient: const LinearGradient(
// //                 colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
// //                 begin: Alignment.centerLeft,
// //                 end: Alignment.centerRight,
// //               ),
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //             child: ElevatedButton.icon(
// //               onPressed: () {
// //                 _downloadTicket(context, ticketData);
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.transparent,
// //                 shadowColor: Colors.transparent,
// //                 padding: const EdgeInsets.symmetric(vertical: 12),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //               ),
// //               icon: const Icon(Icons.save_alt, size: 20, color: Colors.white),
// //               label: const Text(
// //                 'Download Ticket',
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   fontWeight: FontWeight.w600,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _downloadTicket(BuildContext context, Map<String, dynamic> ticketData) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text('Downloading ticket for ${ticketData['movieName']}...'),
// //         duration: const Duration(seconds: 2),
// //       ),
// //     );
// //     // Implement your ticket download logic here
// //   }

// //   void _showQRCodeFullScreen(BuildContext context, String qrCodeUrl) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return Dialog(
// //           backgroundColor: Colors.transparent,
// //           child: Stack(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.all(20),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(15),
// //                 ),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     const Text(
// //                       'QR Code',
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.black87,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 16),
// //                     Container(
// //                       width: 250,
// //                       height: 250,
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         borderRadius: BorderRadius.circular(12),
// //                         border: Border.all(color: Colors.grey[300]!),
// //                       ),
// //                       child: ClipRRect(
// //                         borderRadius: BorderRadius.circular(12),
// //                         child: Image.network(
// //                           qrCodeUrl,
// //                           fit: BoxFit.contain,
// //                           loadingBuilder: (context, child, loadingProgress) {
// //                             if (loadingProgress == null) return child;
// //                             return const Center(
// //                               child: CircularProgressIndicator(),
// //                             );
// //                           },
// //                           errorBuilder: (context, error, stackTrace) {
// //                             return Container(
// //                               color: Colors.grey[100],
// //                               child: const Icon(
// //                                 Icons.qr_code,
// //                                 size: 80,
// //                                 color: Colors.grey,
// //                               ),
// //                             );
// //                           },
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Positioned(
// //                 top: 40,
// //                 right: 20,
// //                 child: IconButton(
// //                   onPressed: () => Navigator.pop(context),
// //                   icon: const Icon(Icons.close, color: Colors.white, size: 30),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   void _showTicketDetails(BuildContext context, Map<String, dynamic> ticketData) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text(ticketData['movieName'] ?? 'Ticket Details'),
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             _buildDetailRow('Movie', ticketData['movieName'] ?? 'N/A'),
// //             _buildDetailRow('Theatre', ticketData['theatrePlace'] ?? 'N/A'),
// //             _buildDetailRow('Date & Time', '${ticketData['showDate'] ?? ''} ${ticketData['showTime'] ?? ''}'),
// //             _buildDetailRow('Tickets', '${ticketData['numberOfTickets'] ?? 1}'),
// //             _buildDetailRow('Total Price', '₹${ticketData['totalPrice'] ?? 0}'),
// //             _buildDetailRow('Payment Method', ticketData['paymentMethod'] ?? 'N/A'),
// //             _buildDetailRow('Status', ticketData['status'] ?? 'N/A'),
// //             if (ticketData['paymentId'] != null)
// //               _buildDetailRow('Payment ID', ticketData['paymentId']),
// //           ],
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text('Close'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildDetailRow(String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           SizedBox(
// //             width: 100,
// //             child: Text(
// //               '$label:',
// //               style: const TextStyle(
// //                 fontWeight: FontWeight.w500,
// //                 color: Colors.grey,
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: Text(
// //               value,
// //               style: const TextStyle(
// //                 fontWeight: FontWeight.w500,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   String _getMonthName(int month) {
// //     const months = [
// //       '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
// //       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
// //     ];
// //     return months[month];
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:backup_ticket/helper/auth_helper.dart';

// class PurchasedTickets extends StatelessWidget {
//   const PurchasedTickets({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'My Purchased Tickets',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//         ),
//       ),
//       body: FutureBuilder<String?>(
//         future: UserPreferences.getUserId(),
//         builder: (context, userSnapshot) {
//           if (userSnapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final userId = userSnapshot.data;
//           if (userId == null) {
//             return const Center(
//               child: Text('User not logged in'),
//             );
//           }

//           return StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('orders')
//                 .where('userId', isEqualTo: userId)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (snapshot.hasError) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.error_outline,
//                           size: 64, color: Colors.grey[400]),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Error loading tickets',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               final tickets = snapshot.data?.docs ?? [];

//               if (tickets.isEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.movie_outlined,
//                           size: 80, color: Colors.grey[400]),
//                       const SizedBox(height: 16),
//                       Text(
//                         'No tickets purchased yet',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Your purchased tickets will appear here',
//                         style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               return ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: tickets.length,
//                 itemBuilder: (context, index) {
//                   final ticketData =
//                       tickets[index].data() as Map<String, dynamic>;
//                   return _buildMovieTicketCard(context, ticketData);
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildMovieTicketCard(
//       BuildContext context, Map<String, dynamic> ticketData) {
//     final movieName = ticketData['movieName'] ?? 'Unknown Movie';
//     final theatrePlace = ticketData['theatrePlace'] ?? 'Unknown Theatre';
//     final showTime = ticketData['showTime'] ?? '';
//     final totalPrice = ticketData['totalPrice'] ?? 0;

//     // -----------------------------------------------------
//     // FIXED: SAFE DATE HANDLING FOR BOTH STRING + TIMESTAMP
//     // -----------------------------------------------------
//     String showDate = _formatDate(ticketData['showDate']);

//     String formattedDateTime = '';
//     if (showDate.isNotEmpty && showTime.isNotEmpty) {
//       formattedDateTime = '$showDate, $showTime';
//     }

//     final qrCodeUrl = ticketData['qrCodeImageUrl'];
//     final ticketImageUrl = ticketData['ticketImageUrl'];

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
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
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 // Poster
//                 Container(
//                   width: 60,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(6),
//                     child: ticketImageUrl != null &&
//                             ticketImageUrl.isNotEmpty
//                         ? Image.network(ticketImageUrl, fit: BoxFit.cover)
//                         : const Icon(Icons.movie, color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(width: 12),

//                 // Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         movieName,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       if (formattedDateTime.isNotEmpty)
//                         Text(
//                           formattedDateTime,
//                           style:
//                               const TextStyle(fontSize: 14, color: Colors.black),
//                         ),
//                       const SizedBox(height: 4),
//                       Text(
//                         theatrePlace,
//                         style:
//                             const TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       Text(
//                         showTime,
//                         style:
//                             const TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         '₹$totalPrice',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF1976D2),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 PopupMenuButton<String>(
//                   icon: const Icon(Icons.more_vert, color: Colors.grey),
//                   onSelected: (value) {
//                     if (value == 'view_qr' && qrCodeUrl != null) {
//                       _showQRCodeFullScreen(context, qrCodeUrl);
//                     } else if (value == 'view_details') {
//                       _showTicketDetails(context, ticketData);
//                     }
//                   },
//                   itemBuilder: (context) => [
//                     if (qrCodeUrl != null && qrCodeUrl.isNotEmpty)
//                       const PopupMenuItem(
//                         value: 'view_qr',
//                         child: Row(
//                           children: [
//                             Icon(Icons.qr_code),
//                             SizedBox(width: 8),
//                             Text('View QR Code'),
//                           ],
//                         ),
//                       ),
//                     const PopupMenuItem(
//                       value: 'view_details',
//                       child: Row(
//                         children: [
//                           Icon(Icons.info_outline),
//                           SizedBox(width: 8),
//                           Text('View Details'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Button
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 _downloadTicket(context, ticketData);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//                 shadowColor: Colors.transparent,
//               ),
//               icon: const Icon(Icons.save_alt, color: Colors.white),
//               label: const Text(
//                 'Download Ticket',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // -------------------------------------------------------------------
//   // UNIVERSAL DATE HANDLER — accepts Timestamp or String safely
//   // -------------------------------------------------------------------
//   String _formatDate(dynamic rawDate) {
//     if (rawDate == null) return '';

//     try {
//       if (rawDate is Timestamp) {
//         DateTime date = rawDate.toDate();
//         return '${date.day} ${_getMonthName(date.month)} ${date.year}';
//       }

//       if (rawDate is String) {
//         // Remove "00:00:00" if string has it
//         if (rawDate.contains(" ")) {
//           rawDate = rawDate.split(" ").first;
//         }

//         DateTime date = DateTime.parse(rawDate);
//         return '${date.day} ${_getMonthName(date.month)} ${date.year}';
//       }
//     } catch (e) {
//       return rawDate.toString();
//     }

//     return '';
//   }

//   void _downloadTicket(BuildContext context, Map<String, dynamic> ticketData) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content:
//             Text('Downloading ticket for ${ticketData['movieName']}...'),
//       ),
//     );
//   }

//   void _showQRCodeFullScreen(BuildContext context, String qrCodeUrl) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         child: Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Image.network(qrCodeUrl, width: 250, height: 250),
//             ),
//             Positioned(
//               right: 10,
//               top: 10,
//               child: IconButton(
//                 icon: const Icon(Icons.close, color: Colors.white, size: 30),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showTicketDetails(
//       BuildContext context, Map<String, dynamic> ticketData) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(ticketData['movieName']),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildDetailRow('Movie', ticketData['movieName']),
//             _buildDetailRow('Theatre', ticketData['theatrePlace']),
//             _buildDetailRow('Date', _formatDate(ticketData['showDate'])),
//             _buildDetailRow('Time', ticketData['showTime']),
//             _buildDetailRow('Tickets', '${ticketData['numberOfTickets']}'),
//             _buildDetailRow(
//                 'Total Price', '₹${ticketData['totalPrice']}'),
//             _buildDetailRow(
//                 'Payment Method', ticketData['paymentMethod']),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               '$label:',
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(value,
//                 style: const TextStyle(fontWeight: FontWeight.w500)),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getMonthName(int month) {
//     const months = [
//       '',
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];
//     return months[month];
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:backup_ticket/helper/auth_helper.dart';

// class PurchasedTickets extends StatelessWidget {
//   const PurchasedTickets({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.grey[50],
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text(
//             'My Purchased Tickets',
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           ),
//           bottom: const TabBar(
//             labelColor: Color(0xFF1976D2),
//             unselectedLabelColor: Colors.grey,
//             indicatorColor: Color(0xFF1976D2),
//             indicatorWeight: 3,
//             tabs: [
//               Tab(icon: Icon(Icons.movie), text: 'Movie Tickets'),
//               Tab(icon: Icon(Icons.directions_bus), text: 'Bus Tickets'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [_buildMovieTicketsTab(), _buildBusTicketsTab()],
//         ),
//       ),
//     );
//   }

//   // Movie Tickets Tab
//   Widget _buildMovieTicketsTab() {
//     return FutureBuilder<String?>(
//       future: UserPreferences.getUserId(),
//       builder: (context, userSnapshot) {
//         if (userSnapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final userId = userSnapshot.data;
//         if (userId == null) {
//           return const Center(child: Text('User not logged in'));
//         }

//         return StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('orders')
//               .where('userId', isEqualTo: userId)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return _buildErrorState('Error loading movie tickets');
//             }

//             final allTickets = snapshot.data?.docs ?? [];

//             // Filter movie tickets (those with movieName field)
//             final tickets = allTickets.where((doc) {
//               final data = doc.data() as Map<String, dynamic>;
//               return data.containsKey('movieName');
//             }).toList();

//             if (tickets.isEmpty) {
//               return _buildEmptyState(
//                 icon: Icons.movie_outlined,
//                 message: 'No movie tickets purchased yet',
//                 subtitle: 'Your purchased movie tickets will appear here',
//               );
//             }

//             return ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: tickets.length,
//               itemBuilder: (context, index) {
//                 final ticketData =
//                     tickets[index].data() as Map<String, dynamic>;
//                 return _buildMovieTicketCard(context, ticketData);
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   // Bus Tickets Tab
//   Widget _buildBusTicketsTab() {
//     return FutureBuilder<String?>(
//       future: UserPreferences.getUserId(),
//       builder: (context, userSnapshot) {
//         if (userSnapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final userId = userSnapshot.data;
//         if (userId == null) {
//           return const Center(child: Text('User not logged in'));
//         }

//         return StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('orders')
//               .where('buyerId', isEqualTo: userId)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return _buildErrorState('Error loading bus tickets');
//             }

//             final allTickets = snapshot.data?.docs ?? [];

//             // Filter bus tickets (those with busName field)
//             final tickets = allTickets.where((doc) {
//               final data = doc.data() as Map<String, dynamic>;
//               return data.containsKey('busName');
//             }).toList();

//             if (tickets.isEmpty) {
//               return _buildEmptyState(
//                 icon: Icons.directions_bus_outlined,
//                 message: 'No bus tickets purchased yet',
//                 subtitle: 'Your purchased bus tickets will appear here',
//               );
//             }

//             return ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: tickets.length,
//               itemBuilder: (context, index) {
//                 final ticketData =
//                     tickets[index].data() as Map<String, dynamic>;
//                 return _buildBusTicketCard(context, ticketData);
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   // Movie Ticket Card
//   Widget _buildMovieTicketCard(
//     BuildContext context,
//     Map<String, dynamic> ticketData,
//   ) {
//     final movieName = ticketData['movieName'] ?? 'Unknown Movie';
//     final theatrePlace = ticketData['theatrePlace'] ?? 'Unknown Theatre';
//     final showTime = ticketData['showTime'] ?? '';
//     final totalPrice = ticketData['totalPrice'] ?? 0;

//     String showDate = _formatDate(ticketData['showDate']);

//     String formattedDateTime = '';
//     if (showDate.isNotEmpty && showTime.isNotEmpty) {
//       formattedDateTime = '$showDate, $showTime';
//     }

//     final qrCodeUrl = ticketData['qrCodeImageUrl'];
//     final ticketImageUrl = ticketData['ticketImageUrl'];

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
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
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 // Poster
//                 Container(
//                   width: 60,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(6),
//                     child: ticketImageUrl != null && ticketImageUrl.isNotEmpty
//                         ? Image.network(ticketImageUrl, fit: BoxFit.cover)
//                         : const Icon(Icons.movie, color: Colors.grey),
//                   ),
//                 ),
//                 const SizedBox(width: 12),

//                 // Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         movieName,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       if (formattedDateTime.isNotEmpty)
//                         Text(
//                           formattedDateTime,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
//                         ),
//                       const SizedBox(height: 4),
//                       Text(
//                         theatrePlace,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         '₹$totalPrice',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF1976D2),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 PopupMenuButton<String>(
//                   icon: const Icon(Icons.more_vert, color: Colors.grey),
//                   onSelected: (value) {
//                     if (value == 'view_qr' && qrCodeUrl != null) {
//                       _showQRCodeFullScreen(context, qrCodeUrl);
//                     } else if (value == 'view_details') {
//                       _showMovieTicketDetails(context, ticketData);
//                     }
//                   },
//                   itemBuilder: (context) => [
//                     if (qrCodeUrl != null && qrCodeUrl.isNotEmpty)
//                       const PopupMenuItem(
//                         value: 'view_qr',
//                         child: Row(
//                           children: [
//                             Icon(Icons.qr_code),
//                             SizedBox(width: 8),
//                             Text('View QR Code'),
//                           ],
//                         ),
//                       ),
//                     const PopupMenuItem(
//                       value: 'view_details',
//                       child: Row(
//                         children: [
//                           Icon(Icons.info_outline),
//                           SizedBox(width: 8),
//                           Text('View Details'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Download Button
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 _downloadTicket(context, ticketData, 'movie');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//                 shadowColor: Colors.transparent,
//               ),
//               icon: const Icon(Icons.save_alt, color: Colors.white),
//               label: const Text(
//                 'Download Ticket',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Bus Ticket Card
//   Widget _buildBusTicketCard(
//     BuildContext context,
//     Map<String, dynamic> ticketData,
//   ) {
//     final busName = ticketData['busName'] ?? 'Unknown Bus';
//     final pickupPoint = ticketData['pickupPoint'] ?? 'Unknown';
//     final dropPoint = ticketData['dropPoint'] ?? 'Unknown';
//     final totalPrice = ticketData['amount'] ?? 0;
//     final ticketType = ticketData['ticketType'] ?? '';
//     final dateOfJourney = _formatDate(ticketData['dateOfJourney']);
//     final ticketImageUrl = ticketData['ticketImageUrl'];
//     final paymentStatus = ticketData['paymentStatus'] ?? 'pending';

//     // Determine badge
//     final isAC =
//         ticketType.toLowerCase().contains('ac') &&
//         !ticketType.toLowerCase().contains('non');
//     final badgeText = isAC ? 'AC' : 'NON-AC';
//     final badgeColor = isAC ? const Color(0xFFE3F2FD) : const Color(0xFFFFF3E0);
//     final badgeTextColor = isAC
//         ? const Color(0xFF1976D2)
//         : const Color(0xFFFF9800);

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
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
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header Row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.directions_bus,
//                           size: 20,
//                           color: Color(0xFF1976D2),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           busName,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: badgeColor,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         badgeText,
//                         style: TextStyle(
//                           color: badgeTextColor,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 12),

//                 // Route Information
//                 Row(
//                   children: [
//                     // Pickup
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'From',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 11,
//                             ),
//                           ),
//                           Text(
//                             pickupPoint,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Arrow
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: const Icon(
//                         Icons.arrow_forward,
//                         color: Color(0xFF1976D2),
//                         size: 20,
//                       ),
//                     ),

//                     // Drop
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             'To',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 11,
//                             ),
//                           ),
//                           Text(
//                             dropPoint,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.right,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 12),

//                 // Date and Price Row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.calendar_today,
//                           size: 14,
//                           color: Colors.grey[600],
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           dateOfJourney,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       '₹$totalPrice',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1976D2),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 8),

//                 // Status Badge
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: paymentStatus == 'completed'
//                         ? Colors.green[50]
//                         : Colors.orange[50],
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         paymentStatus == 'completed'
//                             ? Icons.check_circle
//                             : Icons.pending,
//                         size: 14,
//                         color: paymentStatus == 'completed'
//                             ? Colors.green
//                             : Colors.orange,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         paymentStatus == 'completed' ? 'Confirmed' : 'Pending',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: paymentStatus == 'completed'
//                               ? Colors.green
//                               : Colors.orange,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // View Details Button
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
//             child: OutlinedButton.icon(
//               onPressed: () {
//                 _showBusTicketDetails(context, ticketData);
//               },
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(color: Color(0xFF1976D2)),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               icon: const Icon(Icons.info_outline, color: Color(0xFF1976D2)),
//               label: const Text(
//                 'View Details',
//                 style: TextStyle(
//                   color: Color(0xFF1976D2),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Empty State Widget
//   Widget _buildEmptyState({
//     required IconData icon,
//     required String message,
//     required String subtitle,
//   }) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 80, color: Colors.grey[400]),
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
//         ],
//       ),
//     );
//   }

//   // Error State Widget
//   Widget _buildErrorState(String message) {
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
//         ],
//       ),
//     );
//   }

//   // Date Formatter
//   String _formatDate(dynamic rawDate) {
//     if (rawDate == null) return '';

//     try {
//       if (rawDate is Timestamp) {
//         DateTime date = rawDate.toDate();
//         return '${date.day} ${_getMonthName(date.month)} ${date.year}';
//       }

//       if (rawDate is String) {
//         if (rawDate.contains(" ")) {
//           rawDate = rawDate.split(" ").first;
//         }
//         DateTime date = DateTime.parse(rawDate);
//         return '${date.day} ${_getMonthName(date.month)} ${date.year}';
//       }
//     } catch (e) {
//       return rawDate.toString();
//     }

//     return '';
//   }

//   String _getMonthName(int month) {
//     const months = [
//       '',
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec',
//     ];
//     return months[month];
//   }

//   // Download Ticket
//   void _downloadTicket(
//     BuildContext context,
//     Map<String, dynamic> ticketData,
//     String type,
//   ) {
//     final name = type == 'movie'
//         ? ticketData['movieName']
//         : ticketData['busName'];
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('Downloading ticket for $name...')));
//   }

//   // Show QR Code
//   void _showQRCodeFullScreen(BuildContext context, String qrCodeUrl) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         child: Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Image.network(qrCodeUrl, width: 250, height: 250),
//             ),
//             Positioned(
//               right: 10,
//               top: 10,
//               child: IconButton(
//                 icon: const Icon(Icons.close, color: Colors.white, size: 30),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Show Movie Ticket Details
//   void _showMovieTicketDetails(
//     BuildContext context,
//     Map<String, dynamic> ticketData,
//   ) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(ticketData['movieName'] ?? 'Ticket Details'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildDetailRow('Movie', ticketData['movieName'] ?? 'N/A'),
//               _buildDetailRow('Theatre', ticketData['theatrePlace'] ?? 'N/A'),
//               _buildDetailRow('Date', _formatDate(ticketData['showDate'])),
//               _buildDetailRow('Time', ticketData['showTime'] ?? 'N/A'),
//               _buildDetailRow(
//                 'Tickets',
//                 '${ticketData['numberOfTickets'] ?? 0}',
//               ),
//               _buildDetailRow(
//                 'Total Price',
//                 '₹${ticketData['totalPrice'] ?? 0}',
//               ),
//               _buildDetailRow(
//                 'Payment Method',
//                 ticketData['paymentMethod'] ?? 'N/A',
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Show Bus Ticket Details
//   void _showBusTicketDetails(
//     BuildContext context,
//     Map<String, dynamic> ticketData,
//   ) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(ticketData['busName'] ?? 'Bus Ticket Details'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildDetailRow('Bus Name', ticketData['busName'] ?? 'N/A'),
//               _buildDetailRow('Type', ticketData['ticketType'] ?? 'N/A'),
//               _buildDetailRow('From', ticketData['pickupPoint'] ?? 'N/A'),
//               _buildDetailRow('To', ticketData['dropPoint'] ?? 'N/A'),
//               _buildDetailRow(
//                 'Journey Date',
//                 _formatDate(ticketData['dateOfJourney']),
//               ),
//               _buildDetailRow('Amount', '₹${ticketData['amount'] ?? 0}'),
//               _buildDetailRow('Payment ID', ticketData['paymentId'] ?? 'N/A'),
//               _buildDetailRow('Status', ticketData['paymentStatus'] ?? 'N/A'),
//               _buildDetailRow(
//                 'Purchased At',
//                 _formatDate(ticketData['purchasedAt']),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               '$label:',
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PurchasedTickets extends StatelessWidget {
  const PurchasedTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'My Purchased Tickets',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          bottom: const TabBar(
            labelColor: Color(0xFF1976D2),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF1976D2),
            indicatorWeight: 3,
            tabs: [
              Tab(icon: Icon(Icons.movie), text: 'Movie Tickets'),
              Tab(icon: Icon(Icons.directions_bus), text: 'Bus Tickets'),
            ],
          ),
        ),
        body: TabBarView(
          children: [_buildMovieTicketsTab(), _buildBusTicketsTab()],
        ),
      ),
    );
  }

  // Movie Tickets Tab
  Widget _buildMovieTicketsTab() {
    return FutureBuilder<String?>(
      future: UserPreferences.getUserId(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final userId = userSnapshot.data;
        if (userId == null) {
          return const Center(child: Text('User not logged in'));
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('userId', isEqualTo: userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return _buildErrorState('Error loading movie tickets');
            }

            final allTickets = snapshot.data?.docs ?? [];

            // Filter movie tickets (those with movieName field)
            final tickets = allTickets.where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return data.containsKey('movieName');
            }).toList();

            if (tickets.isEmpty) {
              return _buildEmptyState(
                icon: Icons.movie_outlined,
                message: 'No movie tickets purchased yet',
                subtitle: 'Your purchased movie tickets will appear here',
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticketData =
                    tickets[index].data() as Map<String, dynamic>;
                return _buildMovieTicketCard(context, ticketData);
              },
            );
          },
        );
      },
    );
  }

  // Bus Tickets Tab
  Widget _buildBusTicketsTab() {
    return FutureBuilder<String?>(
      future: UserPreferences.getUserId(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final userId = userSnapshot.data;
        if (userId == null) {
          return const Center(child: Text('User not logged in'));
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('buyerId', isEqualTo: userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return _buildErrorState('Error loading bus tickets');
            }

            final allTickets = snapshot.data?.docs ?? [];

            // Filter bus tickets (those with busName field)
            final tickets = allTickets.where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return data.containsKey('busName');
            }).toList();

            if (tickets.isEmpty) {
              return _buildEmptyState(
                icon: Icons.directions_bus_outlined,
                message: 'No bus tickets purchased yet',
                subtitle: 'Your purchased bus tickets will appear here',
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticketData =
                    tickets[index].data() as Map<String, dynamic>;
                return _buildBusTicketCard(context, ticketData);
              },
            );
          },
        );
      },
    );
  }

  // Movie Ticket Card
  Widget _buildMovieTicketCard(
    BuildContext context,
    Map<String, dynamic> ticketData,
  ) {
    final movieName = ticketData['movieName'] ?? 'Unknown Movie';
    final theatrePlace = ticketData['theatrePlace'] ?? 'Unknown Theatre';
    final showTime = ticketData['showTime'] ?? '';
    final totalPrice = ticketData['totalPrice'] ?? 0;

    String showDate = _formatDate(ticketData['showDate']);

    String formattedDateTime = '';
    if (showDate.isNotEmpty && showTime.isNotEmpty) {
      formattedDateTime = '$showDate, $showTime';
    }

    final qrCodeUrl = ticketData['qrCodeImageUrl'];
    final ticketImageUrl = ticketData['ticketImageUrl'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Poster
                Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: ticketImageUrl != null && ticketImageUrl.isNotEmpty
                        ? Image.network(ticketImageUrl, fit: BoxFit.cover)
                        : const Icon(Icons.movie, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (formattedDateTime.isNotEmpty)
                        Text(
                          formattedDateTime,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        theatrePlace,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹$totalPrice',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ],
                  ),
                ),

                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  onSelected: (value) {
                    if (value == 'view_qr' && qrCodeUrl != null) {
                      _showQRCodeFullScreen(context, qrCodeUrl);
                    } else if (value == 'view_details') {
                      _showMovieTicketDetails(context, ticketData);
                    }
                  },
                  itemBuilder: (context) => [
                    if (qrCodeUrl != null && qrCodeUrl.isNotEmpty)
                      const PopupMenuItem(
                        value: 'view_qr',
                        child: Row(
                          children: [
                            Icon(Icons.qr_code),
                            SizedBox(width: 8),
                            Text('View QR Code'),
                          ],
                        ),
                      ),
                    const PopupMenuItem(
                      value: 'view_details',
                      child: Row(
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(width: 8),
                          Text('View Details'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Download Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                _downloadTicket(context, ticketData, 'movie');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              icon: const Icon(Icons.save_alt, color: Colors.white),
              label: const Text(
                'Download Ticket',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bus Ticket Card
  Widget _buildBusTicketCard(
    BuildContext context,
    Map<String, dynamic> ticketData,
  ) {
    final busName = ticketData['busName'] ?? 'Unknown Bus';
    final pickupPoint = ticketData['pickupPoint'] ?? 'Unknown';
    final dropPoint = ticketData['dropPoint'] ?? 'Unknown';
    final totalPrice = ticketData['amount'] ?? 0;
    final ticketType = ticketData['ticketType'] ?? '';
    final dateOfJourney = _formatDate(ticketData['dateOfJourney']);
    final ticketImageUrl = ticketData['ticketImageUrl'];
    final paymentStatus = ticketData['paymentStatus'] ?? 'pending';

    // Determine badge
    final isAC =
        ticketType.toLowerCase().contains('ac') &&
        !ticketType.toLowerCase().contains('non');
    final badgeText = isAC ? 'AC' : 'NON-AC';
    final badgeColor = isAC ? const Color(0xFFE3F2FD) : const Color(0xFFFFF3E0);
    final badgeTextColor = isAC
        ? const Color(0xFF1976D2)
        : const Color(0xFFFF9800);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_bus,
                          size: 20,
                          color: Color(0xFF1976D2),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          busName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${ticketData['ticketType']}',
                        style: TextStyle(
                          color: badgeTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Route Information
                Row(
                  children: [
                    // Pickup
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            pickupPoint,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Arrow
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF1976D2),
                        size: 20,
                      ),
                    ),

                    // Drop
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'To',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            dropPoint,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Date and Price Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          dateOfJourney,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '₹$totalPrice',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: paymentStatus == 'completed'
                        ? Colors.green[50]
                        : Colors.orange[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        paymentStatus == 'completed'
                            ? Icons.check_circle
                            : Icons.pending,
                        size: 14,
                        color: paymentStatus == 'completed'
                            ? Colors.green
                            : Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        paymentStatus == 'completed' ? 'Confirmed' : 'Pending',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: paymentStatus == 'completed'
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Download and View Details Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showBusTicketDetails(context, ticketData);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1976D2)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(
                      Icons.info_outline,
                      color: Color(0xFF1976D2),
                    ),
                    label: const Text(
                      'View Details',
                      style: TextStyle(
                        color: Color(0xFF1976D2),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _downloadTicket(context, ticketData, 'bus');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      icon: const Icon(
                        Icons.save_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: const Text(
                        'Download',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Empty State Widget
  Widget _buildEmptyState({
    required IconData icon,
    required String message,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[400]),
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
        ],
      ),
    );
  }

  // Error State Widget
  Widget _buildErrorState(String message) {
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
        ],
      ),
    );
  }

  // Date Formatter
  String _formatDate(dynamic rawDate) {
    if (rawDate == null) return '';

    try {
      if (rawDate is Timestamp) {
        DateTime date = rawDate.toDate();
        return '${date.day} ${_getMonthName(date.month)} ${date.year}';
      }

      if (rawDate is String) {
        if (rawDate.contains(" ")) {
          rawDate = rawDate.split(" ").first;
        }
        DateTime date = DateTime.parse(rawDate);
        return '${date.day} ${_getMonthName(date.month)} ${date.year}';
      }
    } catch (e) {
      return rawDate.toString();
    }

    return '';
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }

  // Download Ticket Function with Gal package
  Future<void> _downloadTicket(
    BuildContext context,
    Map<String, dynamic> ticketData,
    String type,
  ) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 16),
              Text('Downloading ticket...'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      String? imageUrl;
      String fileName;

      if (type == 'movie') {
        // For movie tickets, use QR code or ticket image
        imageUrl = ticketData['qrCodeImageUrl'] ?? ticketData['ticketImageUrl'];
        final movieName = ticketData['movieName'] ?? 'Movie';
        fileName =
            'Ticket_${movieName.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      } else {
        // For bus tickets, use ticket image
        imageUrl = ticketData['ticketImageUrl'];
        final busName = ticketData['busName'] ?? 'Bus';
        fileName =
            'Ticket_${busName.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      }

      if (imageUrl == null || imageUrl.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No ticket image available to download'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      // Download the image from URL
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Get temporary directory
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/$fileName';

        // Save the file temporarily
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Check if Gal.hasAccess is available, if not request permission
        bool hasAccess = true;
        try {
          hasAccess = await Gal.hasAccess();
          if (!hasAccess) {
            hasAccess = await Gal.requestAccess();
          }
        } catch (e) {
          // If hasAccess method doesn't exist, try to save directly
          print('Gal.hasAccess not available: $e');
        }

        if (hasAccess) {
          // Save to gallery using Gal - try different methods
          try {
            await Gal.putImage(filePath);
          } catch (e) {
            // If putImage with album fails, try without album parameter
            print('Error with putImage: $e');
            await Gal.putImage(filePath);
          }

          // Delete temporary file
          try {
            await file.delete();
          } catch (e) {
            print('Error deleting temp file: $e');
          }

          // Show success message
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Ticket downloaded successfully!',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          }
        } else {
          // Permission denied
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gallery access permission denied'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        throw Exception(
          'Failed to download image. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Download error: $e');
      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }
    }
  }

  // Show QR Code
  void _showQRCodeFullScreen(BuildContext context, String qrCodeUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(qrCodeUrl, width: 250, height: 250),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show Movie Ticket Details
  void _showMovieTicketDetails(
    BuildContext context,
    Map<String, dynamic> ticketData,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ticketData['movieName'] ?? 'Ticket Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Movie', ticketData['movieName'] ?? 'N/A'),
              _buildDetailRow('Theatre', ticketData['theatrePlace'] ?? 'N/A'),
              _buildDetailRow('Date', _formatDate(ticketData['showDate'])),
              _buildDetailRow('Time', ticketData['showTime'] ?? 'N/A'),
              _buildDetailRow(
                'Tickets',
                '${ticketData['numberOfTickets'] ?? 0}',
              ),
              _buildDetailRow(
                'Total Price',
                '₹${ticketData['totalPrice'] ?? 0}',
              ),
              _buildDetailRow(
                'Payment Method',
                ticketData['paymentMethod'] ?? 'N/A',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Show Bus Ticket Details
  void _showBusTicketDetails(
    BuildContext context,
    Map<String, dynamic> ticketData,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ticketData['busName'] ?? 'Bus Ticket Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Bus Name', ticketData['busName'] ?? 'N/A'),
              _buildDetailRow('Type', ticketData['ticketType'] ?? 'N/A'),
              _buildDetailRow('From', ticketData['pickupPoint'] ?? 'N/A'),
              _buildDetailRow('To', ticketData['dropPoint'] ?? 'N/A'),
              _buildDetailRow(
                'Journey Date',
                _formatDate(ticketData['dateOfJourney']),
              ),
              _buildDetailRow('Amount', '₹${ticketData['amount'] ?? 0}'),
              _buildDetailRow('Payment ID', ticketData['paymentId'] ?? 'N/A'),
              _buildDetailRow('Status', ticketData['paymentStatus'] ?? 'N/A'),
              _buildDetailRow(
                'Purchased At',
                _formatDate(ticketData['purchasedAt']),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
