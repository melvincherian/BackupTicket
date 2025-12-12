// // import 'package:backup_ticket/views/Details/detail_screen.dart';
// // import 'package:backup_ticket/views/notifications/notification_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// // import 'package:backup_ticket/model/movie_ticket_model.dart';

// // class ImageDetailScreen extends StatelessWidget {
// //   final String movieName;
// //   final String? assetImagePath;

// //   const ImageDetailScreen({
// //     super.key,
// //     required this.movieName,
// //     this.assetImagePath,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = Provider.of<MovieTicketProvider>(context, listen: false);

// //     return Scaffold(
// //       appBar: PreferredSize(
// //         preferredSize: const Size.fromHeight(90),
// //         child: AppBar(
// //           automaticallyImplyLeading: false,
// //           elevation: 0,
// //           flexibleSpace: ClipRRect(
// //             borderRadius: const BorderRadius.only(
// //               bottomLeft: Radius.circular(25),
// //               bottomRight: Radius.circular(25),
// //             ),
// //             child: Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //               ),
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
// //               child: SafeArea(
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     // Left side (location)
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Row(
// //                           children: const [
// //                             Icon(Icons.send, color: Colors.white, size: 18),
// //                             SizedBox(width: 5),
// //                             Text(
// //                               "Hyderabad, Telangana..",
// //                               style: TextStyle(
// //                                 color: Colors.white,
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.w600,
// //                               ),
// //                             ),
// //                             Icon(
// //                               Icons.keyboard_arrow_down,
// //                               color: Colors.white,
// //                               size: 20,
// //                             ),
// //                           ],
// //                         ),
// //                         SizedBox(height: 2),
// //                         const Text(
// //                           "       Hyderabad, Telangana, India",
// //                           style: TextStyle(color: Colors.white, fontSize: 12),
// //                         ),
// //                       ],
// //                     ),

// //                     // Right side (notification)
// //                     Container(
// //                       padding: const EdgeInsets.all(8),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         shape: BoxShape.circle,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.black26,
// //                             blurRadius: 4,
// //                             offset: Offset(0, 2),
// //                           ),
// //                         ],
// //                       ),
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => NotificationScreen(),
// //                             ),
// //                           );
// //                         },
// //                         child: const Icon(
// //                           Icons.notifications_none,
// //                           color: Colors.black87,
// //                           size: 22,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: FutureBuilder<MovieTicket?>(
// //         future: provider.getTicketByMovieName(movieName),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //           if (snapshot.hasError) {
// //             return Center(child: Text("Error: ${snapshot.error}"));
// //           }
// //           if (!snapshot.hasData || snapshot.data == null) {
// //             return const Center(child: Text("No ticket found for this movie"));
// //           }

// //           final ticket = snapshot.data!;

// //           return SingleChildScrollView(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // Poster + Movie info
// //                 Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       // ClipRRect(
// //                       //   borderRadius: BorderRadius.circular(12),
// //                       //   child: ticket.ticketImageUrl != null &&
// //                       //           ticket.ticketImageUrl!.isNotEmpty
// //                       //       ? Image.network(
// //                       //           ticket.ticketImageUrl!,
// //                       //           height: 220,
// //                       //           fit: BoxFit.cover,
// //                       //           errorBuilder: (context, error, stackTrace) {
// //                       //             return Image.asset(
// //                       //               'assets/kubera.png',
// //                       //               height: 220,
// //                       //               fit: BoxFit.cover,
// //                       //             );
// //                       //           },
// //                       //         )
// //                       //       : Image.asset(
// //                       //           'assets/kubera.png',
// //                       //           height: 220,
// //                       //           fit: BoxFit.cover,
// //                       //         ),
// //                       // ),

// //                       //                       ClipRRect(
// //                       //   borderRadius: BorderRadius.circular(12),
// //                       //   child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
// //                       //       ? Image.network(
// //                       //           ticket.ticketImageUrl!,
// //                       //           height: 220,
// //                       //           fit: BoxFit.cover,
// //                       //           errorBuilder: (context, error, stackTrace) {
// //                       //             return Image.asset(
// //                       //               assetImagePath ?? 'assets/kubera.png', // <-- fallback to asset
// //                       //               height: 220,
// //                       //               fit: BoxFit.cover,
// //                       //             );
// //                       //           },
// //                       //         )
// //                       //       : Image.asset(
// //                       //           assetImagePath ?? 'assets/kubera.png', // <-- use passed asset
// //                       //           height: 220,
// //                       //           fit: BoxFit.cover,
// //                       //         ),
// //                       // ),
// //                       ClipRRect(
// //                         borderRadius: BorderRadius.circular(12),
// //                         child: Image.asset(
// //                           assetImagePath ??
// //                               'assets/kubera.png', // Always use asset image
// //                           height: 220,
// //                           fit: BoxFit.cover,
// //                         ),
// //                       ),

// //                       const SizedBox(height: 12),
// //                       Text(
// //                         ticket.movieName,
// //                         style: const TextStyle(
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),

// //                       const SizedBox(height: 8),

