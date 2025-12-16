import 'package:flutter/material.dart';

class RedeemScreen extends StatelessWidget {
  const RedeemScreen({super.key});

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
      body: Padding(
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
                      Image.asset('assets/dollar.png', width: 30, height: 30),
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
                          const Text(
                            '₹100',
                            style: TextStyle(
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

            // UPI ID Input
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your UPI ID',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
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
                      borderSide: const BorderSide(color: Color(0xFF4C6EF5)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.transparent, // Make background transparent
                        shadowColor:
                            Colors.transparent, // Remove shadow if needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Redeem Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors
                              .white, // Ensure text is visible on gradient
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
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
                      'Status',
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
            Divider(),

            // Transaction Rows
            _buildTransactionRow(
              '₹100',
              'Completed',
              '25-08-2025',
              Colors.green,
            ),
            _buildTransactionRow(
              '₹500',
              'Pending',
              '25-08-2025',
              Colors.orange,
            ),

            const Spacer(),

            // Footer Note
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.grey[500]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Rewards will be processed within 1-2 business days.',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
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
  String status,
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
                status,
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















// import 'package:backup_ticket/provider/auth/auth_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class RedeemScreen extends StatefulWidget {
//   const RedeemScreen({super.key});

//   @override
//   State<RedeemScreen> createState() => _RedeemScreenState();
// }

// class _RedeemScreenState extends State<RedeemScreen> {
//   final TextEditingController _upiController = TextEditingController();
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthProvider>(context);
//     final user = auth.currentUserData;

//     if (user == null) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

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
//             // ⭐ Wallet Amount Card
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: [
//                   Image.asset('assets/dollar.png', width: 30, height: 30),
//                   const SizedBox(width: 12),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Total Rewards',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 14,
//                         ),
//                       ),
//                       Text(
//                         '₹${user.wallet}',
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 28,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 30),

//             // ⭐ UPI Input
//             TextField(
//               controller: _upiController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your UPI ID',
//                 hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // ⭐ Redeem Button
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: isLoading ? null : () => _handleRedeem(user.id, user.wallet!),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text(
//                           'Redeem Now',
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                         ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 40),

//             // ⭐ Transaction History Header
//             const Text(
//               'Transaction History',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),

//             const SizedBox(height: 10),

//             // ⭐ History List
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('users')
//                     .doc(user.id)
//                     .collection('transactions')
//                     .orderBy('date', descending: true)
//                     .snapshots(),

//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (snapshot.data!.docs.isEmpty) {
//                     return const Center(
//                       child: Text("No transactions yet"),
//                     );
//                   }

//                   return ListView(
//                     children: snapshot.data!.docs.map((doc) {
//                       final data = doc.data() as Map<String, dynamic>;

//                       return _buildTransactionRow(
//                         '₹${data['amount']}',
//                         data['status'],
//                         (data['date'] as Timestamp).toDate().toString().substring(0, 16),
//                         data['status'] == "Completed" ? Colors.green : Colors.orange,
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 10),

//             Row(
//               children: [
//                 const Icon(Icons.info_outline, size: 16, color: Colors.grey),
//                 const SizedBox(width: 6),
//                 Expanded(
//                   child: Text(
//                     "Rewards will be processed within 1–2 business days.",
//                     style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ----------------------------
//   // ⭐ HANDLE REDEEM REQUEST
//   // ----------------------------
//   Future<void> _handleRedeem(String userId, int walletAmount) async {
//     final upi = _upiController.text.trim();

//     if (upi.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Enter a valid UPI ID")),
//       );
//       return;
//     }

//     if (walletAmount <= 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Not enough balance to redeem.")),
//       );
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final txnId = DateTime.now().millisecondsSinceEpoch.toString();

//       // 1️⃣ Save redemption request
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .collection('transactions')
//           .doc(txnId)
//           .set({
//         "amount": walletAmount,
//         "upiId": upi,
//         "status": "Pending", // Admin will process
//         "date": Timestamp.now(),
//       });

//       // 2️⃣ Set user wallet to 0 after redeem
//       await FirebaseFirestore.instance.collection('users').doc(userId).update({
//         "wallet": 0,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Redeem request submitted successfully!")),
//       );

//       Navigator.pop(context);

//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   // ----------------------------
//   // ⭐ TRANSACTION ROW UI
//   // ----------------------------
//   Widget _buildTransactionRow(
//       String amount, String status, String date, Color statusColor) {
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
//                   status,
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
//                     color: Colors.black87,
//                     fontSize: 14,
//                   ),
//                   textAlign: TextAlign.end,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Divider(color: Colors.grey.shade300),
//       ],
//     );
//   }
// }

