// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:gal/gal.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

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
//                         '${ticketData['ticketType']}',
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

//           // Download and View Details Buttons
//           Padding(
//             padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     onPressed: () {
//                       _showBusTicketDetails(context, ticketData);
//                     },
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(color: Color(0xFF1976D2)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     icon: const Icon(
//                       Icons.info_outline,
//                       color: Color(0xFF1976D2),
//                     ),
//                     label: const Text(
//                       'View Details',
//                       style: TextStyle(
//                         color: Color(0xFF1976D2),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         _downloadTicket(context, ticketData, 'bus');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                       ),
//                       icon: const Icon(
//                         Icons.save_alt,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                       label: const Text(
//                         'Download',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
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

//   // Download Ticket Function with Gal package
//   Future<void> _downloadTicket(
//     BuildContext context,
//     Map<String, dynamic> ticketData,
//     String type,
//   ) async {
//     try {
//       // Show loading indicator
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Row(
//             children: [
//               SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                 ),
//               ),
//               SizedBox(width: 16),
//               Text('Downloading ticket...'),
//             ],
//           ),
//           duration: Duration(seconds: 2),
//         ),
//       );

//       String? imageUrl;
//       String fileName;

//       if (type == 'movie') {
//         // For movie tickets, use QR code or ticket image
//         imageUrl = ticketData['qrCodeImageUrl'] ?? ticketData['ticketImageUrl'];
//         final movieName = ticketData['movieName'] ?? 'Movie';
//         fileName =
//             'Ticket_${movieName.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.jpg';
//       } else {
//         // For bus tickets, use ticket image
//         imageUrl = ticketData['ticketImageUrl'];
//         final busName = ticketData['busName'] ?? 'Bus';
//         fileName =
//             'Ticket_${busName.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.jpg';
//       }

//       if (imageUrl == null || imageUrl.isEmpty) {
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('No ticket image available to download'),
//               backgroundColor: Colors.orange,
//             ),
//           );
//         }
//         return;
//       }

//       // Download the image from URL
//       final response = await http.get(Uri.parse(imageUrl));

//       if (response.statusCode == 200) {
//         // Get temporary directory
//         final tempDir = await getTemporaryDirectory();
//         final filePath = '${tempDir.path}/$fileName';

//         // Save the file temporarily
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);

//         // Check if Gal.hasAccess is available, if not request permission
//         bool hasAccess = true;
//         try {
//           hasAccess = await Gal.hasAccess();
//           if (!hasAccess) {
//             hasAccess = await Gal.requestAccess();
//           }
//         } catch (e) {
//           // If hasAccess method doesn't exist, try to save directly
//           print('Gal.hasAccess not available: $e');
//         }

//         if (hasAccess) {
//           // Save to gallery using Gal - try different methods
//           try {
//             await Gal.putImage(filePath);
//           } catch (e) {
//             // If putImage with album fails, try without album parameter
//             print('Error with putImage: $e');
//             await Gal.putImage(filePath);
//           }

//           // Delete temporary file
//           try {
//             await file.delete();
//           } catch (e) {
//             print('Error deleting temp file: $e');
//           }

//           // Show success message
//           if (context.mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Row(
//                   children: [
//                     const Icon(Icons.check_circle, color: Colors.white),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Text(
//                         'Ticket downloaded successfully!',
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//                 backgroundColor: Colors.green,
//                 behavior: SnackBarBehavior.floating,
//                 duration: Duration(seconds: 3),
//               ),
//             );
//           }
//         } else {
//           // Permission denied
//           if (context.mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Gallery access permission denied'),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         }
//       } else {
//         throw Exception(
//           'Failed to download image. Status: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       print('Download error: $e');
//       // Show error message
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: ${e.toString()}'),
//             backgroundColor: Colors.red,
//             duration: Duration(seconds: 4),
//             action: SnackBarAction(
//               label: 'OK',
//               textColor: Colors.white,
//               onPressed: () {},
//             ),
//           ),
//         );
//       }
//     }
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
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PurchasedTickets extends StatelessWidget {
  const PurchasedTickets({super.key});

  /// ================= DUMMY DATA =================
  List<Map<String, dynamic>> get _movieTickets => [
        {
          'movieName': 'Leo',
          'theatrePlace': 'PVR Lulu Mall',
          'showTime': '7:30 PM',
          'showDate': DateTime.now().add(const Duration(days: 1)),
          'totalPrice': 450,
          'numberOfTickets': 2,
          'ticketImageUrl':
              'https://via.placeholder.com/150',
          'qrCodeImageUrl':
              'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=LeoTicket',
          'paymentMethod': 'UPI',
        },
      ];

  List<Map<String, dynamic>> get _busTickets => [
        {
          'busName': 'KSRTC Swift',
          'pickupPoint': 'Calicut',
          'dropPoint': 'Bangalore',
          'ticketType': 'AC Sleeper',
          'dateOfJourney': DateTime.now().add(const Duration(days: 2)),
          'amount': 950,
          'paymentStatus': 'completed',
          'ticketImageUrl':
              'https://via.placeholder.com/150',
          'paymentId': 'PAY123456',
          'purchasedAt': DateTime.now(),
        },
      ];

  /// ================= UI =================
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
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: const TabBar(
            labelColor: Color(0xFF1976D2),
            indicatorColor: Color(0xFF1976D2),
            tabs: [
              Tab(icon: Icon(Icons.movie), text: 'Movie Tickets'),
              Tab(icon: Icon(Icons.directions_bus), text: 'Bus Tickets'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMovieTicketsTab(context),
            _buildBusTicketsTab(context),
          ],
        ),
      ),
    );
  }

  /// ================= MOVIE TAB =================
  Widget _buildMovieTicketsTab(BuildContext context) {
    if (_movieTickets.isEmpty) {
      return _emptyState(
        Icons.movie_outlined,
        'No movie tickets purchased yet',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _movieTickets.length,
      itemBuilder: (_, i) =>
          _buildMovieTicketCard(context, _movieTickets[i]),
    );
  }

  /// ================= BUS TAB =================
  Widget _buildBusTicketsTab(BuildContext context) {
    if (_busTickets.isEmpty) {
      return _emptyState(
        Icons.directions_bus_outlined,
        'No bus tickets purchased yet',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _busTickets.length,
      itemBuilder: (_, i) =>
          _buildBusTicketCard(context, _busTickets[i]),
    );
  }

  /// ================= MOVIE CARD =================
  Widget _buildMovieTicketCard(
      BuildContext context, Map<String, dynamic> ticket) {
    return _card(
      Column(
        children: [
          ListTile(
            leading: const Icon(Icons.movie, size: 40),
            title: Text(ticket['movieName']),
            subtitle: Text(
              '${_formatDate(ticket['showDate'])}, ${ticket['showTime']}\n${ticket['theatrePlace']}',
            ),
            trailing: Text(
              '₹${ticket['totalPrice']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
          ),
          _downloadButton(context, ticket, 'movie'),
        ],
      ),
    );
  }

  /// ================= BUS CARD =================
  Widget _buildBusTicketCard(
      BuildContext context, Map<String, dynamic> ticket) {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.directions_bus, size: 40),
            title: Text(ticket['busName']),
            subtitle: Text(
              '${ticket['pickupPoint']} → ${ticket['dropPoint']}\n${_formatDate(ticket['dateOfJourney'])}',
            ),
            trailing: Text(
              '₹${ticket['amount']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
          ),
          _downloadButton(context, ticket, 'bus'),
        ],
      ),
    );
  }

  /// ================= COMMON =================
  Widget _card(Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _downloadButton(
    BuildContext context,
    Map<String, dynamic> ticket,
    String type,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.save_alt),
        label: const Text('Download Ticket'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
        ),
        onPressed: () => _downloadTicket(context, ticket, type),
      ),
    );
  }

  Widget _emptyState(IconData icon, String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 72, color: Colors.grey),
          const SizedBox(height: 12),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  /// ================= HELPERS =================
  String _formatDate(DateTime date) {
    const months = [
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
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// ================= DOWNLOAD =================
  Future<void> _downloadTicket(
    BuildContext context,
    Map<String, dynamic> ticket,
    String type,
  ) async {
    try {
      final imageUrl = ticket['ticketImageUrl'];
      if (imageUrl == null || imageUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image available')),
        );
        return;
      }

      final response = await http.get(Uri.parse(imageUrl));
      final dir = await getTemporaryDirectory();
      final file =
          File('${dir.path}/ticket_${DateTime.now().millisecondsSinceEpoch}.jpg');

      await file.writeAsBytes(response.bodyBytes);
      await Gal.putImage(file.path);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ticket downloaded successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    }
  }
}
