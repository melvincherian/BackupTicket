// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
// import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// /// ================= ENUMS =================
// enum TicketStatus { active, inactive, cancelled }

// /// ================= MODELS =================
// class MovieTicket {
//   final String id;
//   final String movieName;
//   final String ticketType;
//   final int numberOfTickets;
//   final DateTime showDate;
//   final String showTime;
//   final String theatrePlace;
//   final double totalPrice;
//   final String? ticketImageUrl;
//   final TicketStatus status;
//   final String language;
//   final List<String> selectedSeats;
//   final String email;
//   final String phoneNumber;
//   final int remainingCount;
//   final int soldCount;
//   final String? movieImageUrl;

//   MovieTicket({
//     required this.id,
//     required this.movieName,
//     required this.ticketType,
//     required this.numberOfTickets,
//     required this.showDate,
//     required this.showTime,
//     required this.theatrePlace,
//     required this.totalPrice,
//     this.ticketImageUrl,
//     required this.status,
//     required this.language,
//     required this.selectedSeats,
//     required this.email,
//     required this.phoneNumber,
//     this.remainingCount = 0,
//     this.soldCount = 0,
//     this.movieImageUrl,
//   });

//   factory MovieTicket.fromJson(Map<String, dynamic> json) {
//     try {
//       // Handle new nested structure: json contains 'ticket' and 'movie' objects
//       final ticketData = json['ticket'] ?? json;
//       final movieData = json['movie'] ?? {};

//       return MovieTicket(
//         id: ticketData['ticketId']?.toString() ?? ticketData['_id']?.toString() ?? '',
//         movieName: movieData['MovieName']?.toString() ?? ticketData['MovieName']?.toString() ?? '',
//         ticketType: ticketData['ticketCategory']?.toString() ?? '',
//         numberOfTickets: (ticketData['noOfTickets'] is int)
//             ? ticketData['noOfTickets']
//             : int.tryParse(ticketData['noOfTickets']?.toString() ?? '1') ?? 1,
//         showDate: ticketData['showDate'] != null
//             ? DateTime.parse(ticketData['showDate'])
//             : DateTime.now(),
//         showTime: ticketData['showTime']?.toString() ?? '',
//         theatrePlace: ticketData['theatrePlace']?.toString() ?? '',
//         totalPrice: (ticketData['totalPrice'] is num)
//             ? (ticketData['totalPrice'] as num).toDouble()
//             : (ticketData['pricePerTicket'] is num)
//                 ? (ticketData['pricePerTicket'] as num).toDouble()
//                 : double.tryParse(ticketData['totalPrice']?.toString() ?? ticketData['pricePerTicket']?.toString() ?? '0') ?? 0.0,
//         ticketImageUrl: ticketData['ticketImage']?.toString(),
//         status: _parseStatus(ticketData['status']?.toString()),
//         language: ticketData['language']?.toString() ?? '',
//         selectedSeats: (ticketData['selectedSeats'] is List)
//             ? List<String>.from(ticketData['selectedSeats'])
//             : [],
//         email: ticketData['email']?.toString() ?? '',
//         phoneNumber: ticketData['phoneNumber']?.toString() ?? '',
//         remainingCount: (ticketData['remainingCount'] is int)
//             ? ticketData['remainingCount']
//             : int.tryParse(ticketData['remainingCount']?.toString() ?? '0') ?? 0,
//         soldCount: (ticketData['soldCount'] is int)
//             ? ticketData['soldCount']
//             : int.tryParse(ticketData['soldCount']?.toString() ?? '0') ?? 0,
//         movieImageUrl: movieData['image']?.toString(),
//       );
//     } catch (e) {
//       print('Error parsing ticket: $e');
//       print('JSON data: $json');
//       rethrow;
//     }
//   }

//   static TicketStatus _parseStatus(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'active':
//         return TicketStatus.active;
//       case 'inactive':
//         return TicketStatus.inactive;
//       case 'cancelled':
//         return TicketStatus.cancelled;
//       default:
//         return TicketStatus.active;
//     }
//   }

//   String get statusText {
//     switch (status) {
//       case TicketStatus.active:
//         return 'Active';
//       case TicketStatus.inactive:
//         return 'Inactive';
//       case TicketStatus.cancelled:
//         return 'Cancelled';
//     }
//   }

//   Color get statusColor {
//     switch (status) {
//       case TicketStatus.active:
//         return Colors.green;
//       case TicketStatus.inactive:
//         return Colors.orange;
//       case TicketStatus.cancelled:
//         return Colors.red;
//     }
//   }
// }

// class BusTicket {
//   final String id;
//   final String busName;
//   final String ticketType;
//   final int numberOfTickets;
//   final DateTime dateOfJourney;
//   final String boardingTime;
//   final String pickupPoint;
//   final String dropPoint;
//   final double totalPrice;
//   final String? ticketImageUrl;
//   final String status;

//   BusTicket({
//     required this.id,
//     required this.busName,
//     required this.ticketType,
//     required this.numberOfTickets,
//     required this.dateOfJourney,
//     required this.boardingTime,
//     required this.pickupPoint,
//     required this.dropPoint,
//     required this.totalPrice,
//     this.ticketImageUrl,
//     required this.status,
//   });
// }

// /// ================= API SERVICE =================
// class TicketApiService {
//   static const String baseUrl = 'http://31.97.206.144:8127/api/auth';

//   static Future<List<MovieTicket>> fetchPostedTickets(String userId) async {
//     try {
//       final token = await SharedPrefsHelper.getToken();

