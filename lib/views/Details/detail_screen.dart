// // // import 'package:backup_ticket/widget/payment_popup_widget.dart';
// // // import 'package:backup_ticket/widget/ticket_painter_widget.dart';
// // // import 'package:flutter/material.dart';
// // // class DetailScreen extends StatelessWidget {
// // //   const DetailScreen({super.key});

// // //   // Method to show payment popup
// // //   void _showPaymentPopup(BuildContext context) {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       isScrollControlled: true,
// // //       backgroundColor: Colors.transparent,
// // //       builder: (BuildContext context) {
// // //         return const PaymentPopup();
// // //       },
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[100],
// // //       appBar: PreferredSize(
// // //         preferredSize: const Size.fromHeight(90),
// // //         child: AppBar(
// // //           automaticallyImplyLeading: false,
// // //           elevation: 0,
// // //           flexibleSpace: ClipRRect(
// // //             borderRadius: const BorderRadius.only(
// // //               bottomLeft: Radius.circular(25),
// // //               bottomRight: Radius.circular(25),
// // //             ),
// // //             child: Container(
// // //               decoration: const BoxDecoration(
// // //                 gradient: LinearGradient(
// // //                   colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
// // //                   begin: Alignment.topLeft,
// // //                   end: Alignment.bottomRight,
// // //                 ),
// // //               ),
// // //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
// // //               child: SafeArea(
// // //                 child: Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     // Left side (location)
// // //                     Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       mainAxisAlignment: MainAxisAlignment.center,
// // //                       children: [
// // //                         Row(
// // //                           children: const [
// // //                             Icon(Icons.send, color: Colors.white, size: 18),
// // //                             SizedBox(width: 5),
// // //                             Text(
// // //                               "Hyderabad, Telangana..",
// // //                               style: TextStyle(
// // //                                 color: Colors.white,
// // //                                 fontSize: 16,
// // //                                 fontWeight: FontWeight.w600,
// // //                               ),
// // //                             ),
// // //                             Icon(
// // //                               Icons.keyboard_arrow_down,
// // //                               color: Colors.white,
// // //                               size: 20,
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         SizedBox(height: 2),
// // //                         const Text(
// // //                           "       Hyderabad, Telangana, India",
// // //                           style: TextStyle(color: Colors.white, fontSize: 12),
// // //                         ),
// // //                       ],
// // //                     ),

// // //                     // Right side (notification)
// // //                     Container(
// // //                       padding: const EdgeInsets.all(8),
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white,
// // //                         shape: BoxShape.circle,
// // //                         boxShadow: [
// // //                           BoxShadow(
// // //                             color: Colors.black26,
// // //                             blurRadius: 4,
// // //                             offset: Offset(0, 2),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       child: const Icon(
// // //                         Icons.notifications_none,
// // //                         color: Colors.black87,
// // //                         size: 22,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Column(
// // //           children: [
// // //             // Back button
// // //             Padding(
// // //               padding: const EdgeInsets.all(16.0),
// // //               child: Align(
// // //                 alignment: Alignment.centerLeft,
// // //                 child: GestureDetector(
// // //                   onTap: () => Navigator.pop(context),
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.all(10.0),
// // //                     child: Container(
// // //                       width: 40,
// // //                       height: 40,
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white,
// // //                         border: Border.all(),
// // //                         borderRadius: BorderRadius.circular(8),
// // //                       ),
// // //                       child: Center(
// // //                         child: Transform.translate(
// // //                           offset: Offset(4, 0),
// // //                           child: Icon(
// // //                             Icons.arrow_back_ios,
// // //                             color: Colors.black87,
// // //                             size: 18,
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),

// // //             // Movie ticket card with curved design
// // //             Padding(
// // //               padding: const EdgeInsets.symmetric(horizontal: 20.0),
// // //               child: Column(
// // //                 children: [
// // //                   Container(
// // //                     width: double.infinity,
// // //                     child: CustomPaint(
// // //                       painter: TicketPainter(),
// // //                       child: Container(
// // //                         padding: const EdgeInsets.all(20.0),
// // //                         child: Column(
// // //                           children: [
// // //                             const SizedBox(height: 10),
// // //                             // Movie poster image
// // //                             Container(
// // //                               height: 280,
// // //                               width: 200,
// // //                               decoration: BoxDecoration(
// // //                                 borderRadius: BorderRadius.circular(15),
// // //                                 image: const DecorationImage(
// // //                                   image: AssetImage('assets/kubera.png'),
// // //                                   fit: BoxFit.cover,
// // //                                 ),
// // //                               ),
// // //                               child: Stack(
// // //                                 children: [
// // //                                   // Gradient overlay
// // //                                   Container(
// // //                                     decoration: BoxDecoration(
// // //                                       borderRadius: BorderRadius.circular(15),
// // //                                       gradient: LinearGradient(
// // //                                         begin: Alignment.topCenter,
// // //                                         end: Alignment.bottomCenter,
// // //                                         colors: [
// // //                                           Colors.transparent,
// // //                                           Colors.black.withOpacity(0.7),
// // //                                         ],
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             ),

// // //                             const SizedBox(height: 20),

// // //                             // Movie title
// // //                             const Text(
// // //                               'Kuberaa',
// // //                               style: TextStyle(
// // //                                 fontSize: 20,
// // //                                 fontWeight: FontWeight.w600,
// // //                                 color: Colors.black87,
// // //                               ),
// // //                             ),

// // //                             const SizedBox(height: 10),

// // //                             // Genre tags
// // //                             Row(
// // //                               mainAxisAlignment: MainAxisAlignment.center,
// // //                               children: [
// // //                                 _buildGenreTag('13+'),
// // //                                 const SizedBox(width: 8),
// // //                                 _buildGenreTag('Action'),
// // //                                 const SizedBox(width: 8),
// // //                                 _buildGenreTag('IMAX'),
// // //                               ],
// // //                             ),

// // //                             const SizedBox(height: 20),

// // //                             CustomPaint(
// // //                               painter: DottedLinePainter(),
// // //                               child: Container(
// // //                                 height: 1,
// // //                                 width: double.infinity,
// // //                               ),
// // //                             ),

// // //                             const SizedBox(height: 20),

// // //                             // Movie details
// // //                             Column(
// // //                               children: [
// // //                                 _buildDetailRow('Movie name:', 'Kuberaa'),
// // //                                 _buildDetailRow(
// // //                                   'Time & Date:',
// // //                                   '4 Aug, 8:30 PM',
// // //                                 ),
// // //                                 _buildDetailRow('Location:', 'IMAX Hyderabad'),
// // //                                 _buildDetailRow('Seat No:', 'A 11'),
// // //                               ],
// // //                             ),

// // //                             const SizedBox(height: 20),

// // //                             Row(
// // //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                               children: [
// // //                                 const Text(
// // //                                   '',
// // //                                   style: TextStyle(
// // //                                     fontSize: 14,
// // //                                     color: Colors.black54,
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),

// // //                             const SizedBox(height: 10),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),

// // //                   const SizedBox(height: 30),

