
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:backup_ticket/helper/static_helper.dart';
import 'package:backup_ticket/model/create_movie_ticket_model.dart';
import 'package:backup_ticket/provider/movie/movie_ticket_provider.dart';
import 'package:backup_ticket/views/Sell/image_cropper_screen.dart';
import 'package:backup_ticket/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SeatSelection {
  final String row;
  final int seatNumber;
  bool isBooked;

  SeatSelection({
    required this.row,
    required this.seatNumber,
    this.isBooked = false,
  });

  @override
  String toString() => 'Row $row - Seat $seatNumber';

  String toDisplayString() => 'Row $row, Seat $seatNumber';

  String toFirebaseKey() => '${row}_$seatNumber';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatSelection &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          seatNumber == other.seatNumber;

  @override
  int get hashCode => row.hashCode ^ seatNumber.hashCode;
}

class SellMovieTicket extends StatefulWidget {
  const SellMovieTicket({super.key});

  @override
  State<SellMovieTicket> createState() => _SellMovieTicketState();
}

class _SellMovieTicketState extends State<SellMovieTicket> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _theatrePlaceController = TextEditingController();
  final _pricePerTicketController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final _qrCodeLinkController = TextEditingController();
  final _commissionController = TextEditingController();
  final _finalAmountController = TextEditingController();

  // Seat selection list
  List<SeatSelection> _selectedSeats = [];
  Map<String, bool> _bookedSeats = {};

  // Form state variables
  bool _agreeToTerms = false;
  String? _selectedMovieName;
  String? _selectedMovieId;
  String? _selectedTicketType;
  String? _selectedTicketCount = '1';
  String? _selectedLanguage;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  File? _selectedImage;
  File? _selectedQrImage;
bool _isQrCropped = false;
String? _selectedHallType;   // Screen / Audi
String? _selectedHallNumber;

final List<String> hallTypes = ['Screen', 'Audi'];
final List<String> hallNumbers = List.generate(
  50,
  (index) => (index + 1).toString(),
);


  final DateTime now = DateTime.now();


  String? _selectedCategory;

  final Map<String, List<String>> ticketCategories = {
    "Premium Seats": ["Executive", "Platinum", "Recliner"],
    "Regular Seats": ["Normal", "Gold", "Classic"],
    "Special Seats": [
      "Box",
      "Upper Balcony",
      "Lower Balcony",
      "First Class",
      "Second Class",
    ],
  };

  final List<String> languageOptions = [
    'English',
    'Hindi',
    'Telugu',
    'Tamil',
    'Malayalam',
    'Kannada',
    'Bengali',
    'Marathi',
    'Gujarati',
    'Punjabi',
    'Other',
  ];

  final List<String> rowOptions = List.generate(
    26,
    (index) => String.fromCharCode(65 + index),
  );

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _pricePerTicketController.addListener(_calculateTotalPrice);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieTicketProviderapi>(context, listen: false)
          .fetchMovieNames();
    });
  }

  Future<bool> _isUserLoggedIn() async {
    final userId = await SharedPrefsHelper.getUser();
    return userId != null && userId != 'guest';
  }



//   Future<void> _pickImage({bool isQrCode = false}) async {
//   try {
//     final XFile? image = await _picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 1800,
//       maxHeight: 1800,
//       imageQuality: 85,
//     );
//     if (image != null) {
//       // Navigate to cropper screen
//       final result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ImageCropperScreen(
//             imageFile: File(image.path),
//             isQrCrop: true,
//           ),
//         ),
//       );
      
//       if (result != null && result is Map<String, File>) {
//         setState(() {
//           _selectedImage = result['fullImage'];
//           _selectedQrImage = result['qrImage'];
//           _isQrCropped = true;
//         });
//       }
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error picking image: $e')),
//     );
//   }
// }



Future<void> _pickImage({bool isQrCode = false}) async {
  try {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 85,
    );
    if (image != null) {
      // Navigate to cropper screen - FIX: Use correct class name
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageCropperScreen(  // Changed from CropperScreen
            imageFile: File(image.path),
            isQrCrop: true,
          ),
        ),
      );
      
      if (result != null && result is Map) {
        setState(() {
          _selectedImage = result['fullImage'];
          _selectedQrImage = result['qrImage'];
          _isQrCropped = true;
        });
        
        // Debug print to verify
        print('Full Image: ${_selectedImage?.path}');
        print('QR Image: ${_selectedQrImage?.path}');
        print('Is QR Cropped: $_isQrCropped');
      }
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error picking image: $e')),
    );
  }
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
            'Please login to sell tickets. Guest users cannot sell tickets.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF214194),
              ),
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