//       print('Fetching tickets for userId: $userId');

//       final response = await http.get(
//         Uri.parse('$baseUrl/mypostedticket/$userId'),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (data['success'] == true) {
//           // Check for 'tickets' field (new structure) or 'data' field (old structure)
//           List<dynamic> ticketsJson = [];

//           if (data['tickets'] != null && data['tickets'] is List) {
//             ticketsJson = data['tickets'];
//           } else if (data['data'] != null && data['data'] is List) {
//             ticketsJson = data['data'];
//           }

//           if (ticketsJson.isNotEmpty) {
//             print('Found ${ticketsJson.length} tickets');
//             return ticketsJson.map((json) => MovieTicket.fromJson(json)).toList();
//           } else {
//             print('No tickets found');
//             return [];
//           }
//         } else {
//           print('API returned success: false');
//           return [];
//         }
//       } else {
//         print('API returned status code: ${response.statusCode}');
//         throw Exception('Failed to load tickets: Status ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching tickets: $e');
//       rethrow;
//     }
//   }

//   static Future<bool> deleteTicket(String ticketId, String userId) async {
//     try {
//       final token = await SharedPrefsHelper.getToken();

//       final response = await http.delete(
//         Uri.parse('$baseUrl/deletemovieticket/$userId/$ticketId'),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );
//       print('response status code for delete movie ticket ${response.statusCode}');
//       return response.statusCode == 200;
//     } catch (e) {
//       print('Error deleting ticket: $e');
//       return false;
//     }
//   }
// }

// /// ================= SCREEN =================
// class PostedTickets extends StatefulWidget {
//   const PostedTickets({super.key});

//   @override
//   State<PostedTickets> createState() => _PostedTicketsState();
// }

// class _PostedTicketsState extends State<PostedTickets>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   bool _isLoading = false;
//   String? _errorMessage;

//   List<MovieTicket> _userMovieTickets = [];
//   List<BusTicket> _userBusTickets = [];

//   static const String ticketImageBaseUrl = "http://31.97.206.144:8127";

//   String getTicketImageUrl(String imagePath) {
//     if (imagePath.startsWith('http')) {
//       return imagePath;
//     }
//     return "$ticketImageBaseUrl$imagePath";
//   }

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _loadTickets();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadTickets() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final user = await SharedPrefsHelper.getUser();
//       if (user == null || user.id.isEmpty) {
//         throw Exception('User not found. Please login again.');
//       }

//       final tickets = await TicketApiService.fetchPostedTickets(user.id);

//       setState(() {
//         _userMovieTickets = tickets;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString().replaceAll('Exception: ', '');
//         _isLoading = false;
//       });

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(_errorMessage ?? 'Failed to load tickets'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   /// ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: const Text(
//           'My Posted Tickets',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
//           onPressed: () => Navigator.pop(context),
//         ),
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: const Color(0xFF214194),
//           indicatorColor: const Color(0xFF214194),
//           tabs: const [
//             Tab(icon: Icon(Icons.local_movies), text: 'Movie Tickets'),
//             Tab(icon: Icon(Icons.directions_bus), text: 'Bus Tickets'),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _errorMessage != null
//               ? _buildErrorWidget()
//               : TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _buildMovieTab(),
//                     _buildBusTab(),
//                   ],
//                 ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xFF214194),
//         child: const Icon(Icons.add, color: Colors.white),
//         onPressed: _showAddTicketDialog,
//       ),
//     );
//   }

//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.error_outline, size: 64, color: Colors.red),
//           const SizedBox(height: 16),
//           Text(
//             _errorMessage ?? 'Something went wrong',
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: _loadTickets,
//             icon: const Icon(Icons.refresh),
//             label: const Text('Retry'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF214194),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ================= MOVIE TAB =================
//   Widget _buildMovieTab() {
//     if (_userMovieTickets.isEmpty) {
//       return _buildEmpty(
//         Icons.local_movies_outlined,
//         'No movie tickets posted yet',
//         _navigateToSellMovieTicket,
//       );
//     }

//     return RefreshIndicator(
//       onRefresh: _loadTickets,
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: _userMovieTickets.length,
//         itemBuilder: (_, i) => _buildMovieCard(_userMovieTickets[i]),
//       ),
//     );
//   }

//   Widget _buildMovieCard(MovieTicket ticket) {
//     final canDelete = ticket.status == TicketStatus.active && ticket.soldCount == 0;

//     return _ticketContainer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Status Badge and Price
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: ticket.statusColor.withOpacity(0.1),
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.circle, size: 8, color: ticket.statusColor),
//                     const SizedBox(width: 6),
//                     Text(
//                       ticket.statusText,
//                       style: TextStyle(
//                         color: ticket.statusColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   '₹${ticket.totalPrice.toStringAsFixed(0)}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF214194),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Ticket Image
//           if (ticket.ticketImageUrl != null)
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
//               child: Image.network(
//                 getTicketImageUrl(ticket.ticketImageUrl!),
//                 height: 150,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(
//                   height: 150,
//                   color: Colors.grey[200],
//                   child: const Icon(Icons.image_not_supported, size: 50),
//                 ),
//               ),
//             ),

