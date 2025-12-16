// import 'package:backup_ticket/views/notifications/notification_screen.dart';
// import 'package:backup_ticket/widget/bus_ticket_popup_widget.dart';
// import 'package:flutter/material.dart';

// class BusDetailsScreen extends StatefulWidget {
//   final String?ticket;
//   const BusDetailsScreen({super.key,this.ticket});

//   @override
//   State<BusDetailsScreen> createState() => _BusDetailsScreenState();
// }

// class _BusDetailsScreenState extends State<BusDetailsScreen> {

// void _showSuccessPopup(BuildContext context) {
//     Navigator.pop(context);
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return const BusTicketPopupWidget();
//       },
//     );
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
//                     // Left side with back button and location
//                     Row(
//                       children: [
//                         // GestureDetector(
//                         //   onTap: () => Navigator.pop(context),
//                         //   child: const Icon(
//                         //     Icons.arrow_back_ios,
//                         //     color: Colors.white,
//                         //     size: 20,
//                         //   ),
//                         // ),
//                         const SizedBox(width: 16),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               children: const [
//                                 Icon(Icons.send, color: Colors.white, size: 18),
//                                 SizedBox(width: 5),
//                                 Text(
//                                   "Hyderabad, Telangana..",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 Icon(
//                                   Icons.keyboard_arrow_down,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 2),
//                             const Text(
//                               "       Hyderabad, Telangana, India",
//                               style: TextStyle(color: Colors.white, fontSize: 12),
//                             ),
//                           ],
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
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
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
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         // Search Bar
//                         Expanded(
//                           child: Container(
//                             margin: const EdgeInsets.all(16.0),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                             ),
//                             height: 50,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey.shade300),
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(25),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   spreadRadius: 1,
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: const Row(
//                               children: [
//                                 Icon(
//                                   Icons.search,
//                                   color: Colors.grey,
//                                   size: 20,
//                                 ),
//                                 SizedBox(width: 12),
//                                 Expanded(
//                                   child: Text(
//                                     'Search',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         // Calendar Filter Button
//                         Container(
//                           margin: const EdgeInsets.only(right: 16.0),
//                           child: const CircleAvatar(
//                             radius: 25,
//                             backgroundColor: Color(0xFF4A90E2),
//                             child: Icon(
//                               Icons.calendar_month,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     // Available Nearby Bus Tickets Section
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         'Available Nearby Bus Tickets',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // Bus Ticket Card
//                     _buildBusTicketCard(
//                       companyName: 'Orange Travels',
//                       badgeText: 'AC',
//                       badgeColor: Color(0xFFE3F2FD),
//                       badgeTextColor: Color(0xFF1976D2),
//                       fromCity: 'Hyderabad',
//                       toCity: 'Kalvakole',
//                       departureTime: '08:00',
//                       arrivalTime: '11:30',
//                       price: '₹ 200',
//                       seats: 'Seat : L11',
//                       boardingPoint: 'Boarding at',
//                       boardingLocation: 'Kukatpally, Hyderabad',
//                       destination: 'Destination',
//                       destinationLocation: 'Kakinada, Gandhi nagar',
//                     ),

//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),

//             // Buy Button at bottom
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {

//                     _showSuccessPopup(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF214194),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     elevation: 2,
//                   ),
//                   child: const Text(
//                     'Buy',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBusTicketCard({
//     required String companyName,
//     required String badgeText,
//     required Color badgeColor,
//     required Color badgeTextColor,
//     required String fromCity,
//     required String toCity,
//     required String departureTime,
//     required String arrivalTime,
//     required String price,
//     required String seats,
//     required String boardingPoint,
//     required String boardingLocation,
//     required String destination,
//     required String destinationLocation,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: ClipPath(
//         clipper: TicketClipper(),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // Company name and badge row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.directions_bus, size: 20, color: Colors.black87),
//                         SizedBox(width: 8),
//                         Text(
//                           companyName,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

//                 const SizedBox(height: 16),

//                 // Route and time row
//                 Row(
//                   children: [
//                     // Departure
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           fromCity,
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                           ),
//                         ),
//                         Text(
//                           departureTime,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),

//                     // Route line with bus icon
//                     Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 8,
//                               height: 8,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFF4A90E2),
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 height: 2,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFF4A90E2),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.all(4),
//                                       decoration: BoxDecoration(
//                                         color: Color(0xFF4A90E2),
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Icon(
//                                         Icons.directions_bus,
//                                         color: Colors.white,
//                                         size: 16,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: 8,
//                               height: 8,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFF4A90E2),
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     // Arrival
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           toCity,
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                           ),
//                         ),
//                         Text(
//                           arrivalTime,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 16),