Future<void> _loadUserData() async {
  final user = await SharedPrefsHelper.getUser();

  if (!mounted || user == null) return;

  setState(() {
    _fullNameController.text = user.firstName ?? '';
    _phoneController.text = user.phoneNumber ?? '';
    _emailController.text = user.email ?? '';
  });
}


  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _theatrePlaceController.dispose();
    _pricePerTicketController.dispose();
    _totalPriceController.dispose();
    _qrCodeLinkController.dispose();
    _commissionController.dispose();
    _finalAmountController.dispose();
    super.dispose();
  }

  void _calculateTotalPrice() {
    if (_pricePerTicketController.text.isNotEmpty &&
        _selectedTicketCount != null) {
      double pricePerTicket =
          double.tryParse(_pricePerTicketController.text) ?? 0;
      int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
      double totalPrice = pricePerTicket * ticketCount;

      double commission = totalPrice * 0.10;
      double finalAmount = totalPrice - commission;

      _totalPriceController.text = totalPrice.toStringAsFixed(2);
      _commissionController.text = commission.toStringAsFixed(2);
      _finalAmountController.text = finalAmount.toStringAsFixed(2);
    }
  }

  String _getBookingKey() {
    if (_selectedMovieName == null ||
        _theatrePlaceController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      return '';
    }

    String dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    String timeStr =
        '${_selectedTime!.hour.toString().padLeft(2, '0')}${_selectedTime!.minute.toString().padLeft(2, '0')}';

    return '${_selectedMovieName}_${_theatrePlaceController.text}_${dateStr}_$timeStr'
        .replaceAll(' ', '_')
        .toLowerCase();
  }

  Future<void> _fetchBookedSeats() async {
    String bookingKey = _getBookingKey();
    if (bookingKey.isEmpty) return;

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('booked_seats')
          .doc(bookingKey)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          _bookedSeats = Map<String, bool>.from(data['seats'] ?? {});
        });
      } else {
        setState(() {
          _bookedSeats = {};
        });
      }
    } catch (e) {
      print('Error fetching booked seats: $e');
      setState(() {
        _bookedSeats = {};
      });
    }
  }

  bool _isSeatBooked(String row, int seatNumber) {
    String key = '${row}_$seatNumber';
    return _bookedSeats[key] == true;
  }

  Future<bool> _bookSeatsInFirebase() async {
    String bookingKey = _getBookingKey();
    if (bookingKey.isEmpty || _selectedSeats.isEmpty) return false;

    try {
      Map<String, bool> newSeats = {};
      for (var seat in _selectedSeats) {
        newSeats[seat.toFirebaseKey()] = true;
      }

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentReference docRef = FirebaseFirestore.instance
            .collection('booked_seats')
            .doc(bookingKey);

        DocumentSnapshot snapshot = await transaction.get(docRef);

        Map<String, bool> currentSeats = {};
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          currentSeats = Map<String, bool>.from(data['seats'] ?? {});
        }

        for (var seatKey in newSeats.keys) {
          if (currentSeats[seatKey] == true) {
            throw Exception('Seat $seatKey is already booked');
          }
        }

        currentSeats.addAll(newSeats);

        transaction.set(docRef, {
          'movieName': _selectedMovieName,
          'theatrePlace': _theatrePlaceController.text,
          'showDate': DateFormat('yyyy-MM-dd').format(_selectedDate!),
          'showTime':
              '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
          'seats': currentSeats,
          'lastUpdated': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      });

      return true;
    } catch (e) {
      print('Error booking seats: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to book seats: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  // Future<void> _pickImage({bool isQrCode = false}) async {
  //   try {
  //     final XFile? image = await _picker.pickImage(
  //       source: ImageSource.gallery,
  //       maxWidth: 1800,
  //       maxHeight: 1800,
  //       imageQuality: 85,
  //     );
  //     if (image != null) {
  //       setState(() {
  //         _selectedImage = File(image.path);
  //       });
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error picking image: $e')),
  //     );
  //   }
  // }

  // Future<void> _showSeatSelectionDialog() async {
  //   if (_selectedMovieName == null ||
  //       _theatrePlaceController.text.isEmpty ||
  //       _selectedDate == null ||
  //       _selectedTime == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //           'Please fill Movie Name, Theatre Place, Show Date and Show Time first',
  //         ),
  //         backgroundColor: Colors.orange,
  //       ),
  //     );
  //     return;
  //   }

  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => const Center(child: CircularProgressIndicator()),
  //   );

  //   await _fetchBookedSeats();

  //   if (!mounted) return;
  //   Navigator.pop(context);

  //   int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
  //   List<SeatSelection> tempSelectedSeats = List.from(_selectedSeats);

  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setDialogState) {
  //           return AlertDialog(
  //             title: Text(
  //               'Select $ticketCount Seat${ticketCount > 1 ? 's' : ''}',
  //             ),
  //             content: SizedBox(
  //               width: double.maxFinite,
  //               height: MediaQuery.of(context).size.height * 0.6,
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     padding: const EdgeInsets.all(12),
  //                     decoration: BoxDecoration(
  //                       color: Colors.blue.shade50,
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         Icon(
  //                           Icons.info_outline,
  //                           color: Colors.blue.shade700,
  //                           size: 20,
  //                         ),
  //                         const SizedBox(width: 8),
  //                         Expanded(
  //                           child: Text(
  //                             'Selected: ${tempSelectedSeats.length} of $ticketCount seats',
  //                             style: TextStyle(
  //                               fontSize: 13,
  //                               color: Colors.blue.shade900,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       _buildLegendItem(Colors.grey.shade200, 'Available'),
  //                       _buildLegendItem(const Color(0xFF214194), 'Selected'),
  //                       _buildLegendItem(Colors.red.shade300, 'Booked'),
  //                     ],
  //                   ),
  //                   const SizedBox(height: 16),
  //                   Expanded(
  //                     child: ListView.builder(
  //                       itemCount: rowOptions.length,
  //                       itemBuilder: (context, index) {
  //                         final row = rowOptions[index];

  //                         return ExpansionTile(
  //                           leading: Icon(
  //                             Icons.event_seat,
  //                             color: Colors.grey.shade700,
  //                           ),
  //                           title: Text(
  //                             'Row $row',
  //                             style: const TextStyle(
  //                               fontWeight: FontWeight.w600,
  //                               fontSize: 15,
  //                             ),
  //                           ),
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.symmetric(
  //                                 horizontal: 16,
  //                                 vertical: 8,
  //                               ),
  //                               child: Wrap(
  //                                 spacing: 8,
  //                                 runSpacing: 8,
  //                                 children: List.generate(30, (seatIndex) {
  //                                   final seatNumber = seatIndex + 1;
  //                                   final seat = SeatSelection(
  //                                     row: row,
  //                                     seatNumber: seatNumber,
  //                                   );
  //                                   final isSelected = tempSelectedSeats.any(
  //                                     (s) =>
  //                                         s.row == row &&
  //                                         s.seatNumber == seatNumber,
  //                                   );
  //                                   final isBooked = _isSeatBooked(
  //                                     row,
  //                                     seatNumber,
  //                                   );

  //                                   return InkWell(
  //                                     onTap: isBooked
  //                                         ? null
  //                                         : () {
  //                                             setDialogState(() {
  //                                               if (isSelected) {
  //                                                 tempSelectedSeats.removeWhere(
  //                                                   (s) =>
  //                                                       s.row == row &&
  //                                                       s.seatNumber ==
  //                                                           seatNumber,
  //                                                 );
  //                                               } else {
  //                                                 if (tempSelectedSeats.length <
  //                                                     ticketCount) {
  //                                                   tempSelectedSeats.add(seat);
  //                                                 } else {
  //                                                   ScaffoldMessenger.of(
  //                                                     context,
  //                                                   ).showSnackBar(
  //                                                     SnackBar(
  //                                                       content: Text(
  //                                                         'You can only select $ticketCount seat(s)',
  //                                                       ),
  //                                                       duration:
  //                                                           const Duration(
  //                                                             seconds: 1,
  //                                                           ),
  //                                                     ),
  //                                                   );
  //                                                 }
  //                                               }
  //                                             });
  //                                           },
  //                                     child: Container(
  //                                       width: 45,
  //                                       height: 45,
  //                                       decoration: BoxDecoration(
  //                                         color: isBooked
  //                                             ? Colors.red.shade300
  //                                             : isSelected
  //                                                 ? const Color(0xFF214194)
  //                                                 : Colors.grey.shade200,
  //                                         borderRadius: BorderRadius.circular(8),
  //                                         border: Border.all(
  //                                           color: isBooked
  //                                               ? Colors.red.shade400
  //                                               : isSelected
  //                                                   ? const Color(0xFF214194)
  //                                                   : Colors.grey.shade400,
  //                                           width: 1.5,
  //                                         ),
  //                                       ),
  //                                       child: Center(
  //                                         child: isBooked
  //                                             ? const Icon(
  //                                                 Icons.close,
  //                                                 color: Colors.white,
  //                                                 size: 20,
  //                                               )
  //                                             : Text(
  //                                                 '$seatNumber',
  //                                                 style: TextStyle(
  //                                                   color: isSelected
  //                                                       ? Colors.white
  //                                                       : Colors.black87,
  //                                                   fontWeight: FontWeight.w600,
  //                                                   fontSize: 13,
  //                                                 ),
  //                                               ),
  //                                       ),
  //                                     ),
  //                                   );
  //                                 }),
  //                               ),
  //                             ),
  //                           ],
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: const Text('Cancel'),
  //               ),
  //               ElevatedButton(
  //                 onPressed: tempSelectedSeats.length == ticketCount
  //                     ? () {
  //                         setState(() {
  //                           _selectedSeats = List.from(tempSelectedSeats);
  //                         });
  //                         Navigator.pop(context);
  //                       }
  //                     : null,
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: const Color(0xFF214194),
  //                   disabledBackgroundColor: Colors.grey.shade300,
  //                 ),
  //                 child: const Text(
  //                   'Confirm',
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // Widget _buildLegendItem(Color color, String label) {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Container(
  //         width: 20,
  //         height: 20,
  //         decoration: BoxDecoration(
  //           color: color,
  //           borderRadius: BorderRadius.circular(4),
  //           border: Border.all(color: Colors.grey.shade400),
  //         ),
  //       ),
  //       const SizedBox(width: 6),
  //       Text(label, style: const TextStyle(fontSize: 11)),
  //     ],
  //   );
  // }



Future<void> _showSeatSelectionDialog() async {
  if (_selectedMovieName == null ||
      _theatrePlaceController.text.isEmpty ||
      _selectedDate == null ||
      _selectedTime == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Please fill Movie Name, Theatre Place, Show Date and Show Time first',
        ),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  await _fetchBookedSeats();

  if (!mounted) return;
  Navigator.pop(context);

  int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
  List<SeatSelection> tempSelectedSeats = List.from(_selectedSeats);

  await Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Scaffold(
              backgroundColor: Colors.grey.shade50,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: const Color(0xFF214194),
                leading: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Your Seats',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$_selectedMovieName • ${_theatrePlaceController.text}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildLegendItem(Colors.grey.shade200, 'Available'),
                        _buildLegendItem(const Color(0xFF214194), 'Selected'),
                        _buildLegendItem(Colors.red.shade300, 'Booked'),
                      ],
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF214194).withOpacity(0.1),
                          const Color(0xFF214194).withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF214194).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF214194),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.event_seat,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Seats Selected',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${tempSelectedSeats.length} of $ticketCount',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF214194),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (tempSelectedSeats.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.green.shade300,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tempSelectedSeats
                                  .map((s) => '${s.row}${s.seatNumber}')
                                  .join(', '),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: rowOptions.length,
                      itemBuilder: (context, index) {
                        final row = rowOptions[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF214194).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.event_seat,
                                color: const Color(0xFF214194),
                                size: 20,
                              ),
                            ),
                            title: Text(
                              'Row $row',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF214194),
                              ),
                            ),
                            subtitle: Text(
                              '30 seats available',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  alignment: WrapAlignment.center,
                                  children: List.generate(30, (seatIndex) {
                                    final seatNumber = seatIndex + 1;
                                    final seat = SeatSelection(
                                      row: row,
                                      seatNumber: seatNumber,
                                    );
                                    final isSelected = tempSelectedSeats.any(
                                      (s) =>
                                          s.row == row &&
                                          s.seatNumber == seatNumber,
                                    );
                                    final isBooked = _isSeatBooked(
                                      row,
                                      seatNumber,
                                    );

                                    return InkWell(
                                      onTap: isBooked
                                          ? null
                                          : () {
                                              setDialogState(() {
                                                if (isSelected) {
                                                  tempSelectedSeats.removeWhere(
                                                    (s) =>
                                                        s.row == row &&
                                                        s.seatNumber ==
                                                            seatNumber,
                                                  );
                                                } else {
                                                  if (tempSelectedSeats.length <
                                                      ticketCount) {
                                                    tempSelectedSeats.add(seat);
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'You can only select $ticketCount seat(s)',
                                                        ),
                                                        duration:
                                                            const Duration(
                                                              seconds: 1,
                                                            ),
                                                        backgroundColor:
                                                            Colors.orange,
                                                      ),
                                                    );
                                                  }
                                                }
                                              });
                                            },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: isBooked
                                              ? Colors.red.shade300
                                              : isSelected
                                                  ? const Color(0xFF214194)
                                                  : Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: isBooked
                                                ? Colors.red.shade400
                                                : isSelected
                                                    ? const Color(0xFF214194)
                                                    : Colors.grey.shade300,
                                            width: 2,
                                          ),
                                          boxShadow: isSelected
                                              ? [
                                                  BoxShadow(
                                                    color: const Color(0xFF214194)
                                                        .withOpacity(0.3),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ]
                                              : null,
                                        ),
                                        child: Center(
                                          child: isBooked
                                              ? const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 20,
                                                )
                                              : Text(
                                                  '$seatNumber',
                                                  style: TextStyle(
                                                    color: isSelected
                                                        ? Colors.white
                                                        : Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(
                              color: Color(0xFF214194),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFF214194),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: tempSelectedSeats.length == ticketCount
                              ? () {
                                  setState(() {
                                    _selectedSeats = List.from(tempSelectedSeats);
                                  });
                                  Navigator.pop(context);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF214194),
                            disabledBackgroundColor: Colors.grey.shade300,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            tempSelectedSeats.length == ticketCount
                                ? 'Confirm Selection'
                                : 'Select ${ticketCount - tempSelectedSeats.length} More',
                            style: TextStyle(
                              color: tempSelectedSeats.length == ticketCount
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

Widget _buildLegendItem(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1.5,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}


  Future<void> _submitForm() async {
final DateTime now = DateTime.now();

    final DateTime showDateTime = DateTime(
  _selectedDate!.year,
  _selectedDate!.month,
  _selectedDate!.day,
  _selectedTime!.hour,
  _selectedTime!.minute,
);

final Duration difference = showDateTime.difference(now);
if (difference.inMinutes < 15) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Ticket should be uploaded at least 15 minutes before show time',
      ),
      backgroundColor: Colors.red,
    ),
  );
  return;
}
    bool isLoggedIn = await _isUserLoggedIn();
    if (!isLoggedIn) {
      _showLoginDialog();
      return;
    }