// // //                   // Buy Now button - Updated to show popup
// // //                   Container(
// // //                     width: double.infinity,
// // //                     height: 55,
// // //                     child: ElevatedButton(
// // //                       onPressed: () => _showPaymentPopup(context),
// // //                       style: ElevatedButton.styleFrom(
// // //                         backgroundColor: const Color(0xFF1976D2),
// // //                         shape: RoundedRectangleBorder(
// // //                           borderRadius: BorderRadius.circular(15),
// // //                         ),
// // //                         elevation: 3,
// // //                       ),
// // //                       child: const Text(
// // //                         'Buy Now',
// // //                         style: TextStyle(
// // //                           color: Colors.white,
// // //                           fontSize: 18,
// // //                           fontWeight: FontWeight.w600,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),

// // //                   const SizedBox(height: 20),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildGenreTag(String text) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// // //       decoration: BoxDecoration(
// // //         color: const Color.fromARGB(255, 107, 107, 107),
// // //         borderRadius: BorderRadius.circular(9),
// // //       ),
// // //       child: Text(
// // //         text,
// // //         style: const TextStyle(
// // //           fontSize: 12,
// // //           fontWeight: FontWeight.w500,
// // //           color: Colors.white,
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildDetailRow(String label, String value) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 4),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //         children: [
// // //           Text(
// // //             label,
// // //             style: const TextStyle(fontSize: 14, color: Colors.black54),
// // //           ),
// // //           Text(
// // //             value,
// // //             style: const TextStyle(
// // //               fontSize: 14,
// // //               fontWeight: FontWeight.w500,
// // //               color: Colors.black87,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// // import 'package:backup_ticket/model/movie_ticket_model.dart';
// // import 'package:backup_ticket/widget/payment_popup_widget.dart';
// // import 'package:backup_ticket/widget/ticket_painter_widget.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // class DetailScreen extends StatelessWidget {
// //   final MovieTicket? ticket;
// //   final String? ticketId;

// //   const DetailScreen({
// //     super.key,
// //     this.ticket,
// //     this.ticketId,
// //   });

// //   // Method to show payment popup
// //   void _showPaymentPopup(BuildContext context, MovieTicket? ticket) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (BuildContext context) {
// //         return PaymentPopup();
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[100],
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
// //                       child: const Icon(
// //                         Icons.notifications_none,
// //                         color: Colors.black87,
// //                         size: 22,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: Consumer<MovieTicketProvider>(
// //         builder: (context, provider, child) {
// //           // Get the ticket data
// //           MovieTicket? currentTicket = ticket;

// //           // If no ticket passed but ticketId is provided, find it in provider
// //           if (currentTicket == null && ticketId != null) {
// //             try {
// //               currentTicket = provider.tickets.firstWhere(
// //                 (t) => t.id == ticketId,
// //               );
// //             } catch (e) {
// //               // Ticket not found
// //             }
// //           }

// //           // If still no ticket, show loading or error
// //           if (currentTicket == null) {
// //             return Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   if (provider.isLoading) ...[
// //                     CircularProgressIndicator(),
// //                     SizedBox(height: 16),
// //                     Text(
// //                       'Loading ticket details...',
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         color: Colors.grey[600],
// //                       ),
// //                     ),
// //                   ] else ...[
// //                     Icon(
// //                       Icons.error_outline,
// //                       size: 64,
// //                       color: Colors.grey[400],
// //                     ),
// //                     SizedBox(height: 16),
// //                     Text(
// //                       'Ticket not found',
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w500,
// //                         color: Colors.grey[600],
// //                       ),
// //                     ),
// //                     SizedBox(height: 8),
// //                     Text(
// //                       'The ticket details could not be loaded.',
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         color: Colors.grey[500],
// //                       ),
// //                     ),
// //                     SizedBox(height: 24),
// //                     ElevatedButton(
// //                       onPressed: () => Navigator.pop(context),
// //                       child: Text('Go Back'),
// //                     ),
// //                   ],
// //                 ],
// //               ),
// //             );
// //           }

