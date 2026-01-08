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


























import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/views/referearn/redeem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';

class ReferEarnScreen extends StatefulWidget {
  const ReferEarnScreen({super.key});

  @override
  State<ReferEarnScreen> createState() => _ReferEarnScreenState();
}

class _ReferEarnScreenState extends State<ReferEarnScreen> {
  bool _isLoading = true;
  String? _error;
  double _balance = 0.0;
  String? _userId;
  String? _referralCode;
  String _referralLink = '';

  @override
  void initState() {
    super.initState();
    _loadUserDataAndWallet();
  }

  Future<void> _loadUserDataAndWallet() async {
    final user = await SharedPrefsHelper.getUser();
    setState(() {
      _userId = user?.id;
      _referralCode = user?.referralCode ?? 'REFER123'; // Fallback code
      _referralLink = 'https://play.google.com/store/apps/details?id=com.backup.backup_ticket';
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

void _shareReferralLink() {
  Share.share(
    '🎟️ Download the Backup Ticket app using this link and book tickets easily!\n\n'
    '👉 Download here: $_referralLink\n\n'
    '🎁 Use my referral code: $_referralCode to get exciting rewards.',
    subject: 'Download Backup Ticket App',
  );
}


  void _copyReferralCode() {
    Clipboard.setData(ClipboardData(text: _referralCode ?? ''));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Referral code copied to clipboard!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _copyReferralLink() {
    Clipboard.setData(ClipboardData(text: _referralLink));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Referral link copied to clipboard!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 60, color: Colors.red),
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
              : SingleChildScrollView(
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          'Earn ₹100',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        Image.asset(
                                          'assets/coins.png',
                                          height: 80,
                                          width: 80,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Wallet Balance
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/dollar.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Wallet Balance',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              '₹${_balance.toStringAsFixed(2)}',
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
                                            colors: [
                                              Color(0xFF214194),
                                              Color(0xFF3F7EF3),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const RedeemScreen(),
                                              ),
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
                                              borderRadius:
                                                  BorderRadius.circular(13),
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
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Referral Code & Link Section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Your Referral Code',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      child: Text(
                                        _referralCode ?? 'REFER123',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: _copyReferralCode,
                                    icon: const Icon(Icons.copy),
                                    style: IconButton.styleFrom(
                                      backgroundColor: const Color(0xFF4A90E2),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Your Referral Link',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      child: Text(
                                        _referralLink,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: _copyReferralLink,
                                    icon: const Icon(Icons.copy),
                                    style: IconButton.styleFrom(
                                      backgroundColor: const Color(0xFF4A90E2),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _shareReferralLink,
                                  icon: const Icon(Icons.share, size: 20),
                                  label: const Text(
                                    'Share Referral Link',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4A90E2),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Steps Section
                        _buildStep(
                          icon: Icons.link,
                          text:
                              'Invite your friend to install the app with the link',
                          isFirst: true,
                        ),

                        _buildStep(
                          icon: Icons.confirmation_number_outlined,
                          text: 'Your friend buy a ticket from app.',
                          isFirst: false,
                        ),

                        _buildStep(
                          icon: Icons.account_balance_wallet_outlined,
                          text: 'You get ₹100 once they complete this process',
                          isFirst: false,
                          isLast: true,
                        ),


                      ],
                    ),
                  ),
                ),
    );
  }

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