//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Movie Name
//                 Text(
//                   ticket.movieName,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 // Ticket Counts - Remaining and Sold
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.confirmation_number_outlined,
//                                   size: 18,
//                                   color: Colors.green[700],
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   '${ticket.remainingCount}',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.green[700],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               'Remaining',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: 1,
//                         height: 40,
//                         color: Colors.grey[300],
//                       ),
//                       Expanded(
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.sell_outlined,
//                                   size: 18,
//                                   color: Colors.purple[700],
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   '${ticket.soldCount}',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.purple[700],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               'Sold',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 // Language
//                 Row(
//                   children: [
//                     const Icon(Icons.language, size: 16, color: Colors.grey),
//                     const SizedBox(width: 6),
//                     Text(
//                       ticket.language,
//                       style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),

//                 // Theatre & Date
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                     const SizedBox(width: 6),
//                     Expanded(
//                       child: Text(
//                         ticket.theatrePlace,
//                         style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),

//                 // Show Time & Date
//                 Row(
//                   children: [
//                     const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
//                     const SizedBox(width: 6),
//                     Text(
//                       '${ticket.showDate.day}/${ticket.showDate.month}/${ticket.showDate.year}',
//                       style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                     ),
//                     const SizedBox(width: 16),
//                     const Icon(Icons.access_time, size: 16, color: Colors.grey),
//                     const SizedBox(width: 6),
//                     Text(
//                       ticket.showTime,
//                       style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),

//                 // Ticket Category & Count
//                 Row(
//                   children: [
//                     const Icon(Icons.confirmation_number, size: 16, color: Colors.grey),
//                     const SizedBox(width: 6),
//                     Text(
//                       '${ticket.ticketType} • ${ticket.numberOfTickets} Ticket(s)',
//                       style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),

//                 // Seats
//                 if (ticket.selectedSeats.isNotEmpty)
//                   Row(
//                     children: [
//                       const Icon(Icons.event_seat, size: 16, color: Colors.grey),
//                       const SizedBox(width: 6),
//                       Expanded(
//                         child: Text(
//                           ticket.selectedSeats.join(', '),
//                           style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),

