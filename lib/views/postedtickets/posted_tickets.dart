// // // import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
// // // import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// // // import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// // // import 'package:backup_ticket/provider/selltickets/sell_bus_ticket_provider.dart';
// // // import 'package:backup_ticket/model/movie_ticket_model.dart';
// // // import 'package:backup_ticket/model/bus_ticket_model.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';

// // // class PostedTickets extends StatefulWidget {
// // //   const PostedTickets({super.key});

// // //   @override
// // //   State<PostedTickets> createState() => _PostedTicketsState();
// // // }

// // // class _PostedTicketsState extends State<PostedTickets> with SingleTickerProviderStateMixin {
// // //   List<MovieTicket> _userMovieTickets = [];
// // //   List<BusTicket> _userBusTickets = [];
// // //   late TabController _tabController;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _tabController = TabController(length: 2, vsync: this);
    
// // //     // Load tickets when screen initializes
// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       _loadUserMovieTickets();
// // //       _loadUserBusTickets();
// // //     });
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _tabController.dispose();
// // //     super.dispose();
// // //   }

// // //   Future<void> _loadUserMovieTickets() async {
// // //     final provider = Provider.of<MovieTicketProvider>(context, listen: false);
// // //     final userTickets = await provider.fetchCurrentUserTickets();
// // //     setState(() {
// // //       _userMovieTickets = userTickets;
// // //     });
// // //   }

// // //   Future<void> _loadUserBusTickets() async {
// // //     try {
// // //       final provider = Provider.of<BusTicketProvider>(context, listen: false);
// // //       await provider.fetchMyTickets();
// // //       if (mounted) {
// // //         setState(() {
// // //           _userBusTickets = provider.tickets;
// // //         });
// // //       }
// // //     } catch (e) {
// // //       debugPrint('Error loading bus tickets: $e');
// // //     }
// // //   }

// // //   Future<void> _refreshAllTickets() async {
// // //     await Future.wait([
// // //       _loadUserMovieTickets(),
// // //       _loadUserBusTickets(),
// // //     ]);
// // //   }

// // //   // Delete Movie Ticket
// // //   Future<void> _deleteMovieTicket(MovieTicket ticket) async {
// // //     // Check if ticket is sold or not available for deletion
// // //     // Only pending tickets can be deleted
// // //     bool canDelete = ticket.status == TicketStatus.pending;
    
// // //     if (!canDelete) {
// // //       _showCannotDeleteDialog('This ticket has already been sold or is no longer available for deletion.');
// // //       return;
// // //     }

// // //     // Show confirmation dialog
// // //     bool? confirm = await _showDeleteConfirmationDialog('movie');
// // //     if (confirm != true) return;

// // //     try {
// // //       final provider = Provider.of<MovieTicketProvider>(context, listen: false);
      
// // //       // Show loading indicator
// // //       if (mounted) {
// // //         showDialog(
// // //           context: context,
// // //           barrierDismissible: false,
// // //           builder: (context) => const Center(child: CircularProgressIndicator()),
// // //         );
// // //       }

// // //       // Call delete method from provider (you need to implement this in your provider)
// // //       await provider.deleteTicket(ticket.id.toString());

// // //       // Close loading dialog
// // //       if (mounted) Navigator.of(context).pop();

// // //       // Reload tickets
// // //       await _loadUserMovieTickets();

// // //       // Show success message
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //             content: Text('Ticket deleted successfully'),
// // //             backgroundColor: Colors.green,
// // //           ),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       // Close loading dialog if open
// // //       if (mounted) Navigator.of(context).pop();
      
