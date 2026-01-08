// import 'package:flutter/material.dart';

// class RedeemScreen extends StatelessWidget {
//   const RedeemScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Redeem',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 23,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Rewards Section
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: const Color.fromARGB(255, 211, 210, 210),
//                 ),
//                 color: const Color.fromARGB(255, 255, 255, 255),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Image.asset('assets/dollar.png', width: 30, height: 30),
//                       const SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Total Rewards',
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           const Text(
//                             '₹100',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 28,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 30),

//             // UPI ID Input
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Enter your UPI ID',
//                     hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.grey[300]!),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.grey[300]!),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(color: Color(0xFF4C6EF5)),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Redeem Button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             Colors.transparent, // Make background transparent
//                         shadowColor:
//                             Colors.transparent, // Remove shadow if needed
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         'Redeem Now',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors
//                               .white, // Ensure text is visible on gradient
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 40),

//             // Transaction History
//             const Text(
//               'Transaction History',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),

//             const SizedBox(height: 5),

//             // Table Header
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       'Amount',
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       'Status',
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       'Date',
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       textAlign: TextAlign.end,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(),

//             // Transaction Rows
//             _buildTransactionRow(
//               '₹100',
//               'Completed',
//               '25-08-2025',
//               Colors.green,
//             ),
//             _buildTransactionRow(
//               '₹500',
//               'Pending',
//               '25-08-2025',
//               Colors.orange,
//             ),

//             const Spacer(),

//             // Footer Note
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20),
//               child: Row(
//                 children: [
//                   Icon(Icons.info_outline, size: 16, color: Colors.grey[500]),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'Rewards will be processed within 1-2 business days.',
//                       style: TextStyle(color: Colors.grey[500], fontSize: 12),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// Widget _buildTransactionRow(
//   String amount,
//   String status,
//   String date,
//   Color statusColor,
// ) {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Text(
//                 amount,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Text(
//                 status,
//                 style: TextStyle(
//                   color: statusColor,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Text(
//                 date,
//                 style: const TextStyle(
//                   color: Color.fromARGB(255, 62, 62, 62),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 textAlign: TextAlign.end,
//               ),
//             ),
//           ],
//         ),
//       ),
     
//     ],
//   );
// }

// }























// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';

// class RedeemScreen extends StatefulWidget {
//   const RedeemScreen({super.key});

//   @override
//   State<RedeemScreen> createState() => _RedeemScreenState();
// }

// class _RedeemScreenState extends State<RedeemScreen> {
//   final TextEditingController _upiController = TextEditingController();
//   bool _isLoading = true;
//   bool _isRedeeming = false;
//   String? _error;
//   double _balance = 0.0;
//   List<WalletTransaction> _transactions = [];
//   String? _userId;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserDataAndWallet();
//   }

//   @override
//   void dispose() {
//     _upiController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadUserDataAndWallet() async {
//     final user = await SharedPrefsHelper.getUser();
//     setState(() {
//       _userId = user?.id;
//     });

//     if (_userId != null) {
//       await _fetchWallet();
//     } else {
//       setState(() {
//         _isLoading = false;
//         _error = "Please login to view wallet";
//       });
//     }
//   }

//   Future<void> _fetchWallet() async {
//     try {
//       setState(() {
//         _isLoading = true;
//         _error = null;
//       });