//           // Delete Button
//           if (canDelete)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: TextButton.icon(
//                   onPressed: () => _deleteMovie(ticket),
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   label: const Text(
//                     'Delete Ticket',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.red.withOpacity(0.1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   /// ================= BUS TAB =================
//   Widget _buildBusTab() {
//     if (_userBusTickets.isEmpty) {
//       return _buildEmpty(
//         Icons.directions_bus_outlined,
//         'No bus tickets posted yet',
//         _navigateToSellBusTicket,
//       );
//     }

//     return RefreshIndicator(
//       onRefresh: _loadTickets,
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: _userBusTickets.length,
//         itemBuilder: (_, i) => _buildBusCard(_userBusTickets[i]),
//       ),
//     );
//   }

//   Widget _buildBusCard(BusTicket ticket) {
//     final canDelete = ticket.status == 'active';

//     return _ticketContainer(
//       child: Column(
//         children: [
//           ListTile(
//             leading: const Icon(Icons.directions_bus, size: 40),
//             title: Text(ticket.busName),
//             subtitle: Text(
//               '${ticket.pickupPoint} → ${ticket.dropPoint}\n${ticket.boardingTime}',
//             ),
//             trailing: Text(
//               '₹${ticket.totalPrice.toStringAsFixed(0)}',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           if (canDelete)
//             TextButton.icon(
//               onPressed: () => _deleteBus(ticket),
//               icon: const Icon(Icons.delete, color: Colors.red),
//               label: const Text('Delete', style: TextStyle(color: Colors.red)),
//             ),
//         ],
//       ),
//     );
//   }

//   /// ================= COMMON =================
//   Widget _ticketContainer({required Widget child}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(.15),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }

//   Widget _buildEmpty(IconData icon, String text, VoidCallback onAddPressed) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 64, color: Colors.grey),
//           const SizedBox(height: 12),
//           Text(text, style: const TextStyle(fontSize: 16)),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: onAddPressed,
//             icon: const Icon(Icons.add),
//             label: const Text('Post a Ticket'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF214194),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ================= ACTIONS =================
//   Future<void> _deleteMovie(MovieTicket ticket) async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Ticket'),
//         content: const Text('Are you sure you want to delete this ticket?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Delete', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );

//     if (confirm == true) {
//       setState(() => _isLoading = true);

//       try {
//         final user = await SharedPrefsHelper.getUser();
//         if (user == null || user.id.isEmpty) {
//           throw Exception('User not found. Please login again.');
//         }

//         final success = await TicketApiService.deleteTicket(ticket.id, user.id);

//         if (success) {
//           setState(() {
//             _userMovieTickets.remove(ticket);
//             _isLoading = false;
//           });

//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Ticket deleted successfully'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           }
//         } else {
//           setState(() => _isLoading = false);

//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Failed to delete ticket'),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         }
//       } catch (e) {
//         setState(() => _isLoading = false);

//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Error: ${e.toString().replaceAll('Exception: ', '')}'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       }
//     }
//   }

//   void _deleteBus(BusTicket ticket) {
//     setState(() => _userBusTickets.remove(ticket));
//   }

//   void _showAddTicketDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Add Ticket'),
//         content: const Text('What type of ticket would you like to post?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _navigateToSellBusTicket();
//             },
//             child: const Text('Bus Ticket'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _navigateToSellMovieTicket();
//             },
//             child: const Text('Movie Ticket'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _navigateToSellMovieTicket() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const SellMovieTicket()),
//     );

//     if (result == true) {
//       _loadTickets();
//     }
//   }

//   void _navigateToSellBusTicket() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const SellBusTicket()),
//     );

//     if (result == true) {
//       _loadTickets();
//     }
//   }
// }

// import 'dart:convert';
// import 'dart:math';

// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
// import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// import 'package:http/http.dart' as http;

// /// ================= ENUMS =================
// enum TicketStatus { active, inactive, cancelled }

// /// ================= MOVIE TICKET MODEL =================
// class MovieTicket {
//   final String id;
//   final String movieName;
//   final String ticketType;
//   final int numberOfTickets;
//   final DateTime showDate;
//   final String showTime;
//   final String theatrePlace;
//   final double totalPrice;

//   /// Images
//   final String? ticketImageUrl;
//   final String? moviePosterUrl;

//   final TicketStatus status;
//   final String language;
//   final List<String> selectedSeats;
//   final String email;
//   final String phoneNumber;

//   final int remainingCount;
//   final int soldCount;

//   MovieTicket({
//     required this.id,
//     required this.movieName,
//     required this.ticketType,
//     required this.numberOfTickets,
//     required this.showDate,
//     required this.showTime,
//     required this.theatrePlace,
//     required this.totalPrice,
//     this.ticketImageUrl,
//     this.moviePosterUrl,
//     required this.status,
//     required this.language,
//     required this.selectedSeats,
//     required this.email,
//     required this.phoneNumber,
//     required this.remainingCount,
//     required this.soldCount,
//   });

//   factory MovieTicket.fromJson(Map<String, dynamic> json) {
//     final ticket = json['ticket'] ?? json;
//     final movie = json['movie'] ?? {};

//     final parsedRemaining =
//         int.tryParse(ticket['remainingCount']?.toString() ?? '0') ?? 0;

//     return MovieTicket(
//       id: ticket['ticketId']?.toString() ?? '',
//       movieName: movie['MovieName']?.toString() ?? '',
//       ticketType: ticket['ticketCategory']?.toString() ?? '',
//       numberOfTickets:
//           int.tryParse(ticket['noOfTickets']?.toString() ?? '1') ?? 1,
//       showDate: DateTime.parse(ticket['showDate']),
//       showTime: ticket['showTime']?.toString() ?? '',
//       theatrePlace: ticket['theatrePlace']?.toString() ?? '',
//       totalPrice:
//           (ticket['pricePerTicket'] is num)
//               ? (ticket['pricePerTicket'] as num).toDouble()
//               : double.tryParse(ticket['pricePerTicket']?.toString() ?? '0') ??
//                   0,
//       ticketImageUrl: ticket['ticketImage'],
//       moviePosterUrl: movie['image'],
//       status: _parseStatus(ticket['status']),
//       language: ticket['language'] ?? '',
//       selectedSeats:
//           (ticket['selectedSeats'] is List)
//               ? List<String>.from(ticket['selectedSeats'])
//               : [],
//       email: ticket['email'] ?? '',
//       phoneNumber: ticket['phoneNumber'] ?? '',
//       remainingCount: max(0, parsedRemaining),
//       soldCount:
//           int.tryParse(ticket['soldCount']?.toString() ?? '0') ?? 0,
//     );
//   }

//   static TicketStatus _parseStatus(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'inactive':
//         return TicketStatus.inactive;
//       case 'cancelled':
//         return TicketStatus.cancelled;
//       default:
//         return TicketStatus.active;
//     }
//   }

//   String get statusText =>
//       status.name[0].toUpperCase() + status.name.substring(1);

//   Color get statusColor {
//     switch (status) {
//       case TicketStatus.active:
//         return Colors.green;
//       case TicketStatus.inactive:
//         return Colors.orange;
//       case TicketStatus.cancelled:
//         return Colors.red;
//     }
//   }
// }

// /// ================= BUS MODEL =================
// class BusTicket {
//   final String id;
//   final String busName;
//   final String pickupPoint;
//   final String dropPoint;
//   final String boardingTime;
//   final double totalPrice;
//   final String status;

//   BusTicket({
//     required this.id,
//     required this.busName,
//     required this.pickupPoint,
//     required this.dropPoint,
//     required this.boardingTime,
//     required this.totalPrice,
//     required this.status,
//   });
// }

// /// ================= API =================
// class TicketApiService {
//   static const baseUrl = 'http://31.97.206.144:8127/api/auth';

//   static Future<List<MovieTicket>> fetchPostedTickets(String userId) async {
//     final token = await SharedPrefsHelper.getToken();

//     final res = await http.get(
//       Uri.parse('$baseUrl/mypostedticket/$userId'),
//       headers: {
//         'Content-Type': 'application/json',
//         if (token != null) 'Authorization': 'Bearer $token',
//       },
//     );

//     if (res.statusCode != 200) {
//       throw Exception('Failed to load tickets');
//     }

//     final body = jsonDecode(res.body);
//     final List list = body['tickets'] ?? [];

//     return list.map((e) => MovieTicket.fromJson(e)).toList();
//   }

//   static Future<bool> deleteTicket(String userId, String ticketId) async {
//     final token = await SharedPrefsHelper.getToken();

//     final res = await http.delete(
//       Uri.parse('$baseUrl/deletemovieticket/$userId/$ticketId'),
//       headers: {
//         'Content-Type': 'application/json',
//         if (token != null) 'Authorization': 'Bearer $token',
//       },
//     );

//     return res.statusCode == 200;
//   }
// }

// /// ================= SCREEN =================
// class PostedTickets extends StatefulWidget {
//   const PostedTickets({super.key});

//   @override
//   State<PostedTickets> createState() => _PostedTicketsState();
// }

// class _PostedTicketsState extends State<PostedTickets>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   bool _loading = false;
//   List<MovieTicket> _movies = [];

//   static const imageBase = 'http://31.97.206.144:8127';

//   String _img(String path) =>
//       path.startsWith('http') ? path : '$imageBase$path';

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _load();
//   }

//   Future<void> _load() async {
//     setState(() => _loading = true);
//     final user = await SharedPrefsHelper.getUser();
//     _movies = await TicketApiService.fetchPostedTickets(user!.id);
//     setState(() => _loading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Posted Tickets'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Movie'),
//             Tab(text: 'Bus'),
//           ],
//         ),
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildMovieTab(),
//                 const Center(child: Text('Bus tickets coming soon')),
//               ],
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddTicketDialog,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   /// ================= MOVIE TAB =================
//   Widget _buildMovieTab() {
//     if (_movies.isEmpty) {
//       return const Center(child: Text('No movie tickets posted'));
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _movies.length,
//       itemBuilder: (_, i) => _movieCard(_movies[i]),
//     );
//   }

//   Widget _movieCard(MovieTicket t) {
//     final imageUrl = t.moviePosterUrl ?? t.ticketImageUrl;

//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (imageUrl != null)
//             Image.network(
//               _img(imageUrl),
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Container(
//                 height: 200,
//                 color: Colors.grey[200],
//                 child: const Icon(Icons.movie, size: 50),
//               ),
//             ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(t.movieName,
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 Text('${t.theatrePlace} • ${t.language}'),
//                 const SizedBox(height: 8),
//                 Text(
//                     '${t.showDate.day}/${t.showDate.month}/${t.showDate.year} • ${t.showTime}'),
//                 const SizedBox(height: 8),
//                 Text('Remaining: ${t.remainingCount} | Sold: ${t.soldCount}'),
//                 const SizedBox(height: 12),
//                 if (t.status == TicketStatus.active && t.soldCount == 0)
//                   TextButton.icon(
//                     onPressed: () => _delete(t),
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     label: const Text('Delete',
//                         style: TextStyle(color: Colors.red)),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _delete(MovieTicket t) async {
//     final user = await SharedPrefsHelper.getUser();
//     final ok = await TicketApiService.deleteTicket(user!.id, t.id);
//     if (ok) {
//       setState(() => _movies.remove(t));
//     }
//   }

//   void _showAddTicketDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Add Ticket'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const SellBusTicket()),
//               );
//             },
//             child: const Text('Bus'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const SellMovieTicket()),
//               );
//             },
//             child: const Text('Movie'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:math';

// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
// import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// import 'package:http/http.dart' as http;

// /// ================= ENUMS =================
// enum TicketStatus { active, inactive, cancelled }

// /// ================= MOVIE TICKET MODEL =================
// class MovieTicket {
//   final String id;
//   final String movieName;
//   final String ticketType;
//   final int numberOfTickets;
//   final DateTime showDate;
//   final String showTime;
//   final String theatrePlace;
//   final double totalPrice;
//   final String? ticketImageUrl;
//   final String? moviePosterUrl;
//   final TicketStatus status;
//   final String language;
//   final List<String> selectedSeats;
//   final String email;
//   final String phoneNumber;
//   final int remainingCount;
//   final int soldCount;
//   final String sellerName;

//   MovieTicket({
//     required this.id,
//     required this.movieName,
//     required this.ticketType,
//     required this.numberOfTickets,
//     required this.showDate,
//     required this.showTime,
//     required this.theatrePlace,
//     required this.totalPrice,
//     this.ticketImageUrl,
//     this.moviePosterUrl,
//     required this.status,
//     required this.language,
//     required this.selectedSeats,
//     required this.email,
//     required this.phoneNumber,
//     required this.remainingCount,
//     required this.soldCount,
//     required this.sellerName,
//   });

//   factory MovieTicket.fromJson(Map<String, dynamic> json) {
//     final ticket = json['ticket'] ?? json;
//     final movie = json['movie'] ?? {};

//     final parsedRemaining =
//         int.tryParse(ticket['remainingCount']?.toString() ?? '0') ?? 0;

//     return MovieTicket(
//       id: ticket['ticketId']?.toString() ?? '',
//       movieName: movie['MovieName']?.toString() ?? '',
//       ticketType: ticket['ticketCategory']?.toString() ?? '',
//       numberOfTickets:
//           int.tryParse(ticket['noOfTickets']?.toString() ?? '1') ?? 1,
//       showDate: DateTime.parse(ticket['showDate']),
//       showTime: ticket['showTime']?.toString() ?? '',
//       theatrePlace: ticket['theatrePlace']?.toString() ?? '',
//       totalPrice: (ticket['pricePerTicket'] is num)
//           ? (ticket['pricePerTicket'] as num).toDouble()
//           : double.tryParse(ticket['pricePerTicket']?.toString() ?? '0') ?? 0,
//       ticketImageUrl: ticket['ticketImage'],
//       moviePosterUrl: movie['image'],
//       status: _parseStatus(ticket['status']),
//       language: ticket['language'] ?? '',
//       selectedSeats: (ticket['selectedSeats'] is List)
//           ? List<String>.from(ticket['selectedSeats'])
//           : [],
//       email: ticket['email'] ?? '',
//       phoneNumber: ticket['phoneNumber'] ?? '',
//       remainingCount: max(0, parsedRemaining),
//       soldCount: int.tryParse(ticket['soldCount']?.toString() ?? '0') ?? 0,
//       sellerName: ticket['sellerName'] ?? 'Seller',
//     );
//   }

//   static TicketStatus _parseStatus(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'inactive':
//         return TicketStatus.inactive;
//       case 'cancelled':
//         return TicketStatus.cancelled;
//       default:
//         return TicketStatus.active;
//     }
//   }

//   bool get canDelete => status == TicketStatus.active && soldCount == 0;
// }

// /// ================= BUS MODEL =================
// class BusTicket {
//   final String id;
//   final String busName;
//   final String pickupPoint;
//   final String dropPoint;
//   final String boardingTime;
//   final double totalPrice;
//   final String status;

//   BusTicket({
//     required this.id,
//     required this.busName,
//     required this.pickupPoint,
//     required this.dropPoint,
//     required this.boardingTime,
//     required this.totalPrice,
//     required this.status,
//   });
// }

// /// ================= API =================
// class TicketApiService {
//   static const baseUrl = 'http://31.97.206.144:8127/api/auth';

//   static Future<List<MovieTicket>> fetchPostedTickets(String userId) async {
//     final token = await SharedPrefsHelper.getToken();

//     final res = await http.get(
//       Uri.parse('$baseUrl/mypostedticket/$userId'),
//       headers: {
//         'Content-Type': 'application/json',
//         if (token != null) 'Authorization': 'Bearer $token',
//       },
//     );

//     if (res.statusCode != 200) {
//       throw Exception('Failed to load tickets');
//     }

//     final body = jsonDecode(res.body);
//     final List list = body['tickets'] ?? [];

//     return list.map((e) => MovieTicket.fromJson(e)).toList();
//   }

//   static Future<bool> deleteTicket(String userId, String ticketId) async {
//     final token = await SharedPrefsHelper.getToken();

//     final res = await http.delete(
//       Uri.parse('$baseUrl/deletemovieticket/$userId/$ticketId'),
//       headers: {
//         'Content-Type': 'application/json',
//         if (token != null) 'Authorization': 'Bearer $token',
//       },
//     );

//     return res.statusCode == 200;
//   }
// }

// /// ================= SCREEN =================
// class PostedTickets extends StatefulWidget {
//   const PostedTickets({super.key});

//   @override
//   State<PostedTickets> createState() => _PostedTicketsState();
// }

// class _PostedTicketsState extends State<PostedTickets>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   bool _loading = false;
//   List<MovieTicket> _movies = [];

//   static const imageBase = 'http://31.97.206.144:8127';

//   String _img(String path) =>
//       path.startsWith('http') ? path : '$imageBase$path';

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _load();
//   }

//   Future<void> _load() async {
//     setState(() => _loading = true);
//     final user = await SharedPrefsHelper.getUser();
//     _movies = await TicketApiService.fetchPostedTickets(user!.id);
//     setState(() => _loading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Posted Tickets'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Movie'),
//             Tab(text: 'Bus'),
//           ],
//         ),
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildMovieTab(),
//                 const Center(child: Text('Bus tickets coming soon')),
//               ],
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddTicketDialog,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   /// ================= MOVIE TAB =================
//   Widget _buildMovieTab() {
//     if (_movies.isEmpty) {
//       return const Center(child: Text('No movie tickets posted'));
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _movies.length,
//       itemBuilder: (_, i) => _movieCard(_movies[i]),
//     );
//   }

//   Widget _movieCard(MovieTicket t) {
//     final imageUrl = t.moviePosterUrl ?? t.ticketImageUrl;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300, width: 1),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Movie Poster
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: imageUrl != null
//                   ? Image.network(
//                       _img(imageUrl),
//                       width: 90,
//                       height: 120,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => Container(
//                         width: 90,
//                         height: 120,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.movie, size: 40),
//                       ),
//                     )
//                   : Container(
//                       width: 90,
//                       height: 120,
//                       color: Colors.grey[300],
//                       child: const Icon(Icons.movie, size: 40),
//                     ),
//             ),
//             const SizedBox(width: 12),

//             // Movie Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Movie Name
//                   Text(
//                     t.movieName,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 4),

//                   // Ticket Type & Language
//                   Text(
//                     '${t.ticketType} • ${t.language}',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   // Date & Time
//                   Text(
//                     '${t.showDate.day} ${_getMonthName(t.showDate.month)}, ${t.showTime}',
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 4),

//                   // Theatre Place
//                   Text(
//                     t.theatrePlace,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   // Price and Seller
//                   Row(
//                     children: [
//                       Text(
//                         '₹ ${t.totalPrice.toStringAsFixed(0)}',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const Spacer(),
//                       CircleAvatar(
//                         radius: 10,
//                         backgroundColor: Colors.blue,
//                         child: Text(
//                           t.sellerName[0].toUpperCase(),
//                           style: const TextStyle(
//                             fontSize: 10,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         t.sellerName,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Menu Button
//             PopupMenuButton<String>(
//               icon: const Icon(Icons.more_vert),
//               onSelected: (value) {
//                 if (value == 'delete') {
//                   _handleDeleteAction(t);
//                 }
//               },
//               itemBuilder: (context) => [
//                 PopupMenuItem<String>(
//                   value: 'delete',
//                   enabled: t.canDelete,
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.delete_outline,
//                         color: t.canDelete ? Colors.red : Colors.grey,
//                         size: 20,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Delete',
//                         style: TextStyle(
//                           color: t.canDelete ? Colors.red : Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
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

//   void _handleDeleteAction(MovieTicket t) {
//     if (t.canDelete) {
//       _showDeleteConfirmation(t);
//     } else {
//       _showCannotDeleteMessage();
//     }
//   }

//   void _showCannotDeleteMessage() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('This ticket has been sold and cannot be deleted'),
//         backgroundColor: Colors.orange,
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }

//   void _showDeleteConfirmation(MovieTicket t) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Ticket'),
//         content: Text('Are you sure you want to delete "${t.movieName}" ticket?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _delete(t);
//             },
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _delete(MovieTicket t) async {
//     final user = await SharedPrefsHelper.getUser();
//     final ok = await TicketApiService.deleteTicket(user!.id, t.id);
//     if (ok) {
//       setState(() => _movies.remove(t));
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Ticket deleted successfully'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Failed to delete ticket'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void _showAddTicketDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Add Ticket'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const SellBusTicket()),
//               );
//             },
//             child: const Text('Bus'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const SellMovieTicket()),
//               );
//             },
//             child: const Text('Movie'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:math';

import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
import 'package:http/http.dart' as http;

/// ================= ENUMS =================
enum TicketStatus { active, inactive, cancelled, pending, rejected }

/// ================= MOVIE TICKET MODEL =================
class MovieTicket {
  final String id;
  final String movieName;
  final String ticketType;
  final int numberOfTickets;
  final DateTime showDate;
  final String showTime;
  final String theatrePlace;
  final double totalPrice;
  final String? ticketImageUrl;
  final String? moviePosterUrl;
  final TicketStatus status;
  final String language;
  final List<String> selectedSeats;
  final String email;
  final String phoneNumber;
  final int remainingCount;
  final int soldCount;
  final String sellerName;
  final List<String> purchasedSeats;

  MovieTicket({
    required this.id,
    required this.movieName,
    required this.ticketType,
    required this.numberOfTickets,
    required this.showDate,
    required this.showTime,
    required this.theatrePlace,
    required this.totalPrice,
    this.ticketImageUrl,
    this.moviePosterUrl,
    required this.status,
    required this.language,
    required this.selectedSeats,
    required this.email,
    required this.phoneNumber,
    required this.remainingCount,
    required this.soldCount,
    required this.sellerName,
    required this.purchasedSeats,
  });

  factory MovieTicket.fromJson(Map<String, dynamic> json) {
    final ticket = json['ticket'] ?? json;
    final movie = json['movie'] ?? {};

    final parsedRemaining =
        int.tryParse(ticket['remainingCount']?.toString() ?? '0') ?? 0;

    return MovieTicket(
      id: ticket['ticketId']?.toString() ?? '',
      movieName: movie['MovieName']?.toString() ?? '',
      ticketType: ticket['ticketCategory']?.toString() ?? '',
      numberOfTickets:
          int.tryParse(ticket['noOfTickets']?.toString() ?? '1') ?? 1,
      showDate: DateTime.parse(ticket['showDate']),
      showTime: ticket['showTime']?.toString() ?? '',
      theatrePlace: ticket['theatrePlace']?.toString() ?? '',
      totalPrice: (ticket['pricePerTicket'] is num)
          ? (ticket['pricePerTicket'] as num).toDouble()
          : double.tryParse(ticket['pricePerTicket']?.toString() ?? '0') ?? 0,
      ticketImageUrl: ticket['ticketImage'],
      moviePosterUrl: movie['image'],
      status: _parseStatus(ticket['status']),
      language: ticket['language'] ?? '',
      selectedSeats: (ticket['selectedSeats'] is List)
          ? List<String>.from(ticket['selectedSeats'])
          : [],
      email: ticket['email'] ?? '',
      phoneNumber: ticket['phoneNumber'] ?? '',
      remainingCount: max(0, parsedRemaining),
      soldCount: int.tryParse(ticket['soldCount']?.toString() ?? '0') ?? 0,
      sellerName: ticket['sellerName'] ?? 'Seller',
      purchasedSeats: (ticket['purchasedSeats'] is List)
          ? List<String>.from(ticket['purchasedSeats'])
          : [],
    );
  }

  static TicketStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'inactive':
        return TicketStatus.inactive;
      case 'cancelled':
        return TicketStatus.cancelled;
      case 'pending':
        return TicketStatus.pending;
      case 'rejected':
        return TicketStatus.cancelled;
      default:
        return TicketStatus.active;
    }
  }

  bool get canDelete => status == TicketStatus.active && soldCount == 0;

  String get statusText {
    switch (status) {
      case TicketStatus.active:
        return 'Active';
      case TicketStatus.pending:
        return 'Pending';
      case TicketStatus.rejected:
        return 'Rejected';
      case TicketStatus.inactive:
        return 'Inactive';
      case TicketStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get statusColor {
    switch (status) {
      case TicketStatus.active:
        return Colors.green;
      case TicketStatus.pending:
        return Colors.orange;
      case TicketStatus.rejected:
        return Colors.red;
      case TicketStatus.inactive:
        return Colors.orange;
      case TicketStatus.cancelled:
        return Colors.red;
    }
  }
}

/// ================= BUS MODEL =================
class BusTicket {
  final String id;
  final String busName;
  final String pickupPoint;
  final String dropPoint;
  final String boardingTime;
  final double totalPrice;
  final String status;

  BusTicket({
    required this.id,
    required this.busName,
    required this.pickupPoint,
    required this.dropPoint,
    required this.boardingTime,
    required this.totalPrice,
    required this.status,
  });
}

/// ================= API =================
class TicketApiService {
  static const baseUrl = 'http://31.97.206.144:8127/api/auth';

  static Future<List<MovieTicket>> fetchPostedTickets(String userId) async {
    final token = await SharedPrefsHelper.getToken();
    print(
      "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$userId",
    );
    final res = await http.get(
      Uri.parse('$baseUrl/mypostedticket/$userId'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    print(
      "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii${res.body}",
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to load tickets');
    }

    final body = jsonDecode(res.body);
    final List list = body['tickets'] ?? [];

    return list.map((e) => MovieTicket.fromJson(e)).toList();
  }

  static Future<bool> deleteTicket(String userId, String ticketId) async {
    final token = await SharedPrefsHelper.getToken();

    final res = await http.delete(
      Uri.parse('$baseUrl/deletemovieticket/$userId/$ticketId'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    return res.statusCode == 200;
  }
}

/// ================= SCREEN =================
class PostedTickets extends StatefulWidget {
  const PostedTickets({super.key});

  @override
  State<PostedTickets> createState() => _PostedTicketsState();
}

class _PostedTicketsState extends State<PostedTickets>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _loading = false;
  List<MovieTicket> _movies = [];

  static const imageBase = 'http://31.97.206.144:8127';

  String _img(String path) =>
      path.startsWith('http') ? path : '$imageBase$path';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final user = await SharedPrefsHelper.getUser();
    _movies = await TicketApiService.fetchPostedTickets(user!.id);
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Posted Tickets'),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: 'Movie'),
            // Tab(text: 'Bus'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildMovieTab(),
                const Center(child: Text('Bus tickets coming soon')),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTicketDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  /// ================= MOVIE TAB =================
  Widget _buildMovieTab() {
    if (_movies.isEmpty) {
      return const Center(child: Text('No movie tickets posted'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _movies.length,
      itemBuilder: (_, i) => _movieCard(_movies[i]),
    );
  }

  Widget _movieCard(MovieTicket t) {
    final imageUrl = t.moviePosterUrl ?? t.ticketImageUrl;

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
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Movie Poster
                        Container(
                          width: 90,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: imageUrl != null
                                    ? Image.network(
                                        _img(imageUrl),
                                        width: 90,
                                        height: 120,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          width: 90,
                                          height: 120,
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.movie,
                                            size: 40,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 90,
                                        height: 120,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.movie,
                                          size: 40,
                                        ),
                                      ),
                              ),
                              // Positioned(
                              //   bottom: 8,
                              //   left: 0,
                              //   right: 0,
                              //   child: Container(
                              //     padding: EdgeInsets.symmetric(vertical: 4),
                              //     decoration: BoxDecoration(
                              //       color: Colors.red,
                              //       borderRadius: BorderRadius.circular(4),
                              //     ),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Icon(Icons.play_circle_outline,
                              //             color: Colors.white, size: 14),
                              //         SizedBox(width: 4),
                              //         Text(
                              //           'Watch Trailer',
                              //           style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 9,
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Movie Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      t.movieName,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  // Status Badge
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: t.statusColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: t.statusColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      t.statusText,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: t.statusColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // Ticket Type & Language
                              Text(
                                '${t.ticketType} • ${t.language}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Date & Time
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '${t.showDate.day} ${_getMonthName(t.showDate.month)}, ${t.showTime}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // Theatre Place
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      t.theatrePlace,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Menu Button
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, size: 20),
                          onSelected: (value) {
                            if (value == 'delete') {
                              _handleDeleteAction(t);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<String>(
                              value: 'delete',
                              enabled: t.canDelete,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline,
                                    color: t.canDelete
                                        ? Colors.red
                                        : Colors.grey,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: t.canDelete
                                          ? Colors.red
                                          : Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Seats Info
                    if (t.selectedSeats.isNotEmpty ||
                        t.purchasedSeats.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (t.selectedSeats.isNotEmpty) ...[
                              Row(
                                children: [
                                  Icon(
                                    Icons.event_seat,
                                    size: 16,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'Selected Seats: ${t.selectedSeats.join(', ')}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                                                            color: Color.fromRGBO(255, 255, 255, 1),

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            if (t.purchasedSeats.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'Purchased Seats: ${t.purchasedSeats.join(', ')}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Divider with semicircle cuts
              SizedBox(height: 8),

              // Bottom Section - Ticket Count and Price
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available Tickets',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${t.soldCount}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              ' / ${t.numberOfTickets}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Price per ticket',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹ ${t.totalPrice.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Sold Count (if any)
              if (t.soldCount > 0)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green[700],
                      ),
                      SizedBox(width: 6),
                      Text(
                        '${t.soldCount} ticket(s) sold',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
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

  String _getMonthName(int month) {
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
      'Dec',
    ];
    return months[month - 1];
  }

  void _handleDeleteAction(MovieTicket t) {
    if (t.canDelete) {
      _showDeleteConfirmation(t);
    } else {
      _showCannotDeleteMessage();
    }
  }

  void _showCannotDeleteMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This ticket has been sold and cannot be deleted'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showDeleteConfirmation(MovieTicket t) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Ticket'),
        content: Text(
          'Are you sure you want to delete "${t.movieName}" ticket?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _delete(t);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _delete(MovieTicket t) async {
    final user = await SharedPrefsHelper.getUser();
    final ok = await TicketApiService.deleteTicket(user!.id, t.id);
    if (ok) {
      setState(() => _movies.remove(t));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ticket deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete ticket'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAddTicketDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Ticket'),
        content: Text('Choose ticket type to add'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SellBusTicket()),
              );
            },
            child: const Text('Bus'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SellMovieTicket()),
              ).then((_) => _load());
            },
            child: const Text('Movie'),
          ),
        ],
      ),
    );
  }
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
    double middleY = size.height * 0.7;
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