// //           return SingleChildScrollView(
// //             child: Column(
// //               children: [
// //                 // Back button
// //                 Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Align(
// //                     alignment: Alignment.centerLeft,
// //                     child: GestureDetector(
// //                       onTap: () => Navigator.pop(context),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(10.0),
// //                         child: Container(
// //                           width: 40,
// //                           height: 40,
// //                           decoration: BoxDecoration(
// //                             color: Colors.white,
// //                             border: Border.all(),
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                           child: Center(
// //                             child: Transform.translate(
// //                               offset: Offset(4, 0),
// //                               child: Icon(
// //                                 Icons.arrow_back_ios,
// //                                 color: Colors.black87,
// //                                 size: 18,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),

// //                 // Movie ticket card with curved design
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
// //                   child: Column(
// //                     children: [
// //                       Container(
// //                         width: double.infinity,
// //                         child: CustomPaint(
// //                           painter: TicketPainter(),
// //                           child: Container(
// //                             padding: const EdgeInsets.all(20.0),
// //                             child: Column(
// //                               children: [
// //                                 const SizedBox(height: 10),
// //                                 // Movie poster image
// //                                 Container(
// //                                   height: 280,
// //                                   width: 200,
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: BorderRadius.circular(15),
// //                                   ),
// //                                   child: Stack(
// //                                     children: [
// //                                       ClipRRect(
// //                                         borderRadius: BorderRadius.circular(15),
// //                                         child: (currentTicket.ticketImageUrl != null &&
// //                                                currentTicket.ticketImageUrl!.isNotEmpty)
// //                                             ? Image.network(
// //                                                 currentTicket.ticketImageUrl!,
// //                                                 fit: BoxFit.cover,
// //                                                 width: double.infinity,
// //                                                 height: double.infinity,
// //                                                 loadingBuilder: (context, child, loadingProgress) {
// //                                                   if (loadingProgress == null) return child;
// //                                                   return Container(
// //                                                     color: Colors.grey[300],
// //                                                     child: Center(
// //                                                       child: CircularProgressIndicator(
// //                                                         value: loadingProgress.expectedTotalBytes != null
// //                                                             ? loadingProgress.cumulativeBytesLoaded /
// //                                                                 loadingProgress.expectedTotalBytes!
// //                                                             : null,
// //                                                       ),
// //                                                     ),
// //                                                   );
// //                                                 },
// //                                                 errorBuilder: (context, error, stackTrace) {
// //                                                   return Image.asset(
// //                                                     'assets/kubera.png',
// //                                                     fit: BoxFit.cover,
// //                                                     width: double.infinity,
// //                                                     height: double.infinity,
// //                                                     errorBuilder: (context, error, stackTrace) {
// //                                                       return Container(
// //                                                         color: Colors.grey[300],
// //                                                         child: const Icon(
// //                                                           Icons.movie,
// //                                                           size: 60,
// //                                                           color: Colors.grey,
// //                                                         ),
// //                                                       );
// //                                                     },
// //                                                   );
// //                                                 },
// //                                               )
// //                                             : Image.asset(
// //                                                 'assets/kubera.png',
// //                                                 fit: BoxFit.cover,
// //                                                 width: double.infinity,
// //                                                 height: double.infinity,
// //                                                 errorBuilder: (context, error, stackTrace) {
// //                                                   return Container(
// //                                                     color: Colors.grey[300],
// //                                                     child: const Icon(
// //                                                       Icons.movie,
// //                                                       size: 60,
// //                                                       color: Colors.grey,
// //                                                     ),
// //                                                   );
// //                                                 },
// //                                               ),
// //                                       ),
// //                                       // Gradient overlay
// //                                       Container(
// //                                         decoration: BoxDecoration(
// //                                           borderRadius: BorderRadius.circular(15),
// //                                           gradient: LinearGradient(
// //                                             begin: Alignment.topCenter,
// //                                             end: Alignment.bottomCenter,
// //                                             colors: [
// //                                               Colors.transparent,
// //                                               Colors.black.withOpacity(0.7),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),

// //                                 const SizedBox(height: 20),

// //                                 // Movie title
// //                                 Text(
// //                                   currentTicket.movieName,
// //                                   style: const TextStyle(
// //                                     fontSize: 20,
// //                                     fontWeight: FontWeight.w600,
// //                                     color: Colors.black87,
// //                                   ),
// //                                   textAlign: TextAlign.center,
// //                                 ),

// //                                 const SizedBox(height: 10),

// //                                 // Genre tags
// //                                 Row(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: [
// //                                     // _buildGenreTag(currentTicket.certification ?? '13+'),
// //                                     // const SizedBox(width: 8),
// //                                     // _buildGenreTag(currentTicket.genre ?? 'Action'),
// //                                     // const SizedBox(width: 8),
// //                                     // _buildGenreTag(currentTicket.format ?? 'IMAX'),
// //                                   ],
// //                                 ),

// //                                 const SizedBox(height: 20),

// //                                 CustomPaint(
// //                                   painter: DottedLinePainter(),
// //                                   child: Container(
// //                                     height: 1,
// //                                     width: double.infinity,
// //                                   ),
// //                                 ),

// //                                 const SizedBox(height: 20),

// //                                 // Movie details
// //                                 Column(
// //                                   children: [
// //                                     _buildDetailRow('Movie name:', currentTicket.movieName),
// //                                     _buildDetailRow(
// //                                       'Time & Date:',
// //                                       '${currentTicket.showDate ?? ''} ${currentTicket.showTime ?? ''}',
// //                                     ),
// //                                     _buildDetailRow('Location:', currentTicket.theatrePlace ?? 'N/A'),
// //                                     // _buildDetailRow('Seat No:', currentTicket.seatNo ?? 'N/A'),
// //                                     // if (currentTicket.language != null)
// //                                     //   _buildDetailRow('Language:', currentTicket.language!),
// //                                   ],
// //                                 ),

// //                                 const SizedBox(height: 20),

// //                                 Row(
// //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     Text(
// //                                       'Total Price:',
// //                                       style: const TextStyle(
// //                                         fontSize: 16,
// //                                         fontWeight: FontWeight.w500,
// //                                         color: Colors.black54,
// //                                       ),
// //                                     ),
// //                                     Text(
// //                                       '₹${currentTicket.totalPrice?.toString() ?? '0'}',
// //                                       style: const TextStyle(
// //                                         fontSize: 18,
// //                                         fontWeight: FontWeight.w600,
// //                                         color: Colors.black87,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),

// //                                 const SizedBox(height: 10),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),

// //                       const SizedBox(height: 30),

// //                       // Buy Now button - Updated to show popup with ticket data
// //                       Container(
// //                         width: double.infinity,
// //                         height: 55,
// //                         child: ElevatedButton(
// //                           onPressed: () => _showPaymentPopup(context, currentTicket),
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: const Color(0xFF1976D2),
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(15),
// //                             ),
// //                             elevation: 3,
// //                           ),
// //                           child: const Text(
// //                             'Buy Now',
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                         ),
// //                       ),

// //                       const SizedBox(height: 20),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildGenreTag(String text) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //       decoration: BoxDecoration(
// //         color: const Color.fromARGB(255, 107, 107, 107),
// //         borderRadius: BorderRadius.circular(9),
// //       ),
// //       child: Text(
// //         text,
// //         style: const TextStyle(
// //           fontSize: 12,
// //           fontWeight: FontWeight.w500,
// //           color: Colors.white,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDetailRow(String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(
// //             label,
// //             style: const TextStyle(fontSize: 14, color: Colors.black54),
// //           ),
// //           Flexible(
// //             child: Text(
// //               value,
// //               style: const TextStyle(
// //                 fontSize: 14,
// //                 fontWeight: FontWeight.w500,
// //                 color: Colors.black87,
// //               ),
// //               textAlign: TextAlign.right,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
// import 'package:backup_ticket/model/movie_ticket_model.dart';
// import 'package:backup_ticket/widget/payment_popup_widget.dart';
// import 'package:backup_ticket/widget/ticket_painter_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class DetailScreen extends StatefulWidget {
//   final MovieTicket? ticket;
//   final String? ticketId;

