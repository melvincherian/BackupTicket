// // // import 'package:backup_ticket/views/ticketshare/ticket_share_screen.dart';
// // // import 'package:flutter/material.dart';

// // // class NotificationScreen extends StatelessWidget {
// // //   const NotificationScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         elevation: 0,
// // //         backgroundColor: Colors.white,
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
// // //           onPressed: () => Navigator.pop(context),
// // //         ),
// // //         centerTitle: true,
// // //         title: const Text(
// // //           "Notifications",
// // //           style: TextStyle(
// // //             color: Colors.black,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(12.0),
// // //         child: ListView(
// // //           children: [
// // //             _buildNotificationItem(
// // //               context: context,
// // //               title: "Share Your Bus Tracking\nand driver details.",
// // //               timeAgo: "5 min ago",
// // //               buttonType: ButtonType.share,
// // //             ),
// // //             const SizedBox(height: 12),
// // //             _buildNotificationItem(
// // //               context: context,
// // //               title: "Bus Tracking and driver\ndetails has been received.",
// // //               timeAgo: "5 min ago",
// // //               buttonType: ButtonType.download,
// // //             ),
// // //             const SizedBox(height: 12),
// // //             _buildNotificationItem(
// // //               context: context,
// // //               title: "Your Ticket has been\nDownloaded",
// // //               timeAgo: "5 min ago",
// // //               buttonType: ButtonType.none,
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildNotificationItem({
// // //     required BuildContext context,
// // //     required String title,
// // //     required String timeAgo,
// // //     required ButtonType buttonType,
// // //   }) {
// // //     return Container(
// // //       padding: const EdgeInsets.all(12),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(8),
// // //         border: Border.all(color: Colors.grey.shade300),
// // //       ),
// // //       child: Column(
// // //         children: [
// // //           Row(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               // Thumbnail Image
// // //               ClipRRect(
// // //                 borderRadius: BorderRadius.circular(6),
// // //                 child: Image.asset(
// // //                   "assets/kubera.png",
// // //                   width: 50,
// // //                   height: 50,
// // //                   fit: BoxFit.cover,
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 12),

// // //               // Notification Text
// // //               Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       title,
// // //                       style: const TextStyle(
// // //                         fontSize: 14,
// // //                         fontWeight: FontWeight.w500,
// // //                         color: Colors.black87,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               // Time Ago
// // //               Text(
// // //                 timeAgo,
// // //                 style: const TextStyle(
// // //                   color: Colors.grey,
// // //                   fontSize: 12,
// // //                 ),
// // //               ),
// // //             ],
// // //           ),

// // //           // Buttons Section
// // //           if (buttonType != ButtonType.none) ...[
// // //             const SizedBox(height: 12),
// // //             Row(
// // //               children: [
// // //                 const SizedBox(width: 62),
// // //                 Expanded(
// // //                   child: Container(
// // //                     height: 36,
// // //                     decoration: BoxDecoration(
// // //                       borderRadius: BorderRadius.circular(7),
// // //                       gradient: const LinearGradient(
// // //                         colors: [
// // //                           Color(0xFF214194),
// // //                           Color(0xFF3F7EF3),
// // //                         ],
// // //                         begin: Alignment.centerLeft,
// // //                         end: Alignment.centerRight,
// // //                       ),
// // //                     ),
// // //                     child: ElevatedButton.icon(
// // //                       onPressed: () {
// // //                         if (buttonType == ButtonType.share) {
// // //                           _showShareModal(context);
// // //                         } else if (buttonType == ButtonType.download) {
// // //                           print("Download Details pressed");
// // //                         }
// // //                       },
// // //                       style: ElevatedButton.styleFrom(
// // //                         backgroundColor: Colors.transparent,
// // //                         shadowColor: Colors.transparent,
// // //                         shape: RoundedRectangleBorder(
// // //                           borderRadius: BorderRadius.circular(7),
// // //                         ),
// // //                         padding: const EdgeInsets.symmetric(vertical: 8),
// // //                       ),
// // //                       icon: buttonType == ButtonType.download
// // //                           ? const Icon(Icons.save_alt_outlined, size: 16, color: Colors.white)
// // //                           : const SizedBox.shrink(),
// // //                       label: Text(
// // //                         buttonType == ButtonType.share
// // //                             ? "Share Now"
// // //                             : "Download Details",
// // //                         style: const TextStyle(
// // //                           color: Colors.white,
// // //                           fontSize: 12,
// // //                           fontWeight: FontWeight.w500,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ],
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // Modal Bottom Sheet for Share Now
// // //   void _showShareModal(BuildContext context) {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       shape: const RoundedRectangleBorder(
// // //         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
// // //       ),
// // //       builder: (context) {
// // //         return Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               const Text(
// // //                 "Upload Details screenshot",
// // //                 style: TextStyle(
// // //                   fontSize: 14,
// // //                   fontWeight: FontWeight.w600,
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 16),

