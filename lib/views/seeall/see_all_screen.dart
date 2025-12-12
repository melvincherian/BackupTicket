// import 'package:flutter/material.dart';

// class SeeAllScreen extends StatelessWidget {
//   const SeeAllScreen({super.key});

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
//                       child: const Icon(
//                         Icons.notifications_none,
//                         color: Colors.black87,
//                         size: 22,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 // Search Bar
//                 Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.all(16.0),
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     height: 50,
//                     decoration: BoxDecoration(
//                       border: Border.all(),
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(25),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.1),
//                           spreadRadius: 1,
//                           blurRadius: 10,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: const Row(
//                       children: [
//                         Icon(Icons.search, color: Colors.grey, size: 20),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             'Search',
//                             style: TextStyle(color: Colors.grey, fontSize: 16),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Filter Button
//                 Container(
//                   margin: const EdgeInsets.only(right: 16.0),
//                   child: const CircleAvatar(
//                     radius: 25,
//                     backgroundColor: Color(0xFF4A90E2),
//                     child: Icon(Icons.tune, color: Colors.white, size: 20),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // SizedBox(height: 20),
//                     // SizedBox(
//                     //   height: 280,
//                     //   child: ListView(
//                     //     scrollDirection: Axis.horizontal,
//                     //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     //     children: [],
//                     //   ),
//                     // ),

//                     // Divider(),
//                     const SizedBox(height: 10),

//                     // Nearby Resale Tickets Section
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Nearby Resale Tickets',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 10),

//                     // Resale Tickets List
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       itemCount: 3,
//                       itemBuilder: (context, index) {
//                         return _buildResaleTicketCard();
//                       },
//                     ),

//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMovieCard(String imagePath, String title, List<String> badges) {
//     return Container(
//       width: 160,
//       margin: const EdgeInsets.only(right: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Movie Poster with Stack
//           Stack(
//             children: [
//               Container(
//                 height: 220,
//                 width: 160,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.asset(
//                     imagePath,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.grey[300],
//                         child: const Icon(
//                           Icons.movie,
//                           size: 40,
//                           color: Colors.grey,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 8),

//           // Movie Title
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//             maxLines: 2,
//             textAlign: TextAlign.center,
//             overflow: TextOverflow.ellipsis,
//           ),

//           const SizedBox(height: 6),

//           // Badges Row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: badges.map((badge) => _buildBadge(badge)).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBadge(String text) {
//     Color backgroundColor;
//     Color textColor = Colors.white;

//     switch (text) {
//       case '13+':
//       case 'UA':
//       case 'A':
//         backgroundColor = Colors.grey[700]!;
//         break;
//       case 'Action':
//       case 'Drama':
//       case 'Thriller':
//         backgroundColor = Colors.grey[600]!;
//         break;
//       case 'IMAX':
//       case '2D':
//         backgroundColor = Colors.grey[600]!;
//         break;
//       default:
//         backgroundColor = Colors.grey[600]!;
//     }

//     return Container(
//       margin: const EdgeInsets.only(right: 4),
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: textColor,
//           fontSize: 10,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget _buildResaleTicketCard() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         border: Border.all(),
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
//               image: const DecorationImage(
//                 image: AssetImage('assets/kubera.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),

//           // Movie Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Kuberaa',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 const Text(
//                   '3D.Telungu',
//                   style: TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 4),

//                 const Text(
//                   '4 Aug 8:30 PM',
//                   style: TextStyle(fontSize: 14, color: Colors.black),
//                 ),
//                 const SizedBox(height: 2),
//                 const Text(
//                   'INOX:GVK One,Hyderabad',
//                   style: TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 8),
//               ],
//             ),
//           ),

//           // Price
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 '₹200',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:backup_ticket/views/Details/detail_screen.dart';
// import 'package:backup_ticket/views/notifications/notification_screen.dart';
// import 'package:backup_ticket/views/search/search_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:backup_ticket/model/movie_ticket_model.dart';

// class SeeAllScreen extends StatefulWidget {
//   const SeeAllScreen({super.key});

//   @override
//   State<SeeAllScreen> createState() => _SeeAllScreenState();
// }

// class _SeeAllScreenState extends State<SeeAllScreen> {
//   String _userName = "Guest";

