// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/views/navbar/navbar_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DetailScreen extends StatefulWidget {
//   final String movieName;
//   final String? theatrePlace;
//   final DateTime? showDate;
//   final String? showTime;
//   final String? language;
//   final String? ticketCategory;
//   final List<String> selectedSeats;
//   final double pricePerTicket;
//   final String? ticketImageUrl;
//   final int selectedQuantity;
//   final String? ticketId;
//   final String? posterImage;

//   const DetailScreen({
//     super.key,
//     required this.movieName,
//     this.theatrePlace,
//     this.showDate,
//     this.showTime,
//     this.language,
//     this.ticketCategory,
//     this.selectedSeats = const [],
//     required this.pricePerTicket,
//     this.ticketImageUrl,
//     this.selectedQuantity = 1,
//     this.ticketId,
//     this.posterImage
//   });

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   late Razorpay razorpay;
//   bool _isProcessingOrder = false;
//   String _userName = "Guest";
//   String? _profileImageUrl;
//   String? _userId;

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
//     _loadUserData();

//     // Initialize Razorpay
//     razorpay = Razorpay();
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
//     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
//   }

//   Future<void> _loadUserData() async {
//     print("kkkkkkkkkkkkkkkkkfhddddddddddddddddddddddddddd${widget.selectedSeats[0]}");
//     final user = await SharedPrefsHelper.getUser();
//     setState(() {
//       _userName = user?.fullName ?? "Guest";
//       _userId = user?.id;
//       _profileImageUrl = user?.profileImage;
//     });
//   }

//   @override
//   void dispose() {
//     razorpay.clear();
//     super.dispose();
//   }

//   // Calculate total price
//   double get _totalPrice => widget.pricePerTicket * widget.selectedQuantity;

//   // Razorpay event handlers
//   void handlePaymentErrorResponse(PaymentFailureResponse response) {
//     setState(() {
//       _isProcessingOrder = false;
//     });
//     _showErrorSnackBar("Payment Failed: ${response.message}");
//   }

//   void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
//     try {
//       await _bookTickets(response.paymentId);
//     } catch (e) {
//       setState(() {
//         _isProcessingOrder = false;
//       });
//       _showErrorSnackBar("Ticket booking failed after payment: $e");
//     }
//   }

//   void handleExternalWalletSelected(ExternalWalletResponse response) {
//     _showErrorSnackBar("External wallet selected: ${response.walletName}");
//   }

//   // Method to initiate Razorpay payment
//   void _initiateRazorpayPayment() {
//     var options = {
//       'key': 'rzp_test_BxtRNvflG06PTV',
//       'amount': (_totalPrice * 100).toInt(), // Amount in paise
//       'name': 'Movie Ticket App',
//       'description': 'Movie Ticket Purchase - ${widget.movieName} (${widget.selectedQuantity} tickets)',
//       'send_sms_hash': true,
//       'prefill': {
//         'contact': "9961593179",
//         'email': "melvincherian0190@example.com",
//       },
//       'external': {
//         'wallets': ['paytm'],
//       },
//     };

//     try {
//       print("Opening Razorpay payment gateway...");
//       razorpay.open(options);
//     } catch (e) {
//       setState(() {
//         _isProcessingOrder = false;
//       });
//       _showErrorSnackBar("Failed to open payment gateway: $e");
//     }
//   }

//   Future<void> _bookTickets(String? paymentId) async {
//     try {
//       if (_userId == null || paymentId == null) {
//         throw Exception('User ID or Payment ID is missing');
//       }

//       final response = await http.post(
//         Uri.parse('http://31.97.206.144:8127/api/auth/booktickets'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'userId': _userId,
//           'transactionId': paymentId,
//           'ticketId': widget.ticketId,
//           'quantity': widget.selectedQuantity,
//           'selectedSeats': widget.selectedSeats,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         print('Booking successful: $data');

//         setState(() {
//           _isProcessingOrder = false;
//         });

//         _showSuccessSnackBar('Ticket booked successfully!');
//         _navigateToSuccessScreen('Online Payment', paymentId);
//       } else {
//         setState(() {
//           _isProcessingOrder = false;
//         });
//         _showErrorSnackBar('Booking failed: ${response.body}');
//       }
//     } catch (e) {
//       setState(() {
//         _isProcessingOrder = false;
//       });
//       _showErrorSnackBar('An error occurred while booking: $e');
//     }
//   }

