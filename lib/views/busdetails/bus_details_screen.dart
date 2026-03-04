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
  final String?selectedSeats;
  const BusDetailsScreen({super.key, required this.ticket, this.nooftickets,this.selectedSeats});

  @override
  State<BusDetailsScreen> createState() => _BusDetailsScreenState();
}

class _BusDetailsScreenState extends State<BusDetailsScreen> {
  late Razorpay _razorpay;
  bool _isProcessing = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controllers for editable contact fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _loadUserDetails() async {
    final name = await UserPreferences.getName();
    final email = await UserPreferences.getEmail();
    final mobile = await UserPreferences.getMobileNumber();

    setState(() {
      _nameController.text = name ?? '';
      _emailController.text = email ?? '';
      _mobileController.text = mobile ?? '';
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
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    debugPrint('Payment Success: ${response.paymentId}');
    try {
      await _savePurchaseToFirebase(
        paymentId: response.paymentId ?? '',
        orderId: response.orderId ?? '',
        signature: response.signature ?? '',
      );
      if (mounted) {
        setState(() => _isProcessing = false);
        _showSuccessPopup(context);
      }
    } catch (e) {
      debugPrint('Error saving purchase: $e');
      if (mounted) {
        setState(() => _isProcessing = false);
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
    setState(() => _isProcessing = false);
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

  // ──────────────────────────────────────────────
  //  CONTACT DETAILS SECTION (editable)
  // ──────────────────────────────────────────────
  Widget _buildContactAndPassengerSection() {
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Contact Details ──
            Row(
              children: const [
                Icon(Icons.contact_mail, color: Color(0xFF1976D2), size: 20),
                SizedBox(width: 8),
                Text(
                  'Contact Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Please enter your contact information',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _nameController,
              icon: Icons.person_outline,
              label: 'Full Name',
              hint: 'Enter your full name',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),

            _buildTextField(
              controller: _emailController,
              icon: Icons.email_outlined,
              label: 'Email Address',
              hint: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email is required';
                if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(v.trim())) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            _buildTextField(
              controller: _mobileController,
              icon: Icons.phone_outlined,
              label: 'Mobile Number',
              hint: 'Enter your mobile number',
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Mobile number is required';
                }
                if (v.trim().length < 10) {
                  return 'Enter a valid mobile number';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // ── Passenger Details (read-only) ──
            Row(
              children: const [
                Icon(Icons.airline_seat_recline_normal,
                    color: Color(0xFF1976D2), size: 20),
                SizedBox(width: 8),
                Text(
                  'Passenger Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildReadOnlyRow(
              Icons.person_outline,
              'Name',
              widget.ticket.passengers.isNotEmpty
                  ? widget.ticket.passengers[0].name
                  : '-',
            ),
            _buildReadOnlyRow(
              Icons.male_outlined,
              'Gender',
              widget.ticket.passengers.isNotEmpty
                  ? widget.ticket.passengers[0].gender
                  : '-',
            ),
            _buildReadOnlyRow(
              Icons.numbers,
              'Age',
              widget.ticket.passengers.isNotEmpty
                  ? widget.ticket.passengers[0].age.toString()
                  : '-',
            ),
            _buildReadOnlyRow(
              Icons.event_seat,
              'Seat',
              widget.ticket.passengers.isNotEmpty
                  ? widget.ticket.passengers[0].seatNumber
                  : '-',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF1976D2), size: 20),
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF5F9FF),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1976D2), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildReadOnlyRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF1976D2)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        TextStyle(fontSize: 12, color: Colors.grey[600])),
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
      ),
    );
  }

  Future<void> _savePurchaseToFirebase({
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    try {
      final userId = await UserPreferences.getUserId();
      if (userId == null) throw Exception('User not authenticated');

      final ticketCount = int.tryParse(widget.nooftickets ?? '1') ?? 1;
      final totalAmount = widget.ticket.totalPrice * ticketCount;

      final purchaseData = {
        'ticketId': widget.ticket.id,
        'buyerId': userId,
        'buyerEmail': _emailController.text.trim(),
        'buyerName': _nameController.text.trim(),
        'buyerMobile': _mobileController.text.trim(),
        'sellerId': widget.ticket.sellerId,
        'busName': widget.ticket.busName,
        'ticketType': widget.ticket.ticketType,
        'pickupPoint': widget.ticket.pickupPoint,
        'dropPoint': widget.ticket.dropPoint,
        'dateOfJourney': widget.ticket.dateOfJourney,
        'numberOfTickets': ticketCount,
        'paymentId': paymentId,
        'orderId': orderId,
        'signature': signature,
        'amount': totalAmount,
        'pricePerTicket': widget.ticket.totalPrice,
        'currency': 'INR',
        'paymentStatus': 'completed',
        'purchasedAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
        'ticketImageUrl': widget.ticket.ticketImageUrl,
        'status': 'confirmed',
      };

      DocumentReference orderRef =
          await _firestore.collection('orders').add(purchaseData);

      if (widget.ticket.id != null && widget.ticket.id!.isNotEmpty) {
        await _firestore
            .collection('bus_tickets')
            .doc(widget.ticket.id)
            .update({'status': 'sold', 'soldAt': FieldValue.serverTimestamp()});
      }

      await NotificationService().showBusTicketPurchaseNotification(
        busName: widget.ticket.busName,
        pickupPoint: widget.ticket.pickupPoint,
        dropPoint: widget.ticket.dropPoint,
        numberOfTickets: ticketCount,
        totalPrice: totalAmount,
        paymentMethod: 'Online Payment',
      );

      await NotificationService().saveNotificationToFirestore(
        userId: userId,
        title: 'Bus Ticket Booked! 🚌',
        message:
            'Your $ticketCount ticket(s) for "${widget.ticket.busName}" from ${widget.ticket.pickupPoint} to ${widget.ticket.dropPoint} on ${widget.ticket.dateOfJourney} has been confirmed. Total: ₹${totalAmount.toStringAsFixed(2)}',
        type: 'purchase',
        ticketId: orderRef.id,
        imageUrl: widget.ticket.ticketImageUrl,
      );

      print('✅ Purchase saved successfully with notifications');
    } catch (e) {
      print('❌ Error in _savePurchaseToFirebase: $e');
      rethrow;
    }
  }

  void _openRazorpayCheckout() async {
    // Validate form first
    if (!(_formKey.currentState?.validate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all contact details correctly'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    final userId = await UserPreferences.getUserId();
    if (userId == null) {
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to purchase tickets'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final ticketCount = int.tryParse(widget.nooftickets ?? '1') ?? 1;
    final totalAmount = widget.ticket.totalPrice * ticketCount;
    final amountInPaise = (totalAmount * 100).toInt();

    var options = {
      'key': 'rzp_test_BxtRNvflG06PTV',
      'amount': amountInPaise,
      'name': 'Bus Ticket Booking',
      'description':
          '${widget.ticket.busName} - ${widget.ticket.pickupPoint} to ${widget.ticket.dropPoint} ($ticketCount ticket${ticketCount > 1 ? 's' : ''})',
      'prefill': {
        'contact': _mobileController.text.trim(),
        'email': _emailController.text.trim(),
        'name': _nameController.text.trim(),
      },
      'theme': {'color': '#1976D2'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() => _isProcessing = false);
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
      builder: (BuildContext context) => const BusTicketPopupWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.ticket.ticketType.toLowerCase();
    final isAC = !type.startsWith('non');
    final badgeText = isAC ? 'AC' : 'NON-AC';
    final badgeColor =
        isAC ? const Color(0xFFE3F2FD) : const Color(0xFFFFF3E0);
    final badgeTextColor =
        isAC ? const Color(0xFF1976D2) : const Color(0xFFFF9800);

    final departureTime =
        DateFormat('HH:mm').format(widget.ticket.createdAt);
    final arrivalTime =
        DateFormat('HH:mm').format(widget.ticket.dateOfJourney);
    final dateOfJourney =
        DateFormat('MMM dd, yyyy').format(widget.ticket.dateOfJourney);

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SafeArea(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 16),
                    // const Icon(Icons.send, color: Colors.white, size: 18),
                    const SizedBox(width: 5),
                    Row(
                      children: [
                        SizedBox(width: 65,),
                        const Text(
                          "Ticket Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Journey Date
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Color(0xFF1976D2)),
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

                    _buildBusTicketCard(
                      companyName: widget.ticket.busName,
                      badgeText: widget.ticket.ticketType,
                      badgeColor: badgeColor,
                      badgeTextColor: badgeTextColor,
                      fromCity: widget.ticket.pickupPoint,
                      toCity: widget.ticket.dropPoint,
                      departureTime: departureTime,
                      arrivalTime: arrivalTime,
                      price:
                          '₹ ${widget.ticket.totalPrice.toStringAsFixed(0)}',
                      boardingLocation: widget.ticket.pickupPoint,
                      destinationLocation: widget.ticket.dropPoint,
                    ),

                    const SizedBox(height: 20),

                    // Contact + Passenger section (editable contact)
                    _buildContactAndPassengerSection(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Pay Button
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
                      onPressed:
                          _isProcessing ? null : _openRazorpayCheckout,
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
                                Icon(Icons.shopping_cart,
                                    color: Colors.white),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.directions_bus,
                            size: 20, color: Colors.black87),
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
                          horizontal: 8, vertical: 4),
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(fromCity,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12),
                              overflow: TextOverflow.ellipsis),
                          Text(departureTime,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              )),
                        ],
                      ),
                    ),
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
                                  Container(
                                    height: 2,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        const dashWidth = 4.0;
                                        const dashSpace = 3.0;
                                        final dashCount =
                                            (constraints.maxWidth /
                                                    (dashWidth + dashSpace))
                                                .floor();
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(
                                            dashCount,
                                            (index) => Container(
                                              width: dashWidth,
                                              height: 2,
                                              color:
                                                  const Color(0xFF4A90E2),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF4A90E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.train,
                                        color: Colors.white, size: 16),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(toCity,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right),
                          Text(arrivalTime,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(height: 1, color: Colors.grey[200]),
                const SizedBox(height: 16),
                _buildInfoRow(Icons.location_on, 'Boarding Point',
                    boardingLocation),
                const SizedBox(height: 12),
                _buildInfoRow(
                    Icons.place, 'Destination', destinationLocation),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.airplane_ticket, 'No of Tickets',
                    widget.nooftickets.toString()),
                const SizedBox(height: 12),
                _buildInfoRow(
                    Icons.person, 'Gender', widget.ticket.gender),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.event_seat, 'Seat',
                    widget.ticket.seatNumbers[0]),
                const SizedBox(height: 16),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double circleRadius = 12.0;
    double middleY = size.height / 2;

    path.moveTo(12, 0);
    path.lineTo(size.width - 12, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 12);
    path.lineTo(size.width, middleY - circleRadius);
    path.arcToPoint(
      Offset(size.width, middleY + circleRadius),
      radius: Radius.circular(circleRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height - 12);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 12, size.height);
    path.lineTo(12, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 12);
    path.lineTo(0, middleY + circleRadius);
    path.arcToPoint(
      Offset(0, middleY - circleRadius),
      radius: Radius.circular(circleRadius),
      clockwise: false,
    );
    path.lineTo(0, 12);
    path.quadraticBezierTo(0, 0, 12, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}