if (_selectedHallType == null || _selectedHallNumber == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Please select Screen/Audi and number'),
      backgroundColor: Colors.red,
    ),
  );
  return;
}

final String hallLabel =
    '${_selectedHallType!} ${_selectedHallNumber!}';

    if (_selectedLanguage == null || _selectedLanguage!.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Please select language'),
      backgroundColor: Colors.red,
    ),
  );
  return;
}

    if (!_formKey.currentState!.validate()) return;

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to terms and conditions')),
      );
      return;
    }


    // Add this validation before the try block in _submitForm()
if (_selectedImage == null || _selectedQrImage == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Please upload ticket image and crop QR code'),
      backgroundColor: Colors.red,
    ),
  );
  return;
}

    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select show date and time')),
      );
      return;
    }

    if (_selectedMovieName == null || _selectedMovieId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a movie')),
      );
      return;
    }

    int ticketCount = int.tryParse(_selectedTicketCount!) ?? 1;
    if (_selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select seats for your tickets')),
      );
      return;
    }

    if (_selectedSeats.length != ticketCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select exactly $ticketCount seat(s) matching your ticket count',
          ),
        ),
      );
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      bool seatsBooked = await _bookSeatsInFirebase();

      if (!seatsBooked) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Failed to book seats. Some seats may have been taken by another user.',
            ),
            backgroundColor: Colors.red,
          ),
        );
        await _fetchBookedSeats();
        setState(() {
          _selectedSeats.clear();
        });
        return;
      }

      final provider = Provider.of<MovieTicketProviderapi>(context, listen: false);
      final userId = await SharedPrefsHelper.getUser();

      final seatNumbers = _selectedSeats
          .map((seat) => seat.toDisplayString())
          .toList();

      // final bool success = await provider.createMovieTicket(
      //   userId: userId!.id,
      //   movieId: _selectedMovieId!,
      //   fullName: _fullNameController.text.trim(),
      //   phoneNumber: _phoneController.text.trim(),
      //   email: _emailController.text.trim(),
      //   movieName: _selectedMovieName!,
      //   language: _selectedLanguage ?? 'Not specified',
      //   theatrePlace: _theatrePlaceController.text.trim(),
      //   showDate: _selectedDate!,
      //   showTime:
      //       '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
      //   ticketCategory: _selectedCategory!,
      //   noOfTickets: ticketCount,
      //   selectedSeats: seatNumbers,
      //   pricePerTicket: int.tryParse(_pricePerTicketController.text) ?? 0,
      //   totalPrice: int.tryParse(_totalPriceController.text.split('.')[0]) ?? 0,
      //   qrCodeLink: _qrCodeLinkController.text.trim().isNotEmpty
      //       ? _qrCodeLinkController.text.trim()
      //       : '',
      //   termsAndConditionsAccepted: _agreeToTerms,
      //   ticketImage: _selectedImage,
      // );

      final bool success = await provider.createMovieTicket(
  userId: userId!.id,
  movieId: _selectedMovieId!,
  fullName: _fullNameController.text.trim(),
  phoneNumber: _phoneController.text.trim(),
  email: _emailController.text.trim(),
  movieName: _selectedMovieName!,
  language: _selectedLanguage ?? 'Not specified',
  theatrePlace: _theatrePlaceController.text.trim(),
  showDate: _selectedDate!,
  showTime:
      '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',

  /// ✅ NEW FIELDS
  screen: hallLabel,                 // "Screen 1" / "Audi 2"
  ticketType: _selectedTicketType!,  // "Executive", "Platinum", etc
  qrImage: _selectedQrImage,         // Cropped QR image (File)

  ticketCategory: _selectedCategory!,
  noOfTickets: ticketCount,
  selectedSeats: seatNumbers,
  pricePerTicket: int.tryParse(_pricePerTicketController.text) ?? 0,
  totalPrice: int.tryParse(_totalPriceController.text.split('.')[0]) ?? 0,
  qrCodeLink: _qrCodeLinkController.text.trim().isNotEmpty
      ? _qrCodeLinkController.text.trim()
      : '',
  termsAndConditionsAccepted: _agreeToTerms,
  ticketImage: _selectedImage,
);


      Navigator.pop(context);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Thanks for uploading your ticket! Our team will review and notify you once approved.',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${provider.errorMessage ?? 'Unknown error occurred'}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting ticket: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }




  void _showTermsAndConditionsDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.6,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTermsSection(
                  'Ticket Authenticity',
                  'You confirm that the ticket being sold is genuine and has been legally purchased. Any fraudulent tickets will result in account suspension.',
                ),
                const SizedBox(height: 16),
                _buildTermsSection(
                  'Platform Commission',
                  'A 10% platform fee will be deducted from the total ticket price. The remaining amount will be transferred to your account after successful sale.',
                ),
                const SizedBox(height: 16),
                _buildTermsSection(
                  'Ticket Verification',
                  'All tickets are subject to verification by our team. We reserve the right to reject tickets that do not meet our standards.',
                ),
                const SizedBox(height: 16),
                _buildTermsSection(
                  'Cancellation Policy',
                  'Once a ticket is sold, it cannot be cancelled. Ensure all details are correct before listing.',
                ),
                const SizedBox(height: 16),
                _buildTermsSection(
                  'Payment Terms',
                  'Payment will be processed within 24-48 hours after the movie show time has passed and buyer confirmation is received.',
                ),
                const SizedBox(height: 16),
                _buildTermsSection(
                  'Liability',
                  'The platform is not responsible for any disputes between buyer and seller. Users are responsible for providing accurate ticket information.',
                ),
                const SizedBox(height: 16),
                _buildTermsSection(
                  'Prohibited Activities',
                  'Selling counterfeit tickets, price manipulation, or any fraudulent activities are strictly prohibited and may result in legal action.',
                ),
                const SizedBox(height: 16),
                _buildTermsSection(
                  'Data Privacy',
                  'Your personal information will be used only for transaction purposes and will not be shared with third parties without consent.',
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Decline',
              style: TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _agreeToTerms = true;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF214194),
            ),
            child: const Text(
              'Accept',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}