//   void _navigateToSuccessScreen(String paymentMethod, String? paymentId) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.check_circle, color: Colors.green, size: 80),
//               SizedBox(height: 20),
//               Text(
//                 'Purchase Successful!',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'Your ticket for ${widget.movieName} has been confirmed.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'Payment Method: $paymentMethod',
//                 style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//               ),
//               if (paymentId != null)
//                 Text(
//                   'Payment ID: $paymentId',
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                 ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(builder: (_) => const NavbarScreen()),
//                     (route) => false,
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF1976D2),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                 ),
//                 child: Text(
//                   'Done',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _directRazorpayPayment() async {
//     if (_isProcessingOrder) return;

//     setState(() {
//       _isProcessingOrder = true;
//     });

//     _initiateRazorpayPayment();
//   }

//   void _showSuccessSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//       ),
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
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 22,
//                               backgroundColor: Colors.white,
//                               child: CircleAvatar(
//                                 radius: 20,
//                                 backgroundImage: _profileImageUrl != null &&
//                                         _profileImageUrl!.isNotEmpty
//                                     ? NetworkImage(_profileImageUrl!)
//                                     : null,
//                                 backgroundColor: Colors.grey[300],
//                                 child: _profileImageUrl == null ||
//                                         _profileImageUrl!.isEmpty
//                                     ? const Icon(
//                                         Icons.person,
//                                         color: Colors.grey,
//                                         size: 24,
//                                       )
//                                     : null,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   "Hello,",
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 Text(
//                                   _userName,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
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
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Padding(
//             //   padding: const EdgeInsets.all(16.0),
//             //   child: Align(
//             //     alignment: Alignment.centerLeft,
//             //     child: GestureDetector(
//             //       onTap: () => Navigator.pop(context),
//             //       child: Padding(
//             //         padding: const EdgeInsets.all(10.0),
//             //         child: Container(
//             //           width: 40,
//             //           height: 40,
//             //           decoration: BoxDecoration(
//             //             color: Colors.white,
//             //             border: Border.all(),
//             //             borderRadius: BorderRadius.circular(8),
//             //           ),
//             //           child: Center(
//             //             child: Transform.translate(
//             //               offset: Offset(4, 0),
//             //               child: Icon(
//             //                 Icons.arrow_back_ios,
//             //                 color: Colors.black87,
//             //                 size: 18,
//             //               ),
//             //             ),
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 640,
//                     width: double.infinity,
//                     child: CustomPaint(
//                       painter: TicketPainter(),
//                       child: Container(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           children: [
//                             const SizedBox(height: 10),
//                             Container(
//                               height: 220,
//                               width: 200,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: widget.ticketImageUrl != null &&
//                                             widget.ticketImageUrl!.isNotEmpty
//                                         ? Image.network(
//                                             getTicketImageUrl(
//                                               widget.ticketImageUrl!,
//                                             ),
//                                             fit: BoxFit.cover,
//                                             width: double.infinity,
//                                             height: double.infinity,
//                                             loadingBuilder:
//                                                 (context, child, loadingProgress) {
//                                               if (loadingProgress == null)
//                                                 return child;
//                                               return Container(
//                                                 color: Colors.grey[300],
//                                                 child: Center(
//                                                   child: CircularProgressIndicator(
//                                                     value: loadingProgress
//                                                                 .expectedTotalBytes !=
//                                                             null
//                                                         ? loadingProgress
//                                                                 .cumulativeBytesLoaded /
//                                                             loadingProgress
//                                                                 .expectedTotalBytes!
//                                                         : null,
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                             errorBuilder:
//                                                 (context, error, stackTrace) {
//                                               return Container(
//                                                 color: Colors.grey[300],
//                                                 child: const Icon(
//                                                   Icons.movie,
//                                                   size: 60,
//                                                   color: Colors.grey,
//                                                 ),
//                                               );
//                                             },
//                                           )
//                                         : Container(
//                                             color: Colors.grey[300],
//                                             child: const Icon(
//                                               Icons.movie,
//                                               size: 60,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                   ),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15),
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Colors.transparent,
//                                           Colors.black.withOpacity(0.7),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               widget.movieName,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black87,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 10),
//                             const SizedBox(height: 20),
//                             CustomPaint(
//                               painter: DottedLinePainter(),
//                               child: Container(
//                                 height: 1,
//                                 width: double.infinity,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Column(
//                               children: [
//                                 _buildDetailRow(
//                                   'Movie name:',
//                                   widget.movieName,
//                                 ),
//                                 _buildDetailRow(
//                                   'Time & Date:',
//                                   '${widget.showDate != null ? DateFormat('dd MMM yyyy').format(widget.showDate!) : 'N/A'} ${widget.showTime ?? ''}',
//                                 ),
//                                 _buildDetailRow(
//                                   'Location:',
//                                   widget.theatrePlace ?? 'N/A',
//                                 ),
//                                 SizedBox(height: 15),
//                                 _buildDetailRow(
//                                   'No of tickets:',
//                                   '${widget.selectedQuantity}',
//                                 ),
//                                 _buildDetailRow(
//                                   'Seats:',
//                                   widget.selectedSeats.isNotEmpty
//                                       ? widget.selectedSeats.join(', ')
//                                       : 'N/A',
//                                 ),
//                                 _buildDetailRow(
//                                   'Language:',
//                                   widget.language ?? 'N/A',
//                                 ),
//                                 _buildDetailRow(
//                                   'Category:',
//                                   widget.ticketCategory ?? 'N/A',
//                                 ),
//                                 _buildDetailRow(
//                                   'Total Price:',
//                                   '₹${_totalPrice.toStringAsFixed(0)}',
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Container(
//                     width: double.infinity,
//                     height: 55,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       gradient: LinearGradient(
//                         colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     ),
//                     child: ElevatedButton(
//                       onPressed:
//                           _isProcessingOrder ? null : _directRazorpayPayment,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child: _isProcessingOrder
//                           ? Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                       Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 12),
//                                 Text(
//                                   'Processing...',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           : const Text(
//                               'Buy Now',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     print("ooooooooooooooooooooooooooooooooooooooooooooooooooo${widget.selectedSeats.length}");
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

// class TicketPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     const radius = 20.0;

//     path.moveTo(radius, 0);
//     path.lineTo(size.width - radius, 0);
//     path.arcToPoint(
//       Offset(size.width, radius),
//       radius: Radius.circular(radius),
//     );
//     path.lineTo(size.width, size.height - radius);
//     path.arcToPoint(
//       Offset(size.width - radius, size.height),
//       radius: Radius.circular(radius),
//     );
//     path.lineTo(radius, size.height);
//     path.arcToPoint(
//       Offset(0, size.height - radius),
//       radius: Radius.circular(radius),
//     );
//     path.lineTo(0, radius);
//     path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));

//     canvas.drawPath(path, paint);

//     final shadowPaint = Paint()
//       ..color = Colors.grey.withOpacity(0.3)
//       ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5);
//     canvas.drawPath(path, shadowPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class DottedLinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.grey
//       ..strokeWidth = 1;

//     const double dashWidth = 5;
//     const double dashSpace = 3;
//     double startX = 0;

//     while (startX < size.width) {
//       canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
//       startX += dashWidth + dashSpace;
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailScreen extends StatefulWidget {
  final String movieName;
  final String? theatrePlace;
  final DateTime? showDate;
  final String? showTime;
  final String? language;
  final String? ticketCategory;
  final List<String> selectedSeats;
  final double pricePerTicket;
  final String? ticketImageUrl;
  final int selectedQuantity;
  final String? ticketId;
  final String? posterImage;
  final String? ticketType;
  final String? screen;

  const DetailScreen({
    super.key,
    required this.movieName,
    this.theatrePlace,
    this.showDate,
    this.showTime,
    this.language,
    this.ticketCategory,
    this.selectedSeats = const [],
    required this.pricePerTicket,
    this.ticketImageUrl,
    this.selectedQuantity = 1,
    this.ticketId,
    this.posterImage,
    this.ticketType,
    this.screen,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Razorpay razorpay;
  bool _isProcessingOrder = false;
  String _userName = "Guest";
  String? _profileImageUrl;
  String? _userId;
  bool _showDetails = true;

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
    _loadUserData();

    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  Future<void> _loadUserData() async {
    final user = await SharedPrefsHelper.getUser();
    setState(() {
      _userName = user?.fullName ?? "Guest";
      _userId = user?.id;
      _profileImageUrl = user?.profileImage;
    });
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  double get _convenienceFeeBase => 0.0;
  double get _convenienceFeeGST => _convenienceFeeBase * 0.18;
  double get _totalConvenienceFee => _convenienceFeeBase;
  double get _ticketPrice => widget.pricePerTicket * widget.selectedQuantity;
  double get _ticketGST => _ticketPrice * 0.18;
  double get _grandTotal => _ticketPrice + _ticketGST + _totalConvenienceFee;
  double get _totalPrice => _grandTotal;

  double get _pricePerTicket => widget.pricePerTicket;

  int get _noOfTickets => widget.selectedQuantity;

  double get _baseTotal => _pricePerTicket * _noOfTickets;

  double get _convenienceCharges => _totalConvenienceFee;

  double get _finalTotal => _baseTotal + _convenienceCharges;

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    setState(() {
      _isProcessingOrder = false;
    });
    _showErrorSnackBar("Payment Failed: ${response.message}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    try {
      await _bookTickets(response.paymentId);
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar("Ticket booking failed after payment: $e");
    }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    _showErrorSnackBar("External wallet selected: ${response.walletName}");
  }

  void _initiateRazorpayPayment() {
    var options = {
      'key': 'rzp_live_S10grYJyPBnEmN',
      'amount': (_finalTotal * 100).toInt(),
      'name': 'Movie Ticket App',
      'description':
          'Backup Ticket Purchase - ${widget.movieName} (${widget.selectedQuantity} tickets)',
      'send_sms_hash': true,
      'prefill': {
        'contact': "9961593179",
        'email': "melvincherian0190@example.com",
      },
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      razorpay.open(options);
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar("Failed to open payment gateway: $e");
    }
  }

  Future<void> _bookTickets(String? paymentId) async {
    try {
      if (_userId == null || paymentId == null) {
        throw Exception('User ID or Payment ID is missing');
      }

      final response = await http.post(
        Uri.parse('http://31.97.206.144:8127/api/auth/booktickets'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': _userId,
          'transactionId': paymentId,
          'ticketId': widget.ticketId,
          'quantity': widget.selectedQuantity,
          'selectedSeats': widget.selectedSeats,
          "platformCharge": 0,
          "gstPercentage": 0,
        }),
      );

      print(
        "ppppppppppppppppppppppppppppppppppppppppppppppppp${response.body}",
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _isProcessingOrder = false;
        });
        _showSuccessSnackBar('Ticket booked successfully!');
        _navigateToSuccessScreen('Online Payment', paymentId);
      } else {
        setState(() {
          _isProcessingOrder = false;
        });
        _showErrorSnackBar('Booking failed: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar('An error occurred while booking: $e');
    }
  }

  void _navigateToSuccessScreen(String paymentMethod, String? paymentId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 80),
              SizedBox(height: 20),
              Text(
                'Purchase Successful!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Your ticket for ${widget.movieName} has been confirmed.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Payment Method: $paymentMethod',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              if (paymentId != null)
                Text(
                  'Payment ID: $paymentId',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const NavbarScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1976D2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _directRazorpayPayment() async {
    if (_isProcessingOrder) return;

    setState(() {
      _isProcessingOrder = true;
    });

    _initiateRazorpayPayment();
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.grey[900],
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Your Ticket',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Ticket Card with Semicircle Cuts
              ClipPath(
                clipper: TicketClipper(),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Top Section - Movie Details
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Movie Poster
                                Container(
                                  width: 100,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child:
                                            widget.ticketImageUrl != null &&
                                                widget
                                                    .ticketImageUrl!
                                                    .isNotEmpty
                                            ? Image.network(
                                                getTicketImageUrl(
                                                  widget.ticketImageUrl!,
                                                ),
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
                                                        child: Icon(
                                                          Icons.movie,
                                                          size: 40,
                                                        ),
                                                      );
                                                    },
                                              )
                                            : Container(
                                                color: Colors.grey[300],
                                                child: Icon(
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
                                      //         Icon(Icons.play_circle_outline, color: Colors.white, size: 16),
                                      //         SizedBox(width: 4),
                                      //         Text(
                                      //           'Watch Trailer',
                                      //           style: TextStyle(
                                      //             color: Colors.white,
                                      //             fontSize: 10,
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
                                SizedBox(width: 16),
                                // Movie Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.movieName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '${widget.language ?? 'N/A'}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                                                            SizedBox(height: 4),

                                      Text(
                                        [
                                              widget.ticketCategory,
                                              widget.ticketType,
                                            ]
                                            .where(
                                              (e) => e != null && e!.isNotEmpty,
                                            )
                                            .join(' '),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),

                                      SizedBox(height: 8),
                                      Text(
                                        '${widget.showDate != null ? DateFormat('E, dd MMM').format(widget.showDate!) : 'N/A'} | ${widget.showTime ?? 'N/A'}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        widget.theatrePlace ?? 'N/A',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Backup-Ticket',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            // Tap to hide details button
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _showDetails = !_showDetails;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF214194),
                                      Color(0xFF3F7EF3),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    _showDetails
                                        ? 'Tap to hide details'
                                        : 'Tap to show details',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        255,
                                        255,
                                        255,
                                      ),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Expandable Details Section
                      if (_showDetails) ...[
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                '${widget.selectedQuantity} Ticket(s)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                widget.screen.toString().toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.selectedSeats.isNotEmpty
                                    ? widget.selectedSeats
                                          .map((seat) {
                                            // "Row A, Seat 19" → "A19"
                                            final parts = seat.split(',');
                                            if (parts.length != 2) return seat;

                                            final row = parts[0]
                                                .replaceAll('Row', '')
                                                .trim();
                                            final number = parts[1]
                                                .replaceAll('Seat', '')
                                                .trim();

                                            return '$row$number';
                                          })
                                          .join(', ')
                                    : 'N/A',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),

                              SizedBox(height: 24),
                              Text(
                                'BOOKING ID: ${widget.ticketId ?? 'TZASAH3'}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              // SizedBox(height: 16),
                              // Container(
                              //   padding: EdgeInsets.all(12),
                              //   decoration: BoxDecoration(
                              //     color: Colors.grey[100],
                              //     borderRadius: BorderRadius.circular(8),
                              //   ),
                              //   child: Text(
                              //     'Cancellation unavailable : cut-off time of 20 minutes before showtime has passed',
                              //     textAlign: TextAlign.center,
                              //     style: TextStyle(
                              //       fontSize: 12,
                              //       color: Colors.grey[600],
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: 16),
                              // Column(
                              //   children: [
                              //     Icon(Icons.phone, color: Colors.grey[600], size: 30),
                              //     SizedBox(height: 4),
                              //     Text(
                              //       'Contact\nsupport',
                              //       textAlign: TextAlign.center,
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //         color: Colors.grey[600],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],

                      // Divider with semicircle cuts
                      SizedBox(height: 20),

                      // Bottom Section - Bill Summary
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _buildBillRow(
                              'Price per ticket',
                              '₹ ${_pricePerTicket.toStringAsFixed(2)}',
                            ),
                            SizedBox(height: 12),

                            _buildBillRow('No. of tickets', '$_noOfTickets'),
                            SizedBox(height: 12),

                            _buildBillRow(
                              'Base total',
                              '₹ ${_baseTotal.toStringAsFixed(2)}',
                            ),
                            SizedBox(height: 12),

                            _buildBillRow(
                              'Convenience charges',
                              '₹ ${_convenienceCharges.toStringAsFixed(2)}',
                            ),

                            Divider(height: 30),

                            _buildBillRow(
                              'Total amount',
                              '₹ ${_finalTotal.toStringAsFixed(2)}',
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Buy Now Button
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
                  onPressed: _isProcessingOrder ? null : _directRazorpayPayment,
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
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Buy Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBillRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// Custom Clipper for Ticket Shape with Semicircle Cuts
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 20.0;
    const semicircleRadius = 15.0;

    // Start from top-left
    path.moveTo(radius, 0);

    // Top edge
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: Radius.circular(radius),
    );

    // Right edge with semicircle cut (middle)
    double middleY = size.height * 0.68;
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