// // //               // File Upload Box
// // //               Container(
// // //                 height: 100,
// // //                 decoration: BoxDecoration(
// // //                   border: Border.all(color: Colors.grey.shade400),
// // //                   borderRadius: BorderRadius.circular(8),
// // //                 ),
// // //                 child: Center(
// // //                   child: Column(
// // //                     mainAxisAlignment: MainAxisAlignment.center,
// // //                     children: const [
// // //                       Icon(Icons.add_photo_alternate_outlined,
// // //                           color: Colors.grey, size: 30),
// // //                       SizedBox(height: 6),
// // //                       Text(
// // //                         "Choose File",
// // //                         style: TextStyle(
// // //                           color: Colors.black54,
// // //                           fontSize: 13,
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 20),

// // //               // Gradient Share Now Button
// // //               Container(
// // //                 height: 45,
// // //                 width: double.infinity,
// // //                 decoration: BoxDecoration(
// // //                   borderRadius: BorderRadius.circular(7),
// // //                   gradient: const LinearGradient(
// // //                     colors: [
// // //                       Color(0xFF214194),
// // //                       Color(0xFF3F7EF3),
// // //                     ],
// // //                     begin: Alignment.centerLeft,
// // //                     end: Alignment.centerRight,
// // //                   ),
// // //                 ),
// // //                 child: ElevatedButton(
// // //                   onPressed: () {

// // //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>TicketShareScreen()));

// // //                   },
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: Colors.transparent,
// // //                     shadowColor: Colors.transparent,
// // //                     shape: RoundedRectangleBorder(
// // //                       borderRadius: BorderRadius.circular(7),
// // //                     ),
// // //                   ),
// // //                   child: const Text(
// // //                     "Share Now",
// // //                     style: TextStyle(
// // //                       color: Colors.white,
// // //                       fontSize: 14,
// // //                       fontWeight: FontWeight.w600,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }

// // // enum ButtonType { share, download, none }

// // import 'package:backup_ticket/helper/auth_helper.dart';
// // import 'package:backup_ticket/views/ticketshare/ticket_share_screen.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:timeago/timeago.dart' as timeago;

// // class NotificationScreen extends StatelessWidget {
// //   const NotificationScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         elevation: 0,
// //         backgroundColor: Colors.white,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //         centerTitle: true,
// //         title: const Text(
// //           "Notifications",
// //           style: TextStyle(
// //             color: Colors.black,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //       body: FutureBuilder<String?>(
// //         future: UserPreferences.getUserId(),
// //         builder: (context, userSnapshot) {
// //           if (!userSnapshot.hasData) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           final userId = userSnapshot.data ?? 'guest';

// //           // FIXED: Fetch all notifications for user, then sort in memory
// //           return StreamBuilder<QuerySnapshot>(
// //             stream: FirebaseFirestore.instance
// //                 .collection('notifications')
// //                 .where('userId', isEqualTo: userId)
// //                 .snapshots(),
// //             builder: (context, snapshot) {
// //               if (snapshot.connectionState == ConnectionState.waiting) {
// //                 return const Center(child: CircularProgressIndicator());
// //               }

// //               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //                 return Center(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(
// //                         Icons.notifications_off_outlined,
// //                         size: 80,
// //                         color: Colors.grey[400],
// //                       ),
// //                       const SizedBox(height: 16),
// //                       Text(
// //                         'No notifications yet',
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           color: Colors.grey[600],
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               }

// //               // Sort notifications by createdAt in memory
// //               final sortedDocs = snapshot.data!.docs.toList()
// //                 ..sort((a, b) {
// //                   final aTime = (a.data() as Map<String, dynamic>)['createdAt'] as Timestamp?;
// //                   final bTime = (b.data() as Map<String, dynamic>)['createdAt'] as Timestamp?;

