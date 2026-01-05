// import 'package:backup_ticket/views/ticketshare/ticket_share_screen.dart';
// import 'package:flutter/material.dart';

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
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: ListView(
//           children: [
//             _buildNotificationItem(
//               context: context,
//               title: "Share Your Bus Tracking\nand driver details.",
//               timeAgo: "5 min ago",
//               buttonType: ButtonType.share,
//             ),
//             const SizedBox(height: 12),
//             _buildNotificationItem(
//               context: context,
//               title: "Bus Tracking and driver\ndetails has been received.",
//               timeAgo: "5 min ago",
//               buttonType: ButtonType.download,
//             ),
//             const SizedBox(height: 12),
//             _buildNotificationItem(
//               context: context,
//               title: "Your Ticket has been\nDownloaded",
//               timeAgo: "5 min ago",
//               buttonType: ButtonType.none,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNotificationItem({
//     required BuildContext context,
//     required String title,
//     required String timeAgo,
//     required ButtonType buttonType,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Thumbnail Image
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(6),
//                 child: Image.asset(
//                   "assets/kubera.png",
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 12),

//               // Notification Text
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Time Ago
//               Text(
//                 timeAgo,
//                 style: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),

//           // Buttons Section
//           if (buttonType != ButtonType.none) ...[
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 const SizedBox(width: 62),
//                 Expanded(
//                   child: Container(
//                     height: 36,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(7),
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFF214194),
//                           Color(0xFF3F7EF3),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     ),
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         if (buttonType == ButtonType.share) {
//                           _showShareModal(context);
//                         } else if (buttonType == ButtonType.download) {
//                           print("Download Details pressed");
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(7),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                       ),
//                       icon: buttonType == ButtonType.download
//                           ? const Icon(Icons.save_alt_outlined, size: 16, color: Colors.white)
//                           : const SizedBox.shrink(),
//                       label: Text(
//                         buttonType == ButtonType.share
//                             ? "Share Now"
//                             : "Download Details",
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ],
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

//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>TicketShareScreen()));

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

// enum ButtonType { share, download, none }

















// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/views/ticketshare/ticket_share_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   List<dynamic> notifications = [];
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     fetchNotifications();
//   }

//   Future<void> fetchNotifications() async {
//     try {
//       // Get user ID from SharedPreferences
//       final user = await SharedPrefsHelper.getUser();
//       if (user == null) {
//         setState(() {
//           errorMessage = "User not found. Please login again.";
//           isLoading = false;
//         });
//         return;
//       }

//       final userId = user.id;
//       final url = 'http://31.97.206.144:8127/api/auth/mynotification/$userId';

//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       print('response status code for notification ${response.statusCode}');
//             print('response bodyyyyyyyyy for notification ${response.body}');


//      if (response.statusCode == 200) {
//   final data = jsonDecode(response.body);
//   setState(() {
//     notifications = data['data'] ?? []; // ✅ FIXED
//     isLoading = false;
//   });
// } else {
//         setState(() {
//           errorMessage = "Failed to load notifications";
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error: $e";
//         isLoading = false;
//       });
//     }
//   }

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
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         errorMessage!,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             isLoading = true;
//                             errorMessage = null;
//                           });
//                           fetchNotifications();
//                         },
//                         child: const Text("Retry"),
//                       ),
//                     ],
//                   ),
//                 )
//               : notifications.isEmpty
//                   ? const Center(
//                       child: Text(
//                         "No notifications available",
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                     )
//                   : Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: ListView.separated(
//                         itemCount: notifications.length,
//                         separatorBuilder: (context, index) =>
//                             const SizedBox(height: 12),
//                         itemBuilder: (context, index) {
//                           final notification = notifications[index];
//                           return _buildNotificationItem(
//                             context: context,
//                             notification: notification,
//                           );
//                         },
//                       ),
//                     ),
//     );
//   }

//   Widget _buildNotificationItem({
//     required BuildContext context,
//     required Map<String, dynamic> notification,
//   }) {
//     final String title = notification['title'] ?? 'No title';
//     final String message = notification['message'] ?? '';
//     final String? imageUrl = notification['image'];
//     final String createdAt = notification['createdAt'] ?? '';
//     final String notificationType = notification['notificationType'] ?? '';

//     // Determine button type based on notification type or title
//     ButtonType buttonType = ButtonType.none;
//     if (notificationType.toLowerCase().contains('share') ||
//         title.toLowerCase().contains('share')) {
//       buttonType = ButtonType.share;
//     } else if (notificationType.toLowerCase().contains('download') ||
//         title.toLowerCase().contains('received')) {
//       buttonType = ButtonType.download;
//     }

//     // Calculate time ago
//     String timeAgo = _getTimeAgo(createdAt);

