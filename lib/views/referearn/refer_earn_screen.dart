// import 'package:backup_ticket/views/referearn/redeem_screen.dart';
// import 'package:flutter/material.dart';

// class ReferEarnScreen extends StatelessWidget {
//   const ReferEarnScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Refer & Earn',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Main Refer Card
//               Container(
//                 // height: 0,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Refer Your Friends',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 'Earn ₹100',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // Coin icons
//                           Stack(
//                             children: [
//                               Image.asset(
//                                 'assets/coins.png',
//                                 height: 80,
//                                 width: 80,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       // Rewards and Redeem section
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                           horizontal: 16,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/dollar.png',
//                               height: 30,
//                               width: 30,
//                             ),
//                             const SizedBox(width: 12),
//                             const Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Recieved Money',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   Text(
//                                     '₹100',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Color(0xFF214194),
//                                     Color(0xFF3F7EF3),
//                                   ],
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                 ),
//                                 borderRadius: BorderRadius.circular(13),
//                               ),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>RedeemScreen()));
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors
//                                       .transparent, // Make button background transparent
//                                   shadowColor: Colors
//                                       .transparent, // Remove shadow if needed
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 20,
//                                     vertical: 6,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(13),
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Redeem',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color:
//                                         Colors.white, // Text color for contrast
//                                   ),
//                                 ),
//                               ),
//                             ),

//                           ],
//                         ),
//                       ),

//                         SizedBox(height: 15,),
//                            Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 12,
//                           horizontal: 16,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/dollar.png',
//                               height: 30,
//                               width: 30,
//                             ),
//                             const SizedBox(width: 12),
//                             const Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Referal Rewards',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   Text(
//                                     '₹100',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Color(0xFF214194),
//                                     Color(0xFF3F7EF3),
//                                   ],
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                 ),
//                                 borderRadius: BorderRadius.circular(13),
//                               ),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>RedeemScreen()));
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors
//                                       .transparent, // Make button background transparent
//                                   shadowColor: Colors
//                                       .transparent, // Remove shadow if needed
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 20,
//                                     vertical: 6,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(13),
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Redeem',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color:
//                                         Colors.white, // Text color for contrast
//                                   ),
//                                 ),
//                               ),
//                             ),

//                           ],
//                         ),
//                       ),

//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // Steps Section
//               _buildStep(
//                 icon: Icons.link,
//                 text: 'Invite your friend to install the app with the link',
//                 isFirst: true,
//               ),

//               _buildStep(
//                 icon: Icons.confirmation_number_outlined,
//                 text: 'Your friend buy a ticket from app.',
//                 isFirst: false,
//               ),

//               _buildStep(
//                 icon: Icons.account_balance_wallet_outlined,
//                 text: 'You get ₹100 once they complete this process',
//                 isFirst: false,
//                 isLast: true,
//               ),

//               const SizedBox(height: 32),

//               // FAQ Section
//               const Text(
//                 'Frequently asked question',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),

//               const SizedBox(height: 16),

//               _buildFAQItem('What is the Refer & Earn program?'),
//               _buildFAQItem('How do I refer someone?'),
//               _buildFAQItem('How much can I earn per referral?'),
//               _buildFAQItem('What counts as a valid referral?'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStep({
//     required IconData icon,
//     required String text,
//     required bool isFirst,
//     bool isLast = false,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF4A90E2).withOpacity(0.1),
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: const Color(0xFF4A90E2).withOpacity(0.3),
//                   width: 1,
//                 ),
//               ),
//               child: Icon(icon, color: const Color(0xFF4A90E2), size: 20),
//             ),
//             if (!isLast)
//               Container(
//                 width: 2,
//                 height: 40,
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(1),
//                 ),
//               ),
//           ],
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: Text(
//               text,
//               style: const TextStyle(
//                 fontSize: 15,
//                 color: Colors.black87,
//                 height: 1.4,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFAQItem(String question) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: ExpansionTile(
//         title: Text(
//           question,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//         children: const [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Answer content would go here...',
//               style: TextStyle(fontSize: 14, color: Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:backup_ticket/provider/auth/auth_provider.dart';
import 'package:backup_ticket/views/referearn/redeem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferEarnScreen extends StatelessWidget {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.currentUserData;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Refer & Earn',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Refer Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(20.0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Text + Image
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Refer Your Friends',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Earn ₹50',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          Image.asset(
                            'assets/coins.png',
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Wallet Section 1
                      _walletCard(
                        title: "Received Money",
                        amount: user.wallet!,
                        context: context,
                      ),

                      const SizedBox(height: 15),

                      // Wallet Section 2 — referral rewards (same value)
                      _walletCard(
                        title: "Referral Rewards",
                        amount: user.wallet!,
                        context: context,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 REFERRAL CODE BOX
              _referralCodeBox(context, user.referralCode.toString()),

              const SizedBox(height: 24),

              // Share button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Share.share(
                      "Hey! 🎉\nUse my referral code **${user.referralCode}** and get ₹50 instantly in your wallet!\n\nDownload the Backup Ticket app now:\nhttps://play.google.com/store/apps/details?id=com.backup.backup_ticket",
                    );

                    // Share.share(
                    //   "Hey! Use my referral code **${user.referralCode}** and get ₹50 instantly in your wallet!\nDownload the app now!",
                    // );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text("Share Referral Code"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Steps Section
              _buildStep(
                icon: Icons.link,
                text: 'Invite your friend to install the app with the link',
                isFirst: true,
              ),
              _buildStep(
                icon: Icons.confirmation_number_outlined,
                text: 'Your friend buys a ticket from the app.',
                isFirst: false,
              ),
              _buildStep(
                icon: Icons.account_balance_wallet_outlined,
                text: 'You get ₹50 once they complete the process',
                isFirst: false,
                isLast: true,
              ),

              const SizedBox(height: 32),

              const Text(
                'Frequently asked question',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 16),

              _buildFAQItem('What is the Refer & Earn program?'),
              _buildFAQItem('How do I refer someone?'),
              _buildFAQItem('How much can I earn per referral?'),
              _buildFAQItem('What counts as a valid referral?'),
            ],
          ),
        ),
      ),
    );
  }

  // -----------------------
  // Wallet Card UI
  // -----------------------
  Widget _walletCard({
    required String title,
    required int amount,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Image.asset('assets/dollar.png', height: 30, width: 30),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
                Text(
                  '₹$amount',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF214194), Color(0xFF3F7EF3)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RedeemScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: const Text(
                'Redeem',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------
  // Referral Code Box
  // -----------------------
  Widget _referralCodeBox(BuildContext context, String code) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label + Code
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Referral Code",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 6),
              Text(
                code,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          // Copy Button
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.blue),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code));

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Referral code copied!")),
              );
            },
          ),
        ],
      ),
    );
  }

  // -----------------------
  // Steps
  // -----------------------
  Widget _buildStep({
    required IconData icon,
    required String text,
    required bool isFirst,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,

              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2).withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF4A90E2).withOpacity(0.3),
                  width: 1,
                ),
              ),

              child: Icon(icon, color: const Color(0xFF4A90E2), size: 20),
            ),

            if (!isLast)
              Container(
                width: 2,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
          ],
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // -----------------------
  // FAQ Item
  // -----------------------
  Widget _buildFAQItem(String question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        children: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Answer content would go here...',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