//       final response = await http.get(
//         Uri.parse('http://31.97.206.144:8127/api/auth/getuserwallet/$_userId'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['success'] == true && data['wallet'] != null) {
//           final wallet = data['wallet'];
//           setState(() {
//             _balance = (wallet['balance'] ?? 0).toDouble();
//             _transactions = (wallet['history'] as List? ?? [])
//                 .map((item) => WalletTransaction.fromJson(item))
//                 .toList();
//             _isLoading = false;
//           });
//         } else {
//           setState(() {
//             _error = data['message'] ?? 'Failed to load wallet';
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _error = 'Failed to fetch wallet data';
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _error = 'An error occurred: $e';
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _handleRedeem() async {
//     if (_upiController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enter your UPI ID'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     if (_balance <= 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Insufficient balance to redeem'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     setState(() {
//       _isRedeeming = true;
//     });

//     try {
//       // TODO: Replace with actual redeem API endpoint
//       // final response = await http.post(
//       //   Uri.parse('http://31.97.206.144:8127/api/auth/redeemwallet'),
//       //   headers: {'Content-Type': 'application/json'},
//       //   body: json.encode({
//       //     'userId': _userId,
//       //     'upiId': _upiController.text.trim(),
//       //     'amount': _balance,
//       //   }),
//       // );

//       // Simulating API call
//       await Future.delayed(const Duration(seconds: 2));

//       setState(() {
//         _isRedeeming = false;
//       });

//       // Show success dialog
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.check_circle, color: Colors.green, size: 80),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Redeem Request Submitted!',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Your request to redeem ₹${_balance.toStringAsFixed(2)} has been submitted.',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 14),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Amount will be transferred to ${_upiController.text.trim()} within 1-2 business days.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     Navigator.of(context).pop();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF4A90E2),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 40,
//                       vertical: 12,
//                     ),
//                   ),
//                   child: const Text(
//                     'Done',
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     } catch (e) {
//       setState(() {
//         _isRedeeming = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Redeem',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 23,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.error_outline,
//                           size: 60, color: Colors.red),
//                       const SizedBox(height: 16),
//                       Text(
//                         _error!,
//                         style: const TextStyle(fontSize: 16),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: _fetchWallet,
//                         child: const Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Rewards Section
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: const Color.fromARGB(255, 211, 210, 210),
//                           ),
//                           color: const Color.fromARGB(255, 255, 255, 255),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Image.asset('assets/dollar.png',
//                                     width: 30, height: 30),
//                                 const SizedBox(width: 12),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Total Rewards',
//                                       style: TextStyle(
//                                         color: Colors.grey[600],
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                     Text(
//                                       '₹${_balance.toStringAsFixed(2)}',
//                                       style: const TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       // UPI ID Input
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextField(
//                             controller: _upiController,
//                             decoration: InputDecoration(
//                               hintText: 'Enter your UPI ID',
//                               hintStyle: TextStyle(
//                                   color: Colors.grey[400], fontSize: 16),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(color: Colors.grey[300]!),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(color: Colors.grey[300]!),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide:
//                                     const BorderSide(color: Color(0xFF4C6EF5)),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 14,
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 20),

//                           // Redeem Button
//                           SizedBox(
//                             width: double.infinity,
//                             height: 50,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: ElevatedButton(
//                                 onPressed: _isRedeeming ? null : _handleRedeem,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   shadowColor: Colors.transparent,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: _isRedeeming
//                                     ? const Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                             width: 20,
//                                             height: 20,
//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 2,
//                                               valueColor:
//                                                   AlwaysStoppedAnimation<Color>(
//                                                 Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(width: 12),
//                                           Text(
//                                             'Processing...',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     : const Text(
//                                         'Redeem Now',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 40),

//                       // Transaction History
//                       const Text(
//                         'Transaction History',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),

//                       const SizedBox(height: 5),

//                       // Table Header
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: Text(
//                                 'Amount',
//                                 style: TextStyle(
//                                   color: Colors.grey[700],
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Text(
//                                 'Type',
//                                 style: TextStyle(
//                                   color: Colors.grey[700],
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 3,
//                               child: Text(
//                                 'Date',
//                                 style: TextStyle(
//                                   color: Colors.grey[700],
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 textAlign: TextAlign.end,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Divider(),

//                       // Transaction List
//                       Expanded(
//                         child: _transactions.isEmpty
//                             ? Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.receipt_long_outlined,
//                                       size: 60,
//                                       color: Colors.grey.shade400,
//                                     ),
//                                     const SizedBox(height: 16),
//                                     Text(
//                                       'No transactions yet',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.grey.shade600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             : ListView.builder(
//                                 itemCount: _transactions.length,
//                                 itemBuilder: (context, index) {
//                                   final transaction = _transactions[index];
//                                   return _buildTransactionRow(
//                                     '₹${transaction.amount.toStringAsFixed(2)}',
//                                     transaction.type,
//                                     DateFormat('dd-MM-yyyy')
//                                         .format(transaction.date),
//                                     transaction.type.toLowerCase() == 'credit'
//                                         ? Colors.green
//                                         : Colors.orange,
//                                   );
//                                 },
//                               ),
//                       ),

//                       // Footer Note
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 20, top: 10),
//                         child: Row(
//                           children: [
//                             Icon(Icons.info_outline,
//                                 size: 16, color: Colors.grey[500]),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 'Rewards will be processed within 1-2 business days.',
//                                 style: TextStyle(
//                                     color: Colors.grey[500], fontSize: 12),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//     );
//   }

//   Widget _buildTransactionRow(
//     String amount,
//     String type,
//     String date,
//     Color statusColor,
//   ) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           child: Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   amount,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   type.toUpperCase(),
//                   style: TextStyle(
//                     color: statusColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Text(
//                   date,
//                   style: const TextStyle(
//                     color: Color.fromARGB(255, 62, 62, 62),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   textAlign: TextAlign.end,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class WalletTransaction {
//   final String id;
//   final String type;
//   final double amount;
//   final String description;
//   final DateTime date;

//   WalletTransaction({
//     required this.id,
//     required this.type,
//     required this.amount,
//     required this.description,
//     required this.date,
//   });

//   factory WalletTransaction.fromJson(Map<String, dynamic> json) {
//     return WalletTransaction(
//       id: json['_id'] ?? '',
//       type: json['type'] ?? 'debit',
//       amount: (json['amount'] ?? 0).toDouble(),
//       description: json['description'] ?? 'Transaction',
//       date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
//     );
//   }
// }




















import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({super.key});

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  bool _isLoading = true;
  String? _error;
  double _balance = 0.0;
  List<WalletTransaction> _transactions = [];
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserDataAndWallet();
  }

  Future<void> _loadUserDataAndWallet() async {
    final user = await SharedPrefsHelper.getUser();
    setState(() {
      _userId = user?.id;
    });

    if (_userId != null) {
      await _fetchWallet();
    } else {
      setState(() {
        _isLoading = false;
        _error = "Please login to view wallet";
      });
    }
  }

  Future<void> _fetchWallet() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await http.get(
        Uri.parse('http://31.97.206.144:8127/api/auth/getuserwallet/$_userId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true && data['wallet'] != null) {
          final wallet = data['wallet'];
          setState(() {
            _balance = (wallet['balance'] ?? 0).toDouble();
            _transactions = (wallet['history'] as List? ?? [])
                .map((item) => WalletTransaction.fromJson(item))
                .toList();
            _isLoading = false;
          });
        } else {
          setState(() {
            _error = data['message'] ?? 'Failed to load wallet';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _error = 'Failed to fetch wallet data';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  void _showRedeemModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RedeemModal(
        userId: _userId!,
        balance: _balance,
        onSuccess: () {
          _fetchWallet();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Redeem',
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 60, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        _error!,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchWallet,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rewards Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 211, 210, 210),
                          ),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/dollar.png',
                                    width: 30, height: 30),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Rewards',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '₹${_balance.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Redeem Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton(
                            onPressed: _balance <= 0 ? null : _showRedeemModal,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              disabledBackgroundColor: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Redeem Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Transaction History
                      const Text(
                        'Transaction History',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Table Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Amount',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Type',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),

                      // Transaction List
                      Expanded(
                        child: _transactions.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.receipt_long_outlined,
                                      size: 60,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No transactions yet',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: _transactions.length,
                                itemBuilder: (context, index) {
                                  final transaction = _transactions[index];
                                  return _buildTransactionRow(
                                    '₹${transaction.amount.toStringAsFixed(2)}',
                                    transaction.type,
                                    DateFormat('dd-MM-yyyy')
                                        .format(transaction.date),
                                    transaction.type.toLowerCase() == 'credit'
                                        ? Colors.green
                                        : Colors.orange,
                                  );
                                },
                              ),
                      ),

                      // Footer Note
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,
                                size: 16, color: Colors.grey[500]),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Rewards will be processed within 1-2 business days.',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 12),
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

  Widget _buildTransactionRow(
    String amount,
    String type,
    String date,
    Color statusColor,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  amount,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  type.toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  date,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 62, 62, 62),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Modal Widget for Redeem Form
class RedeemModal extends StatefulWidget {
  final String userId;
  final double balance;
  final VoidCallback onSuccess;

  const RedeemModal({
    super.key,
    required this.userId,
    required this.balance,
    required this.onSuccess,
  });

  @override
  State<RedeemModal> createState() => _RedeemModalState();
}

class _RedeemModalState extends State<RedeemModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.balance.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _accountHolderController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    _upiController.dispose();
    super.dispose();
  }

  Future<void> _submitRedeemRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://31.97.206.144:8127/api/auth/sendredemption/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'amount': double.parse(_amountController.text),
          'accountHolderName': _accountHolderController.text.trim(),
          'bankName': _bankNameController.text.trim(),
          'accountNumber': _accountNumberController.text.trim(),
          'ifscCode': _ifscController.text.trim().toUpperCase(),
          'upiId': _upiController.text.trim(),
        }),
      );

      final data = json.decode(response.body);

      print("ppppppppppppppppppppppppppppppppppppp${response.body}");
            print("ppppppppppppppppppppppppppppppppppppp${response.statusCode}");


      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Redemption request submitted successfully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
        
        widget.onSuccess();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Failed to submit redemption request'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Redeem Rewards',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.grey),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Fill in your bank details to receive your rewards',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Amount Field
                _buildTextField(
                  controller: _amountController,
                  label: 'Amount',
                  hint: 'Enter amount',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount';
                    }
                    final amount = double.tryParse(value);
                    if (amount == null || amount <= 0) {
                      return 'Please enter valid amount';
                    }
                    if (amount > widget.balance) {
                      return 'Amount exceeds available balance';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Account Holder Name
                _buildTextField(
                  controller: _accountHolderController,
                  label: 'Account Holder Name',
                  hint: 'Enter account holder name',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter account holder name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Bank Name
                _buildTextField(
                  controller: _bankNameController,
                  label: 'Bank Name',
                  hint: 'Enter bank name',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter bank name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Account Number
                _buildTextField(
                  controller: _accountNumberController,
                  label: 'Account Number',
                  hint: 'Enter account number',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter account number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // IFSC Code
                _buildTextField(
                  controller: _ifscController,
                  label: 'IFSC Code',
                  hint: 'Enter IFSC code',
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter IFSC code';
                    }
                    if (value.trim().length != 11) {
                      return 'IFSC code must be 11 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // UPI ID
                _buildTextField(
                  controller: _upiController,
                  label: 'UPI ID',
                  hint: 'Enter UPI ID (e.g., user@upi)',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter UPI ID';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter valid UPI ID';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitRedeemRequest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isSubmitting
                          ? const Row(
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
                                  'Submitting...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              'Submit Request',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Info Text
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.grey[500]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Amount will be transferred within 1-2 business days',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4C6EF5), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class WalletTransaction {
  final String id;
  final String type;
  final double amount;
  final String description;
  final DateTime date;

  WalletTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id: json['_id'] ?? '',
      type: json['type'] ?? 'debit',
      amount: (json['amount'] ?? 0).toDouble(),
      description: json['description'] ?? 'Transaction',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    );
  }
}