// //                   if (aTime == null && bTime == null) return 0;
// //                   if (aTime == null) return 1;
// //                   if (bTime == null) return -1;

// //                   return bTime.compareTo(aTime); // Descending order
// //                 });

// //               return Padding(
// //                 padding: const EdgeInsets.all(12.0),
// //                 child: ListView.separated(
// //                   itemCount: sortedDocs.length,
// //                   separatorBuilder: (context, index) =>
// //                       const SizedBox(height: 12),
// //                   itemBuilder: (context, index) {
// //                     final doc = sortedDocs[index];
// //                     final data = doc.data() as Map<String, dynamic>;

// //                     final title = data['title'] ?? '';
// //                     final message = data['message'] ?? '';
// //                     final type = data['type'] ?? 'purchase';
// //                     final imageUrl = data['imageUrl'];
// //                     final createdAt = data['createdAt'] as Timestamp?;
// //                     final isRead = data['isRead'] ?? false;

// //                     String timeAgo = 'Just now';
// //                     if (createdAt != null) {
// //                       timeAgo = timeago.format(createdAt.toDate());
// //                     }

// //                     ButtonType buttonType = ButtonType.none;
// //                     if (type == 'share') {
// //                       buttonType = ButtonType.share;
// //                     } else if (type == 'download') {
// //                       buttonType = ButtonType.download;
// //                     }

