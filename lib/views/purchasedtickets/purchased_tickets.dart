// import 'dart:io';
// import 'package:backup_ticket/provider/purchaseticket/purchase_ticket_provider.dart';
// import 'package:backup_ticket/services/purchase_ticket_service.dart';
// import 'package:flutter/material.dart';
// import 'package:gal/gal.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// import 'package:intl/intl.dart';

// class PurchasedTickets extends StatefulWidget {
//   const PurchasedTickets({super.key});

//   @override
//   State<PurchasedTickets> createState() => _PurchasedTicketsState();
// }

// class _PurchasedTicketsState extends State<PurchasedTickets> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch tickets when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<TicketProvider>(
//         context,
//         listen: false,
//       ).fetchPurchasedTickets();
//     });
//   }

//   /// ================= DUMMY DATA FOR BUS TICKETS =================
//   List<Map<String, dynamic>> get _busTickets => [
//     {
//       'busName': 'KSRTC Swift',
//       'pickupPoint': 'Calicut',
//       'dropPoint': 'Bangalore',
//       'ticketType': 'AC Sleeper',
//       'dateOfJourney': DateTime.now().add(const Duration(days: 2)),
//       'amount': 950,
//       'paymentStatus': 'completed',
//       'ticketImageUrl': 'https://via.placeholder.com/150',
//       'paymentId': 'PAY123456',
//       'purchasedAt': DateTime.now(),
//     },
//   ];

//   /// ================= UI =================
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
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//           bottom: const TabBar(
//             labelColor: Color(0xFF1976D2),
//             indicatorColor: Color(0xFF1976D2),
//             tabs: [
//               Tab(icon: Icon(Icons.movie), text: 'Movie Tickets'),
//               Tab(icon: Icon(Icons.directions_bus), text: 'Bus Tickets'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildMovieTicketsTab(context),
//             _buildBusTicketsTab(context),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ================= MOVIE TAB =================
//   Widget _buildMovieTicketsTab(BuildContext context) {
//     return Consumer<TicketProvider>(
//       builder: (context, ticketProvider, child) {
//         if (ticketProvider.isLoading) {
//           return const Center(
//             child: CircularProgressIndicator(color: Color(0xFF1976D2)),
//           );
//         }

//         if (ticketProvider.errorMessage != null) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.error_outline, size: 72, color: Colors.red[300]),
//                 const SizedBox(height: 16),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 32),
//                   child: Text(
//                     ticketProvider.errorMessage!,
//                     style: TextStyle(fontSize: 16, color: Colors.red[700]),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.refresh),
//                   label: const Text('Retry'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF1976D2),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 32,
//                       vertical: 12,
//                     ),
//                   ),
//                   onPressed: () => ticketProvider.refreshTickets(),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (ticketProvider.orders.isEmpty) {
//           return _emptyState(
//             Icons.movie_outlined,
//             'No movie tickets purchased yet',
//           );
//         }

//         return RefreshIndicator(
//           onRefresh: () => ticketProvider.refreshTickets(),
//           color: const Color(0xFF1976D2),
//           child: ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: ticketProvider.orders.length,
//             itemBuilder: (_, i) {
//               final order = ticketProvider.orders[i];
//               return _buildMovieOrderCard(context, order);
//             },
//           ),
//         );
//       },
//     );
//   }

//   /// ================= BUS TAB =================
//   Widget _buildBusTicketsTab(BuildContext context) {
//     if (_busTickets.isEmpty) {
//       return _emptyState(
//         Icons.directions_bus_outlined,
//         'No bus tickets purchased yet',
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _busTickets.length,
//       itemBuilder: (_, i) => _buildBusTicketCard(context, _busTickets[i]),
//     );
//   }

//   /// ================= MOVIE ORDER CARD =================
//   Widget _buildMovieOrderCard(BuildContext context, OrderModel order) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Order Header
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: _getStatusColor(order.orderStatus).withOpacity(0.1),
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Order #${order.orderId.substring(order.orderId.length - 8)}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       _formatDateTime(order.createdAt),
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: _getStatusColor(order.orderStatus),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     order.orderStatus.toUpperCase(),
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 11,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Tickets List
//           ...order.tickets.map(
//             (ticket) => _buildMovieTicketItem(context, ticket, order),
//           ),