//   @override
//   void initState() {
//     _loadUserName();
//     super.initState();
//     // Fetch tickets when the screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<MovieTicketProvider>(
//         context,
//         listen: false,
//       ).fetchAllTickets();
//     });
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
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 // Search Bar
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => SearchScreen()),
//                       );
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(16.0),
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       height: 50,
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.1),
//                             spreadRadius: 1,
//                             blurRadius: 10,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: const Row(
//                         children: [
//                           Icon(Icons.search, color: Colors.grey, size: 20),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               'Search',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Filter Button
//                 // Container(
//                 //   margin: const EdgeInsets.only(right: 16.0),
//                 //   child: const CircleAvatar(
//                 //     radius: 25,
//                 //     backgroundColor: Color(0xFF4A90E2),
//                 //     child: Icon(Icons.tune, color: Colors.white, size: 20),
//                 //   ),
//                 // ),
//               ],
//             ),
//             Expanded(
//               child: Consumer<MovieTicketProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (provider.error != null) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.error_outline,
//                             size: 64,
//                             color: Colors.grey[400],
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'Error: ${provider.error}',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 16,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 16),
//                           ElevatedButton(
//                             onPressed: () {
//                               provider.fetchAllTickets();
//                             },
//                             child: const Text('Retry'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }

//                   if (provider.tickets.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.movie_outlined,
//                             size: 64,
//                             color: Colors.grey[400],
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'No tickets available',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Check back later for new resale tickets',
//                             style: TextStyle(
//                               color: Colors.grey[500],
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }

//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       await provider.fetchAllTickets();
//                     },
//                     child: SingleChildScrollView(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 10),

//                           // Nearby Resale Tickets Section
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Available Resale Tickets (${provider.tickets.length})',
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 10),

//                           // Resale Tickets List
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                             ),
//                             itemCount: provider.tickets.length,
//                             itemBuilder: (context, index) {
//                               final ticket = provider.tickets[index];
//                               return _buildResaleTicketCard(ticket);
//                             },
//                           ),

//                           const SizedBox(height: 16),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildResaleTicketCard(MovieTicket ticket) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         border: Border.all(),
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
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailScreen(
//                     image: ticket.ticketImageUrl,
//                     ticketId: ticket.id,
//                     ticket: ticket,
//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               width: 60,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child:
//                   ticket.ticketImageUrl != null &&
//                       ticket.ticketImageUrl!.isNotEmpty
//                   ? ClipRRect(
//                       borderRadius: BorderRadius.circular(6),
//                       child: Image.network(
//                         ticket.ticketImageUrl!,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return _buildPlaceholderImage();
//                         },
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Center(
//                             child: CircularProgressIndicator(
//                               value: loadingProgress.expectedTotalBytes != null
//                                   ? loadingProgress.cumulativeBytesLoaded /
//                                         loadingProgress.expectedTotalBytes!
//                                   : null,
//                               strokeWidth: 2,
//                             ),
//                           );
//                         },
//                       ),
//                     )
//                   : _buildPlaceholderImage(),
//             ),
//           ),
//           const SizedBox(width: 12),

//           // Movie Details
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
//                 // Text(
//                 //   '${ticket.screenType} • ${ticket.language}',
//                 //   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 // ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${_formatDate(ticket.showDate)} ${ticket.showTime}',
//                   style: const TextStyle(fontSize: 14, color: Colors.black),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   '${ticket.theatrePlace}',
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//               ],
//             ),
//           ),

//           // Price and Seats
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 '₹${ticket.pricePerTicket.toStringAsFixed(0)}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 '${ticket.numberOfTickets} seat${ticket.numberOfTickets > 1 ? 's' : ''}',
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPlaceholderImage() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: const Icon(Icons.movie, size: 30, color: Colors.grey),
//     );
//   }

//   String _formatDate(DateTime date) {
//     final months = [
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
//     return '${date.day} ${months[date.month - 1]}';
//   }
// }

















import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
import 'package:backup_ticket/views/Home/image_detail_screen.dart';
import 'package:backup_ticket/views/notifications/notification_screen.dart';
import 'package:backup_ticket/views/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  String _userName = "Guest";

  @override
  void initState() {
    _loadUserName();
    super.initState();
    // Fetch categories when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieCategoryProvider>(
        context,
        listen: false,
      ).fetchCategories();
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
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                // Search Bar
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey, size: 20),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Consumer<MovieCategoryProvider>(
                builder: (context, categoryProvider, child) {
                  if (categoryProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (categoryProvider.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${categoryProvider.error}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              categoryProvider.fetchCategories();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final categories = categoryProvider.activeCategories;

                  if (categories.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No categories available',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Check back later for new categories',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await categoryProvider.fetchCategories();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),

                          // Categories Section Header
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'All Categories (${categories.length})',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Categories GridView
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return _buildCategoryCard(
                                  category.imageUrl,
                                  category.name,
                                  category.tags,
                                  category.languages.toString(),
                                  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageDetailScreen(
                                          movieName: category.name,
                                          assetImagePath: category.imageUrl,
                                          languages: category.languages
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    String imageUrl,
    String name,
    List<String> tags,
    String languages,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Image
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildPlaceholderImage();
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                                strokeWidth: 2,
                              ),
                            );
                          },
                        )
                      : _buildPlaceholderImage(),
                ),
              ),
            ),

            // Category Details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (tags.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      tags.join(' • '),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.category,
          size: 48,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}