// //                     return _buildNotificationItem(
// //                       context: context,
// //                       notificationId: doc.id,
// //                       title: title,
// //                       message: message,
// //                       timeAgo: timeAgo,
// //                       buttonType: buttonType,
// //                       imageUrl: imageUrl,
// //                       isRead: isRead,
// //                     );
// //                   },
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildNotificationItem({
// //     required BuildContext context,
// //     required String notificationId,
// //     required String title,
// //     required String message,
// //     required String timeAgo,
// //     required ButtonType buttonType,
// //     String? imageUrl,
// //     required bool isRead,
// //   }) {
// //     // Mark as read when viewed
// //     if (!isRead) {
// //       FirebaseFirestore.instance
// //           .collection('notifications')
// //           .doc(notificationId)
// //           .update({'isRead': true});
// //     }

// //     return Container(
// //       padding: const EdgeInsets.all(12),
// //       decoration: BoxDecoration(
// //         color: isRead ? Colors.white : Colors.blue.shade50,
// //         borderRadius: BorderRadius.circular(8),
// //         border: Border.all(
// //           color: isRead ? Colors.grey.shade300 : Colors.blue.shade200,
// //         ),
// //       ),
// //       child: Column(
// //         children: [
// //           Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // Thumbnail Image
// //               ClipRRect(
// //                 borderRadius: BorderRadius.circular(6),
// //                 child: imageUrl != null && imageUrl.isNotEmpty
// //                     ? Image.network(
// //                         imageUrl,
// //                         width: 50,
// //                         height: 50,
// //                         fit: BoxFit.cover,
// //                         errorBuilder: (context, error, stackTrace) {
// //                           return Image.asset(
// //                             "assets/kubera.png",
// //                             width: 50,
// //                             height: 50,
// //                             fit: BoxFit.cover,
// //                           );
// //                         },
// //                       )
// //                     : Image.asset(
// //                         "assets/kubera.png",
// //                         width: 50,
// //                         height: 50,
// //                         fit: BoxFit.cover,
// //                       ),
// //               ),
// //               const SizedBox(width: 12),

// //               // Notification Text
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       title,
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
// //                         color: Colors.black87,
// //                       ),
// //                     ),
// //                     if (message.isNotEmpty) ...[
// //                       const SizedBox(height: 4),
// //                       Text(
// //                         message,
// //                         style: TextStyle(
// //                           fontSize: 12,
// //                           color: Colors.grey[700],
// //                         ),
// //                         maxLines: 2,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                     ],
// //                   ],
// //                 ),
// //               ),

// //               // Time Ago
// //               Text(
// //                 timeAgo,
// //                 style: const TextStyle(
// //                   color: Colors.grey,
// //                   fontSize: 12,
// //                 ),
// //               ),
// //             ],
// //           ),

// //           // Buttons Section
// //           if (buttonType != ButtonType.none) ...[
// //             const SizedBox(height: 12),
// //             Row(
// //               children: [
// //                 const SizedBox(width: 62),
// //                 Expanded(
// //                   child: Container(
// //                     height: 36,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(7),
// //                       gradient: const LinearGradient(
// //                         colors: [
// //                           Color(0xFF214194),
// //                           Color(0xFF3F7EF3),
// //                         ],
// //                         begin: Alignment.centerLeft,
// //                         end: Alignment.centerRight,
// //                       ),
// //                     ),
// //                     child: ElevatedButton.icon(
// //                       onPressed: () {
// //                         if (buttonType == ButtonType.share) {
// //                           _showShareModal(context);
// //                         } else if (buttonType == ButtonType.download) {
// //                           print("Download Details pressed");
// //                         }
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.transparent,
// //                         shadowColor: Colors.transparent,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(7),
// //                         ),
// //                         padding: const EdgeInsets.symmetric(vertical: 8),
// //                       ),
// //                       icon: buttonType == ButtonType.download
// //                           ? const Icon(Icons.save_alt_outlined,
// //                               size: 16, color: Colors.white)
// //                           : const SizedBox.shrink(),
// //                       label: Text(
// //                         buttonType == ButtonType.share
// //                             ? "Share Now"
// //                             : "Download Details",
// //                         style: const TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 12,
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ],
// //       ),
// //     );
// //   }

// //   // Modal Bottom Sheet for Share Now
// //   void _showShareModal(BuildContext context) {
// //     showModalBottomSheet(
// //       context: context,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
// //       ),
// //       builder: (context) {
// //         return Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               const Text(
// //                 "Upload Details screenshot",
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //               const SizedBox(height: 16),

// //               // File Upload Box
// //               Container(
// //                 height: 100,
// //                 decoration: BoxDecoration(
// //                   border: Border.all(color: Colors.grey.shade400),
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: Center(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: const [
// //                       Icon(Icons.add_photo_alternate_outlined,
// //                           color: Colors.grey, size: 30),
// //                       SizedBox(height: 6),
// //                       Text(
// //                         "Choose File",
// //                         style: TextStyle(
// //                           color: Colors.black54,
// //                           fontSize: 13,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),

// //               // Gradient Share Now Button
// //               Container(
// //                 height: 45,
// //                 width: double.infinity,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(7),
// //                   gradient: const LinearGradient(
// //                     colors: [
// //                       Color(0xFF214194),
// //                       Color(0xFF3F7EF3),
// //                     ],
// //                     begin: Alignment.centerLeft,
// //                     end: Alignment.centerRight,
// //                   ),
// //                 ),
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => TicketShareScreen(),
// //                       ),
// //                     );
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.transparent,
// //                     shadowColor: Colors.transparent,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(7),
// //                     ),
// //                   ),
// //                   child: const Text(
// //                     "Share Now",
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // enum ButtonType { share, download, none }

// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/views/ticketshare/ticket_share_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:timeago/timeago.dart' as timeago;

// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         title: const Text(
//           "Notifications",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: FutureBuilder<String?>(
//         future: UserPreferences.getUserId(),
//         builder: (context, userSnapshot) {
//           if (!userSnapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final userId = userSnapshot.data ?? 'guest';

//           return StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('notifications')
//                 .where('userId', isEqualTo: userId)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.notifications_off_outlined,
//                         size: 80,
//                         color: Colors.grey[400],
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'No notifications yet',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               // Sort notifications by createdAt in memory
//               final sortedDocs = snapshot.data!.docs.toList()
//                 ..sort((a, b) {
//                   final aTime = (a.data() as Map<String, dynamic>)['createdAt'] as Timestamp?;
//                   final bTime = (b.data() as Map<String, dynamic>)['createdAt'] as Timestamp?;

//                   if (aTime == null && bTime == null) return 0;
//                   if (aTime == null) return 1;
//                   if (bTime == null) return -1;

//                   return bTime.compareTo(aTime);
//                 });

//               return Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: ListView.separated(
//                   itemCount: sortedDocs.length,
//                   separatorBuilder: (context, index) =>
//                       const SizedBox(height: 12),
//                   itemBuilder: (context, index) {
//                     final doc = sortedDocs[index];
//                     final data = doc.data() as Map<String, dynamic>;

//                     final title = data['title'] ?? '';
//                     final message = data['message'] ?? '';
//                     final type = data['type'] ?? 'purchase';
//                     final imageUrl = data['imageUrl'];
//                     final createdAt = data['createdAt'] as Timestamp?;
//                     final isRead = data['isRead'] ?? false;

//                     String timeAgo = 'Just now';
//                     if (createdAt != null) {
//                       timeAgo = timeago.format(createdAt.toDate());
//                     }

//                     ButtonType buttonType = ButtonType.none;
//                     if (type == 'share') {
//                       buttonType = ButtonType.share;
//                     } else if (type == 'download') {
//                       buttonType = ButtonType.download;
//                     }

//                     return _buildNotificationItem(
//                       context: context,
//                       notificationId: doc.id,
//                       title: title,
//                       message: message,
//                       timeAgo: timeAgo,
//                       buttonType: buttonType,
//                       imageUrl: imageUrl,
//                       isRead: isRead,
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Delete notification function
//   Future<void> _deleteNotification(BuildContext context, String notificationId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('notifications')
//           .doc(notificationId)
//           .delete();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Notification deleted'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to delete notification: $e'),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   // Show delete confirmation dialog
//   void _showDeleteConfirmation(BuildContext context, String notificationId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delete Notification'),
//           content: const Text('Are you sure you want to delete this notification?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _deleteNotification(context, notificationId);
//               },
//               child: const Text(
//                 'Delete',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildNotificationItem({
//     required BuildContext context,
//     required String notificationId,
//     required String title,
//     required String message,
//     required String timeAgo,
//     required ButtonType buttonType,
//     String? imageUrl,
//     required bool isRead,
//   }) {
//     // Mark as read when viewed
//     if (!isRead) {
//       FirebaseFirestore.instance
//           .collection('notifications')
//           .doc(notificationId)
//           .update({'isRead': true});
//     }

//     return Dismissible(
//       key: Key(notificationId),
//       direction: DismissDirection.endToStart,
//       background: Container(
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: const Icon(
//           Icons.delete,
//           color: Colors.red,
//           size: 28,
//         ),
//       ),
//       confirmDismiss: (direction) async {
//         return await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Delete Notification'),
//               content: const Text('Are you sure you want to delete this notification?'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context, false),
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.pop(context, true),
//                   child: const Text(
//                     'Delete',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       onDismissed: (direction) {
//         _deleteNotification(context, notificationId);
//       },
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isRead ? Colors.white : Colors.blue.shade50,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isRead ? Colors.grey.shade300 : Colors.blue.shade200,
//           ),
//         ),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Thumbnail Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(6),
//                   child: imageUrl != null && imageUrl.isNotEmpty
//                       ? Image.network(
//                           imageUrl,
//                           width: 50,
//                           height: 50,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Image.asset(
//                               "assets/kubera.png",
//                               width: 50,
//                               height: 50,
//                               fit: BoxFit.cover,
//                             );
//                           },
//                         )
//                       : Image.asset(
//                           "assets/kubera.png",
//                           width: 50,
//                           height: 50,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//                 const SizedBox(width: 12),

//                 // Notification Text
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       if (message.isNotEmpty) ...[
//                         const SizedBox(height: 4),
//                         Text(
//                           message,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[700],
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),

//                 // Time Ago and Delete Button
//                 Column(
//                   children: [
//                     Text(
//                       timeAgo,
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     IconButton(
//                       icon: const Icon(Icons.delete_outline, size: 20),
//                       color: Colors.red,
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                       onPressed: () => _showDeleteConfirmation(context, notificationId),
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             // Buttons Section
//             if (buttonType != ButtonType.none) ...[
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   const SizedBox(width: 62),
//                   Expanded(
//                     child: Container(
//                       height: 36,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(7),
//                         gradient: const LinearGradient(
//                           colors: [
//                             Color(0xFF214194),
//                             Color(0xFF3F7EF3),
//                           ],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                         ),
//                       ),
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           if (buttonType == ButtonType.share) {
//                             _showShareModal(context);
//                           } else if (buttonType == ButtonType.download) {
//                             print("Download Details pressed");
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           shadowColor: Colors.transparent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                         ),
//                         icon: buttonType == ButtonType.download
//                             ? const Icon(Icons.save_alt_outlined,
//                                 size: 16, color: Colors.white)
//                             : const SizedBox.shrink(),
//                         label: Text(
//                           buttonType == ButtonType.share
//                               ? "Share Now"
//                               : "Download Details",
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   // Modal Bottom Sheet for Share Now
//   void _showShareModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Upload Details screenshot",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // File Upload Box
//               Container(
//                 height: 100,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade400),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.add_photo_alternate_outlined,
//                           color: Colors.grey, size: 30),
//                       SizedBox(height: 6),
//                       Text(
//                         "Choose File",
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Gradient Share Now Button
//               Container(
//                 height: 45,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(7),
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color(0xFF214194),
//                       Color(0xFF3F7EF3),
//                     ],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => TicketShareScreen(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(7),
//                     ),
//                   ),
//                   child: const Text(
//                     "Share Now",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// enum ButtonType { share, download, none}




import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/views/ticketshare/ticket_share_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: FutureBuilder<String?>(
        future: UserPreferences.getUserId(),
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final userId = userSnapshot.data ?? 'guest';

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notifications')
                .where('userId', isEqualTo: userId)
                .snapshots(),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // *************** NO NOTIFICATION UI WITH LOTTIE ***************
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: 180,
                      //   child: Image.asset(
                      //     'assets/no-notifications-animation-gif-download-4323106.webp',
                      //   ),
                      // ),
                      const SizedBox(height: 16),
                      Text(
                        'No notifications yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Sort notifications
              final sortedDocs = snapshot.data!.docs.toList()
                ..sort((a, b) {
                  final aTime =
                      (a.data() as Map<String, dynamic>)['createdAt']
                          as Timestamp?;
                  final bTime =
                      (b.data() as Map<String, dynamic>)['createdAt']
                          as Timestamp?;
                  if (aTime == null && bTime == null) return 0;
                  if (aTime == null) return 1;
                  if (bTime == null) return -1;
                  return bTime.compareTo(aTime);
                });

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  itemCount: sortedDocs.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final doc = sortedDocs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    final title = data['title'] ?? '';
                    final message = data['message'] ?? '';
                    final type = data['type'] ?? 'purchase';
                    final imageUrl = data['imageUrl'];
                    final createdAt = data['createdAt'] as Timestamp?;
                    final isRead = data['isRead'] ?? false;

                    String timeAgo = createdAt != null
                        ? timeago.format(createdAt.toDate())
                        : "Just now";

                    ButtonType buttonType = ButtonType.none;
                    if (type == 'share') buttonType = ButtonType.share;
                    if (type == 'download') buttonType = ButtonType.download;

                    return _buildNotificationItem(
                      context: context,
                      notificationId: doc.id,
                      title: title,
                      message: message,
                      timeAgo: timeAgo,
                      buttonType: buttonType,
                      imageUrl: imageUrl,
                      isRead: isRead,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Delete Notification
  Future<void> _deleteNotification(
    BuildContext context,
    String notificationId,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notificationId)
          .delete();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Notification deleted')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Confirmation dialog
  void _showDeleteConfirmation(BuildContext context, String notificationId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notification'),
        content: const Text(
          'Are you sure you want to delete this notification?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteNotification(context, notificationId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Notification deleted Successfully'),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Notification Item UI
  Widget _buildNotificationItem({
    required BuildContext context,
    required String notificationId,
    required String title,
    required String message,
    required String timeAgo,
    required ButtonType buttonType,
    String? imageUrl,
    required bool isRead,
  }) {
    // mark as read
    if (!isRead) {
      FirebaseFirestore.instance
          .collection('notifications')
          .doc(notificationId)
          .update({'isRead': true});
    }

    return Dismissible(
      key: Key(notificationId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Notification'),
            content: const Text('Are you sure?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },

      onDismissed: (_) => _deleteNotification(context, notificationId),

      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),

        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: imageUrl != null && imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Image.asset("assets/kubera.png", width: 50, height: 50),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isRead
                              ? FontWeight.w500
                              : FontWeight.w700,
                        ),
                      ),
                      if (message.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                Column(
                  children: [
                    Text(
                      timeAgo,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red,
                      onPressed: () =>
                          _showDeleteConfirmation(context, notificationId),
                    ),
                  ],
                ),
              ],
            ),

            if (buttonType != ButtonType.none) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const SizedBox(width: 62),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (buttonType == ButtonType.share) {
                          _showShareModal(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: Text(
                        buttonType == ButtonType.share
                            ? "Share Now"
                            : "Download Details",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Share Modal Bottom Sheet
  void _showShareModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),

      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Upload Details Screenshot",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate_outlined),
                    SizedBox(height: 6),
                    Text("Choose File"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicketShareScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 45),
              ),
              child: const Text(
                "Share Now",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ButtonType { share, download, none }