//   const DetailScreen({
//     super.key,
//     this.ticket,
//     this.ticketId,
//   });

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {

//     late Razorpay razorpay;
//       bool _isProcessingOrder = false;
//         int? _selectedPaymentMethod; // Changed to nullable to check if payment method is selected

//      @override
//   void initState() {
//     super.initState();
//     // Initialize Razorpay
//     razorpay = Razorpay();
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
//     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

//     // Don't set default payment method - user must select one
//     // _selectedPaymentMethod = null;
//   }

//   // Method to show payment popup
//   void _showPaymentPopup(BuildContext context, MovieTicket? ticket) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return PaymentPopup();
//       },
//     );
//   }

//     void handlePaymentErrorResponse(PaymentFailureResponse response) {

//     _showErrorSnackBar("Payment Failed: ${response.message}");
//   }

//   void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
//     // Payment successful, now process the order
//     try {
//       await _processOrder(response.paymentId);
//     } catch (e) {
//       setState(() {
//         _isProcessingOrder = false;
//       });
//       _showErrorSnackBar("Order processing failed after payment: $e");
//     }
//   }

//   void handleExternalWalletSelected(ExternalWalletResponse response) {
//     _showErrorSnackBar("External wallet selected: ${response.walletName}");
//   }

//   // Method to initiate Razorpay payment
//   void _initiateRazorpayPayment() {

//     var options = {
//       'key': 'rzp_test_BxtRNvflG06PTV', // Replace with your Razorpay key
//       'amount': '100' ,
//       'name': 'Medical App',
//       'description': 'Medicine Order Payment',
//       'retry': {'enabled': true, 'max_count': 1},
//       'send_sms_hash': true,
//       'prefill': {
//         'contact': "9961593179", // Get from user profile
//         'email': "user@example.com", // Get from user profile
//       },
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//               print("Opeeeeeeeeeeeeeeeeen$_selectedPaymentMethod");

//       razorpay.open(options);
//                     print("gsddsdjsdsjdhslkdlsdj$_selectedPaymentMethod");

//     } catch (e) {
//       setState(() {
//         _isProcessingOrder = false;
//       });
//       _showErrorSnackBar("Failed to open payment gateway: $e");
//     }
//   }

//    void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   // Method to show QR code in full screen
//   void _showQRCodeFullScreen(BuildContext context, String qrCodeUrl) {
//     showDialog(
//       context: context,
//       // backgroundColor: Colors.black87,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Stack(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text(
//                       'QR Code',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Container(
//                       width: 250,
//                       height: 250,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.grey[300]!),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           qrCodeUrl,
//                           fit: BoxFit.contain,
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Center(
//                               child: CircularProgressIndicator(
//                                 value: loadingProgress.expectedTotalBytes != null
//                                     ? loadingProgress.cumulativeBytesLoaded /
//                                         loadingProgress.expectedTotalBytes!
//                                     : null,
//                               ),
//                             );
//                           },
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               color: Colors.grey[100],
//                               child: const Icon(
//                                 Icons.qr_code,
//                                 size: 80,
//                                 color: Colors.grey,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 40,
//                 right: 20,
//                 child: IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(
//                     Icons.close,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
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
//       body: Consumer<MovieTicketProvider>(
//         builder: (context, provider, child) {
//           // Get the ticket data
//           MovieTicket? currentTicket = widget.ticket;

//           // If no ticket passed but ticketId is provided, find it in provider
//           if (currentTicket == null && widget.ticketId != null) {
//             try {
//               currentTicket = provider.tickets.firstWhere(
//                 (t) => t.id == widget.ticketId,
//               );
//             } catch (e) {
//               // Ticket not found
//             }
//           }

//           // If still no ticket, show loading or error
//           if (currentTicket == null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (provider.isLoading) ...[
//                     CircularProgressIndicator(),
//                     SizedBox(height: 16),
//                     Text(
//                       'Loading ticket details...',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ] else ...[
//                     Icon(
//                       Icons.error_outline,
//                       size: 64,
//                       color: Colors.grey[400],
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       'Ticket not found',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'The ticket details could not be loaded.',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                     SizedBox(height: 24),
//                     ElevatedButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: Text('Go Back'),
//                     ),
//                   ],
//                 ],
//               ),
//             );
//           }

//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Back button
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Center(
//                             child: Transform.translate(
//                               offset: Offset(4, 0),
//                               child: Icon(
//                                 Icons.arrow_back_ios,
//                                 color: Colors.black87,
//                                 size: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Movie ticket card with curved design
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         child: CustomPaint(
//                           painter: TicketPainter(),
//                           child: Container(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Column(
//                               children: [
//                                 const SizedBox(height: 10),
//                                 // Movie poster image
//                                 Container(
//                                   height: 280,
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(15),
//                                         child: (currentTicket.ticketImageUrl != null &&
//                                                currentTicket.ticketImageUrl!.isNotEmpty)
//                                             ? Image.network(
//                                                 currentTicket.ticketImageUrl!,
//                                                 fit: BoxFit.cover,
//                                                 width: double.infinity,
//                                                 height: double.infinity,
//                                                 loadingBuilder: (context, child, loadingProgress) {
//                                                   if (loadingProgress == null) return child;
//                                                   return Container(
//                                                     color: Colors.grey[300],
//                                                     child: Center(
//                                                       child: CircularProgressIndicator(
//                                                         value: loadingProgress.expectedTotalBytes != null
//                                                             ? loadingProgress.cumulativeBytesLoaded /
//                                                                 loadingProgress.expectedTotalBytes!
//                                                             : null,
//                                                       ),
//                                                     ),
//                                                   );
//                                                 },
//                                                 errorBuilder: (context, error, stackTrace) {
//                                                   return Image.asset(
//                                                     'assets/kubera.png',
//                                                     fit: BoxFit.cover,
//                                                     width: double.infinity,
//                                                     height: double.infinity,
//                                                     errorBuilder: (context, error, stackTrace) {
//                                                       return Container(
//                                                         color: Colors.grey[300],
//                                                         child: const Icon(
//                                                           Icons.movie,
//                                                           size: 60,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       );
//                                                     },
//                                                   );
//                                                 },
//                                               )
//                                             : Image.asset(
//                                                 'assets/kubera.png',
//                                                 fit: BoxFit.cover,
//                                                 width: double.infinity,
//                                                 height: double.infinity,
//                                                 errorBuilder: (context, error, stackTrace) {
//                                                   return Container(
//                                                     color: Colors.grey[300],
//                                                     child: const Icon(
//                                                       Icons.movie,
//                                                       size: 60,
//                                                       color: Colors.grey,
//                                                     ),
//                                                   );
//                                                 },
//                                               ),
//                                       ),
//                                       // Gradient overlay
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(15),
//                                           gradient: LinearGradient(
//                                             begin: Alignment.topCenter,
//                                             end: Alignment.bottomCenter,
//                                             colors: [
//                                               Colors.transparent,
//                                               Colors.black.withOpacity(0.7),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 const SizedBox(height: 20),

//                                 // Movie title
//                                 Text(
//                                   currentTicket.movieName,
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),

//                                 const SizedBox(height: 10),

//                                 // Genre tags
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     // _buildGenreTag(currentTicket.certification ?? '13+'),
//                                     // const SizedBox(width: 8),
//                                     // _buildGenreTag(currentTicket.genre ?? 'Action'),
//                                     // const SizedBox(width: 8),
//                                     // _buildGenreTag(currentTicket.format ?? 'IMAX'),
//                                   ],
//                                 ),

//                                 const SizedBox(height: 20),

//                                 CustomPaint(
//                                   painter: DottedLinePainter(),
//                                   child: Container(
//                                     height: 1,
//                                     width: double.infinity,
//                                   ),
//                                 ),

//                                 const SizedBox(height: 20),

//                                 // Movie details
//                                 Column(
//                                   children: [
//                                     _buildDetailRow('Movie name:', currentTicket.movieName),
//                                     _buildDetailRow(
//                                       'Time & Date:',
//                                       '${currentTicket.showDate ?? ''} ${currentTicket.showTime ?? ''}',
//                                     ),
//                                     _buildDetailRow('Location:', currentTicket.theatrePlace ?? 'N/A'),
//                                     SizedBox(height: 15,)
// ,
//                                     _buildDetailRow('Total Price:',  '₹${currentTicket.totalPrice?.toString() ?? '0'}',),
//                                     // _buildDetailRow('Seat No:', currentTicket.seatNo ?? 'N/A'),
//                                     // if (currentTicket.language != null)
//                                     //   _buildDetailRow('Language:', currentTicket.language!),
//                                   ],
//                                 ),

//                                 const SizedBox(height: 20),

//                                 // QR Code section - NEW ADDITION
//                                 // if (currentTicket.qrCodeImageUrl != null &&
//                                 //     currentTicket.qrCodeImageUrl!.isNotEmpty) ...[
//                                 //   Column(
//                                 //     children: [
//                                 //       Row(
//                                 //         mainAxisAlignment: MainAxisAlignment.center,
//                                 //         children: [
//                                 //           // const Text(
//                                 //           //   'QR Code:',
//                                 //           //   style: TextStyle(
//                                 //           //     fontSize: 16,
//                                 //           //     fontWeight: FontWeight.w500,
//                                 //           //     color: Colors.black54,
//                                 //           //   ),
//                                 //           // ),
//                                 //           GestureDetector(
//                                 //             // onTap: () => _showQRCodeFullScreen(
//                                 //             //   context,
//                                 //             //   currentTicket.qrCodeImageUrl!
//                                 //             // ),
//                                 //             child: Container(
//                                 //               width: 150,
//                                 //               height: 150,
//                                 //               decoration: BoxDecoration(
//                                 //                 color: Colors.white,
//                                 //                 borderRadius: BorderRadius.circular(8),
//                                 //                 border: Border.all(
//                                 //                   color: Colors.grey[300]!,
//                                 //                   width: 1,
//                                 //                 ),
//                                 //                 boxShadow: [
//                                 //                   BoxShadow(
//                                 //                     color: Colors.grey.withOpacity(0.2),
//                                 //                     spreadRadius: 1,
//                                 //                     blurRadius: 3,
//                                 //                     offset: const Offset(0, 1),
//                                 //                   ),
//                                 //                 ],
//                                 //               ),
//                                 //               child: Stack(
//                                 //                 children: [
//                                 //                   ClipRRect(
//                                 //                     borderRadius: BorderRadius.circular(8),
//                                 //                     child: Padding(
//                                 //                       padding: const EdgeInsets.all(8.0),
//                                 //                       child: Image.network(
//                                 //                         currentTicket.qrCodeImageUrl!,
//                                 //                         width: 150,
//                                 //                         height: 150,
//                                 //                         fit: BoxFit.cover,
//                                 //                         loadingBuilder: (context, child, loadingProgress) {
//                                 //                           if (loadingProgress == null) return child;
//                                 //                           return Container(
//                                 //                             width: 80,
//                                 //                             height: 80,
//                                 //                             color: Colors.grey[200],
//                                 //                             child: const Center(
//                                 //                               child: SizedBox(
//                                 //                                 width: 20,
//                                 //                                 height: 20,
//                                 //                                 child: CircularProgressIndicator(
//                                 //                                   strokeWidth: 2,
//                                 //                                 ),
//                                 //                               ),
//                                 //                             ),
//                                 //                           );
//                                 //                         },
//                                 //                         errorBuilder: (context, error, stackTrace) {
//                                 //                           return Container(
//                                 //                             width: 80,
//                                 //                             height: 80,
//                                 //                             color: Colors.grey[200],
//                                 //                             child: const Icon(
//                                 //                               Icons.qr_code,
//                                 //                               size: 40,
//                                 //                               color: Colors.grey,
//                                 //                             ),
//                                 //                           );
//                                 //                         },
//                                 //                       ),
//                                 //                     ),
//                                 //                   ),
//                                 //                   // Tap indicator
//                                 //                   // Positioned(
//                                 //                   //   bottom: 2,
//                                 //                   //   right: 2,
//                                 //                   //   child: Container(
//                                 //                   //     padding: const EdgeInsets.all(2),
//                                 //                   //     decoration: BoxDecoration(
//                                 //                   //       color: Colors.black.withOpacity(0.7),
//                                 //                   //       borderRadius: BorderRadius.circular(4),
//                                 //                   //     ),
//                                 //                   //     // child: const Icon(
//                                 //                   //     //   Icons.zoom_in,
//                                 //                   //     //   color: Colors.white,
//                                 //                   //     //   size: 12,
//                                 //                   //     // ),
//                                 //                   //   ),
//                                 //                   // ),
//                                 //                 ],
//                                 //               ),
//                                 //             ),
//                                 //           ),
//                                 //         ],
//                                 //       ),
//                                 //       const SizedBox(height: 8),
//                                 //       // const Text(
//                                 //       //   'Tap QR code to view full size',
//                                 //       //   style: TextStyle(
//                                 //       //     fontSize: 12,
//                                 //       //     color: Colors.grey,
//                                 //       //     fontStyle: FontStyle.italic,
//                                 //       //   ),
//                                 //       // ),
//                                 //       const SizedBox(height: 20),
//                                 //     ],
//                                 //   ),
//                                 // ],

//                                 // Row(
//                                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 //   children: [
//                                 //     Text(
//                                 //       'Total Price:',
//                                 //       style: const TextStyle(
//                                 //         fontSize: 16,
//                                 //         fontWeight: FontWeight.w500,
//                                 //         color: Colors.black54,
//                                 //       ),
//                                 //     ),
//                                 //     Text(
//                                 //       '₹${currentTicket.totalPrice?.toString() ?? '0'}',
//                                 //       style: const TextStyle(
//                                 //         fontSize: 18,
//                                 //         fontWeight: FontWeight.w600,
//                                 //         color: Colors.black87,
//                                 //       ),
//                                 //     ),
//                                 //   ],
//                                 // ),

//                                 const SizedBox(height: 10),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       // Buy Now button - Updated to show popup with ticket data
//                       Container(
//                         width: double.infinity,
//                         height: 55,
//                         child: ElevatedButton(
//                           onPressed: () => _showPaymentPopup(context, currentTicket),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF1976D2),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 3,
//                           ),
//                           child: const Text(
//                             'Buy Now',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildGenreTag(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 107, 107, 107),
//         borderRadius: BorderRadius.circular(9),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(fontSize: 14, color: Colors.black54),
//           ),
//           Flexible(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87,
//               ),
//               textAlign: TextAlign.right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
import 'package:backup_ticket/model/movie_ticket_model.dart';
import 'package:backup_ticket/services/notification_service.dart';
import 'package:backup_ticket/views/Details/qr_code_detail_screen.dart';
import 'package:backup_ticket/views/auth/login_screen.dart';
import 'package:backup_ticket/widget/payment_popup_widget.dart';
import 'package:backup_ticket/widget/ticket_painter_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DetailScreen extends StatefulWidget {
  final String? rows;
  final String? noftickets;
  final String? image;
  final MovieTicket? ticket;
  final String? ticketId;
  final int? selectedQuantity;

  const DetailScreen({
    super.key,
    this.ticket,
    this.ticketId,
    this.image,
    this.noftickets,
    this.rows,
    this.selectedQuantity = 1,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Razorpay razorpay;
  bool _isProcessingOrder = false;
  int? _selectedPaymentMethod;
  late int _purchaseQuantity; // ADD THIS
  late double _purchaseTotal;

  String _userName = "Guest";

  final paymentMethods = [
    {'name': 'Online Payment', 'icon': Icons.credit_card, 'value': 'Online'},
    {
      'name': 'Cash on Delivery',
      'icon': Icons.money,
      'value': 'Cash on Delivery',
    },
  ];

  @override
  void initState() {
    _loadUserName();
    super.initState();

    _purchaseQuantity = widget.selectedQuantity ?? 1;
    if (widget.ticket != null) {
      _purchaseTotal =
          widget.ticket!.pricePerTicket * _purchaseQuantity; // ADD THIS
    } else {
      _purchaseTotal = 0.0;
    }

    NotificationService().initialize();
    // Initialize Razorpay
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
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
    razorpay.clear();
    super.dispose();
  }

  // Razorpay event handlers
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    setState(() {
      _isProcessingOrder = false;
    });
    _showErrorSnackBar("Payment Failed: ${response.message}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    try {
      print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
      await _processTicketPurchase(response.paymentId);

      //   if (mounted) {
      //   _showPaymentPopup(context);
      // }
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar("Ticket purchase failed after payment: $e");
    }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    _showErrorSnackBar("External wallet selected: ${response.walletName}");
  }

  // Method to initiate Razorpay payment
  void _initiateRazorpayPayment(MovieTicket ticket) {
    var options = {
      'key': 'rzp_test_BxtRNvflG06PTV', // Replace with your actual Razorpay key
      // 'amount': ((ticket.totalPrice ?? 0) * 100).toInt(), // Amount in paise
      'amount': (_purchaseTotal * 100).toInt(),
      'name': 'Movie Ticket App',
      'description':
          'Movie Ticket Purchase - ${ticket.movieName} ($_purchaseQuantity tickets)',
      'send_sms_hash': true,
      'prefill': {
        'contact': "9961593179", // Get from user profile
        'email': "melvincherian0190@example.com", // Get from user profile
      },
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      print("Opening Razorpay payment gateway...");
      razorpay.open(options);
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar("Failed to open payment gateway: $e");
    }
  }

  // Future<void> _processTicketPurchase(String? paymentId) async {
  //   try {
  //     final provider = Provider.of<MovieTicketProvider>(context, listen: false);

  //     // Get ticket either from widget or provider
  //     MovieTicket? currentTicket = widget.ticket;
  //     if (currentTicket == null && widget.ticketId != null) {
  //       try {
  //         currentTicket = provider.tickets.firstWhere(
  //           (t) => t.id == widget.ticketId,
  //         );
  //       } catch (e) {
  //         currentTicket = null;
  //       }
  //     }

  //     if (currentTicket == null) {
  //       _showErrorSnackBar('Invalid ticket data');
  //       setState(() {
  //         _isProcessingOrder = false;
  //       });
  //       return;
  //     }

  //     final userId = await UserPreferences.getUserId();

  //     await FirebaseFirestore.instance.collection('orders').add({
  //       'userId': userId ?? 'guest',
  //       'movieName': currentTicket.movieName,
  //       'theatrePlace': currentTicket.theatrePlace,
  //       'showDate': currentTicket.showDate.toString(),
  //       'showTime': currentTicket.showTime,
  //       'numberOfTickets': currentTicket.numberOfTickets,
  //       'totalPrice': currentTicket.totalPrice,
  //       'paymentMethod': paymentMethods[_selectedPaymentMethod!]['value'],
  //       'paymentId': paymentId ?? 'COD',
  //       'status': 'confirmed',
  //       'createdAt': FieldValue.serverTimestamp(),
  //       'qrCodeImageUrl': currentTicket.qrCodeImageUrl,
  //       'ticketImageUrl': currentTicket.ticketImageUrl,
  //     });

  //     // Show loading dialog for COD
  //     if (_selectedPaymentMethod == 1) {
  //       _showLoadingDialog();
  //     }

  //     String paymentMethod = paymentMethods[_selectedPaymentMethod!]['value']
  //         .toString();

  //     // Simulate processing
  //     await Future.delayed(Duration(seconds: 2));

  //     if (Navigator.of(context).canPop()) {
  //       Navigator.of(context).pop(); // hide loading
  //     }

  //     _showSuccessSnackBar('Ticket purchased successfully!');
  //     _navigateToSuccessScreen(currentTicket, paymentMethod, paymentId);
  //   } catch (e) {
  //     if (Navigator.of(context).canPop()) {
  //       Navigator.of(context).pop();
  //     }
  //     _showErrorSnackBar('An error occurred while purchasing the ticket');
  //     setState(() {
  //       _isProcessingOrder = false;
  //     });
  //   }
  // }

  //   void _showPaymentPopup(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (BuildContext context) {
  //       return const PaymentPopup();
  //     },
  //   );
  // }

  Future<void> _processTicketPurchase(String? paymentId) async {
    try {
      final provider = Provider.of<MovieTicketProvider>(context, listen: false);

      MovieTicket? currentTicket = widget.ticket;
      if (currentTicket == null && widget.ticketId != null) {
        try {
          currentTicket = provider.tickets.firstWhere(
            (t) => t.id == widget.ticketId,
          );
        } catch (e) {
          currentTicket = null;
        }
      }

      if (currentTicket == null) {
        _showErrorSnackBar('Invalid ticket data');
        setState(() {
          _isProcessingOrder = false;
        });
        return;
      }

      final userId = await UserPreferences.getUserId();
      final paymentMethodName = paymentMethods[_selectedPaymentMethod!]['value']
          .toString();

      // Save order to Firestore
      DocumentReference orderRef = await FirebaseFirestore.instance
          .collection('orders')
          .add({
            'userId': userId ?? 'guest',
            'movieName': currentTicket.movieName,
            'theatrePlace': currentTicket.theatrePlace,
            'showDate': currentTicket.showDate.toString(),
            'showTime': currentTicket.showTime,
            'numberOfTickets': _purchaseQuantity,
            'totalPrice': _purchaseTotal,
            'paymentMethod': paymentMethodName,
            'paymentId': paymentId ?? 'COD',
            'status': 'confirmed',
            'createdAt': FieldValue.serverTimestamp(),
            'qrCodeImageUrl': currentTicket.qrCodeImageUrl,
            'ticketImageUrl': currentTicket.ticketImageUrl,
          });

      // Update ticket quantity in database
      final remainingTickets =
          currentTicket.numberOfTickets - _purchaseQuantity;
      if (remainingTickets > 0) {
        await provider.updateTicketQuantity(
          currentTicket.id!,
          remainingTickets,
        );
      } else {
        await provider.deleteTicket(currentTicket.id!);
      }

      // Show local notification
      await NotificationService().showTicketPurchaseNotification(
        movieName: currentTicket.movieName,
        numberOfTickets: _purchaseQuantity,
        totalPrice: _purchaseTotal,
        paymentMethod: paymentMethodName,
      );

      // Save notification to Firestore for notification history
      await NotificationService().saveNotificationToFirestore(
        userId: userId ?? 'guest',
        title: 'Ticket Purchase Successful! 🎉',
        message:
            'Your $_purchaseQuantity ticket(s) for "${currentTicket.movieName}" has been confirmed. Total: ₹$_purchaseTotal via $paymentMethodName',
        type: 'purchase',
        ticketId: orderRef.id,
        imageUrl: currentTicket.ticketImageUrl,
      );

      if (_selectedPaymentMethod == 1) {
        _showLoadingDialog();
      }

      await Future.delayed(Duration(seconds: 2));

      // _showPaymentPopup(context);

      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      _showSuccessSnackBar('Ticket purchased successfully!');
      _navigateToSuccessScreen(currentTicket, paymentMethodName, paymentId);
    } catch (e) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      _showErrorSnackBar('An error occurred while purchasing the ticket');
      setState(() {
        _isProcessingOrder = false;
      });
    }
  }

  // Future<void> _processTicketPurchase(String? paymentId) async {
  //   try {
  //     final provider = Provider.of<MovieTicketProvider>(context, listen: false);

  //     MovieTicket? currentTicket = widget.ticket;
  //     if (currentTicket == null && widget.ticketId != null) {
  //       try {
  //         currentTicket = provider.tickets.firstWhere(
  //           (t) => t.id == widget.ticketId,
  //         );
  //       } catch (e) {
  //         currentTicket = null;
  //       }
  //     }

  //     if (currentTicket == null) {
  //       _showErrorSnackBar('Invalid ticket data');
  //       setState(() {
  //         _isProcessingOrder = false;
  //       });
  //       return;
  //     }

  //     final userId = await UserPreferences.getUserId();

  //     await FirebaseFirestore.instance.collection('orders').add({
  //       'userId': userId ?? 'guest',
  //       'movieName': currentTicket.movieName,
  //       'theatrePlace': currentTicket.theatrePlace,
  //       'showDate': currentTicket.showDate.toString(),
  //       'showTime': currentTicket.showTime,
  //       'numberOfTickets': _purchaseQuantity, // CHANGE THIS LINE
  //       'totalPrice': _purchaseTotal, // CHANGE THIS LINE
  //       'paymentMethod': paymentMethods[_selectedPaymentMethod!]['value'],
  //       'paymentId': paymentId ?? 'COD',
  //       'status': 'confirmed',
  //       'createdAt': FieldValue.serverTimestamp(),
  //       'qrCodeImageUrl': currentTicket.qrCodeImageUrl,
  //       'ticketImageUrl': currentTicket.ticketImageUrl,
  //     });

  //     // ADD THIS: Update ticket quantity in database
  //     final remainingTickets =
  //         currentTicket.numberOfTickets - _purchaseQuantity;
  //     if (remainingTickets > 0) {
  //       await provider.updateTicketQuantity(
  //         currentTicket.id!,
  //         remainingTickets,
  //       );
  //     } else {
  //       await provider.deleteTicket(currentTicket.id!);
  //     }

  //     if (_selectedPaymentMethod == 1) {
  //       _showLoadingDialog();
  //     }

  //     String paymentMethod = paymentMethods[_selectedPaymentMethod!]['value']
  //         .toString();
  //     await Future.delayed(Duration(seconds: 2));

  //     if (Navigator.of(context).canPop()) {
  //       Navigator.of(context).pop();
  //     }

  //     _showSuccessSnackBar('Ticket purchased successfully!');
  //     _navigateToSuccessScreen(currentTicket, paymentMethod, paymentId);
  //   } catch (e) {
  //     if (Navigator.of(context).canPop()) {
  //       Navigator.of(context).pop();
  //     }
  //     _showErrorSnackBar('An error occurred while purchasing the ticket');
  //     setState(() {
  //       _isProcessingOrder = false;
  //     });
  //   }
  // }
  // Navigate to success screen
  // void _navigateToSuccessScreen(
  //   MovieTicket ticket,
  //   String paymentMethod,
  //   String? paymentId,
  // ) {
  //   // Replace this with your actual success screen navigation
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Purchase Successful!'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Movie: ${ticket.movieName}'),
  //             Text('Amount: ₹${ticket.totalPrice}'),
  //             Text('Payment Method: $paymentMethod'),
  //             if (paymentId != null) Text('Payment ID: $paymentId'),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close dialog
  //               Navigator.of(context).pop(); // Go back to previous screen
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Updated _navigateToSuccessScreen method for your DetailScreen
  void _navigateToSuccessScreen(
    MovieTicket ticket,
    String paymentMethod,
    String? paymentId,
  ) {
    // Navigate to the QR Code Detail Screen instead of showing dialog
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QrCodeDetailScreen(
          ticket: ticket,
          paymentMethod: paymentMethod,
          paymentId: paymentId,
        ),
      ),
    );
  }

  Future<bool> _isUserLoggedIn() async {
    final userId = await UserPreferences.getUserId();
    return userId != null && userId != 'guest';
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Login Required',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Please login to continue with the purchase.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A6CF7),
              ),
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Also add this import at the top of your DetailScreen file:
  // import 'qr_code_detail_screen.dart'; // Adjust path as needed

  // Method to directly initiate Razorpay payment (skip payment method selection)
  // void _directRazorpayPayment(MovieTicket ticket) {
  //   if (_isProcessingOrder) return;

  //   setState(() {
  //     _isProcessingOrder = true;
  //     _selectedPaymentMethod = 0; // Set to online payment
  //   });

  //   _initiateRazorpayPayment(ticket);
  // }

  void _directRazorpayPayment(MovieTicket ticket) async {
    if (_isProcessingOrder) return;

    // Check if user is logged in
    bool isLoggedIn = await _isUserLoggedIn();
    if (!isLoggedIn) {
      _showLoginDialog();
      return;
    }

    setState(() {
      _isProcessingOrder = true;
      _selectedPaymentMethod = 0;
    });

    _initiateRazorpayPayment(ticket);
  }

  // Method to handle purchase confirmation
  Future<void> _confirmPurchase() async {
    if (_isProcessingOrder) return;

    // Check if payment method is selected
    if (_selectedPaymentMethod == null) {
      _showErrorSnackBar('Please select a payment method');
      return;
    }

    final currentTicket = widget.ticket;
    if (currentTicket == null) {
      _showErrorSnackBar('Invalid ticket data');
      return;
    }

    setState(() {
      _isProcessingOrder = true;
    });

    try {
      if (_selectedPaymentMethod == 0) {
        // Online payment - initiate Razorpay
        _initiateRazorpayPayment(currentTicket);
      } else {
        // Cash on Delivery - process directly
        await _processTicketPurchase(null);
      }
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar('An error occurred: $e');
    }
  }

  // Show payment method selection dialog
  void _showPaymentMethodDialog(MovieTicket ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Payment Method',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Ticket summary
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ticket Summary',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Movie: ${ticket.movieName}'),
                        if (ticket.showDate != null)
                          Text('Date: ${ticket.showDate}'),
                        if (ticket.showTime != null)
                          Text('Time: ${ticket.showTime}'),
                        if (ticket.theatrePlace != null)
                          Text('Theatre: ${ticket.theatrePlace}'),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '₹${ticket.totalPrice}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Payment methods
                  Text(
                    'Choose Payment Method',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),

                  ...List.generate(
                    paymentMethods.length,
                    (index) => Container(
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedPaymentMethod == index
                              ? Color(0xFF1976D2)
                              : Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: RadioListTile(
                        title: Text(
                          paymentMethods[index]['name'].toString(),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        value: index,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setModalState(() {
                            _selectedPaymentMethod = value as int;
                          });
                          setState(() {
                            _selectedPaymentMethod = value as int;
                          });
                        },
                        activeColor: Color(0xFF1976D2),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Confirm button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          _selectedPaymentMethod != null && !_isProcessingOrder
                          ? () {
                              Navigator.pop(context); // Close modal
                              _confirmPurchase();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isProcessingOrder
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Processing...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              _selectedPaymentMethod == null
                                  ? 'Select Payment Method'
                                  : 'Confirm Purchase - ₹${ticket.totalPrice}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Show loading dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                const Text(
                  'Processing your purchase...',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show success snackbar
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Show error snackbar
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Method to show QR code in full screen
  void _showQRCodeFullScreen(BuildContext context, String qrCodeUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'QR Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          qrCodeUrl,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[100],
                              child: const Icon(
                                Icons.qr_code,
                                size: 80,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                    // Left side (location)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row(
                        //   children: const [
                        //     Icon(Icons.send, color: Colors.white, size: 18),
                        //     SizedBox(width: 5),
                        //     Text(
                        //       "Hyderabad, Telangana..",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //     Icon(
                        //       Icons.keyboard_arrow_down,
                        //       color: Colors.white,
                        //       size: 20,
                        //     ),
                        //   ],
                        // ),
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
                                        profileProvider.profileImageUrl !=
                                                null &&
                                            profileProvider
                                                .profileImageUrl!
                                                .isNotEmpty
                                        ? NetworkImage(
                                            profileProvider.profileImageUrl!,
                                          )
                                        : null,
                                    backgroundColor: Colors.grey[300],
                                    child:
                                        profileProvider.profileImageUrl ==
                                                null ||
                                            profileProvider
                                                .profileImageUrl!
                                                .isEmpty
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
                        // SizedBox(height: 2),
                        // const Text(
                        //   "       Hyderabad, Telangana, India",
                        //   style: TextStyle(color: Colors.white, fontSize: 12),
                        // ),
                      ],
                    ),

                    // Right side (notification)
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
                      child: const Icon(
                        Icons.notifications_none,
                        color: Colors.black87,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<MovieTicketProvider>(
        builder: (context, provider, child) {
          // Get the ticket data
          MovieTicket? currentTicket = widget.ticket;

          // If no ticket passed but ticketId is provided, find it in provider
          if (currentTicket == null && widget.ticketId != null) {
            try {
              currentTicket = provider.tickets.firstWhere(
                (t) => t.id == widget.ticketId,
              );
            } catch (e) {
              // Ticket not found
            }
          }

          // If still no ticket, show loading or error
          if (currentTicket == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (provider.isLoading) ...[
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Loading ticket details...',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ] else ...[
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Ticket not found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'The ticket details could not be loaded.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Go Back'),
                    ),
                  ],
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Back button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Transform.translate(
                              offset: Offset(4, 0),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black87,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Movie ticket card with curved design
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Container(
                        height: 660,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: TicketPainter(),
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                // Movie poster image
                                Container(
                                  height: 280,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child:
                                            (currentTicket.ticketImageUrl !=
                                                    null &&
                                                currentTicket
                                                    .ticketImageUrl!
                                                    .isNotEmpty)
                                            ? Image.network(
                                                widget.image.toString(),
                                                // currentTicket.ticketImageUrl!,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Container(
                                                    color: Colors.grey[300],
                                                    child: Center(
                                                      child: CircularProgressIndicator(
                                                        value:
                                                            loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Image.asset(
                                                        'assets/kubera.png',
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) {
                                                              return Container(
                                                                color: Colors
                                                                    .grey[300],
                                                                child: const Icon(
                                                                  Icons.movie,
                                                                  size: 60,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              );
                                                            },
                                                      );
                                                    },
                                              )
                                            : Image.asset(
                                                'assets/kubera.png',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Container(
                                                        color: Colors.grey[300],
                                                        child: const Icon(
                                                          Icons.movie,
                                                          size: 60,
                                                          color: Colors.grey,
                                                        ),
                                                      );
                                                    },
                                              ),
                                      ),
                                      // Gradient overlay
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.7),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Movie title
                                Text(
                                  currentTicket.movieName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 10),

                                const SizedBox(height: 20),

                                CustomPaint(
                                  painter: DottedLinePainter(),
                                  child: Container(
                                    height: 1,
                                    width: double.infinity,
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Movie details
                                Column(
                                  children: [
                                    _buildDetailRow(
                                      'Movie name:',
                                      currentTicket.movieName,
                                    ),

                                    _buildDetailRow(
                                      'Time & Date:',
                                      '${currentTicket.showDate != null ? DateFormat('dd MMM yyyy').format(currentTicket.showDate!) : ''} ${currentTicket.showTime ?? ''}',
                                    ),
                                    _buildDetailRow(
                                      'Location:',
                                      currentTicket.theatrePlace ?? 'N/A',
                                    ),
                                    SizedBox(height: 15),

                                    //    _buildDetailRow(
                                    //   'No of tickets:',
                                    //   '${currentTicket.numberOfTickets?.toString() ?? '0'}',
                                    // ),
                                    // _buildDetailRow(
                                    //   'No of tickets:',
                                    //   '$_purchaseQuantity', // CHANGE THIS LINE
                                    // ),
                                    _buildDetailRow(
                                      'No of tickets:',
                                      '${_purchaseQuantity != null && _purchaseQuantity! > 0 ? _purchaseQuantity : (widget.noftickets ?? 0)}',
                                    ),

                                    _buildDetailRow(
                                      'Row:',
                                      currentTicket.seatNumbers[0].split(
                                        ',',
                                      )[0], // Shows only "Row E"
                                    ),

                                     _buildDetailRow(
                                      'Language:',
                                      '${currentTicket.language}', // CHANGE THIS LINE
                                    ),

                                    _buildDetailRow(
                                      'Total Price:',
                                      '₹${_purchaseTotal.toStringAsFixed(0)}', // CHANGE THIS LINE
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Buy Now button - Updated to show payment method selection
                      // Container(
                      //   width: double.infinity,
                      //   height: 55,
                      //   child: ElevatedButton(
                      //     onPressed: _isProcessingOrder
                      //         ? null
                      //         : () {
                      //             if (currentTicket != null) {
                      //               _directRazorpayPayment(currentTicket);
                      //             }
                      //           },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: _isProcessingOrder
                      //           ? Colors.grey
                      //           : const Color(0xFF1976D2),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //       elevation: 3,
                      //     ),
                      //     child: _isProcessingOrder
                      //         ? Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               SizedBox(
                      //                 width: 20,
                      //                 height: 20,
                      //                 child: CircularProgressIndicator(
                      //                   strokeWidth: 2,
                      //                   valueColor:
                      //                       AlwaysStoppedAnimation<Color>(
                      //                         Colors.white,
                      //                       ),
                      //                 ),
                      //               ),
                      //               SizedBox(width: 12),
                      //               Text(
                      //                 'Processing...',
                      //                 style: TextStyle(
                      //                   color: Colors.white,
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.w600,
                      //                 ),
                      //               ),
                      //             ],
                      //           )
                      //         : const Text(
                      //             'Buy Now',
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           ),
                      //   ),
                      // ),
                      Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: _isProcessingOrder
                              ? null
                              : () {
                                  if (currentTicket != null) {
                                    _directRazorpayPayment(currentTicket);
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: _isProcessingOrder
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Processing...',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  'Buy Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGenreTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 107, 107, 107),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    const double dashWidth = 5;
    const double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