Widget _buildTermsSection(String title, String content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Color(0xFF214194),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        content,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade700,
          height: 1.4,
        ),
      ),
    ],
  );
}


void _showShareLinkSample(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// HEADER
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Text(
                  'How to get ticket link',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          /// IMAGE
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/sample.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          /// FOOTER TEXT
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 16,
            ),
            child: Text(
              'Tap on the highlighted Share option to copy your ticket link.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECEFF1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Sell Movie Tickets',
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<MovieTicketProviderapi>(
        builder: (context, ticketProvider, child) {
          final movieNames = ticketProvider.movieNames;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    'Full Name',
                    'Enter your full name',
                    _fullNameController,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Phone Number',
                    'Enter phone number',
                    _phoneController,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'E-Mail',
                    'Enter email address',
                    _emailController,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  ticketProvider.isLoading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : movieNames.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Movie Name',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.orange.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.orange.shade700,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      const Expanded(
                                        child: Text(
                                          'No movies available. Please try again later.',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : _buildMovieDropdown(movieNames),
                  const SizedBox(height: 16),
       _buildDropdownField(
  'Language',
  'Select language',
  languageOptions,
  _selectedLanguage,
  (value) {
    setState(() {
      _selectedLanguage = value;
    });
  },
  required: true, // ✅ NOW REQUIRED
),

                  const SizedBox(height: 16),
                  _buildTextField(
                    'Theatre Place',
                    'Enter theatre name/place',
                    _theatrePlaceController,
                    required: true,
                    onChanged: (value) {
                      setState(() {
                        _selectedSeats.clear();
                        _bookedSeats.clear();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDateField(
                    'Show Date',
                    _selectedDate != null
                        ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                        : 'Select show date',
                  ),
                  const SizedBox(height: 16),
                  _buildTimeField(
                    'Show Time',
                    _selectedTime != null
                        ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                        : '',
                  ),/// Screen / Audi selection
                                    const SizedBox(height: 16),

_buildDropdownField(
  'Hall Type',
  'Select Screen or Audi',
  hallTypes,
  _selectedHallType,
  (value) {
    setState(() {
      _selectedHallType = value;
      _selectedHallNumber = null; // reset number
    });
  },
  required: true,
),

const SizedBox(height: 16),

/// Screen / Audi number selection
if (_selectedHallType != null)
  _buildDropdownField(
    '${_selectedHallType} Number',
    'Select number',
    hallNumbers,
    _selectedHallNumber,
    (value) {
      setState(() {
        _selectedHallNumber = value;
      });
    },
    required: true,
  ),

                  const SizedBox(height: 16),
                  _buildDropdownField(
                    'Ticket Category',
                    'Select category',
                    ticketCategories.keys.toList(),
                    _selectedCategory,
                    (value) {
                      setState(() {
                        _selectedCategory = value;
                        _selectedTicketType = null;
                      });
                    },
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  if (_selectedCategory != null)
                    _buildDropdownField(
                      'Ticket Type',
                      'Select ticket type',
                      ticketCategories[_selectedCategory]!,
                      _selectedTicketType,
                      (value) {
                        setState(() {
                          _selectedTicketType = value;
                        });
                      },
                      required: true,
                    ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    'Number of Tickets',
                    '1',
                    ['1', '2', '3', '4', '5', '6'],
                    _selectedTicketCount,
                    (value) {
                      setState(() {
                        _selectedTicketCount = value;
                        _calculateTotalPrice();
                        _selectedSeats.clear();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSeatSelectionField(),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Price per Ticket',
                    'Enter price per ticket',
                    _pricePerTicketController,
                    required: true,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Total Price',
                    'Calculated automatically',
                    _totalPriceController,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Platform fee (10%)',
                    'Calculated automatically',
                    _commissionController,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Final Amount (You will receive)',
                    'Calculated automatically',
                    _finalAmountController,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
   Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        const Text(
          'Share your ticket link',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const Text(
          ' *',
          style: TextStyle(color: Colors.red),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _showShareLinkSample(context),
          child: const Text(
            'View Sample',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF214194),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    ),
    const SizedBox(height: 8),
    TextFormField(
      controller: _qrCodeLinkController,
      decoration: InputDecoration(
        hintText: 'Paste ticket share link here',
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF214194), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Ticket link is required';
        }
        return null;
      },
    ),
  ],
),

                  const SizedBox(height: 16),
                  _buildImagePicker(),
                  const SizedBox(height: 16),
                  _buildTermsCheckbox(),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF214194),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Submit Ticket',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    bool required = false,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            if (required)
              const Text(
                ' *',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF214194), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          validator: required
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildMovieDropdown(List<MovieName> movieNames) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Movie Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedMovieName,
          decoration: InputDecoration(
            hintText: 'Select movie',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF214194), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          items: movieNames.map((movie) {
            return DropdownMenuItem<String>(
              value: movie.movieName,
              child: Text(movie.movieName),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedMovieName = value;
              _selectedMovieId = movieNames.firstWhere(
                (movie) => movie.movieName == value,
              ).id;
              _selectedSeats.clear();
              _bookedSeats.clear();
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a movie';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    String hint,
    List<String> items,
    String? value,
    void Function(String?) onChanged, {
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            if (required)
              const Text(
                ' *',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF214194), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          validator: required
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildDateField(String label, String displayText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Show Date',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF214194),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              setState(() {
                _selectedDate = picked;
                _selectedSeats.clear();
                _bookedSeats.clear();
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  displayText,
                  style: TextStyle(
                    color: _selectedDate != null
                        ? Colors.black87
                        : Colors.grey.shade400,
                    fontSize: 14,
                  ),
                ),
                Icon(Icons.calendar_today, color: Colors.grey.shade600, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(String label, String displayText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Show Time',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: _selectedTime ?? TimeOfDay.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF214194),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              setState(() {
                _selectedTime = picked;
                _selectedSeats.clear();
                _bookedSeats.clear();
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  displayText.isEmpty ? 'Select show time' : displayText,
                  style: TextStyle(
                    color: _selectedTime != null
                        ? Colors.black87
                        : Colors.grey.shade400,
                    fontSize: 14,
                  ),
                ),
                Icon(Icons.access_time, color: Colors.grey.shade600, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeatSelectionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Seat Selection',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _showSeatSelectionDialog,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.event_seat, color: Colors.grey.shade600, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedSeats.isEmpty
                        ? 'Tap to select seats'
                        : 'Selected: ${_selectedSeats.map((s) => s.toDisplayString()).join(', ')}',
                    style: TextStyle(
                      color: _selectedSeats.isEmpty
                          ? Colors.grey.shade400
                          : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    color: Colors.grey.shade400, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildImagePicker() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Ticket Image (Optional)',
  //         style: TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.w500,
  //           color: Colors.black87,
  //         ),
  //       ),
  //       const SizedBox(height: 8),
  //       InkWell(
  //         onTap: () => _pickImage(),
  //         child: Container(
  //           height: 150,
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(8),
  //             border: Border.all(color: Colors.grey.shade300),
  //           ),
  //           child: _selectedImage != null
  //               ? ClipRRect(
  //                   borderRadius: BorderRadius.circular(8),
  //                   child: Image.file(
  //                     _selectedImage!,
  //                     fit: BoxFit.cover,
  //                   ),
  //                 )
  //               : Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(Icons.add_photo_alternate,
  //                         size: 40, color: Colors.grey.shade400),
  //                     const SizedBox(height: 8),
  //                     Text(
  //                       'Tap to upload ticket image',
  //                       style: TextStyle(
  //                         color: Colors.grey.shade600,
  //                         fontSize: 13,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //         ),
  //       ),
  //     ],
  //   );
  // }


Widget _buildImagePicker() {
  print('Building image picker - Image: ${_selectedImage != null}, QR: ${_selectedQrImage != null}, Cropped: $_isQrCropped');
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Row(
        children: [
          Text(
            'Ticket Image',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            ' *',
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ),
      const SizedBox(height: 8),
      
      // Full Ticket Image
      InkWell(
        onTap: () => _pickImage(),
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _selectedImage != null ? Colors.green.shade300 : Colors.grey.shade300,
              width: _selectedImage != null ? 2 : 1,
            ),
          ),
          child: _selectedImage != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate,
                        size: 40, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text(
                      'Tap to upload ticket image',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      
      // Show QR Code preview if cropped
      if (_selectedQrImage != null) ...[
        const SizedBox(height: 16),
        const Text(
          'Cropped QR Code',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade300, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.file(
                _selectedQrImage!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 16),
              SizedBox(width: 4),
              Text(
                'QR Code cropped successfully',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ],
  );
}

  // Widget _buildTermsCheckbox() {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Checkbox(
  //         value: _agreeToTerms,
  //         onChanged: (value) {
  //           setState(() {
  //             _agreeToTerms = value ?? false;
  //           });
  //         },
  //         activeColor: const Color(0xFF214194),
  //       ),
  //       const Expanded(
  //         child: Padding(
  //           padding: EdgeInsets.only(top: 12),
  //           child: Text(
  //             'I agree to the terms and conditions',
  //             style: TextStyle(fontSize: 13, color: Colors.black87),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }


  Widget _buildTermsCheckbox() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Checkbox(
        value: _agreeToTerms,
        onChanged: (value) {
          if (value == true) {
            _showTermsAndConditionsDialog();
          } else {
            setState(() {
              _agreeToTerms = false;
            });
          }
        },
        activeColor: const Color(0xFF214194),
      ),
      Expanded(
        child: InkWell(
          onTap: () {
            if (!_agreeToTerms) {
              _showTermsAndConditionsDialog();
            } 
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              'I agree to the terms and conditions',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
}