//           // Order Footer
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(12),
//                 bottomRight: Radius.circular(12),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Total Amount',
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       '₹${order.totalAmount}',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1976D2),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       'Payment',
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                     const SizedBox(height: 2),
//                     Row(
//                       children: [
//                         Icon(
//                           order.paymentStatus == 'paid'
//                               ? Icons.check_circle
//                               : Icons.pending,
//                           size: 16,
//                           color: order.paymentStatus == 'paid'
//                               ? Colors.green
//                               : Colors.orange,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           order.paymentStatus.toUpperCase(),
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: order.paymentStatus == 'paid'
//                                 ? Colors.green
//                                 : Colors.orange,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ================= MOVIE TICKET ITEM =================
//   Widget _buildMovieTicketItem(
//     BuildContext context,
//     TicketModel ticket,
//     OrderModel order,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Movie Poster
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   ticket.fullImageUrl,
//                   width: 80,
//                   height: 100,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       width: 80,
//                       height: 100,
//                       color: Colors.grey[300],
//                       child: const Icon(
//                         Icons.movie,
//                         size: 40,
//                         color: Colors.grey,
//                       ),
//                     );
//                   },
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Container(
//                       width: 80,
//                       height: 100,
//                       color: Colors.grey[200],
//                       child: const Center(
//                         child: CircularProgressIndicator(strokeWidth: 2),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(width: 12),

//               // Movie Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       ticket.movieName,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.calendar_today,
//                           size: 14,
//                           color: Colors.grey[600],
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           _formatDate(ticket.showDate),
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Icon(
//                           Icons.access_time,
//                           size: 14,
//                           color: Colors.grey[600],
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           ticket.showTime,
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF1976D2).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         ticket.ticketCategory,
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Color(0xFF1976D2),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       'Seats: ${ticket.selectedSeats.join(", ")}',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[700],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '₹${ticket.pricePerTicket} × ${ticket.selectedSeats.length} = ₹${ticket.pricePerTicket * ticket.selectedSeats.length}',
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1976D2),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),

//           // Download Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               icon: const Icon(Icons.save_alt, size: 18),
//               label: const Text('Download Ticket'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF1976D2),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () => _downloadMovieTicket(context, ticket),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ================= BUS CARD =================
//   Widget _buildBusTicketCard(
//     BuildContext context,
//     Map<String, dynamic> ticket,
//   ) {
//     return _card(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             leading: const Icon(Icons.directions_bus, size: 40),
//             title: Text(ticket['busName']),
//             subtitle: Text(
//               '${ticket['pickupPoint']} → ${ticket['dropPoint']}\n${_formatDate(ticket['dateOfJourney'])}',
//             ),
//             trailing: Text(
//               '₹${ticket['amount']}',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1976D2),
//               ),
//             ),
//           ),
//           _downloadButton(context, ticket, 'bus'),
//         ],
//       ),
//     );
//   }

//   /// ================= COMMON =================
//   Widget _card(Widget child) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 8),
//         ],
//       ),
//       child: child,
//     );
//   }

//   Widget _downloadButton(
//     BuildContext context,
//     Map<String, dynamic> ticket,
//     String type,
//   ) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         icon: const Icon(Icons.save_alt),
//         label: const Text('Download Ticket'),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF1976D2),
//         ),
//         onPressed: () => _downloadTicket(context, ticket, type),
//       ),
//     );
//   }

//   Widget _emptyState(IconData icon, String text) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 72, color: Colors.grey),
//           const SizedBox(height: 12),
//           Text(text, style: const TextStyle(fontSize: 16, color: Colors.grey)),
//         ],
//       ),
//     );
//   }

//   /// ================= HELPERS =================
//   String _formatDate(DateTime date) {
//     return DateFormat('dd MMM yyyy').format(date);
//   }