//                 // Divider
//                 Container(
//                   height: 1,
//                   color: Colors.grey[200],
//                 ),

//                 const SizedBox(height: 12),

//                 // Price and seat row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           price,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Text(
//                           seats,
//                           style: TextStyle(
//                             color: Color(0xFF4A90E2),
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           'Select',
//                           style: TextStyle(
//                             color: Color(0xFF4A90E2),
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(width: 4),
//                         Icon(
//                           Icons.arrow_forward_ios,
//                           color: Color(0xFF4A90E2),
//                           size: 14,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Divider(),

//                 const SizedBox(height: 16),

//                 // Boarding point section
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           boardingPoint,
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       boardingLocation,
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 12),
//                 Divider(),
//                 // Destination section with divider
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           destination,
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       destinationLocation,
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TicketClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     double circleRadius = 12.0;
//     double middleY = size.height / 2;

//     // Start from top left, with rounded corner
//     path.moveTo(12, 0);
//     path.lineTo(size.width - 12, 0);
//     path.quadraticBezierTo(size.width, 0, size.width, 12);

//     // Right side - go down to middle, create semicircle cut
//     path.lineTo(size.width, middleY - circleRadius);
//     path.arcToPoint(
//       Offset(size.width, middleY + circleRadius),
//       radius: Radius.circular(circleRadius),
//       clockwise: false,
//     );

//     // Continue down right side
//     path.lineTo(size.width, size.height - 12);
//     path.quadraticBezierTo(size.width, size.height, size.width - 12, size.height);

//     // Bottom side
//     path.lineTo(12, size.height);
//     path.quadraticBezierTo(0, size.height, 0, size.height - 12);

//     // Left side - go up to middle, create semicircle cut
//     path.lineTo(0, middleY + circleRadius);
//     path.arcToPoint(
//       Offset(0, middleY - circleRadius),
//       radius: Radius.circular(circleRadius),
//       clockwise: false,
//     );

//     // Continue up left side
//     path.lineTo(0, 12);
//     path.quadraticBezierTo(0, 0, 12, 0);

//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/helper/static_helper.dart';
import 'package:backup_ticket/model/bus_ticket_model.dart';
import 'package:backup_ticket/services/notification_service.dart';
import 'package:backup_ticket/views/notifications/notification_screen.dart';
import 'package:backup_ticket/widget/bus_ticket_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class BusDetailsScreen extends StatefulWidget {
  final String? nooftickets;
  final BusTicket ticket;
  const BusDetailsScreen({super.key, required this.ticket, this.nooftickets});

  @override
  State<BusDetailsScreen> createState() => _BusDetailsScreenState();
}

class _BusDetailsScreenState extends State<BusDetailsScreen> {
  late Razorpay _razorpay;
  bool _isProcessing = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _userName;
  String? _userEmail;
  String? _userMobile;