// //                       // Tags row
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           _buildTag("13+"),
// //                           const SizedBox(width: 6),
// //                           _buildTag("Action"),
// //                           const SizedBox(width: 6),
// //                           _buildTag("IMAX"),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 const Divider(thickness: 1),

// //                 // Available Tickets
// //                 const Padding(
// //                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                   child: Text(
// //                     "Available Tickets",
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// //                   ),
// //                 ),

// //                 ListView.builder(
// //                   shrinkWrap: true,
// //                   physics: const NeverScrollableScrollPhysics(),
// //                   itemCount: ticket
// //                       .numberOfTickets, // repeat for demo (replace with list)
// //                   itemBuilder: (context, index) {
// //                     return GestureDetector(
// //                       onTap: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) =>
// //                                 DetailScreen(ticketId: ticket.id),
// //                           ),
// //                         );
// //                       },
// //                       child: Card(
// //                         margin: const EdgeInsets.symmetric(
// //                           horizontal: 16,
// //                           vertical: 6,
// //                         ),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         elevation: 2,
// //                         child: ListTile(
// //                           leading: ClipRRect(
// //                             borderRadius: BorderRadius.circular(8),
// //                             child: Image.asset(
// //                               assetImagePath.toString(),
// //                               width: 60,
// //                               height: 60,
// //                               fit: BoxFit.cover,
// //                             ),
// //                           ),
// //                           // leading: ClipRRect(
// //                           //   borderRadius: BorderRadius.circular(8),
// //                           //   child: Image.network(
// //                           //     ticket.ticketImageUrl ??
// //                           //         "https://via.placeholder.com/60",
// //                           //     width: 60,
// //                           //     height: 60,
// //                           //     fit: BoxFit.cover,
// //                           //   ),
// //                           // ),
// //                           title: Text(
// //                             ticket.movieName,
// //                             style: const TextStyle(
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                           subtitle: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(
// //                                 "${ticket.ticketType} • Telugu",
// //                                 style: const TextStyle(fontSize: 12),
// //                               ),
// //                               Text(
// //                                 "${ticket.showDate.toString().split(" ")[0]}, ${ticket.showTime}",
// //                                 style: const TextStyle(fontSize: 12),
// //                               ),
// //                               Text(
// //                                 ticket.theatrePlace,
// //                                 style: const TextStyle(
// //                                   fontSize: 12,
// //                                   color: Colors.grey,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           trailing: Column(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               Text(
// //                                 "₹${ticket.pricePerTicket.toStringAsFixed(0)}",
// //                                 style: const TextStyle(
// //                                   fontSize: 16,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                               const Text(
// //                                 "Ravi",
// //                                 style: TextStyle(
// //                                   fontSize: 12,
// //                                   color: Colors.grey,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildTag(String text) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(6),
// //         color: Colors.grey.shade200,
// //       ),
// //       child: Text(
// //         text,
// //         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
// //       ),
// //     );
// //   }
// // }

// import 'package:backup_ticket/model/movie_category_model.dart';
// import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
// import 'package:backup_ticket/views/Details/detail_screen.dart';
// import 'package:backup_ticket/views/notifications/notification_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:backup_ticket/model/movie_ticket_model.dart';

// class ImageDetailScreen extends StatefulWidget {
//   final String movieName;
//   final String? assetImagePath;

//   const ImageDetailScreen({
//     super.key,
//     required this.movieName,
//     this.assetImagePath,
//   });

//   @override
//   State<ImageDetailScreen> createState() => _ImageDetailScreenState();
// }

// class _ImageDetailScreenState extends State<ImageDetailScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//         final provider = Provider.of<MovieCategoryProvider>(context, listen: false);

//     // final provider = Provider.of<MovieTicketProvider>(context, listen: false);

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
//       body: FutureBuilder<MovieCategory?>(
//         future: provider.fetchCategories(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }
//           if (!snapshot.hasData || snapshot.data == null) {
//             return const Center(child: Text("No ticket found for this movie"));
//           }

//           final ticket = snapshot.data!;

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Poster + Movie info
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           widget.assetImagePath ?? 'assets/kubera.png',
//                           height: 220,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       // Text(
//                       //   ticket.movieName,
//                       //   style: const TextStyle(
//                       //     fontSize: 20,
//                       //     fontWeight: FontWeight.bold,
//                       //   ),
//                       // ),
//                         Text(
//                         '${widget.movieName}',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),

//                       // Tags row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _buildTag("13+"),
//                           const SizedBox(width: 6),
//                           _buildTag("Action"),
//                           const SizedBox(width: 6),
//                           _buildTag("IMAX"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Divider(thickness: 1),

//                 // Search Bar
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: TextField(
//                     controller: _searchController,
//                     onChanged: (value) {
//                       setState(() {
//                         _searchQuery = value.toLowerCase();
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Search tickets by theatre, time, or type...',
//                       prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                       suffixIcon: _searchQuery.isNotEmpty
//                           ? IconButton(
//                               icon: const Icon(Icons.clear, color: Colors.grey),
//                               onPressed: () {
//                                 setState(() {
//                                   _searchController.clear();
//                                   _searchQuery = '';
//                                 });
//                               },
//                             )
//                           : null,
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Available Tickets
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Text(
//                     "Available Tickets",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                   ),
//                 ),

//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: ticket.numberOfTickets,
//                   itemBuilder: (context, index) {
//                     // Filter logic
//                     if (_searchQuery.isNotEmpty) {
//                       final searchableText =
//                           '${ticket.movieName} ${ticket.ticketType} ${ticket.theatrePlace} ${ticket.showTime}'
//                               .toLowerCase();

//                       if (!searchableText.contains(_searchQuery)) {
//                         return const SizedBox.shrink();
//                       }
//                     }

//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailScreen(ticketId: ticket.id),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 6,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         elevation: 2,
//                         child: ListTile(
//                           leading: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.asset(
//                               widget.assetImagePath ?? 'assets/kubera.png',
//                               width: 60,
//                               height: 60,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           title: Text(
//                             ticket.movieName,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "${ticket.ticketType} • Telugu",
//                                 style: const TextStyle(fontSize: 12),
//                               ),
//                               Text(
//                                 "${ticket.showDate.toString().split(" ")[0]}, ${ticket.showTime}",
//                                 style: const TextStyle(fontSize: 12),
//                               ),
//                               Text(
//                                 ticket.theatrePlace,
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           trailing: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "₹${ticket.pricePerTicket.toStringAsFixed(0)}",
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Text(
//                                 "Ravi",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTag(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(6),
//         color: Colors.grey.shade200,
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//       ),
//     );
//   }
// }

// import 'package:backup_ticket/model/movie_category_model.dart';
// import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
// import 'package:backup_ticket/views/Details/detail_screen.dart';
// import 'package:backup_ticket/views/notifications/notification_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:backup_ticket/model/movie_ticket_model.dart';

// class ImageDetailScreen extends StatefulWidget {
//   final String movieName;
//   final String? assetImagePath;
//   final String? categoryId; // Add category ID to fetch specific category

//   const ImageDetailScreen({
//     super.key,
//     required this.movieName,
//     this.assetImagePath,
//     this.categoryId,
//   });

//   @override
//   State<ImageDetailScreen> createState() => _ImageDetailScreenState();
// }

// class _ImageDetailScreenState extends State<ImageDetailScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     // Fetch categories when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<MovieCategoryProvider>(context, listen: false).fetchCategories();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
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
//                     // Back button
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     // Location
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: const [
//                               Icon(Icons.location_on, color: Colors.white, size: 18),
//                               SizedBox(width: 5),
//                               Flexible(
//                                 child: Text(
//                                   "Hyderabad, Telangana",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 2),
//                           const Text(
//                             "India",
//                             style: TextStyle(color: Colors.white70, fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Notification button
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
//       body: Consumer<MovieCategoryProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.error != null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, size: 60, color: Colors.red),
//                   const SizedBox(height: 16),
//                   Text(
//                     "Error: ${provider.error}",
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => provider.fetchCategories(),
//                     child: const Text("Retry"),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (provider.categories.isEmpty) {
//             return const Center(
//               child: Text(
//                 "No categories available",
//                 style: TextStyle(fontSize: 16),
//               ),
//             );
//           }

//           // Get the specific category or first one
//           final MovieCategory category = widget.categoryId != null
//               ? provider.getCategoryById(widget.categoryId!) ?? provider.categories.first
//               : provider.categories.first;

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Poster + Movie info
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: widget.assetImagePath != null
//                             ? (widget.assetImagePath!.startsWith('http')
//                                 ? Image.network(
//                                     widget.assetImagePath!,
//                                     height: 220,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         height: 220,
//                                         color: Colors.grey.shade300,
//                                         child: const Icon(Icons.movie, size: 60),
//                                       );
//                                     },
//                                   )
//                                 : Image.network(
//                                     widget.assetImagePath!,
//                                     height: 220,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         height: 220,
//                                         color: Colors.grey.shade300,
//                                         child: const Icon(Icons.movie, size: 60),
//                                       );
//                                     },
//                                   ))
//                             : Container(
//                                 height: 220,
//                                 width: double.infinity,
//                                 color: Colors.grey.shade300,
//                                 child: const Icon(Icons.movie, size: 60),
//                               ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         widget.movieName,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 8),
//                       // Tags row
//                       Wrap(
//                         alignment: WrapAlignment.center,
//                         spacing: 6,
//                         runSpacing: 6,
//                         children: category.tags
//                             .map((tag) => _buildTag(tag))
//                             .toList(),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Divider(thickness: 1),

//                 // Search Bar
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: TextField(
//                     controller: _searchController,
//                     onChanged: (value) {
//                       setState(() {
//                         _searchQuery = value.toLowerCase();
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Search tickets by theatre, time, or type...',
//                       prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                       suffixIcon: _searchQuery.isNotEmpty
//                           ? IconButton(
//                               icon: const Icon(Icons.clear, color: Colors.grey),
//                               onPressed: () {
//                                 setState(() {
//                                   _searchController.clear();
//                                   _searchQuery = '';
//                                 });
//                               },
//                             )
//                           : null,
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Category Description (if available)
//                 // if (category.description != null && category.description!.isNotEmpty)
//                 //   Padding(
//                 //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 //     child: Text(
//                 //       category.description!,
//                 //       style: const TextStyle(
//                 //         fontSize: 14,
//                 //         color: Colors.grey,
//                 //       ),
//                 //     ),
//                 //   ),

//                 // Available Tickets header
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Available Tickets",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                       Text(
//                         "${category.movieCount} movies",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Placeholder for tickets - Replace with actual ticket data
//                 _buildTicketsList(category),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTicketsList(MovieCategory category) {
//     // This is a placeholder. You should fetch actual tickets based on the category
//     // For now, showing a message
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Center(
//         child: Column(
//           children: [
//             Icon(Icons.movie_filter, size: 60, color: Colors.grey.shade400),
//             const SizedBox(height: 16),
//             Text(
//               "No tickets available for ${category.name}",
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               "Check back later for updates",
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTag(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(6),
//         color: Colors.grey.shade200,
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//       ),
//     );
//   }
// }

// import 'package:backup_ticket/model/movie_category_model.dart';
// import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
// import 'package:backup_ticket/views/Details/detail_screen.dart';
// import 'package:backup_ticket/views/notifications/notification_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:backup_ticket/model/movie_ticket_model.dart';

// class ImageDetailScreen extends StatefulWidget {
//   final String movieName;
//   final String? assetImagePath;
//   final String? categoryId;

//   const ImageDetailScreen({
//     super.key,
//     required this.movieName,
//     this.assetImagePath,
//     this.categoryId,
//   });

//   @override
//   State<ImageDetailScreen> createState() => _ImageDetailScreenState();
// }

// class _ImageDetailScreenState extends State<ImageDetailScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     // Fetch categories and tickets when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<MovieCategoryProvider>(context, listen: false).fetchCategories();
//       Provider.of<MovieTicketProvider>(context, listen: false).fetchAllTickets();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
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
//                     // Back button
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     // Location
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: const [
//                               Icon(Icons.location_on, color: Colors.white, size: 18),
//                               SizedBox(width: 5),
//                               Flexible(
//                                 child: Text(
//                                   "Hyderabad, Telangana",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 2),
//                           const Text(
//                             "India",
//                             style: TextStyle(color: Colors.white70, fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Notification button
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
//       body: Consumer2<MovieCategoryProvider, MovieTicketProvider>(
//         builder: (context, categoryProvider, ticketProvider, child) {
//           if (categoryProvider.isLoading || ticketProvider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (categoryProvider.error != null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, size: 60, color: Colors.red),
//                   const SizedBox(height: 16),
//                   Text(
//                     "Error: ${categoryProvider.error}",
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => categoryProvider.fetchCategories(),
//                     child: const Text("Retry"),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (categoryProvider.categories.isEmpty) {
//             return const Center(
//               child: Text(
//                 "No categories available",
//                 style: TextStyle(fontSize: 16),
//               ),
//             );
//           }

//           // Get the specific category or first one
//           final MovieCategory category = widget.categoryId != null
//               ? categoryProvider.getCategoryById(widget.categoryId!) ??
//                 categoryProvider.categories.first
//               : categoryProvider.categories.first;

//           // Filter tickets by movie name (category name)
//           List<MovieTicket> categoryTickets = ticketProvider.tickets
//               .where((ticket) =>
//                 ticket.movieName.toLowerCase() == widget.movieName.toLowerCase())
//               .toList();

//           // Apply search filter
//           if (_searchQuery.isNotEmpty) {
//             categoryTickets = categoryTickets.where((ticket) {
//               return ticket.theatrePlace.toLowerCase().contains(_searchQuery) ||
//                      ticket.showTime.toLowerCase().contains(_searchQuery) ||
//                      ticket.ticketType.toLowerCase().contains(_searchQuery) ||
//                      ticket.fullName.toLowerCase().contains(_searchQuery);
//             }).toList();
//           }

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Poster + Movie info
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: widget.assetImagePath != null
//                             ? (widget.assetImagePath!.startsWith('http')
//                                 ? Image.network(
//                                     widget.assetImagePath!,
//                                     height: 220,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         height: 220,
//                                         color: Colors.grey.shade300,
//                                         child: const Icon(Icons.movie, size: 60),
//                                       );
//                                     },
//                                   )
//                                 : Image.network(
//                                     widget.assetImagePath!,
//                                     height: 220,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         height: 220,
//                                         color: Colors.grey.shade300,
//                                         child: const Icon(Icons.movie, size: 60),
//                                       );
//                                     },
//                                   ))
//                             : Container(
//                                 height: 220,
//                                 width: double.infinity,
//                                 color: Colors.grey.shade300,
//                                 child: const Icon(Icons.movie, size: 60),
//                               ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         widget.movieName,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 8),
//                       // Tags row
//                       Wrap(
//                         alignment: WrapAlignment.center,
//                         spacing: 6,
//                         runSpacing: 6,
//                         children: category.tags
//                             .map((tag) => _buildTag(tag))
//                             .toList(),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Divider(thickness: 1),

//                 // Search Bar
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: TextField(
//                     controller: _searchController,
//                     onChanged: (value) {
//                       setState(() {
//                         _searchQuery = value.toLowerCase();
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Search tickets by theatre, time, or type...',
//                       prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                       suffixIcon: _searchQuery.isNotEmpty
//                           ? IconButton(
//                               icon: const Icon(Icons.clear, color: Colors.grey),
//                               onPressed: () {
//                                 setState(() {
//                                   _searchController.clear();
//                                   _searchQuery = '';
//                                 });
//                               },
//                             )
//                           : null,
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Available Tickets header
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Available Tickets",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                       Text(
//                         "${categoryTickets.length} tickets",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Tickets list
//                 _buildTicketsList(categoryTickets),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTicketsList(List<MovieTicket> tickets) {
//     if (tickets.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.all(16),
//         child: Center(
//           child: Column(
//             children: [
//               Icon(Icons.movie_filter, size: 60, color: Colors.grey.shade400),
//               const SizedBox(height: 16),
//               Text(
//                 _searchQuery.isEmpty
//                     ? "No tickets available for ${widget.movieName}"
//                     : "No tickets found matching your search",
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 _searchQuery.isEmpty
//                     ? "Check back later for updates"
//                     : "Try a different search term",
//                 style: const TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: tickets.length,
//       itemBuilder: (context, index) {
//         final ticket = tickets[index];
//         return _buildTicketCard(ticket);
//       },
//     );
//   }

//   Widget _buildTicketCard(MovieTicket ticket) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => DetailScreen(ticket: ticket,image: widget.assetImagePath,),
//             ),
//           );
//         },
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header: Theatre and Price
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       ticket.theatrePlace,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.green.shade50,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Text(
//                       '₹${ticket.pricePerTicket.toStringAsFixed(0)}/ticket',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green.shade700,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               // Show date and time
//               Row(
//                 children: [
//                   Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
//                   const SizedBox(width: 6),
//                   Text(
//                     '${ticket.showDate.day.toString().padLeft(2, '0')}/${ticket.showDate.month.toString().padLeft(2, '0')}/${ticket.showDate.year}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
//                   const SizedBox(width: 6),
//                   Text(
//                     ticket.showTime,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               // Ticket type and count
//               Row(
//                 children: [
//                   _buildInfoChip(
//                     Icons.airplane_ticket,
//                     ticket.ticketType,
//                     Colors.blue,
//                   ),
//                   const SizedBox(width: 8),
//                   _buildInfoChip(
//                     Icons.confirmation_number,
//                     '${ticket.numberOfTickets} ticket${ticket.numberOfTickets > 1 ? 's' : ''}',
//                     Colors.orange,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               // Seller info and total price
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 12,
//                         backgroundColor: Colors.blue.shade100,
//                         child: Text(
//                           ticket.fullName[0].toUpperCase(),
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue.shade700,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         ticket.fullName,
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     'Total: ₹${ticket.totalPrice.toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(IconData icon, String label, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: color),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color:Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTag(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(6),
//         color: Colors.grey.shade200,
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//       ),
//     );
//   }
// }

// import 'package:backup_ticket/model/movie_category_model.dart';
// import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
// import 'package:backup_ticket/views/Details/detail_screen.dart';
// import 'package:backup_ticket/views/notifications/notification_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:backup_ticket/model/movie_ticket_model.dart';
// import 'package:intl/intl.dart';

// class ImageDetailScreen extends StatefulWidget {
//   final String movieName;
//   final String? assetImagePath;
//   final String? categoryId;

//   const ImageDetailScreen({
//     super.key,
//     required this.movieName,
//     this.assetImagePath,
//     this.categoryId,
//   });

//   @override
//   State<ImageDetailScreen> createState() => _ImageDetailScreenState();
// }

// class _ImageDetailScreenState extends State<ImageDetailScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   DateTime _selectedDate = DateTime.now();
//   final ScrollController _dateScrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     // Fetch categories and tickets when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<MovieCategoryProvider>(context, listen: false).fetchCategories();
//       Provider.of<MovieTicketProvider>(context, listen: false).fetchAllTickets();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _dateScrollController.dispose();
//     super.dispose();
//   }

//   List<DateTime> _generateDateList() {
//     List<DateTime> dates = [];
//     DateTime today = DateTime.now();
//     for (int i = 0; i < 30; i++) {
//       dates.add(today.add(Duration(days: i)));
//     }
//     return dates;
//   }

//   bool _isSameDate(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
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
//                     // Back button
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     // Location
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: const [
//                               Icon(Icons.location_on, color: Colors.white, size: 18),
//                               SizedBox(width: 5),
//                               Flexible(
//                                 child: Text(
//                                   "Hyderabad, Telangana",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 2),
//                           const Text(
//                             "India",
//                             style: TextStyle(color: Colors.white70, fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Notification button
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
//       body: Consumer2<MovieCategoryProvider, MovieTicketProvider>(
//         builder: (context, categoryProvider, ticketProvider, child) {
//           if (categoryProvider.isLoading || ticketProvider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (categoryProvider.error != null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, size: 60, color: Colors.red),
//                   const SizedBox(height: 16),
//                   Text(
//                     "Error: ${categoryProvider.error}",
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => categoryProvider.fetchCategories(),
//                     child: const Text("Retry"),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (categoryProvider.categories.isEmpty) {
//             return const Center(
//               child: Text(
//                 "No categories available",
//                 style: TextStyle(fontSize: 16),
//               ),
//             );
//           }

//           // Get the specific category or first one
//           final MovieCategory category = widget.categoryId != null
//               ? categoryProvider.getCategoryById(widget.categoryId!) ??
//                 categoryProvider.categories.first
//               : categoryProvider.categories.first;

//           // Filter tickets by movie name
//           List<MovieTicket> categoryTickets = ticketProvider.tickets
//               .where((ticket) =>
//                 ticket.movieName.toLowerCase() == widget.movieName.toLowerCase())
//               .toList();

//           // Filter by selected date
//           categoryTickets = categoryTickets.where((ticket) {
//             return _isSameDate(ticket.showDate, _selectedDate);
//           }).toList();

//           // Apply search filter
//           if (_searchQuery.isNotEmpty) {
//             categoryTickets = categoryTickets.where((ticket) {
//               return ticket.theatrePlace.toLowerCase().contains(_searchQuery) ||
//                      ticket.showTime.toLowerCase().contains(_searchQuery) ||
//                      ticket.ticketType.toLowerCase().contains(_searchQuery) ||
//                      ticket.fullName.toLowerCase().contains(_searchQuery);
//             }).toList();
//           }

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Poster + Movie info
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: widget.assetImagePath != null
//                             ? (widget.assetImagePath!.startsWith('http')
//                                 ? Image.network(
//                                     widget.assetImagePath!,
//                                     height: 220,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         height: 220,
//                                         color: Colors.grey.shade300,
//                                         child: const Icon(Icons.movie, size: 60),
//                                       );
//                                     },
//                                   )
//                                 : Image.network(
//                                     widget.assetImagePath!,
//                                     height: 220,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         height: 220,
//                                         color: Colors.grey.shade300,
//                                         child: const Icon(Icons.movie, size: 60),
//                                       );
//                                     },
//                                   ))
//                             : Container(
//                                 height: 220,
//                                 width: double.infinity,
//                                 color: Colors.grey.shade300,
//                                 child: const Icon(Icons.movie, size: 60),
//                               ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         widget.movieName,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 8),
//                       // Tags row
//                       Wrap(
//                         alignment: WrapAlignment.center,
//                         spacing: 6,
//                         runSpacing: 6,
//                         children: category.tags
//                             .map((tag) => _buildTag(tag))
//                             .toList(),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Divider(thickness: 1),

//                 // Date Selector
//                 _buildDateSelector(),

//                 const SizedBox(height: 8),

//                 // Search Bar
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: TextField(
//                     controller: _searchController,
//                     onChanged: (value) {
//                       setState(() {
//                         _searchQuery = value.toLowerCase();
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Search tickets by theatre, time, or type...',
//                       prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                       suffixIcon: _searchQuery.isNotEmpty
//                           ? IconButton(
//                               icon: const Icon(Icons.clear, color: Colors.grey),
//                               onPressed: () {
//                                 setState(() {
//                                   _searchController.clear();
//                                   _searchQuery = '';
//                                 });
//                               },
//                             )
//                           : null,
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Available Tickets header
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Available Tickets",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                       Text(
//                         "${categoryTickets.length} tickets",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Tickets list
//                 _buildTicketsList(categoryTickets),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildDateSelector() {
//     final dates = _generateDateList();

//     return Container(
//       height: 90,
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: ListView.builder(
//         controller: _dateScrollController,
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         itemCount: dates.length,
//         itemBuilder: (context, index) {
//           final date = dates[index];
//           final isSelected = _isSameDate(date, _selectedDate);
//           final dayName = DateFormat('EEE').format(date).toUpperCase();
//           final dayNumber = DateFormat('dd').format(date);
//           final monthName = DateFormat('MMM').format(date).toUpperCase();

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 _selectedDate = date;
//               });
//             },
//             child: Container(
//               width: 70,
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               decoration: BoxDecoration(
//                 color: isSelected ? const Color(0xFFE57373) : Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: isSelected ? const Color(0xFFE57373) : Colors.grey.shade300,
//                   width: 1.5,
//                 ),
//                 boxShadow: isSelected
//                     ? [
//                         BoxShadow(
//                           color: const Color(0xFFE57373).withOpacity(0.3),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ]
//                     : [],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     dayName,
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: isSelected ? Colors.white : Colors.grey.shade600,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     dayNumber,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: isSelected ? Colors.white : Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     monthName,
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w500,
//                       color: isSelected ? Colors.white : Colors.grey.shade600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTicketsList(List<MovieTicket> tickets) {
//     if (tickets.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.all(16),
//         child: Center(
//           child: Column(
//             children: [
//               Icon(Icons.movie_filter, size: 60, color: Colors.grey.shade400),
//               const SizedBox(height: 16),
//               Text(
//                 _searchQuery.isEmpty
//                     ? "No tickets available for ${DateFormat('MMM dd, yyyy').format(_selectedDate)}"
//                     : "No tickets found matching your search",
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 _searchQuery.isEmpty
//                     ? "Try selecting a different date"
//                     : "Try a different search term",
//                 style: const TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: tickets.length,
//       itemBuilder: (context, index) {
//         final ticket = tickets[index];
//         return _buildTicketCard(ticket);
//       },
//     );
//   }

//   Widget _buildTicketCard(MovieTicket ticket) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => DetailScreen(ticket: ticket, image: widget.assetImagePath),
//             ),
//           );
//         },
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header: Theatre and Price
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       ticket.theatrePlace,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.green.shade50,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Text(
//                       '₹${ticket.pricePerTicket.toStringAsFixed(0)}/ticket',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green.shade700,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               // Show date and time
//               Row(
//                 children: [
//                   Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
//                   const SizedBox(width: 6),
//                   Text(
//                     '${ticket.showDate.day.toString().padLeft(2, '0')}/${ticket.showDate.month.toString().padLeft(2, '0')}/${ticket.showDate.year}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
//                   const SizedBox(width: 6),
//                   Text(
//                     ticket.showTime,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               // Ticket type and count
//               Row(
//                 children: [
//                   _buildInfoChip(
//                     Icons.airplane_ticket,
//                     ticket.ticketType,
//                     Colors.blue,
//                   ),
//                   const SizedBox(width: 8),
//                   _buildInfoChip(
//                     Icons.confirmation_number,
//                     '${ticket.numberOfTickets} ticket${ticket.numberOfTickets > 1 ? 's' : ''}',
//                     Colors.orange,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               // Seller info and total price
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 12,
//                         backgroundColor: Colors.blue.shade100,
//                         child: Text(
//                           ticket.fullName[0].toUpperCase(),
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue.shade700,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         ticket.fullName,
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     'Total: ₹${ticket.totalPrice.toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(IconData icon, String label, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: color),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTag(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(6),
//         color: Colors.grey.shade200,
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//       ),
//     );
//   }
// }

import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/movie_category_model.dart';
import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
import 'package:backup_ticket/views/Details/detail_screen.dart';
import 'package:backup_ticket/views/notifications/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
import 'package:backup_ticket/model/movie_ticket_model.dart';
import 'package:intl/intl.dart';

class ImageDetailScreen extends StatefulWidget {
  final String? languages;
  final String movieName;
  final String? assetImagePath;
  final String? categoryId;

  const ImageDetailScreen({
    super.key,
    required this.movieName,
    this.assetImagePath,
    this.categoryId,
    this.languages,
  });

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  DateTime _selectedDate = DateTime.now();
  String _userName = "Guest";
  final ScrollController _dateScrollController = ScrollController();

  @override
  void initState() {
    _loadUserName();
    super.initState();
    // Fetch categories and tickets when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieCategoryProvider>(
        context,
        listen: false,
      ).fetchCategories();
      Provider.of<MovieTicketProvider>(
        context,
        listen: false,
      ).fetchAllTickets();
    });
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
  void dispose() {
    _searchController.dispose();
    _dateScrollController.dispose();
    super.dispose();
  }

  List<DateTime> _generateDateList() {
    List<DateTime> dates = [];
    DateTime today = DateTime.now();
    for (int i = 0; i < 30; i++) {
      dates.add(today.add(Duration(days: i)));
    }
    return dates;
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
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

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(),
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
      body: Consumer2<MovieCategoryProvider, MovieTicketProvider>(
        builder: (context, categoryProvider, ticketProvider, child) {
          if (categoryProvider.isLoading || ticketProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (categoryProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    "Error: ${categoryProvider.error}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => categoryProvider.fetchCategories(),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (categoryProvider.categories.isEmpty) {
            return const Center(
              child: Text(
                "No categories available",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // Get the specific category or first one
          final MovieCategory category = widget.categoryId != null
              ? categoryProvider.getCategoryById(widget.categoryId!) ??
                    categoryProvider.categories.first
              : categoryProvider.categories.first;

          // Filter tickets by movie name
          List<MovieTicket> categoryTickets = ticketProvider.tickets
              .where(
                (ticket) =>
                    ticket.movieName.toLowerCase() ==
                    widget.movieName.toLowerCase(),
              )
              .toList();

          // Filter by selected date
          categoryTickets = categoryTickets.where((ticket) {
            return _isSameDate(ticket.showDate, _selectedDate);
          }).toList();

          // Apply search filter
          if (_searchQuery.isNotEmpty) {
            categoryTickets = categoryTickets.where((ticket) {
              return ticket.theatrePlace.toLowerCase().contains(_searchQuery) ||
                  ticket.showTime.toLowerCase().contains(_searchQuery) ||
                  ticket.ticketType.toLowerCase().contains(_searchQuery) ||
                  ticket.fullName.toLowerCase().contains(_searchQuery);
            }).toList();
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster + Movie info
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: widget.assetImagePath != null
                            ? (widget.assetImagePath!.startsWith('http')
                                  ? Image.network(
                                      widget.assetImagePath!,
                                      height: 220,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              height: 220,
                                              color: Colors.grey.shade300,
                                              child: const Icon(
                                                Icons.movie,
                                                size: 60,
                                              ),
                                            );
                                          },
                                    )
                                  : Image.network(
                                      widget.assetImagePath!,
                                      height: 220,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              height: 220,
                                              color: Colors.grey.shade300,
                                              child: const Icon(
                                                Icons.movie,
                                                size: 60,
                                              ),
                                            );
                                          },
                                    ))
                            : Container(
                                height: 220,
                                width: double.infinity,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.movie, size: 60),
                              ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.movieName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Tags row
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 6,
                        runSpacing: 6,
                        children: category.tags
                            .map((tag) => _buildTag(tag))
                            .toList(),
                      ),
                    ],
                  ),
                ),

                const Divider(thickness: 1),

                // Date Selector
                _buildDateSelector(),

                const SizedBox(height: 8),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search tickets by theatre, time, or type...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                // Available Tickets header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Available Tickets",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${categoryTickets.length} tickets",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Languages ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // Text(
                      //   "${widget.languages}",
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      Text(
                        (widget.languages == null || widget.languages!.isEmpty)
                            ? "No languages available"
                            : widget.languages!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                // Tickets list
                _buildTicketsList(categoryTickets),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateSelector() {
    final dates = _generateDateList();

    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        controller: _dateScrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = _isSameDate(date, _selectedDate);
          final dayName = DateFormat('EEE').format(date).toUpperCase();
          final dayNumber = DateFormat('dd').format(date);
          final monthName = DateFormat('MMM').format(date).toUpperCase();

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE57373) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFE57373)
                      : Colors.grey.shade300,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFFE57373).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dayNumber,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    monthName,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTicketsList(List<MovieTicket> tickets) {
    if (tickets.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.movie_filter, size: 60, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                _searchQuery.isEmpty
                    ? "No tickets available for ${DateFormat('MMM dd, yyyy').format(_selectedDate)}"
                    : "No tickets found matching your search",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _searchQuery.isEmpty
                    ? "Try selecting a different date"
                    : "Try a different search term",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return _buildTicketCard(ticket);
      },
    );
  }

  Widget _buildTicketCard(MovieTicket ticket) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Show quantity selector bottom sheet
          _showQuantitySelector(ticket);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Theatre and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      ticket.theatrePlace,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '₹${ticket.pricePerTicket.toStringAsFixed(0)}/ticket',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Show date and time
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${ticket.showDate.day.toString().padLeft(2, '0')}/${ticket.showDate.month.toString().padLeft(2, '0')}/${ticket.showDate.year}',
                    style: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    ticket.showTime,
                    style: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Ticket type and count
              Row(
                children: [
                  _buildInfoChip(
                    Icons.airplane_ticket,
                    ticket.ticketType,
                    Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    Icons.confirmation_number,
                    '${ticket.numberOfTickets} available',
                    Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Seat: ${ticket.seatNumbers[0].split(',')[0]}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Seller info and total price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          ticket.fullName[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        ticket.fullName,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'From: ₹${ticket.pricePerTicket.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Quantity selector bottom sheet
  void _showQuantitySelector(MovieTicket ticket) {
    int selectedQuantity = 1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Quantity',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${ticket.numberOfTickets} ticket${ticket.numberOfTickets > 1 ? 's' : ''} available',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20),

                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Decrease button
                      Container(
                        decoration: BoxDecoration(
                          color: selectedQuantity > 1
                              ? Colors.blue.shade50
                              : Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: selectedQuantity > 1
                              ? () {
                                  setModalState(() {
                                    selectedQuantity--;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.remove),
                          iconSize: 24,
                          color: selectedQuantity > 1
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),

                      const SizedBox(width: 20),

                      // Quantity display
                      Container(
                        width: 80,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue.shade50,
                        ),
                        child: Text(
                          selectedQuantity.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),

                      const SizedBox(width: 20),

                      // Increase button
                      Container(
                        decoration: BoxDecoration(
                          color: selectedQuantity < ticket.numberOfTickets
                              ? Colors.blue.shade50
                              : Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: selectedQuantity < ticket.numberOfTickets
                              ? () {
                                  setModalState(() {
                                    selectedQuantity++;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.add),
                          iconSize: 24,
                          color: selectedQuantity < ticket.numberOfTickets
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Price breakdown
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Price per ticket:',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '₹${ticket.pricePerTicket.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quantity:',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              '$selectedQuantity',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₹${(ticket.pricePerTicket * selectedQuantity).toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close bottom sheet
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              ticket: ticket,
                              image: widget.assetImagePath,
                              selectedQuantity: selectedQuantity,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Continue to Purchase',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey.shade200,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