//   String _formatDateTime(DateTime date) {
//     return DateFormat('dd MMM yyyy, hh:mm a').format(date);
//   }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'completed':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'cancelled':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   /// ================= DOWNLOAD MOVIE TICKET =================
//   Future<void> _downloadMovieTicket(
//     BuildContext context,
//     TicketModel ticket,
//   ) async {
//     try {
//       // Show loading indicator
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(
//           child: CircularProgressIndicator(color: Color(0xFF1976D2)),
//         ),
//       );

//       final imageUrl = ticket.fullImageUrl;
//       final response = await http.get(Uri.parse(imageUrl));

//       if (response.statusCode != 200) {
//         throw Exception('Failed to download image');
//       }

//       final dir = await getTemporaryDirectory();
//       final file = File(
//         '${dir.path}/movie_ticket_${ticket.movieName.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.jpg',
//       );

//       await file.writeAsBytes(response.bodyBytes);
//       await Gal.putImage(file.path);

//       // Close loading dialog
//       Navigator.pop(context);

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: const [
//               Icon(Icons.check_circle, color: Colors.white),
//               SizedBox(width: 8),
//               Text('Ticket downloaded  successfully'),
//             ],
//           ),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//       );
//     } catch (e) {
//       // Close loading dialog
//       Navigator.pop(context);

//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: [
//               const Icon(Icons.error_outline, color: Colors.white),
//               const SizedBox(width: 8),
//               Expanded(child: Text('Download failed: ${e.toString()}')),
//             ],
//           ),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//       );
//     }
//   }

//   /// ================= DOWNLOAD BUS TICKET =================
//   Future<void> _downloadTicket(
//     BuildContext context,
//     Map<String, dynamic> ticket,
//     String type,
//   ) async {
//     try {
//       final imageUrl = ticket['ticketImageUrl'];
//       if (imageUrl == null || imageUrl.isEmpty) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('No image available')));
//         return;
//       }

//       final response = await http.get(Uri.parse(imageUrl));
//       final dir = await getTemporaryDirectory();
//       final file = File(
//         '${dir.path}/ticket_${DateTime.now().millisecondsSinceEpoch}.jpg',
//       );

//       await file.writeAsBytes(response.bodyBytes);
//       await Gal.putImage(file.path);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Ticket downloaded successfully'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
//     }
//   }
// }

// import 'dart:io';
// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/model/purchased_ticket_models.dart';
// import 'package:backup_ticket/provider/purchaseticket/purchased_ticket_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gal/gal.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:media_scanner/media_scanner.dart';

// class PurchasedTickets extends StatefulWidget {
//   const PurchasedTickets({super.key});

//   @override
//   State<PurchasedTickets> createState() => _PurchasedTicketsState();
// }

// class _PurchasedTicketsState extends State<PurchasedTickets> {
//   String? userId;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserAndTickets();
//   }

//     Future<void> _loadUserAndTickets() async {
//     final user = await SharedPrefsHelper.getUser();

//     if (!mounted) return;

//     setState(() {
//       userId = user?.id;
//     });

//     if (userId != null) {
//       context
//           .read<PurchasedTicketProvider>()
//           .fetchPurchasedTickets(userId!);
//     }
//   }

//   /// ================= STATIC BUS DATA (UNCHANGED) =================
//   List<Map<String, dynamic>> get _busTickets => [
//         {
//           'busName': 'KSRTC Swift',
//           'pickupPoint': 'Calicut',
//           'dropPoint': 'Bangalore',
//           'ticketType': 'AC Sleeper',
//           'dateOfJourney': DateTime.now().add(const Duration(days: 2)),
//           'amount': 950,
//           'paymentStatus': 'completed',
//           'ticketImageUrl': 'https://via.placeholder.com/150',
//         },
//       ];

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
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//           bottom: const TabBar(
//             labelColor: Color(0xFF1976D2),
//             indicatorColor: Color(0xFF1976D2),
//             tabs: [
//               Tab(icon: Icon(Icons.movie), text: 'Movie Tickets'),
//               Tab(icon: Icon(Icons.directions_bus), text: 'Bus Tickets'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildMovieTicketsTab(), // 🔥 API BASED
//             _buildBusTicketsTab(),   // ✅ STATIC
//           ],
//         ),
//       ),
//     );
//   }

//   /// ================= MOVIE TAB (API BASED) =================
//   Widget _buildMovieTicketsTab() {
//     return Consumer<PurchasedTicketProvider>(
//       builder: (_, provider, __) {
//         if (provider.isLoading) {
//           return const Center(
//             child: CircularProgressIndicator(color: Color(0xFF1976D2)),
//           );
//         }

//         if (provider.errorMessage != null) {
//           return Center(child: Text(provider.errorMessage!));
//         }

//         if (provider.orders.isEmpty) {
//           return _emptyState(Icons.movie, 'No movie tickets purchased yet');
//         }

//         return RefreshIndicator(
//           onRefresh: () => provider.refresh(userId.toString()),
//           child: ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: provider.orders.length,
//             itemBuilder: (_, i) =>
//                 _buildMovieOrderCard(provider.orders[i]),
//           ),
//         );
//       },
//     );
//   }

//   /// ================= BUS TAB (STATIC – UNCHANGED) =================
//   Widget _buildBusTicketsTab() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _busTickets.length,
//       itemBuilder: (_, i) => _buildBusTicketCard(_busTickets[i]),
//     );
//   }

//   /// ================= MOVIE ORDER CARD =================
//   Widget _buildMovieOrderCard(PurchasedOrder order) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 8),
//         ],
//       ),
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(
//               'Order #${order.orderId.substring(order.orderId.length - 6)}',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//               DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt),
//             ),
//             trailing: Chip(
//               label: Text(order.orderStatus.toUpperCase()),
//               backgroundColor: Colors.green,
//             ),
//           ),

//           ...order.tickets.map((t) => _movieTicketItem(t)),

//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '₹${order.totalAmount}',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1976D2),
//                   ),
//                 ),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.picture_as_pdf),
//                   label: const Text('Invoice'),
//                   onPressed: () => _downloadPdf(order.pdfUrl),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ================= MOVIE TICKET ITEM =================
//   Widget _movieTicketItem(PurchasedTicketWrapper wrapper) {
//     final ticket = wrapper.ticket;
//     final movie = wrapper.movie;

//     return ListTile(
//       leading: ClipRRect(
//         borderRadius: BorderRadius.circular(6),
//         child: Image.network(
//           movie.fullImageUrl,
//           width: 60,
//           height: 80,
//           fit: BoxFit.cover,
//         ),
//       ),
//       title: Text(ticket.movieName),
//       subtitle: Text(
//         '${DateFormat('dd MMM').format(ticket.showDate)} • ${ticket.showTime}\nSeats: ${ticket.selectedSeats.join(', ')}',
//       ),
//     );
//   }

//   /// ================= BUS CARD (UNCHANGED) =================
//   Widget _buildBusTicketCard(Map<String, dynamic> ticket) {
//     return Card(
//       child: ListTile(
//         leading: const Icon(Icons.directions_bus, size: 40),
//         title: Text(ticket['busName']),
//         subtitle: Text(
//           '${ticket['pickupPoint']} → ${ticket['dropPoint']}',
//         ),
//         trailing: Text(
//           '₹${ticket['amount']}',
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1976D2),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _emptyState(IconData icon, String text) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 72, color: Colors.grey),
//           const SizedBox(height: 12),
//           Text(text, style: const TextStyle(color: Colors.grey)),
//         ],
//       ),
//     );
//   }

//   /// ================= DOWNLOAD HELPERS =================

// // Future<void> _downloadPdf(String pdfPath) async {
// //   try {
// //     // Loader
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (_) => const Center(
// //         child: CircularProgressIndicator(color: Color(0xFF1976D2)),
// //       ),
// //     );

// //     final String url = 'http://31.97.206.144:8127$pdfPath';

// //     final response = await http.get(Uri.parse(url));

// //     if (response.statusCode != 200) {
// //       throw Exception('Failed to download PDF');
// //     }

// //     // 📂 Save to Downloads (Android) / Documents (iOS)
// //     final Directory dir = Platform.isAndroid
// //         ? Directory('/storage/emulated/0/Download')
// //         : await getApplicationDocumentsDirectory();

// //     final file = File(
// //       '${dir.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf',
// //     );

// //     await file.writeAsBytes(response.bodyBytes);

// //     Navigator.pop(context);

// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         backgroundColor: Colors.green,
// //         content: Text('Invoice saved to ${dir.path}'),
// //       ),
// //     );
// //   } catch (e) {
// //     Navigator.pop(context);
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         backgroundColor: Colors.red,
// //         content: Text('PDF download failed: $e'),
// //       ),
// //     );
// //   }
// // }

// Future<void> _downloadPdf(String pdfPath) async {
//   try {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => const Center(
//         child: CircularProgressIndicator(color: Color(0xFF1976D2)),
//       ),
//     );

//     final String url = 'http://31.97.206.144:8127$pdfPath';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode != 200) {
//       throw Exception('Failed to download PDF');
//     }

//     final Directory dir = Directory('/storage/emulated/0/Download');
//     final file = File(
//       '${dir.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf',
//     );

//     await file.writeAsBytes(response.bodyBytes);

//     // 🔥 THIS MAKES IT APPEAR IN "DOWNLOADS" CATEGORY
//     await MediaScanner.loadMedia(path: file.path);

//     Navigator.pop(context);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.green,
//         content: Text('Invoice downloaded successfully'),
//       ),
//     );
//   } catch (e) {
//     Navigator.pop(context);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         backgroundColor: Colors.red,
//         content: Text('PDF download failed: $e'),
//       ),
//     );
//   }
// }

// }

// import 'dart:io';
// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/model/purchased_ticket_models.dart';
// import 'package:backup_ticket/provider/purchaseticket/purchased_ticket_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gal/gal.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:media_scanner/media_scanner.dart';

// class PurchasedTickets extends StatefulWidget {
//   const PurchasedTickets({super.key});

//   @override
//   State<PurchasedTickets> createState() => _PurchasedTicketsState();
// }

// class _PurchasedTicketsState extends State<PurchasedTickets> {
//   String? userId;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserAndTickets();
//   }

//   Future<void> _loadUserAndTickets() async {
//     final user = await SharedPrefsHelper.getUser();

//     if (!mounted) return;

//     setState(() {
//       userId = user?.id;
//     });

//     if (userId != null) {
//       context.read<PurchasedTicketProvider>().fetchPurchasedTickets(userId!);
//     }
//   }

//   /// ================= STATIC BUS DATA (UNCHANGED) =================
//   List<Map<String, dynamic>> get _busTickets => [
//         {
//           'busName': 'KSRTC Swift',
//           'pickupPoint': 'Calicut',
//           'dropPoint': 'Bangalore',
//           'ticketType': 'AC Sleeper',
//           'dateOfJourney': DateTime.now().add(const Duration(days: 2)),
//           'amount': 950,
//           'paymentStatus': 'completed',
//           'ticketImageUrl': 'https://via.placeholder.com/150',
//         },
//       ];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.grey[100],
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text(
//             'My Purchased Tickets',
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//           bottom: const TabBar(
//             labelColor: Color(0xFF1976D2),
//             unselectedLabelColor: Colors.grey,
//             indicatorColor: Color(0xFF1976D2),
//             tabs: [
//               Tab(icon: Icon(Icons.movie), text: 'Movie Tickets'),
//               Tab(icon: Icon(Icons.directions_bus), text: 'Bus Tickets'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildMovieTicketsTab(), // 🔥 API BASED
//             _buildBusTicketsTab(), // ✅ STATIC
//           ],
//         ),
//       ),
//     );
//   }

//   /// ================= MOVIE TAB (API BASED) =================
//   Widget _buildMovieTicketsTab() {
//     return Consumer<PurchasedTicketProvider>(
//       builder: (_, provider, __) {
//         if (provider.isLoading) {
//           return const Center(
//             child: CircularProgressIndicator(color: Color(0xFF1976D2)),
//           );
//         }

//         if (provider.errorMessage != null) {
//           return Center(child: Text(provider.errorMessage!));
//         }

//         if (provider.orders.isEmpty) {
//           return _emptyState(Icons.movie, 'No movie tickets purchased yet');
//         }

//         return RefreshIndicator(
//           onRefresh: () => provider.refresh(userId.toString()),
//           child: ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: provider.orders.length,
//             itemBuilder: (_, i) => _buildMovieOrderCard(provider.orders[i]),
//           ),
//         );
//       },
//     );
//   }

//   /// ================= BUS TAB (STATIC – UNCHANGED) =================
//   Widget _buildBusTicketsTab() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _busTickets.length,
//       itemBuilder: (_, i) => _buildBusTicketCard(_busTickets[i]),
//     );
//   }

//   /// ================= MOVIE ORDER CARD WITH TICKET DESIGN =================
//   Widget _buildMovieOrderCard(PurchasedOrder order) {
//     final ticketStatus =
//     order.tickets.isNotEmpty ? order.tickets.first.ticket.status : 'unknown';

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: ClipPath(
//         clipper: TicketClipper(),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               // Top Section - Order Info
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Order #${order.orderId.substring(order.orderId.length - 6)}',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               DateFormat('dd MMM yyyy, hh:mm a')
//                                   .format(order.createdAt),
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//   Container(
//   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//   decoration: BoxDecoration(
//     color: ticketStatus == 'active'
//         ? Colors.green[50]
//         : Colors.red[50],
//     borderRadius: BorderRadius.circular(12),
//     border: Border.all(
//       color: ticketStatus == 'active'
//           ? Colors.green
//           : Colors.red,
//     ),
//   ),
//   child: Text(
//     ticketStatus.toUpperCase(),
//     style: TextStyle(
//       fontSize: 11,
//       fontWeight: FontWeight.bold,
//       color: ticketStatus == 'active'
//           ? Colors.green[700]
//           : Colors.red[700],
//     ),
//   ),
// ),

//                       ],
//                     ),
//                     SizedBox(height: 16),

//                     // Movie Tickets List
//                     ...order.tickets.map((t) => _movieTicketItem(t)),
//                   ],
//                 ),
//               ),

//               // Divider with semicircle cuts
//               SizedBox(height: 8),

//               // Bottom Section - Price & Download
//               Container(
//                 padding: EdgeInsets.all(16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Total Amount',
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           '₹ ${order.totalAmount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF1976D2),
//                           ),
//                         ),
//                       ],
//                     ),
//                     ElevatedButton.icon(
//                       icon: const Icon(Icons.download, size: 18),
//                       label: const Text('Invoice'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF1976D2),
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 12,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () => _downloadPdf(order.pdfUrl),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// ================= MOVIE TICKET ITEM =================
//   Widget _movieTicketItem(PurchasedTicketWrapper wrapper) {
//     final ticket = wrapper.ticket;
//     final movie = wrapper.movie;

//     return Container(
//       margin: EdgeInsets.only(bottom: 12),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Movie Poster
//           ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: Image.network(
//               movie.fullImageUrl,
//               width: 60,
//               height: 80,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Container(
//                 width: 60,
//                 height: 80,
//                 color: Colors.grey[300],
//                 child: Icon(Icons.movie, size: 30),
//               ),
//             ),
//           ),
//           SizedBox(width: 12),

//           // Movie Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   ticket.movieName,
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Icon(Icons.calendar_today, size: 13, color: Colors.grey[600]),
//                     SizedBox(width: 4),
//                     Text(
//                       '${DateFormat('dd MMM yyyy').format(ticket.showDate)} • ${ticket.showTime}',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Icon(Icons.event_seat, size: 13, color: Colors.grey[600]),
//                     SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         'Seats: ${ticket.selectedSeats.join(', ')}',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey[700],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ================= BUS CARD WITH TICKET DESIGN =================
//   Widget _buildBusTicketCard(Map<String, dynamic> ticket) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: ClipPath(
//         clipper: TicketClipper(),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               // Top Section
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Color(0xFF1976D2).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         Icons.directions_bus,
//                         size: 32,
//                         color: Color(0xFF1976D2),
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             ticket['busName'],
//                             style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             ticket['ticketType'],
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Text(
//                                 ticket['pickupPoint'],
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 8),
//                                 child: Icon(
//                                   Icons.arrow_forward,
//                                   size: 16,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                               Text(
//                                 ticket['dropPoint'],
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Divider with semicircle cuts
//               SizedBox(height: 8),

//               // Bottom Section
//               Container(
//                 padding: EdgeInsets.all(16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Date of Journey',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           DateFormat('dd MMM yyyy')
//                               .format(ticket['dateOfJourney']),
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           'Fare',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           '₹ ${ticket['amount']}',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF1976D2),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _emptyState(IconData icon, String text) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 72, color: Colors.grey),
//           const SizedBox(height: 12),
//           Text(text, style: const TextStyle(color: Colors.grey)),
//         ],
//       ),
//     );
//   }

//   /// ================= DOWNLOAD HELPERS =================
//   Future<void> _downloadPdf(String pdfPath) async {
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (_) => const Center(
//           child: CircularProgressIndicator(color: Color(0xFF1976D2)),
//         ),
//       );

//       final String url = 'http://31.97.206.144:8127$pdfPath';
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode != 200) {
//         throw Exception('Failed to download PDF');
//       }

//       final Directory dir = Directory('/storage/emulated/0/Download');
//       final file = File(
//         '${dir.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf',
//       );

//       await file.writeAsBytes(response.bodyBytes);

//       // 🔥 THIS MAKES IT APPEAR IN "DOWNLOADS" CATEGORY
//       await MediaScanner.loadMedia(path: file.path);

//       Navigator.pop(context);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.green,
//           content: Text('Invoice downloaded successfully'),
//         ),
//       );
//     } catch (e) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           content: Text('PDF download failed: $e'),
//         ),
//       );
//     }
//   }
// }

// /// ================= TICKET CLIPPER =================
// class TicketClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     const radius = 12.0;
//     const semicircleRadius = 12.0;

//     // Start from top-left
//     path.moveTo(radius, 0);

//     // Top edge
//     path.lineTo(size.width - radius, 0);
//     path.arcToPoint(
//       Offset(size.width, radius),
//       radius: Radius.circular(radius),
//     );

//     // Right edge with semicircle cut (middle)
//     double middleY = size.height * 0.65;
//     path.lineTo(size.width, middleY - semicircleRadius);
//     path.arcToPoint(
//       Offset(size.width, middleY + semicircleRadius),
//       radius: Radius.circular(semicircleRadius),
//       clockwise: false,
//     );

//     // Continue right edge
//     path.lineTo(size.width, size.height - radius);
//     path.arcToPoint(
//       Offset(size.width - radius, size.height),
//       radius: Radius.circular(radius),
//     );

//     // Bottom edge
//     path.lineTo(radius, size.height);
//     path.arcToPoint(
//       Offset(0, size.height - radius),
//       radius: Radius.circular(radius),
//     );

//     // Left edge with semicircle cut (middle)
//     path.lineTo(0, middleY + semicircleRadius);
//     path.arcToPoint(
//       Offset(0, middleY - semicircleRadius),
//       radius: Radius.circular(semicircleRadius),
//       clockwise: false,
//     );

//     // Continue left edge
//     path.lineTo(0, radius);
//     path.arcToPoint(
//       Offset(radius, 0),
//       radius: Radius.circular(radius),
//     );

//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'dart:io';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/purchased_ticket_models.dart';
import 'package:backup_ticket/provider/purchaseticket/purchased_ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:media_scanner/media_scanner.dart';

class PurchasedTickets extends StatefulWidget {
  const PurchasedTickets({super.key});

  @override
  State<PurchasedTickets> createState() => _PurchasedTicketsState();
}

class _PurchasedTicketsState extends State<PurchasedTickets> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserAndTickets();
  }

  Future<void> _loadUserAndTickets() async {
    final user = await SharedPrefsHelper.getUser();

    if (!mounted) return;

    setState(() {
      userId = user?.id;
    });

    if (userId != null) {
      context.read<PurchasedTicketProvider>().fetchPurchasedTickets(userId!);
    }
  }

  /// ================= STATIC BUS DATA (UNCHANGED) =================
  List<Map<String, dynamic>> get _busTickets => [
    {
      'busName': 'KSRTC Swift',
      'pickupPoint': 'Calicut',
      'dropPoint': 'Bangalore',
      'ticketType': 'AC Sleeper',
      'dateOfJourney': DateTime.now().add(const Duration(days: 2)),
      'amount': 950,
      'paymentStatus': 'completed',
      'ticketImageUrl': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
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
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF1976D2),
            tabs: [
              Tab(icon: Icon(Icons.movie), text: 'Movie Tickets'),
              // Tab(icon: Icon(Icons.directions_bus), text: 'Bus Tickets'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMovieTicketsTab(), // 🔥 API BASED
            // _buildBusTicketsTab(), // ✅ STATIC
          ],
        ),
      ),
    );
  }

  /// ================= MOVIE TAB (API BASED) =================
  Widget _buildMovieTicketsTab() {
    return Consumer<PurchasedTicketProvider>(
      builder: (_, provider, __) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF1976D2)),
          );
        }

        if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        }

        if (provider.orders.isEmpty) {
          return _emptyState(Icons.movie, 'No movie tickets purchased yet');
        }

        return RefreshIndicator(
          onRefresh: () => provider.refresh(userId.toString()),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.orders.length,
            itemBuilder: (_, i) => _buildMovieOrderCard(provider.orders[i]),
          ),
        );
      },
    );
  }

  /// ================= BUS TAB (STATIC – UNCHANGED) =================
  Widget _buildBusTicketsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _busTickets.length,
      itemBuilder: (_, i) => _buildBusTicketCard(_busTickets[i]),
    );
  }

  /// ================= MOVIE ORDER CARD WITH TICKET DESIGN =================
  Widget _buildMovieOrderCard(PurchasedOrder order) {
    final ticketStatus = order.tickets.isNotEmpty
        ? order.tickets.first.ticket.status
        : 'unknown';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Top Section - Order Info
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order #${order.orderId.substring(order.orderId.length - 6)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              DateFormat(
                                'dd MMM yyyy, hh:mm a',
                              ).format(order.createdAt),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: ticketStatus == 'active'
                                ? Colors.green[50]
                                : Colors.red[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: ticketStatus == 'active'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          child: Text(
                            ticketStatus.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: ticketStatus == 'active'
                                  ? Colors.green[700]
                                  : Colors.red[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Movie Tickets List
                    ...order.tickets.map((t) => _movieTicketItem(t)),
                  ],
                ),
              ),

              // Divider with semicircle cuts
              SizedBox(height: 8),

              // Bottom Section - Price & Download
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹ ${order.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Preview Button
                        ElevatedButton.icon(
                          icon: const Icon(Icons.visibility, size: 18),
                          label: const Text('Preview'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1976D2),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => _showTicketPreview(order),
                        ),
                        // SizedBox(width: 8),
                        // // Invoice Button
                        // ElevatedButton.icon(
                        //   icon: const Icon(Icons.download, size: 18),
                        //   label: const Text('Invoice'),
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Color(0xFF1976D2),
                        //     foregroundColor: Colors.white,
                        //     padding: EdgeInsets.symmetric(
                        //       horizontal: 16,
                        //       vertical: 12,
                        //     ),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        //   onPressed: () => _downloadPdf(order.pdfUrl),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= MOVIE TICKET ITEM =================
  Widget _movieTicketItem(PurchasedTicketWrapper wrapper) {
    final ticket = wrapper.ticket;
    final movie = wrapper.movie;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              movie.fullImageUrl,
              width: 60,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60,
                height: 80,
                color: Colors.grey[300],
                child: Icon(Icons.movie, size: 30),
              ),
            ),
          ),
          SizedBox(width: 12),

          // Movie Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.movieName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 13,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${DateFormat('dd MMM yyyy').format(ticket.showDate)} • ${ticket.showTime}',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.event_seat, size: 13, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Seats: ${ticket.selectedSeats.join(', ')}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= TICKET PREVIEW DIALOG =================
  void _showTicketPreview(PurchasedOrder order) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.black),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(height: 8),
              // Ticket Preview Cards
              ...order.tickets.map((ticket) => _buildTicketPreviewCard(ticket)),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= TICKET PREVIEW CARD (BOOKMYSHOW STYLE) =================