  Future<void> _loadUserDetails() async {
    final name = await UserPreferences.getName();
    final email = await UserPreferences.getEmail();
    final mobile = await UserPreferences.getMobileNumber();

    setState(() {
      _userName = name;
      _userEmail = email;
      _userMobile = mobile;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeRazorpay();
    _loadUserDetails();
  }

  void _initializeRazorpay() {
    NotificationService().initialize();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    debugPrint('Payment Success: ${response.paymentId}');

    try {
      // Save purchase to Firebase
      await _savePurchaseToFirebase(
        paymentId: response.paymentId ?? '',
        orderId: response.orderId ?? '',
        signature: response.signature ?? '',
      );

      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _showSuccessPopup(context);
      }
    } catch (e) {
      debugPrint('Error saving purchase: $e');
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment successful but failed to save: $e'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('Payment Error: ${response.code} - ${response.message}');

    setState(() {
      _isProcessing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment Failed: ${response.message}'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: ${response.walletName}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External Wallet: ${response.walletName}')),
    );
  }

  Widget _buildContactAndPassengerSection() {
    final ticketCount = int.tryParse(widget.nooftickets ?? '1') ?? 1;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Details Section
          const Text(
            'Contact Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.person_outline,
            'Name',
            _userName ?? 'Loading...',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            Icons.email_outlined,
            'Email',
            _userEmail ?? 'Loading...',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            Icons.phone_outlined,
            'Mobile',
            _userMobile ?? 'Loading...',
          ),

          const SizedBox(height: 20),

          // Passenger Details Section
          const Text(
            'Passenger Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          _buildDetailRow(
            Icons.person_outline,
            'Name',
            widget.ticket.passengers.isNotEmpty
                ? widget.ticket.passengers[0].name
                : 'Loading...',
          ),

          _buildDetailRow(
            Icons.male_outlined,
            'Gender',
            widget.ticket.passengers.isNotEmpty
                ? widget.ticket.passengers[0].gender
                : 'Loading...',
          ),

          _buildDetailRow(
            Icons.numbers,
            'Age',
            widget.ticket.passengers.isNotEmpty
                ? widget.ticket.passengers[0].age.toString()
                : 'Loading...',
          ),

          _buildDetailRow(
            Icons.event_seat,
            'Seat',
            widget.ticket.passengers.isNotEmpty
                ? widget.ticket.passengers[0].seatNumber
                : 'Loading...',
          ),
          // _buildDetailRow(Icons.airplane_ticket, 'Number of Tickets', ticketCount.toString()),
          // const SizedBox(height: 8),
          // _buildDetailRow(Icons.person, 'Gender', widget.ticket.gender),
          // const SizedBox(height: 8),
          // _buildDetailRow(Icons.event_seat, 'Seat Number', widget.ticket.seatNumbers[0]),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF1976D2)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Future<void> _savePurchaseToFirebase({
  //   required String paymentId,
  //   required String orderId,
  //   required String signature,
  // }) async {
  //     final userId = await UserPreferences.getUserId();
  //   if (userId == null) {
  //     throw Exception('User not authenticated');
  //   }

  //   final purchaseData = {
  //     'ticketId': widget.ticket.id,
  //     'buyerId': userId,
  //     'buyerEmail': userId,
  //     'sellerId': widget.ticket.sellerId,

  //     // Ticket details
  //     'busName': widget.ticket.busName,
  //     'ticketType': widget.ticket.ticketType,
  //     'pickupPoint': widget.ticket.pickupPoint,
  //     'dropPoint': widget.ticket.dropPoint,
  //     'dateOfJourney': widget.ticket.dateOfJourney,

  //     // Payment details
  //     'paymentId': paymentId,
  //     'orderId': orderId,
  //     'signature': signature,
  //     'amount': widget.ticket.totalPrice,
  //     'currency': 'INR',
  //     'paymentStatus': 'completed',

  //     // Timestamps
  //     'purchasedAt': FieldValue.serverTimestamp(),
  //     'createdAt': FieldValue.serverTimestamp(),

  //     // Additional info
  //     'ticketImageUrl': widget.ticket.ticketImageUrl,
  //     'status': 'confirmed',
  //   };

  //   // Add to 'orders' collection
  //   await _firestore.collection('orders').add(purchaseData);

  //   // Update ticket status to sold
  //   if (widget.ticket.id != null && widget.ticket.id!.isNotEmpty) {
  //     await _firestore
  //         .collection('bus_tickets')
  //         .doc(widget.ticket.id)
  //         .update({'status': 'sold'});
  //   }
  // }

  // Future<void> _savePurchaseToFirebase({
  //   required String paymentId,
  //   required String orderId,
  //   required String signature,
  // }) async {
  //   final userId = await UserPreferences.getUserId();
  //   if (userId == null) {
  //     throw Exception('User not authenticated');
  //   }

  //   // Parse the number of tickets
  //   final ticketCount = int.tryParse(widget.nooftickets ?? '1') ?? 1;
  //   final totalAmount = widget.ticket.totalPrice * ticketCount;

  //   final purchaseData = {
  //     'ticketId': widget.ticket.id,
  //     'buyerId': userId,
  //     'buyerEmail': userId,
  //     'sellerId': widget.ticket.sellerId,

  //     // Ticket details
  //     'busName': widget.ticket.busName,
  //     'ticketType': widget.ticket.ticketType,
  //     'pickupPoint': widget.ticket.pickupPoint,
  //     'dropPoint': widget.ticket.dropPoint,
  //     'dateOfJourney': widget.ticket.dateOfJourney,
  //     'numberOfTickets': ticketCount, // Add this line
  //     // Payment details
  //     'paymentId': paymentId,
  //     'orderId': orderId,
  //     'signature': signature,
  //     'amount': totalAmount, // Use calculated total amount
  //     'pricePerTicket': widget.ticket.totalPrice, // Add this line
  //     'currency': 'INR',
  //     'paymentStatus': 'completed',

  //     // Timestamps
  //     'purchasedAt': FieldValue.serverTimestamp(),
  //     'createdAt': FieldValue.serverTimestamp(),

  //     // Additional info
  //     'ticketImageUrl': widget.ticket.ticketImageUrl,
  //     'status': 'confirmed',
  //   };

  //   await _firestore.collection('orders').add(purchaseData);

  //   if (widget.ticket.id != null && widget.ticket.id!.isNotEmpty) {
  //     await _firestore.collection('bus_tickets').doc(widget.ticket.id).update({
  //       'status': 'sold',
  //     });
  //   }
  // }

  Future<void> _savePurchaseToFirebase({
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    try {
      final userId = await UserPreferences.getUserId();
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Parse the number of tickets
      final ticketCount = int.tryParse(widget.nooftickets ?? '1') ?? 1;
      final totalAmount = widget.ticket.totalPrice * ticketCount;

      final purchaseData = {
        'ticketId': widget.ticket.id,
        'buyerId': userId,
        'buyerEmail': userId,
        'sellerId': widget.ticket.sellerId,

        // Ticket details
        'busName': widget.ticket.busName,
        'ticketType': widget.ticket.ticketType,
        'pickupPoint': widget.ticket.pickupPoint,
        'dropPoint': widget.ticket.dropPoint,
        'dateOfJourney': widget.ticket.dateOfJourney,
        'numberOfTickets': ticketCount,

        // Payment details
        'paymentId': paymentId,
        'orderId': orderId,
        'signature': signature,
        'amount': totalAmount,
        'pricePerTicket': widget.ticket.totalPrice,
        'currency': 'INR',
        'paymentStatus': 'completed',

        // Timestamps
        'purchasedAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),

        // Additional info
        'ticketImageUrl': widget.ticket.ticketImageUrl,
        'status': 'confirmed',
      };

      // Save order to Firestore
      DocumentReference orderRef = await _firestore
          .collection('orders')
          .add(purchaseData);

      // Update ticket status
      if (widget.ticket.id != null && widget.ticket.id!.isNotEmpty) {
        await _firestore.collection('bus_tickets').doc(widget.ticket.id).update(
          {'status': 'sold', 'soldAt': FieldValue.serverTimestamp()},
        );
      }

      // ========== NOTIFICATIONS ==========

      // 1. Show local push notification with bus-specific details
      await NotificationService().showBusTicketPurchaseNotification(
        busName: widget.ticket.busName,
        pickupPoint: widget.ticket.pickupPoint,
        dropPoint: widget.ticket.dropPoint,
        numberOfTickets: ticketCount,
        totalPrice: totalAmount,
        paymentMethod: 'Online Payment',
      );

      // 2. Save notification to Firestore for history
      await NotificationService().saveNotificationToFirestore(
        userId: userId,
        title: 'Bus Ticket Booked! 🚌',
        message:
            'Your $ticketCount ticket(s) for "${widget.ticket.busName}" from ${widget.ticket.pickupPoint} to ${widget.ticket.dropPoint} on ${widget.ticket.dateOfJourney} has been confirmed. Total: ₹${totalAmount.toStringAsFixed(2)}',
        type: 'purchase',
        ticketId: orderRef.id,
        imageUrl: widget.ticket.ticketImageUrl,
      );

      // ========== END NOTIFICATIONS ==========

      print('✅ Purchase saved successfully with notifications');
    } catch (e) {
      print('❌ Error in _savePurchaseToFirebase: $e');
      rethrow; // Re-throw to handle in calling function
    }
  }
  // void _openRazorpayCheckout()async {
  //   if (_isProcessing) return;

  //   setState(() {
  //     _isProcessing = true;
  //   });

  //     final userId = await UserPreferences.getUserId();
  //   if (userId == null) {
  //     setState(() {
  //       _isProcessing = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please login to purchase tickets'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   // Convert price to paise (Razorpay accepts amount in smallest currency unit)
  //   final amountInPaise = (widget.ticket.totalPrice * 100).toInt();

  //   var options = {
  //     'key': 'rzp_test_BxtRNvflG06PTV', // Replace with your Razorpay key
  //     'amount': amountInPaise,
  //     'name': 'Bus Ticket Booking',
  //     'description': '${widget.ticket.busName} - ${widget.ticket.pickupPoint} to ${widget.ticket.dropPoint}',
  //     'prefill': {
  //       'contact':'9961593179',
  //       'email': 'melvin@gmail.com',
  //     },
  //     'theme': {
  //       'color': '#1976D2',
  //     },
  //     'modal': {
  //       'ondismiss': () {
  //         setState(() {
  //           _isProcessing = false;
  //         });
  //       }
  //     }
  //   };

  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     setState(() {
  //       _isProcessing = false;
  //     });
  //     debugPrint('Error opening Razorpay: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: $e'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  //   void _openRazorpayCheckout() async {
  //   if (_isProcessing) return;

  //   setState(() {
  //     _isProcessing = true;
  //   });

  //   final userId = await UserPreferences.getUserId();
  //   if (userId == null) {
  //     setState(() {
  //       _isProcessing = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please login to purchase tickets'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   // Convert price to paise (Razorpay accepts amount in smallest currency unit)
  //   final amountInPaise = (widget.ticket.totalPrice * 100).toInt();

  //   var options = {
  //     'key': 'rzp_test_BxtRNvflG06PTV', // Replace with your Razorpay key
  //     'amount': amountInPaise,
  //     'name': 'Bus Ticket Booking',
  //     'description': '${widget.ticket.busName} - ${widget.ticket.pickupPoint} to ${widget.ticket.dropPoint}',
  //     'prefill': {
  //       'contact': '9961593179',
  //       'email': 'melvin@gmail.com',
  //     },
  //     'theme': {
  //       'color': '#1976D2',
  //     },
  //     // Remove the 'modal' configuration with ondismiss callback
  //   };

  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     setState(() {
  //       _isProcessing = false;
  //     });
  //     debugPrint('Error opening Razorpay: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: $e'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  void _openRazorpayCheckout() async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    final userId = await UserPreferences.getUserId();
    if (userId == null) {
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to purchase tickets'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Parse the number of tickets from the passed parameter
    final ticketCount = int.tryParse(widget.nooftickets ?? '1') ?? 1;

    // Calculate total amount based on ticket count
    final totalAmount = widget.ticket.totalPrice * ticketCount;

    // Convert price to paise (Razorpay accepts amount in smallest currency unit)
    final amountInPaise = (totalAmount * 100).toInt();

    var options = {
      'key': 'rzp_test_BxtRNvflG06PTV',
      'amount': amountInPaise,
      'name': 'Bus Ticket Booking',
      'description':
          '${widget.ticket.busName} - ${widget.ticket.pickupPoint} to ${widget.ticket.dropPoint} ($ticketCount ticket${ticketCount > 1 ? 's' : ''})',
      'prefill': {'contact': '9961593179', 'email': 'melvin@gmail.com'},
      'theme': {'color': '#1976D2'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      debugPrint('Error opening Razorpay: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const BusTicketPopupWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ticket.ticketType);

    // Determine badge based on ticket type
    final type = widget.ticket.ticketType.toLowerCase();

    // if ticket type starts with "non", it is NON-AC
    final isAC = !type.startsWith('non');

    final badgeText = isAC ? 'AC' : 'NON-AC';
    final badgeColor = isAC ? const Color(0xFFE3F2FD) : const Color(0xFFFFF3E0);
    final badgeTextColor = isAC
        ? const Color(0xFF1976D2)
        : const Color(0xFFFF9800);

    // Format times
    final departureTime = DateFormat('HH:mm').format(widget.ticket.createdAt);
    final arrivalTime = DateFormat('HH:mm').format(widget.ticket.dateOfJourney);
    final dateOfJourney = DateFormat(
      'MMM dd, yyyy',
    ).format(widget.ticket.dateOfJourney);

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
                    // Left side with back button and location
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.send, color: Colors.white, size: 18),
                                SizedBox(width: 5),
                                Text(
                                  "Ticket Details",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Right side (notification)
                    // Container(
                    //   padding: const EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     shape: BoxShape.circle,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black26,
                    //         blurRadius: 4,
                    //         offset: Offset(0, 2),
                    //       ),
                    //     ],
                    //   ),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => NotificationScreen(),
                    //         ),
                    //       );
                    //     },
                    //     child: const Icon(
                    //       Icons.notifications_none,
                    //       color: Colors.black87,
                    //       size: 22,
                    //     ),
                    //   ),
                    // ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Journey Date
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Color(0xFF1976D2),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Journey Date: $dateOfJourney',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Ticket Image (if available)
                    // if (widget.ticket.ticketImageUrl != null &&
                    //     widget.ticket.ticketImageUrl!.isNotEmpty)
                    //   Container(
                    //     margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    //     height: 200,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.2),
                    //           spreadRadius: 1,
                    //           blurRadius: 6,
                    //           offset: const Offset(0, 2),
                    //         ),
                    //       ],
                    //     ),
                    //     child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(12),
                    //       child: Image.network(
                    //         widget.ticket.ticketImageUrl!,
                    //         fit: BoxFit.cover,
                    //         width: double.infinity,
                    //         errorBuilder: (context, error, stackTrace) {
                    //           return Container(
                    //             color: Colors.grey[200],
                    //             child: const Center(
                    //               child: Icon(
                    //                 Icons.image_not_supported,
                    //                 size: 50,
                    //                 color: Colors.grey,
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //         loadingBuilder: (context, child, loadingProgress) {
                    //           if (loadingProgress == null) return child;
                    //           return Container(
                    //             color: Colors.grey[200],
                    //             child: Center(
                    //               child: CircularProgressIndicator(
                    //                 value: loadingProgress.expectedTotalBytes != null
                    //                     ? loadingProgress.cumulativeBytesLoaded /
                    //                         loadingProgress.expectedTotalBytes!
                    //                     : null,
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    const SizedBox(height: 20),

                    // Available Nearby Bus Tickets Section
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Ticket Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Bus Ticket Card
                    _buildBusTicketCard(
                      companyName: widget.ticket.busName,
                      badgeText: widget.ticket.ticketType,
                      badgeColor: badgeColor,
                      badgeTextColor: badgeTextColor,
                      fromCity: widget.ticket.pickupPoint,
                      toCity: widget.ticket.dropPoint,
                      departureTime: departureTime,
                      arrivalTime: arrivalTime,
                      price: '₹ ${widget.ticket.totalPrice.toStringAsFixed(0)}',
                      boardingLocation: widget.ticket.pickupPoint,
                      destinationLocation: widget.ticket.dropPoint,
                    ),

                    const SizedBox(height: 20),

                    _buildContactAndPassengerSection(),
                  ],
                ),
              ),
            ),

            // Buy Button at bottom
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Price summary
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text(
                  //       'Total Amount',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w500,
                  //         color: Colors.black87,
                  //       ),
                  //     ),
                  //     Text(
                  //       '₹ ${widget.ticket.totalPrice.toStringAsFixed(0)}',
                  //       style: const TextStyle(
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(0xFF1976D2),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // Inside the build method, replace the price summary section:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '₹ ${(widget.ticket.totalPrice * (int.tryParse(widget.nooftickets ?? '1') ?? 1)).toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isProcessing ? null : _openRazorpayCheckout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF214194),
                        disabledBackgroundColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 2,
                      ),
                      child: _isProcessing
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Proceed to Pay',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusTicketCard({
    required String companyName,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
    required String fromCity,
    required String toCity,
    required String departureTime,
    required String arrivalTime,
    required String price,
    required String boardingLocation,
    required String destinationLocation,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Company name and badge row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_bus,
                          size: 20,
                          color: Colors.black87,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          companyName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
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
                        badgeText,
                        style: TextStyle(
                          color: badgeTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Route and time row
                Row(
                  children: [
                    // Departure
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fromCity,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            departureTime,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Route line with bus icon
                    // Expanded(
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(horizontal: 8),
                    //     child: Row(
                    //       children: [
                    //         Container(
                    //           width: 8,
                    //           height: 8,
                    //           decoration: const BoxDecoration(
                    //             color: Color(0xFF4A90E2),
                    //             shape: BoxShape.circle,
                    //           ),
                    //         ),
                    //         Expanded(
                    //           child: Container(
                    //             height: 2,
                    //             decoration: const BoxDecoration(
                    //               color: Color(0xFF4A90E2),
                    //             ),
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Container(
                    //                   padding: const EdgeInsets.all(4),
                    //                   decoration: const BoxDecoration(
                    //                     color: Color(0xFF4A90E2),
                    //                     shape: BoxShape.circle,
                    //                   ),
                    //                   child: const Icon(
                    //                     Icons.directions_bus,
                    //                     color: Colors.white,
                    //                     size: 16,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         Container(
                    //           width: 8,
                    //           height: 8,
                    //           decoration: const BoxDecoration(
                    //             color: Color(0xFF4A90E2),
                    //             shape: BoxShape.circle,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // Route line with train icon
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4A90E2),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Dashed line
                                  Container(
                                    height: 2,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        final dashWidth = 4.0;
                                        final dashSpace = 3.0;
                                        final dashCount =
                                            (constraints.maxWidth /
                                                    (dashWidth + dashSpace))
                                                .floor();
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(dashCount, (
                                            index,
                                          ) {
                                            return Container(
                                              width: dashWidth,
                                              height: 2,
                                              color: Color(0xFF4A90E2),
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                  ),
                                  // Train icon in center
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF4A90E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.train,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4A90E2),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Arrival
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            toCity,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            arrivalTime,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Divider
                Container(height: 1, color: Colors.grey[200]),

                const SizedBox(height: 16),

                // Boarding point section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Boarding Point',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        boardingLocation,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Destination section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.place, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          'Destination',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        destinationLocation,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.airplane_ticket,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'No of tickets',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.nooftickets.toString(),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          'Gender',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.ticket.gender,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.event_seat,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Seat',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.ticket.seatNumbers[0],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Price display
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ticket Price',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      // Text(
                      //   price,
                      //   style: const TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //     color: Color(0xFF1976D2),
                      //   ),
                      // ),
                      Text(
                        '₹ ${(widget.ticket.totalPrice * (int.tryParse(widget.nooftickets ?? '1') ?? 1)).toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double circleRadius = 12.0;
    double middleY = size.height / 2;

    // Start from top left, with rounded corner
    path.moveTo(12, 0);
    path.lineTo(size.width - 12, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 12);

    // Right side - go down to middle, create semicircle cut
    path.lineTo(size.width, middleY - circleRadius);
    path.arcToPoint(
      Offset(size.width, middleY + circleRadius),
      radius: Radius.circular(circleRadius),
      clockwise: false,
    );

    // Continue down right side
    path.lineTo(size.width, size.height - 12);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 12,
      size.height,
    );

    // Bottom side
    path.lineTo(12, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 12);

    // Left side - go up to middle, create semicircle cut
    path.lineTo(0, middleY + circleRadius);
    path.arcToPoint(
      Offset(0, middleY - circleRadius),
      radius: Radius.circular(circleRadius),
      clockwise: false,
    );

    // Continue up left side
    path.lineTo(0, 12);
    path.quadraticBezierTo(0, 0, 12, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