// // //       // Show error message
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(
// // //             content: Text('Failed to delete ticket: $e'),
// // //             backgroundColor: Colors.red,
// // //           ),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   // Delete Bus Ticket
// // //   Future<void> _deleteBusTicket(BusTicket ticket) async {
// // //     // Check if ticket is sold - only 'active' status tickets can be deleted
// // //     bool canDelete = ticket.status == 'active';
    
// // //     if (!canDelete) {
// // //       _showCannotDeleteDialog('This ticket has already been sold or is no longer available for deletion.');
// // //       return;
// // //     }

// // //     // Show confirmation dialog
// // //     bool? confirm = await _showDeleteConfirmationDialog('bus');
// // //     if (confirm != true) return;

// // //     try {
// // //       final provider = Provider.of<BusTicketProvider>(context, listen: false);
      
// // //       // Show loading indicator
// // //       if (mounted) {
// // //         showDialog(
// // //           context: context,
// // //           barrierDismissible: false,
// // //           builder: (context) => const Center(child: CircularProgressIndicator()),
// // //         );
// // //       }

// // //       // Call delete method from provider
// // //       await provider.deleteTicket(ticket.id.toString());

// // //       // Close loading dialog
// // //       if (mounted) Navigator.of(context).pop();

// // //       // Reload tickets
// // //       await _loadUserBusTickets();

// // //       // Show success message
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //             content: Text('Ticket deleted successfully'),
// // //             backgroundColor: Colors.green,
// // //           ),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       // Close loading dialog if open
// // //       if (mounted) Navigator.of(context).pop();
      
// // //       // Show error message
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(
// // //             content: Text('Failed to delete ticket: $e'),
// // //             backgroundColor: Colors.red,
// // //           ),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   // Show confirmation dialog
// // //   Future<bool?> _showDeleteConfirmationDialog(String ticketType) {
// // //     return showDialog<bool>(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: const Text('Delete Ticket'),
// // //           content: Text('Are you sure you want to delete this $ticketType ticket? This action cannot be undone.'),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () => Navigator.of(context).pop(false),
// // //               child: const Text('Cancel'),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: () => Navigator.of(context).pop(true),
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

// // //   // Show cannot delete dialog
// // //   void _showCannotDeleteDialog(String message) {
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: const Text('Cannot Delete'),
// // //           content: Text(message),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () => Navigator.of(context).pop(),
// // //               child: const Text('OK'),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
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
// // //         bottom: TabBar(
// // //           controller: _tabController,
// // //           labelColor: const Color(0xFF214194),
// // //           unselectedLabelColor: Colors.grey,
// // //           indicatorColor: const Color(0xFF214194),
// // //           indicatorWeight: 3,
// // //           tabs: const [
// // //             Tab(
// // //               icon: Icon(Icons.local_movies),
// // //               text: 'Movie Tickets',
// // //             ),
// // //             Tab(
// // //               icon: Icon(Icons.directions_bus),
// // //               text: 'Bus Tickets',
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //       body: TabBarView(
// // //         controller: _tabController,
// // //         children: [
// // //           _buildMovieTicketsTab(),
// // //           _buildBusTicketsTab(),
// // //         ],
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: () {
// // //           _showAddTicketDialog();
// // //         },
// // //         backgroundColor: const Color(0xFF214194),
// // //         child: const Icon(Icons.add, color: Colors.white),
// // //       ),
// // //     );
// // //   }

// // //   // Movie Tickets Tab
// // //   Widget _buildMovieTicketsTab() {
// // //     return Consumer<MovieTicketProvider>(
// // //       builder: (context, provider, child) {
// // //         if (provider.isLoading) {
// // //           return const Center(child: CircularProgressIndicator());
// // //         }

// // //         if (provider.error != null) {
// // //           return _buildErrorView(
// // //             message: 'Error loading movie tickets',
// // //             error: provider.error!,
// // //             onRetry: _loadUserMovieTickets,
// // //           );
// // //         }

// // //         if (_userMovieTickets.isEmpty) {
// // //           return _buildEmptyView(
// // //             icon: Icons.local_movies_outlined,
// // //             message: 'No movie tickets posted yet',
// // //             subtitle: 'Your posted movie tickets will appear here',
// // //             onAddPressed: () => _navigateToSellMovieTicket(),
// // //           );
// // //         }

// // //         return RefreshIndicator(
// // //           onRefresh: _loadUserMovieTickets,
// // //           child: ListView.builder(
// // //             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
// // //             itemCount: _userMovieTickets.length,
// // //             itemBuilder: (context, index) {
// // //               return _buildMovieTicketCard(context, _userMovieTickets[index]);
// // //             },
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   // Bus Tickets Tab
// // //   Widget _buildBusTicketsTab() {
// // //     return Consumer<BusTicketProvider>(
// // //       builder: (context, provider, child) {
// // //         if (provider.isLoading) {
// // //           return const Center(child: CircularProgressIndicator());
// // //         }

// // //         // Use provider.tickets instead of local state for real-time updates
// // //         final tickets = provider.tickets;

// // //         if (tickets.isEmpty) {
// // //           return _buildEmptyView(
// // //             icon: Icons.directions_bus_outlined,
// // //             message: 'No bus tickets posted yet',
// // //             subtitle: 'Your posted bus tickets will appear here',
// // //             onAddPressed: () => _navigateToSellBusTicket(),
// // //           );
// // //         }

// // //         return RefreshIndicator(
// // //           onRefresh: _loadUserBusTickets,
// // //           child: ListView.builder(
// // //             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
// // //             itemCount: tickets.length,
// // //             itemBuilder: (context, index) {
// // //               return _buildBusTicketCard(context, tickets[index]);
// // //             },
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   // Movie Ticket Card
// // //   Widget _buildMovieTicketCard(BuildContext context, MovieTicket ticket) {
// // //     String formattedDate = '${ticket.showDate.day} ${_getMonthName(ticket.showDate.month)}, ${ticket.showTime}';
// // //     bool canDelete = ticket.status == TicketStatus.pending;
    
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
// // //       child: Column(
// // //         children: [
// // //           Row(
// // //             children: [
// // //               // Movie Poster
// // //               Container(
// // //                 width: 60,
// // //                 height: 80,
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey[300],
// // //                   borderRadius: BorderRadius.circular(6),
// // //                 ),
// // //                 child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
// // //                     ? ClipRRect(
// // //                         borderRadius: BorderRadius.circular(6),
// // //                         child: Image.network(
// // //                           ticket.ticketImageUrl!,
// // //                           fit: BoxFit.cover,
// // //                           errorBuilder: (context, error, stackTrace) {
// // //                             return const Icon(Icons.local_movies, color: Colors.grey, size: 32);
// // //                           },
// // //                         ),
// // //                       )
// // //                     : const Icon(Icons.local_movies, color: Colors.grey, size: 32),
// // //               ),
// // //               const SizedBox(width: 12),

// // //               // Details
// // //               Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       ticket.movieName,
// // //                       style: const TextStyle(
// // //                         fontSize: 16,
// // //                         fontWeight: FontWeight.w600,
// // //                         color: Colors.black87,
// // //                       ),
// // //                       maxLines: 1,
// // //                       overflow: TextOverflow.ellipsis,
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Text(
// // //                       '${ticket.ticketType} • ${ticket.numberOfTickets} ticket${ticket.numberOfTickets > 1 ? 's' : ''}',
// // //                       style: const TextStyle(fontSize: 12, color: Colors.grey),
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Text(
// // //                       formattedDate,
// // //                       style: const TextStyle(fontSize: 14, color: Colors.black),
// // //                     ),
// // //                     const SizedBox(height: 2),
// // //                     Text(
// // //                       ticket.theatrePlace,
// // //                       style: const TextStyle(fontSize: 12, color: Colors.grey),
// // //                       maxLines: 1,
// // //                       overflow: TextOverflow.ellipsis,
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               // Price
// // //               Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.end,
// // //                 children: [
// // //                   const SizedBox(height: 8),
// // //                   Text(
// // //                     '₹ ${ticket.totalPrice.toStringAsFixed(0)}',
// // //                     style: const TextStyle(
// // //                       fontSize: 18,
// // //                       fontWeight: FontWeight.w600,
// // //                       color: Colors.black87,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
          
// // //           // Delete button (only show if status is pending)
// // //           if (canDelete) ...[
// // //             const SizedBox(height: 12),
// // //             const Divider(height: 1),
// // //             const SizedBox(height: 8),
// // //             SizedBox(
// // //               width: double.infinity,
// // //               child: TextButton.icon(
// // //                 onPressed: () => _deleteMovieTicket(ticket),
// // //                 icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
// // //                 label: const Text(
// // //                   'Delete Ticket',
// // //                   style: TextStyle(color: Colors.red),
// // //                 ),
// // //                 style: TextButton.styleFrom(
// // //                   padding: const EdgeInsets.symmetric(vertical: 8),
// // //                 ),
// // //               ),
// // //             ),
// // //           ] else ...[
// // //             const SizedBox(height: 12),
// // //             Container(
// // //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// // //               decoration: BoxDecoration(
// // //                 color: _getStatusColor(ticket.status).withOpacity(0.1),
// // //                 borderRadius: BorderRadius.circular(6),
// // //               ),
// // //               child: Row(
// // //                 mainAxisSize: MainAxisSize.min,
// // //                 children: [
// // //                   Icon(
// // //                     _getStatusIcon(ticket.status),
// // //                     size: 16,
// // //                     color: _getStatusColor(ticket.status),
// // //                   ),
// // //                   const SizedBox(width: 6),
// // //                   Text(
// // //                     _getStatusText(ticket.status),
// // //                     style: TextStyle(
// // //                       fontSize: 12,
// // //                       color: _getStatusColor(ticket.status),
// // //                       fontWeight: FontWeight.w500,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // Bus Ticket Card
// // //   Widget _buildBusTicketCard(BuildContext context, BusTicket ticket) {
// // //     String formattedDate = '${ticket.dateOfJourney.day} ${_getMonthName(ticket.dateOfJourney.month)} ${ticket.dateOfJourney.year}';
// // //     bool canDelete = ticket.status == 'active';
    
// // //     // Format time properly - remove seconds if present
// // //     String formattedTime = ticket.dropPoint;
// // //     if (formattedTime.contains(':')) {
// // //       List<String> timeParts = formattedTime.split(':');
// // //       if (timeParts.length >= 2) {
// // //         formattedTime = '${timeParts[0]}:${timeParts[1]}';
// // //       }
// // //     }
    
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
// // //       child: Column(
// // //         children: [
// // //           Row(
// // //             children: [
// // //               // Bus Icon/Image
// // //               Container(
// // //                 width: 60,
// // //                 height: 80,
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey[300],
// // //                   borderRadius: BorderRadius.circular(6),
// // //                 ),
// // //                 child: ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty
// // //                     ? ClipRRect(
// // //                         borderRadius: BorderRadius.circular(6),
// // //                         child: Image.network(
// // //                           ticket.ticketImageUrl!,
// // //                           fit: BoxFit.cover,
// // //                           errorBuilder: (context, error, stackTrace) {
// // //                             return const Icon(Icons.directions_bus, color: Colors.grey, size: 32);
// // //                           },
// // //                         ),
// // //                       )
// // //                     : const Icon(Icons.directions_bus, color: Colors.grey, size: 32),
// // //               ),
// // //               const SizedBox(width: 12),

// // //               // Details
// // //               Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       ticket.busName,
// // //                       style: const TextStyle(
// // //                         fontSize: 16,
// // //                         fontWeight: FontWeight.w600,
// // //                         color: Colors.black87,
// // //                       ),
// // //                       maxLines: 1,
// // //                       overflow: TextOverflow.ellipsis,
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Text(
// // //                       '${ticket.ticketType} • ${ticket.busName} seat${ticket.numberOfTickets > 1 ? 's' : ''}',
// // //                       style: const TextStyle(fontSize: 12, color: Colors.grey),
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Text(
// // //                       '$formattedDate, $formattedTime',
// // //                       style: const TextStyle(fontSize: 14, color: Colors.black),
// // //                     ),
// // //                     Text(
// // //                       '${ticket.boardingTime}',
// // //                       style: const TextStyle(fontSize: 14, color: Colors.black),
// // //                     ),
// // //                     const SizedBox(height: 2),
// // //                     Text(
// // //                       '${ticket.pickupPoint} → ${ticket.dropPoint}',
// // //                       style: const TextStyle(fontSize: 12, color: Colors.grey),
// // //                       maxLines: 1,
// // //                       overflow: TextOverflow.ellipsis,
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               // Price
// // //               Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.end,
// // //                 children: [
// // //                   const SizedBox(height: 8),
// // //                   Text(
// // //                     '₹ ${ticket.totalPrice.toStringAsFixed(0)}',
// // //                     style: const TextStyle(
// // //                       fontSize: 18,
// // //                       fontWeight: FontWeight.w600,
// // //                       color: Colors.black87,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
          
// // //           // Delete button (only show if status is active)
// // //           if (canDelete) ...[
// // //             const SizedBox(height: 12),
// // //             const Divider(height: 1),
// // //             const SizedBox(height: 8),
// // //             SizedBox(
// // //               width: double.infinity,
// // //               child: TextButton.icon(
// // //                 onPressed: () => _deleteBusTicket(ticket),
// // //                 icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
// // //                 label: const Text(
// // //                   'Delete Ticket',
// // //                   style: TextStyle(color: Colors.red),
// // //                 ),
// // //                 style: TextButton.styleFrom(
// // //                   padding: const EdgeInsets.symmetric(vertical: 8),
// // //                 ),
// // //               ),
// // //             ),
// // //           ] else ...[
// // //             const SizedBox(height: 12),
// // //             Container(
// // //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// // //               decoration: BoxDecoration(
// // //                 color: _getBusStatusColor(ticket.status).withOpacity(0.1),
// // //                 borderRadius: BorderRadius.circular(6),
// // //               ),
// // //               child: Row(
// // //                 mainAxisSize: MainAxisSize.min,
// // //                 children: [
// // //                   Icon(
// // //                     _getBusStatusIcon(ticket.status),
// // //                     size: 16,
// // //                     color: _getBusStatusColor(ticket.status),
// // //                   ),
// // //                   const SizedBox(width: 6),
// // //                   Text(
// // //                     _getBusStatusText(ticket.status),
// // //                     style: TextStyle(
// // //                       fontSize: 12,
// // //                       color: _getBusStatusColor(ticket.status),
// // //                       fontWeight: FontWeight.w500,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // Empty View
// // //   Widget _buildEmptyView({
// // //     required IconData icon,
// // //     required String message,
// // //     required String subtitle,
// // //     required VoidCallback onAddPressed,
// // //   }) {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(icon, size: 64, color: Colors.grey[400]),
// // //           const SizedBox(height: 16),
// // //           Text(
// // //             message,
// // //             style: TextStyle(
// // //               fontSize: 18,
// // //               fontWeight: FontWeight.w500,
// // //               color: Colors.grey[600],
// // //             ),
// // //           ),
// // //           const SizedBox(height: 8),
// // //           Text(
// // //             subtitle,
// // //             style: TextStyle(fontSize: 14, color: Colors.grey[500]),
// // //           ),
// // //           const SizedBox(height: 24),
// // //           ElevatedButton.icon(
// // //             onPressed: onAddPressed,
// // //             icon: const Icon(Icons.add, color: Colors.white),
// // //             label: const Text(
// // //               'Post a Ticket',
// // //               style: TextStyle(color: Colors.white),
// // //             ),
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: const Color(0xFF214194),
// // //               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // Error View
// // //   Widget _buildErrorView({
// // //     required String message,
// // //     required String error,
// // //     required VoidCallback onRetry,
// // //   }) {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
// // //           const SizedBox(height: 16),
// // //           Text(
// // //             message,
// // //             style: TextStyle(
// // //               fontSize: 18,
// // //               fontWeight: FontWeight.w500,
// // //               color: Colors.grey[600],
// // //             ),
// // //           ),
// // //           const SizedBox(height: 8),
// // //           Text(
// // //             error,
// // //             textAlign: TextAlign.center,
// // //             style: TextStyle(fontSize: 14, color: Colors.grey[500]),
// // //           ),
// // //           const SizedBox(height: 16),
// // //           ElevatedButton(
// // //             onPressed: onRetry,
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: const Color(0xFF214194),
// // //             ),
// // //             child: const Text('Retry', style: TextStyle(color: Colors.white)),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // Show dialog to choose ticket type
// // //   void _showAddTicketDialog() {
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: const Text('Add Ticket'),
// // //           content: const Text('What type of ticket would you like to post?'),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () {
// // //                 Navigator.of(context).pop();
// // //               },
// // //               child: const Text('Cancel'),
// // //             ),
// // //             ElevatedButton.icon(
// // //               onPressed: () {
// // //                 Navigator.of(context).pop();
// // //                 _navigateToSellBusTicket();
// // //               },
// // //               icon: const Icon(Icons.directions_bus, size: 18),
// // //               label: const Text('Bus Ticket'),
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: const Color(0xFF214194),
// // //                 foregroundColor: Colors.white,
// // //               ),
// // //             ),
// // //             ElevatedButton.icon(
// // //               onPressed: () {
// // //                 Navigator.of(context).pop();
// // //                 _navigateToSellMovieTicket();
// // //               },
// // //               icon: const Icon(Icons.local_movies, size: 18),
// // //               label: const Text('Movie Ticket'),
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: const Color(0xFF214194),
// // //                 foregroundColor: Colors.white,
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _navigateToSellMovieTicket() {
// // //     Navigator.push(
// // //       context,
// // //       MaterialPageRoute(
// // //         builder: (context) => const SellMovieTicket(),
// // //       ),
// // //     ).then((_) {
// // //       _loadUserMovieTickets();
// // //     });
// // //   }

// // //   void _navigateToSellBusTicket() {
// // //     Navigator.push(
// // //       context,
// // //       MaterialPageRoute(
// // //         builder: (context) => const SellBusTicket(),
// // //       ),
// // //     ).then((_) {
// // //       _loadUserBusTickets();
// // //     });
// // //   }

// // //   String _getMonthName(int month) {
// // //     const months = [
// // //       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
// // //       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
// // //     ];
// // //     return months[month - 1];
// // //   }

// // //   // Helper methods for Movie Ticket Status
// // //   Color _getStatusColor(TicketStatus status) {
// // //     switch (status) {
// // //       case TicketStatus.pending:
// // //         return Colors.orange;
// // //       case TicketStatus.confirmed:
// // //         return Colors.blue;
// // //       case TicketStatus.accepted:
// // //         return Colors.green;
// // //       case TicketStatus.sold:
// // //         return Colors.green;
// // //       case TicketStatus.cancelled:
// // //         return Colors.red;
// // //       default:
// // //         return Colors.grey;
// // //     }
// // //   }

// // //   IconData _getStatusIcon(TicketStatus status) {
// // //     switch (status) {
// // //       case TicketStatus.pending:
// // //         return Icons.pending;
// // //       case TicketStatus.confirmed:
// // //         return Icons.check_circle_outline;
// // //       case TicketStatus.accepted:
// // //         return Icons.check_circle;
// // //       case TicketStatus.sold:
// // //         return Icons.check_circle;
// // //       case TicketStatus.cancelled:
// // //         return Icons.cancel;
// // //       default:
// // //         return Icons.help_outline;
// // //     }
// // //   }

// // //   String _getStatusText(TicketStatus status) {
// // //     switch (status) {
// // //       case TicketStatus.pending:
// // //         return 'Pending';
// // //       case TicketStatus.confirmed:
// // //         return 'Confirmed';
// // //       case TicketStatus.accepted:
// // //         return 'Accepted';
// // //       case TicketStatus.sold:
// // //         return 'Sold';
// // //       case TicketStatus.cancelled:
// // //         return 'Cancelled';
// // //       default:
// // //         return 'Unknown';
// // //     }
// // //   }

// // //   // Helper methods for Bus Ticket Status
// // //   Color _getBusStatusColor(String status) {
// // //     switch (status.toLowerCase()) {
// // //       case 'active':
// // //         return Colors.orange;
// // //       case 'sold':
// // //         return Colors.green;
// // //       case 'cancelled':
// // //         return Colors.red;
// // //       default:
// // //         return Colors.grey;
// // //     }
// // //   }

// // //   IconData _getBusStatusIcon(String status) {
// // //     switch (status.toLowerCase()) {
// // //       case 'active':
// // //         return Icons.pending;
// // //       case 'sold':
// // //         return Icons.check_circle;
// // //       case 'cancelled':
// // //         return Icons.cancel;
// // //       default:
// // //         return Icons.help_outline;
// // //     }
// // //   }

// // //   String _getBusStatusText(String status) {
// // //     switch (status.toLowerCase()) {
// // //       case 'active':
// // //         return 'Active';
// // //       case 'sold':
// // //         return 'Sold';
// // //       case 'cancelled':
// // //         return 'Cancelled';
// // //       default:
// // //         return 'Unknown';
// // //     }
// // //   }
// // // }











// // import 'package:flutter/material.dart';
// // import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
// // import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';

// // /// ================= ENUMS =================
// // enum TicketStatus { pending, confirmed, accepted, sold, cancelled }

// // /// ================= MODELS =================
// // class MovieTicket {
// //   final String id;
// //   final String movieName;
// //   final String ticketType;
// //   final int numberOfTickets;
// //   final DateTime showDate;
// //   final String showTime;
// //   final String theatrePlace;
// //   final double totalPrice;
// //   final String? ticketImageUrl;
// //   final TicketStatus status;

// //   MovieTicket({
// //     required this.id,
// //     required this.movieName,
// //     required this.ticketType,
// //     required this.numberOfTickets,
// //     required this.showDate,
// //     required this.showTime,
// //     required this.theatrePlace,
// //     required this.totalPrice,
// //     this.ticketImageUrl,
// //     required this.status,
// //   });
// // }

// // class BusTicket {
// //   final String id;
// //   final String busName;
// //   final String ticketType;
// //   final int numberOfTickets;
// //   final DateTime dateOfJourney;
// //   final String boardingTime;
// //   final String pickupPoint;
// //   final String dropPoint;
// //   final double totalPrice;
// //   final String? ticketImageUrl;
// //   final String status; // active | sold | cancelled

// //   BusTicket({
// //     required this.id,
// //     required this.busName,
// //     required this.ticketType,
// //     required this.numberOfTickets,
// //     required this.dateOfJourney,
// //     required this.boardingTime,
// //     required this.pickupPoint,
// //     required this.dropPoint,
// //     required this.totalPrice,
// //     this.ticketImageUrl,
// //     required this.status,
// //   });
// // }

// // /// ================= SCREEN =================
// // class PostedTickets extends StatefulWidget {
// //   const PostedTickets({super.key});

// //   @override
// //   State<PostedTickets> createState() => _PostedTicketsState();
// // }

// // class _PostedTicketsState extends State<PostedTickets>
// //     with SingleTickerProviderStateMixin {
// //   late TabController _tabController;

// //   bool _isLoading = false;

// //   List<MovieTicket> _userMovieTickets = [];
// //   List<BusTicket> _userBusTickets = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 2, vsync: this);
// //     _loadTickets();
// //   }

// //   Future<void> _loadTickets() async {
// //     setState(() => _isLoading = true);

// //     await Future.delayed(const Duration(seconds: 1));

// //     _userMovieTickets = [
// //       MovieTicket(
// //         id: '1',
// //         movieName: 'Leo',
// //         ticketType: 'Balcony',
// //         numberOfTickets: 2,
// //         showDate: DateTime.now().add(const Duration(days: 1)),
// //         showTime: '7:30 PM',
// //         theatrePlace: 'PVR Lulu Mall',
// //         totalPrice: 500,
// //         status: TicketStatus.pending,
// //       ),
// //     ];

// //     _userBusTickets = [
// //       BusTicket(
// //         id: '1',
// //         busName: 'KSRTC Swift',
// //         ticketType: 'Sleeper',
// //         numberOfTickets: 1,
// //         dateOfJourney: DateTime.now().add(const Duration(days: 2)),
// //         boardingTime: '10:00 PM',
// //         pickupPoint: 'Calicut',
// //         dropPoint: 'Bangalore',
// //         totalPrice: 900,
// //         status: 'active',
// //       ),
// //     ];

// //     setState(() => _isLoading = false);
// //   }

// //   /// ================= UI =================
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       appBar: AppBar(
// //         title: const Text(
// //           'My Posted Tickets',
// //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
// //         ),
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //         bottom: TabBar(
// //           controller: _tabController,
// //           labelColor: const Color(0xFF214194),
// //           indicatorColor: const Color(0xFF214194),
// //           tabs: const [
// //             Tab(icon: Icon(Icons.local_movies), text: 'Movie Tickets'),
// //             Tab(icon: Icon(Icons.directions_bus), text: 'Bus Tickets'),
// //           ],
// //         ),
// //       ),
// //       body: _isLoading
// //           ? const Center(child: CircularProgressIndicator())
// //           : TabBarView(
// //               controller: _tabController,
// //               children: [
// //                 _buildMovieTab(),
// //                 _buildBusTab(),
// //               ],
// //             ),
// //       floatingActionButton: FloatingActionButton(
// //         backgroundColor: const Color(0xFF214194),
// //         child: const Icon(Icons.add, color: Colors.white),
// //         onPressed: _showAddTicketDialog,
// //       ),
// //     );
// //   }

// //   /// ================= MOVIE TAB =================
// //   Widget _buildMovieTab() {
// //     if (_userMovieTickets.isEmpty) {
// //       return _buildEmpty(
// //         Icons.local_movies_outlined,
// //         'No movie tickets posted yet',
// //         _navigateToSellMovieTicket,
// //       );
// //     }

// //     return RefreshIndicator(
// //       onRefresh: _loadTickets,
// //       child: ListView.builder(
// //         padding: const EdgeInsets.all(16),
// //         itemCount: _userMovieTickets.length,
// //         itemBuilder: (_, i) => _buildMovieCard(_userMovieTickets[i]),
// //       ),
// //     );
// //   }

// //   Widget _buildMovieCard(MovieTicket ticket) {
// //     final canDelete = ticket.status == TicketStatus.pending;

// //     return _ticketContainer(
// //       child: Column(
// //         children: [
// //           ListTile(
// //             leading: const Icon(Icons.local_movies, size: 40),
// //             title: Text(ticket.movieName),
// //             subtitle: Text(
// //               '${ticket.ticketType} • ${ticket.showTime}\n${ticket.theatrePlace}',
// //             ),
// //             trailing: Text(
// //               '₹${ticket.totalPrice.toStringAsFixed(0)}',
// //               style: const TextStyle(
// //                 fontSize: 16,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //           if (canDelete)
// //             TextButton.icon(
// //               onPressed: () => _deleteMovie(ticket),
// //               icon: const Icon(Icons.delete, color: Colors.red),
// //               label: const Text('Delete', style: TextStyle(color: Colors.red)),
// //             ),
// //         ],
// //       ),
// //     );
// //   }

// //   /// ================= BUS TAB =================
// //   Widget _buildBusTab() {
// //     if (_userBusTickets.isEmpty) {
// //       return _buildEmpty(
// //         Icons.directions_bus_outlined,
// //         'No bus tickets posted yet',
// //         _navigateToSellBusTicket,
// //       );
// //     }

// //     return RefreshIndicator(
// //       onRefresh: _loadTickets,
// //       child: ListView.builder(
// //         padding: const EdgeInsets.all(16),
// //         itemCount: _userBusTickets.length,
// //         itemBuilder: (_, i) => _buildBusCard(_userBusTickets[i]),
// //       ),
// //     );
// //   }

// //   Widget _buildBusCard(BusTicket ticket) {
// //     final canDelete = ticket.status == 'active';

// //     return _ticketContainer(
// //       child: Column(
// //         children: [
// //           ListTile(
// //             leading: const Icon(Icons.directions_bus, size: 40),
// //             title: Text(ticket.busName),
// //             subtitle: Text(
// //               '${ticket.pickupPoint} → ${ticket.dropPoint}\n${ticket.boardingTime}',
// //             ),
// //             trailing: Text(
// //               '₹${ticket.totalPrice.toStringAsFixed(0)}',
// //               style: const TextStyle(
// //                 fontSize: 16,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //           if (canDelete)
// //             TextButton.icon(
// //               onPressed: () => _deleteBus(ticket),
// //               icon: const Icon(Icons.delete, color: Colors.red),
// //               label: const Text('Delete', style: TextStyle(color: Colors.red)),
// //             ),
// //         ],
// //       ),
// //     );
// //   }

// //   /// ================= COMMON =================
// //   Widget _ticketContainer({required Widget child}) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 8),
// //         ],
// //       ),
// //       child: child,
// //     );
// //   }

// //   Widget _buildEmpty(
// //       IconData icon, String text, VoidCallback onAddPressed) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(icon, size: 64, color: Colors.grey),
// //           const SizedBox(height: 12),
// //           Text(text, style: const TextStyle(fontSize: 16)),
// //           const SizedBox(height: 20),
// //           ElevatedButton.icon(
// //             onPressed: onAddPressed,
// //             icon: const Icon(Icons.add),
// //             label: const Text('Post a Ticket'),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: const Color(0xFF214194),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   /// ================= ACTIONS =================
// //   void _deleteMovie(MovieTicket ticket) {
// //     setState(() => _userMovieTickets.remove(ticket));
// //   }

// //   void _deleteBus(BusTicket ticket) {
// //     setState(() => _userBusTickets.remove(ticket));
// //   }

// //   void _showAddTicketDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (_) => AlertDialog(
// //         title: const Text('Add Ticket'),
// //         actions: [
// //           TextButton(
// //             onPressed: _navigateToSellBusTicket,
// //             child: const Text('Bus Ticket'),
// //           ),
// //           TextButton(
// //             onPressed: _navigateToSellMovieTicket,
// //             child: const Text('Movie Ticket'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _navigateToSellMovieTicket() {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (_) => const SellMovieTicket()),
// //     );
// //   }

// //   void _navigateToSellBusTicket() {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (_) => const SellBusTicket()),
// //     );
// //   }
// // }













// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
// import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// /// ================= ENUMS =================
// enum TicketStatus { pending, confirmed, accepted, sold, cancelled }

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
//   });

//   factory MovieTicket.fromJson(Map<String, dynamic> json) {
//     return MovieTicket(
//       id: json['_id'] ?? '',
//       movieName: json['MovieName'] ?? '',
//       ticketType: json['ticketCategory'] ?? '',
//       numberOfTickets: json['noOfTickets'] ?? 0,
//       showDate: DateTime.parse(json['showDate']),
//       showTime: json['showTime'] ?? '',
//       theatrePlace: json['theatrePlace'] ?? '',
//       totalPrice: (json['totalPrice'] ?? 0).toDouble(),
//       ticketImageUrl: json['ticketImage'],
//       status: _parseStatus(json['status']),
//       language: json['language'] ?? '',
//       selectedSeats: List<String>.from(json['selectedSeats'] ?? []),
//       email: json['email'] ?? '',
//       phoneNumber: json['phoneNumber'] ?? '',
//     );
//   }

//   static TicketStatus _parseStatus(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'pending':
//         return TicketStatus.pending;
//       case 'confirmed':
//         return TicketStatus.confirmed;
//       case 'accepted':
//         return TicketStatus.accepted;
//       case 'sold':
//         return TicketStatus.sold;
//       case 'cancelled':
//         return TicketStatus.cancelled;
//       default:
//         return TicketStatus.pending;
//     }
//   }

//   String get statusText {
//     switch (status) {
//       case TicketStatus.pending:
//         return 'Pending';
//       case TicketStatus.confirmed:
//         return 'Confirmed';
//       case TicketStatus.accepted:
//         return 'Accepted';
//       case TicketStatus.sold:
//         return 'Sold';
//       case TicketStatus.cancelled:
//         return 'Cancelled';
//     }
//   }

//   Color get statusColor {
//     switch (status) {
//       case TicketStatus.pending:
//         return Colors.orange;
//       case TicketStatus.confirmed:
//         return Colors.blue;
//       case TicketStatus.accepted:
//         return Colors.green;
//       case TicketStatus.sold:
//         return Colors.purple;
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
      
//       final response = await http.get(
//         Uri.parse('$baseUrl/mypostedticket/$userId'),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success'] == true && data['data'] != null) {
//           final List<dynamic> ticketsJson = data['data'];
//           return ticketsJson.map((json) => MovieTicket.fromJson(json)).toList();
//         }
//       }
//       throw Exception('Failed to load tickets');
//     } catch (e) {
//       print('Error fetching tickets: $e');
//       rethrow;
//     }
//   }

//   static Future<bool> deleteTicket(String ticketId,String userId) async {
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


//   static const String ticketImageBaseUrl =
//     "http://31.97.206.144:8127";



//     String getTicketImageUrl(String imagePath) {
//   if (imagePath.startsWith('http')) {
//     return imagePath;
//   }
//   return "$ticketImageBaseUrl$imagePath";
// }


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
//     final canDelete = ticket.status == TicketStatus.pending;

//     return _ticketContainer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Status Badge
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
//                     // Icon(Icons.circle, size: 8, color: ticket.statusColor),
//                     const SizedBox(width: 6),
//                     // Text(
//                     //   ticket.statusText,
//                     //   style: TextStyle(
//                     //     color: ticket.statusColor,
//                     //     fontWeight: FontWeight.bold,
//                     //     fontSize: 12,
//                     //   ),
//                     // ),
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
//               getTicketImageUrl(ticket.ticketImageUrl!),
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
//                 const SizedBox(height: 8),
                
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
//                 Row(
//                   children: [
//                     const Icon(Icons.event_seat, size: 16, color: Colors.grey),
//                     const SizedBox(width: 6),
//                     Expanded(
//                       child: Text(
//                         ticket.selectedSeats.join(', '),
//                         style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
          
//           // Delete Button
//           // if (canDelete)
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
//   // Future<void> _deleteMovie(MovieTicket ticket) async {
//   //   final confirm = await showDialog<bool>(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //       title: const Text('Delete Ticket'),
//   //       content: const Text('Are you sure you want to delete this ticket?'),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () => Navigator.pop(context, false),
//   //           child: const Text('Cancel'),
//   //         ),
//   //         TextButton(
//   //           onPressed: () => Navigator.pop(context, true),
//   //           child: const Text('Delete', style: TextStyle(color: Colors.red)),
//   //         ),
//   //       ],
//   //     ),
//   //   );

//   //   if (confirm == true) {
//   //     setState(() => _isLoading = true);
      
//   //     final success = await TicketApiService.deleteTicket(ticket.id,);
      
//   //     if (success) {
//   //       setState(() {
//   //         _userMovieTickets.remove(ticket);
//   //         _isLoading = false;
//   //       });
        
//   //       if (mounted) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           const SnackBar(
//   //             content: Text('Ticket deleted successfully'),
//   //             backgroundColor: Colors.green,
//   //           ),
//   //         );
//   //       }
//   //     } else {
//   //       setState(() => _isLoading = false);
        
//   //       if (mounted) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           const SnackBar(
//   //             content: Text('Failed to delete ticket'),
//   //             backgroundColor: Colors.red,
//   //           ),
//   //         );
//   //       }
//   //     }
//   //   }
//   // }



//   /// ================= ACTIONS =================
// Future<void> _deleteMovie(MovieTicket ticket) async {
//   final confirm = await showDialog<bool>(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text('Delete Ticket'),
//       content: const Text('Are you sure you want to delete this ticket?'),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context, false),
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context, true),
//           child: const Text('Delete', style: TextStyle(color: Colors.red)),
//         ),
//       ],
//     ),
//   );

//   if (confirm == true) {
//     setState(() => _isLoading = true);
    
//     try {
//       // Get the user ID
//       final user = await SharedPrefsHelper.getUser();
//       if (user == null || user.id.isEmpty) {
//         throw Exception('User not found. Please login again.');
//       }
      
//       // Call delete with both ticketId and userId
//       final success = await TicketApiService.deleteTicket(ticket.id, user.id);
      
//       if (success) {
//         setState(() {
//           _userMovieTickets.remove(ticket);
//           _isLoading = false;
//         });
        
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Ticket deleted successfully'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         }
//       } else {
//         setState(() => _isLoading = false);
        
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Failed to delete ticket'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       setState(() => _isLoading = false);
      
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: ${e.toString().replaceAll('Exception: ', '')}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }
// }

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
    
//     // Reload tickets if a new ticket was added
//     if (result == true) {
//       _loadTickets();
//     }
//   }

//   void _navigateToSellBusTicket() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const SellBusTicket()),
//     );
    
//     // Reload tickets if a new ticket was added
//     if (result == true) {
//       _loadTickets();
//     }
//   }
// }

















import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:backup_ticket/views/Sell/sell_bus_ticket.dart';
import 'package:backup_ticket/views/Sell/sell_movie_ticket.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// ================= ENUMS =================
enum TicketStatus { pending, confirmed, accepted, sold, cancelled }

/// ================= MODELS =================
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
  final TicketStatus status;
  final String language;
  final List<String> selectedSeats;
  final String email;
  final String phoneNumber;
  final int remainingCount;
  final int soldCount;

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
    required this.status,
    required this.language,
    required this.selectedSeats,
    required this.email,
    required this.phoneNumber,
    this.remainingCount = 0,
    this.soldCount = 0,
  });

  factory MovieTicket.fromJson(Map<String, dynamic> json) {
    return MovieTicket(
      id: json['_id'] ?? '',
      movieName: json['MovieName'] ?? '',
      ticketType: json['ticketCategory'] ?? '',
      numberOfTickets: json['noOfTickets'] ?? 0,
      showDate: DateTime.parse(json['showDate']),
      showTime: json['showTime'] ?? '',
      theatrePlace: json['theatrePlace'] ?? '',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      ticketImageUrl: json['ticketImage'],
      status: _parseStatus(json['status']),
      language: json['language'] ?? '',
      selectedSeats: List<String>.from(json['selectedSeats'] ?? []),
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      remainingCount: json['remainingCount'] ?? 0,
      soldCount: json['soldCount'] ?? 0,
    );
  }

  static TicketStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return TicketStatus.pending;
      case 'confirmed':
        return TicketStatus.confirmed;
      case 'accepted':
        return TicketStatus.accepted;
      case 'sold':
        return TicketStatus.sold;
      case 'cancelled':
        return TicketStatus.cancelled;
      default:
        return TicketStatus.pending;
    }
  }

  String get statusText {
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
    }
  }

  Color get statusColor {
    switch (status) {
      case TicketStatus.pending:
        return Colors.orange;
      case TicketStatus.confirmed:
        return Colors.blue;
      case TicketStatus.accepted:
        return Colors.green;
      case TicketStatus.sold:
        return Colors.purple;
      case TicketStatus.cancelled:
        return Colors.red;
    }
  }
}

class BusTicket {
  final String id;
  final String busName;
  final String ticketType;
  final int numberOfTickets;
  final DateTime dateOfJourney;
  final String boardingTime;
  final String pickupPoint;
  final String dropPoint;
  final double totalPrice;
  final String? ticketImageUrl;
  final String status;

  BusTicket({
    required this.id,
    required this.busName,
    required this.ticketType,
    required this.numberOfTickets,
    required this.dateOfJourney,
    required this.boardingTime,
    required this.pickupPoint,
    required this.dropPoint,
    required this.totalPrice,
    this.ticketImageUrl,
    required this.status,
  });
}

/// ================= API SERVICE =================
class TicketApiService {
  static const String baseUrl = 'http://31.97.206.144:8127/api/auth';

  static Future<List<MovieTicket>> fetchPostedTickets(String userId) async {
    try {
      final token = await SharedPrefsHelper.getToken();
      
      final response = await http.get(
        Uri.parse('$baseUrl/mypostedticket/$userId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          final List<dynamic> ticketsJson = data['data'];
          return ticketsJson.map((json) => MovieTicket.fromJson(json)).toList();
        }
      }
      throw Exception('Failed to load tickets');
    } catch (e) {
      print('Error fetching tickets: $e');
      rethrow;
    }
  }

  static Future<bool> deleteTicket(String ticketId, String userId) async {
    try {
      final token = await SharedPrefsHelper.getToken();
      
      final response = await http.delete(
        Uri.parse('$baseUrl/deletemovieticket/$userId/$ticketId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      print('response status code for delete movie ticket ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting ticket: $e');
      return false;
    }
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

  bool _isLoading = false;
  String? _errorMessage;

  List<MovieTicket> _userMovieTickets = [];
  List<BusTicket> _userBusTickets = [];

  static const String ticketImageBaseUrl = "http://31.97.206.144:8127";

  String getTicketImageUrl(String imagePath) {
    if (imagePath.startsWith('http')) {
      return imagePath;
    }
    return "$ticketImageBaseUrl$imagePath";
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadTickets();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadTickets() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await SharedPrefsHelper.getUser();
      if (user == null || user.id.isEmpty) {
        throw Exception('User not found. Please login again.');
      }

      final tickets = await TicketApiService.fetchPostedTickets(user.id);
      
      setState(() {
        _userMovieTickets = tickets;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage ?? 'Failed to load tickets'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'My Posted Tickets',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF214194),
          indicatorColor: const Color(0xFF214194),
          tabs: const [
            Tab(icon: Icon(Icons.local_movies), text: 'Movie Tickets'),
            Tab(icon: Icon(Icons.directions_bus), text: 'Bus Tickets'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? _buildErrorWidget()
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMovieTab(),
                    _buildBusTab(),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF214194),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _showAddTicketDialog,
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            _errorMessage ?? 'Something went wrong',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _loadTickets,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF214194),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= MOVIE TAB =================
  Widget _buildMovieTab() {
    if (_userMovieTickets.isEmpty) {
      return _buildEmpty(
        Icons.local_movies_outlined,
        'No movie tickets posted yet',
        _navigateToSellMovieTicket,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadTickets,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _userMovieTickets.length,
        itemBuilder: (_, i) => _buildMovieCard(_userMovieTickets[i]),
      ),
    );
  }

  Widget _buildMovieCard(MovieTicket ticket) {
    final canDelete = ticket.status == TicketStatus.pending;

    return _ticketContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Badge and Price
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: ticket.statusColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: ticket.statusColor),
                    const SizedBox(width: 6),
                    Text(
                      ticket.statusText,
                      style: TextStyle(
                        color: ticket.statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Text(
                  '₹${ticket.totalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF214194),
                  ),
                ),
              ],
            ),
          ),
          
          // Ticket Image
          if (ticket.ticketImageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
              child: Image.network(
                getTicketImageUrl(ticket.ticketImageUrl!),
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Name
                Text(
                  ticket.movieName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Ticket Counts - Remaining and Sold
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.confirmation_number_outlined, 
                                  size: 18, 
                                  color: Colors.green[700],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${ticket.remainingCount}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Remaining',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.sell_outlined, 
                                  size: 18, 
                                  color: Colors.purple[700],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${ticket.soldCount}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple[700],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Sold',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                
                // Language
                Row(
                  children: [
                    const Icon(Icons.language, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      ticket.language,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Theatre & Date
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        ticket.theatrePlace,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Show Time & Date
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      '${ticket.showDate.day}/${ticket.showDate.month}/${ticket.showDate.year}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      ticket.showTime,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Ticket Category & Count
                Row(
                  children: [
                    const Icon(Icons.confirmation_number, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      '${ticket.ticketType} • ${ticket.numberOfTickets} Ticket(s)',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Seats
                if (ticket.selectedSeats.isNotEmpty)
                  Row(
                    children: [
                      const Icon(Icons.event_seat, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          ticket.selectedSeats.join(', '),
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          
          // Delete Button
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            child: SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () => _deleteMovie(ticket),
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  'Delete Ticket',
                  style: TextStyle(color: Colors.red),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= BUS TAB =================
  Widget _buildBusTab() {
    if (_userBusTickets.isEmpty) {
      return _buildEmpty(
        Icons.directions_bus_outlined,
        'No bus tickets posted yet',
        _navigateToSellBusTicket,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadTickets,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _userBusTickets.length,
        itemBuilder: (_, i) => _buildBusCard(_userBusTickets[i]),
      ),
    );
  }

  Widget _buildBusCard(BusTicket ticket) {
    final canDelete = ticket.status == 'active';

    return _ticketContainer(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.directions_bus, size: 40),
            title: Text(ticket.busName),
            subtitle: Text(
              '${ticket.pickupPoint} → ${ticket.dropPoint}\n${ticket.boardingTime}',
            ),
            trailing: Text(
              '₹${ticket.totalPrice.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (canDelete)
            TextButton.icon(
              onPressed: () => _deleteBus(ticket),
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }

  /// ================= COMMON =================
  Widget _ticketContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildEmpty(IconData icon, String text, VoidCallback onAddPressed) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
          const SizedBox(height: 12),
          Text(text, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add),
            label: const Text('Post a Ticket'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF214194),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= ACTIONS =================
  Future<void> _deleteMovie(MovieTicket ticket) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Ticket'),
        content: const Text('Are you sure you want to delete this ticket?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      
      try {
        final user = await SharedPrefsHelper.getUser();
        if (user == null || user.id.isEmpty) {
          throw Exception('User not found. Please login again.');
        }
        
        final success = await TicketApiService.deleteTicket(ticket.id, user.id);
        
        if (success) {
          setState(() {
            _userMovieTickets.remove(ticket);
            _isLoading = false;
          });
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ticket deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
        } else {
          setState(() => _isLoading = false);
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to delete ticket'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        setState(() => _isLoading = false);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString().replaceAll('Exception: ', '')}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _deleteBus(BusTicket ticket) {
    setState(() => _userBusTickets.remove(ticket));
  }

  void _showAddTicketDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Ticket'),
        content: const Text('What type of ticket would you like to post?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToSellBusTicket();
            },
            child: const Text('Bus Ticket'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToSellMovieTicket();
            },
            child: const Text('Movie Ticket'),
          ),
        ],
      ),
    );
  }

  void _navigateToSellMovieTicket() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SellMovieTicket()),
    );
    
    if (result == true) {
      _loadTickets();
    }
  }

  void _navigateToSellBusTicket() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SellBusTicket()),
    );
    
    if (result == true) {
      _loadTickets();
    }
  }
}