Widget _buildTicketPreviewCard(PurchasedTicketWrapper wrapper) {
  final ticket = wrapper.ticket;
  final movie = wrapper.movie;

  return Container(
    margin: EdgeInsets.only(bottom: 16),
    child: Stack(
      children: [
        // Main ticket container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Top section with movie details
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Header with logo and backup ticket badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/appstore.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey[300],
                              child: Icon(Icons.movie, size: 40),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Backup Ticket',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Movie poster and details
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            movie.fullImageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: Icon(Icons.movie, size: 40),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ticket.movieName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${ticket.language}, ${ticket.ticketType}',
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Date, time and theatre
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('EEE, dd MMM').format(ticket.showDate),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                ticket.showTime,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ticket.theatrePlace,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Dotted separator with circular cutouts
              Stack(
                alignment: Alignment.center,
                children: [
                  // Dotted line
                  CustomPaint(
                    size: Size(double.infinity, 1),
                    painter: DottedLinePainter(),
                  ),
                  // Left circle cutout
                  Positioned(
                    left: -10,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Right circle cutout
                  Positioned(
                    right: -10,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              // Bottom section with ticket details
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Seats and Screen
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${ticket.quantity} Ticket(s)',
                              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                            ),
                            SizedBox(height: 4),
                            Text(
                              ticket.screen,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'SEATS',
                              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                            ),
                            SizedBox(height: 4),
                            Text(
                              ticket.selectedSeats.isNotEmpty
                                  ? ticket.selectedSeats
                                      .map((seat) {
                                        final parts = seat.split(',');
                                        if (parts.length != 2) return seat;
                                        final row = parts[0].replaceAll('Row', '').trim();
                                        final number = parts[1].replaceAll('Seat', '').trim();
                                        return '$row$number';
                                      })
                                      .join(', ')
                                  : 'N/A',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // QR Code
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.network(
                          ticket.fullQrUrl,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey[200],
                            child: Icon(Icons.error, size: 80),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Booking ID
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'BOOKING ID: ',
                            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                          ),
                          Text(
                            ticket.ticketId.substring(
                              ticket.ticketId.length > 8
                                  ? ticket.ticketId.length - 8
                                  : 0,
                            ),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Total Amount
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!, width: 1),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          ),
                          Text(
                            '₹ ${ticket.totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}



  /// ================= BUS CARD WITH TICKET DESIGN =================
  Widget _buildBusTicketCard(Map<String, dynamic> ticket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Top Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.directions_bus,
                        size: 32,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ticket['busName'],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            ticket['ticketType'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                ticket['pickupPoint'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                ticket['dropPoint'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Divider with semicircle cuts
              SizedBox(height: 8),

              // Bottom Section
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date of Journey',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          DateFormat(
                            'dd MMM yyyy',
                          ).format(ticket['dateOfJourney']),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Fare',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹ ${ticket['amount']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
          Text(text, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  /// ================= DOWNLOAD HELPERS =================
  Future<void> _downloadPdf(String pdfPath) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(color: Color(0xFF1976D2)),
        ),
      );

      final String url = 'http://31.97.206.144:8127$pdfPath';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to download PDF');
      }

      final Directory dir = Directory('/storage/emulated/0/Download');
      final file = File(
        '${dir.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      await file.writeAsBytes(response.bodyBytes);

      // 🔥 THIS MAKES IT APPEAR IN "DOWNLOADS" CATEGORY
      await MediaScanner.loadMedia(path: file.path);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Invoice downloaded successfully'),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('PDF download failed: $e'),
        ),
      );
    }
  }
}



// Custom painter for dotted line
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 5.0;
    const dashSpace = 5.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// ================= TICKET CLIPPER =================
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 12.0;
    const semicircleRadius = 12.0;

    // Start from top-left
    path.moveTo(radius, 0);

    // Top edge
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: Radius.circular(radius),
    );

    // Right edge with semicircle cut (middle)
    double middleY = size.height * 0.65;
    path.lineTo(size.width, middleY - semicircleRadius);
    path.arcToPoint(
      Offset(size.width, middleY + semicircleRadius),
      radius: Radius.circular(semicircleRadius),
      clockwise: false,
    );

    // Continue right edge
    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(
      Offset(size.width - radius, size.height),
      radius: Radius.circular(radius),
    );

    // Bottom edge
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: Radius.circular(radius),
    );

    // Left edge with semicircle cut (middle)
    path.lineTo(0, middleY + semicircleRadius);
    path.arcToPoint(
      Offset(0, middleY - semicircleRadius),
      radius: Radius.circular(semicircleRadius),
      clockwise: false,
    );

    // Continue left edge
    path.lineTo(0, radius);
    path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