//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Thumbnail Image
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(6),
//                 child: imageUrl != null && imageUrl.isNotEmpty
//                     ? Image.network(
//                         imageUrl,
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Image.asset(
//                             "assets/kubera.png",
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           );
//                         },
//                       )
//                     : Image.asset(
//                         "assets/kubera.png",
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                       ),
//               ),
//               const SizedBox(width: 12),

//               // Notification Text
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     if (message.isNotEmpty) ...[
//                       const SizedBox(height: 4),
//                       Text(
//                         message,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),

//               // Time Ago
//               Text(
//                 timeAgo,
//                 style: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),

//           // Buttons Section
//           if (buttonType != ButtonType.none) ...[
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 const SizedBox(width: 62),
//                 Expanded(
//                   child: Container(
//                     height: 36,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(7),
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFF214194),
//                           Color(0xFF3F7EF3),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     ),
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         if (buttonType == ButtonType.share) {
//                           _showShareModal(context, notification);
//                         } else if (buttonType == ButtonType.download) {
//                           print("Download Details pressed");
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(7),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                       ),
//                       icon: buttonType == ButtonType.download
//                           ? const Icon(Icons.save_alt_outlined,
//                               size: 16, color: Colors.white)
//                           : const SizedBox.shrink(),
//                       label: Text(
//                         buttonType == ButtonType.share
//                             ? "Share Now"
//                             : "Download Details",
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   String _getTimeAgo(String dateString) {
//     try {
//       final DateTime dateTime = DateTime.parse(dateString);
//       final Duration difference = DateTime.now().difference(dateTime);

//       if (difference.inDays > 0) {
//         return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
//       } else if (difference.inHours > 0) {
//         return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
//       } else if (difference.inMinutes > 0) {
//         return '${difference.inMinutes} min ago';
//       } else {
//         return 'Just now';
//       }
//     } catch (e) {
//       return '';
//     }
//   }

//   // Modal Bottom Sheet for Share Now
//   void _showShareModal(BuildContext context, Map<String, dynamic> notification) {
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

// enum ButtonType { share, download, none }
















import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/views/ticketshare/ticket_share_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;
  String? errorMessage;

  static const String imageBaseUrl = "http://31.97.206.144:8127";

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      final user = await SharedPrefsHelper.getUser();
      if (user == null) {
        setState(() {
          errorMessage = "User not found. Please login again.";
          isLoading = false;
        });
        return;
      }

      final url =
          'http://31.97.206.144:8127/api/auth/mynotification/${user.id}';

      final response = await http.get(Uri.parse(url));

      print('response status code for notification ${response.statusCode}');
      print('response bodyyyyyyyyy for notification ${response.body}');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        setState(() {
          notifications =
              List<Map<String, dynamic>>.from(decoded['data'] ?? []);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Failed to load notifications";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: $e";
        isLoading = false;
      });
    }
  }

  String _buildImageUrl(String path) {
    if (path.startsWith('http')) return path;
    return "$imageBaseUrl$path";
  }

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : notifications.isEmpty
                  ? const Center(
                      child: Text("No notifications available"),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: notifications.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return _buildNotificationItem(notifications[index]);
                      },
                    ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final String title = notification['MovieName'] ?? 'No title';
    final String message = notification['message'] ?? '';
    final String imagePath = notification['ticketImage'] ?? '';
    final String createdAt = notification['date'] ?? '';
    final String type = notification['type'] ?? '';

    ButtonType buttonType =
        type.toLowerCase() == 'order' ? ButtonType.share : ButtonType.none;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  _buildImageUrl(imagePath),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    "assets/kubera.png",
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Text(
                _getTimeAgo(createdAt),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          // if (buttonType == ButtonType.share) ...[
          //   const SizedBox(height: 12),
          //   Align(
          //     alignment: Alignment.centerRight,
          //     child: ElevatedButton(
          //       onPressed: () => _showShareModal(context),
          //       child: const Text("Share Now"),
          //     ),
          //   )
          // ]
        ],
      ),
    );
  }

  String _getTimeAgo(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      final diff = DateTime.now().difference(dateTime);
      if (diff.inDays > 0) return "${diff.inDays} days ago";
      if (diff.inHours > 0) return "${diff.inHours} hours ago";
      if (diff.inMinutes > 0) return "${diff.inMinutes} mins ago";
      return "Just now";
    } catch (_) {
      return "";
    }
  }

  // void _showShareModal(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (_) => Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: ElevatedButton(
  //         onPressed: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (_) => const TicketShareScreen()),
  //           );
  //         },
  //         child: const Text("Share Now"),
  //       ),
  //     ),
  //   );
  // }
}

enum ButtonType { share, download, none }
