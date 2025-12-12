// // // import 'dart:io';
// // // import 'package:backup_ticket/model/movie_ticket_model.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_storage/firebase_storage.dart';
// // // import 'package:flutter/foundation.dart';
// // // import 'package:image_picker/image_picker.dart';

// // // class MovieTicketProvider with ChangeNotifier {
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // //   final FirebaseStorage _storage = FirebaseStorage.instance;
// // //   final String _collectionName = 'movie_tickets';

// // //   List<MovieTicket> _tickets = [];
// // //   bool _isLoading = false;
// // //   String? _error;

// // //   // Getters
// // //   List<MovieTicket> get tickets => _tickets;
// // //   bool get isLoading => _isLoading;
// // //   String? get error => _error;

// // //   // Set loading state
// // //   void _setLoading(bool loading) {
// // //     _isLoading = loading;
// // //     notifyListeners();
// // //   }

// // //   // Set error state
// // //   void _setError(String? error) {
// // //     _error = error;
// // //     notifyListeners();
// // //   }

// // //   // Upload image to Firebase Storage
// // //   Future<String?> uploadTicketImage(XFile imageFile, String ticketId) async {
// // //     try {
// // //       _setLoading(true);
      
// // //       final ref = _storage.ref().child('ticket_images/$ticketId.jpg');
      
// // //       if (kIsWeb) {
// // //         // For web platform
// // //         await ref.putData(await imageFile.readAsBytes());
// // //       } else {
// // //         // For mobile platforms
// // //         await ref.putFile(File(imageFile.path));
// // //       }
      
// // //       final downloadUrl = await ref.getDownloadURL();
// // //       return downloadUrl;
// // //     } catch (e) {
// // //       _setError('Failed to upload image: ${e.toString()}');
// // //       return null;
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }

// // //   // Create a new movie ticket
// // //   Future<String?> createMovieTicket(MovieTicket ticket, {XFile? imageFile}) async {
// // //     try {
// // //       _setLoading(true);
// // //       _setError(null);

// // //       // Add the ticket to Firestore first to get document ID
// // //       DocumentReference docRef = await _firestore
// // //           .collection(_collectionName)
// // //           .add(ticket.toMap());

// // //       String? imageUrl;
      
// // //       // Upload image if provided
// // //       if (imageFile != null) {
// // //         imageUrl = await uploadTicketImage(imageFile, docRef.id);
        
// // //         if (imageUrl != null) {
// // //           // Update the document with image URL
// // //           await docRef.update({'ticketImageUrl': imageUrl});
// // //         }
// // //       }

// // //       // Fetch updated tickets
// // //       await fetchAllTickets();
      
// // //       return docRef.id;
// // //     } catch (e) {
// // //       _setError('Failed to create ticket: ${e.toString()}');
// // //       return null;
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }

// // //   // Fetch all movie tickets
// // //   Future<void> fetchAllTickets() async {
// // //     try {
// // //       _setLoading(true);
// // //       _setError(null);

// // //       QuerySnapshot snapshot = await _firestore
// // //           .collection(_collectionName)
// // //           .orderBy('createdAt', descending: true)
// // //           .get();

// // //       _tickets = snapshot.docs.map((doc) {
// // //         return MovieTicket.fromMap(
// // //           doc.data() as Map<String, dynamic>,
// // //           doc.id,
// // //         );
// // //       }).toList();

// // //       notifyListeners();
// // //     } catch (e) {
// // //       _setError('Failed to fetch tickets: ${e.toString()}');
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }

// // //   // Fetch tickets by user email
// // //   Future<List<MovieTicket>> fetchTicketsByUser(String email) async {
// // //     try {
// // //       _setLoading(true);
// // //       _setError(null);

// // //       QuerySnapshot snapshot = await _firestore
// // //           .collection(_collectionName)
// // //           .where('email', isEqualTo: email)
// // //           .orderBy('createdAt', descending: true)
// // //           .get();

// // //       List<MovieTicket> userTickets = snapshot.docs.map((doc) {
// // //         return MovieTicket.fromMap(
// // //           doc.data() as Map<String, dynamic>,
// // //           doc.id,
// // //         );
// // //       }).toList();

// // //       return userTickets;
// // //     } catch (e) {
// // //       _setError('Failed to fetch user tickets: ${e.toString()}');
// // //       return [];
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }

// // //   // Update ticket status (for admin use)
// // //   Future<bool> updateTicketStatus(String ticketId, String status) async {
// // //     try {
// // //       _setLoading(true);
// // //       _setError(null);

// // //       await _firestore
// // //           .collection(_collectionName)
// // //           .doc(ticketId)
// // //           .update({'status': status});

// // //       // Update local list
// // //       int index = _tickets.indexWhere((ticket) => ticket.id == ticketId);
// // //       if (index != -1) {
// // //         _tickets[index] = _tickets[index].copyWith(status: status);
// // //         notifyListeners();
// // //       }

// // //       return true;
// // //     } catch (e) {
// // //       _setError('Failed to update ticket status: ${e.toString()}');
// // //       return false;
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }

// // //   // Delete a movie ticket
// // //   Future<bool> deleteMovieTicket(String ticketId) async {
// // //     try {
// // //       _setLoading(true);
// // //       _setError(null);

// // //       // Find the ticket to get image URL
// // //       MovieTicket? ticket = _tickets.firstWhere(
// // //         (t) => t.id == ticketId,
// // //         orElse: () => throw Exception('Ticket not found'),
// // //       );

// // //       // Delete image from storage if it exists
// // //       if (ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty) {
// // //         try {
// // //           await _storage.refFromURL(ticket.ticketImageUrl!).delete();
// // //         } catch (e) {
// // //           print('Failed to delete image: $e');
// // //         }
// // //       }

// // //       // Delete document from Firestore
// // //       await _firestore.collection(_collectionName).doc(ticketId).delete();

// // //       // Remove from local list
// // //       _tickets.removeWhere((ticket) => ticket.id == ticketId);
// // //       notifyListeners();

// // //       return true;
// // //     } catch (e) {
// // //       _setError('Failed to delete ticket: ${e.toString()}');
// // //       return false;
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }

// // //   // Get tickets by status
// // //   List<MovieTicket> getTicketsByStatus(String status) {
// // //     return _tickets.where((ticket) => ticket.status == status).toList();
// // //   }

// // //   // Get tickets by date range
// // //   List<MovieTicket> getTicketsByDateRange(DateTime startDate, DateTime endDate) {
// // //     return _tickets.where((ticket) {
// // //       return ticket.showDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
// // //              ticket.showDate.isBefore(endDate.add(const Duration(days: 1)));
// // //     }).toList();
// // //   }

// // //   // Stream tickets for real-time updates
// // //   Stream<List<MovieTicket>> streamTickets() {
// // //     return _firestore
// // //         .collection(_collectionName)
// // //         .orderBy('createdAt', descending: true)
// // //         .snapshots()
// // //         .map((snapshot) {
// // //       return snapshot.docs.map((doc) {
// // //         return MovieTicket.fromMap(
// // //           doc.data() as Map<String, dynamic>,
// // //           doc.id,
// // //         );
// // //       }).toList();
// // //     });
// // //   }

// // //   // Stream tickets by user
// // //   Stream<List<MovieTicket>> streamUserTickets(String email) {
// // //     return _firestore
// // //         .collection(_collectionName)
// // //         .where('email', isEqualTo: email)
// // //         .orderBy('createdAt', descending: true)
// // //         .snapshots()
// // //         .map((snapshot) {
// // //       return snapshot.docs.map((doc) {
// // //         return MovieTicket.fromMap(
// // //           doc.data() as Map<String, dynamic>,
// // //           doc.id,
// // //         );
// // //       }).toList();
// // //     });
// // //   }

// // //   // Clear error
// // //   void clearError() {
// // //     _setError(null);
// // //   }
// // // }













// // // ignore_for_file: unnecessary_cast

// // import 'dart:io';
// // import 'package:backup_ticket/model/movie_ticket_model.dart';
// // import 'package:backup_ticket/services/cloudinary_image_services.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:image_picker/image_picker.dart';

// // class MovieTicketProvider with ChangeNotifier {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final String _collectionName = 'movie_tickets';

// //   List<MovieTicket> _tickets = [];
// //   bool _isLoading = false;
// //   String? _error;

// //   // Getters
// //   List<MovieTicket> get tickets => _tickets;
// //   bool get isLoading => _isLoading;
// //   String? get error => _error;

// //   // Set loading state
// //   void _setLoading(bool loading) {
// //     _isLoading = loading;
// //     notifyListeners();
// //   }

// //   // Set error state
// //   void _setError(String? error) {
// //     _error = error;
// //     notifyListeners();
// //   }

// //   // Upload image to Cloudinary
// //   Future<String?> uploadTicketImage(XFile imageFile) async {
// //     try {
// //       _setLoading(true);
      
// //       String? imageUrl;
      
// //       if (kIsWeb) {
        
// //         final bytes = await imageFile.readAsBytes();
// //         imageUrl = await CloudinaryService.uploadImageFromBytes(bytes, imageFile.name);
// //       } else {
// //         final file = File(imageFile.path);
// //         imageUrl = await CloudinaryService.uploadImage(file);
// //       }
      
// //       return imageUrl;
// //     } catch (e) {
// //       _setError('Failed to upload image: ${e.toString()}');
// //       return null;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }

// //   // Create a new movie ticket
// //   Future<String?> createMovieTicket(MovieTicket ticket, {XFile? imageFile}) async {
// //     try {
// //       _setLoading(true);
// //       _setError(null);

// //       String? imageUrl;
      
// //       // Upload image to Cloudinary if provided
// //       if (imageFile != null) {
// //         imageUrl = await uploadTicketImage(imageFile);
        
// //         if (imageUrl == null) {
// //           _setError('Failed to upload image');
// //           return null;
// //         }
// //       }

// //       // Create ticket data with image URL
// //       Map<String, dynamic> ticketData = ticket.toMap();
// //       if (imageUrl != null) {
// //         ticketData['ticketImageUrl'] = imageUrl;
// //       }

// //       // Add the ticket to Firestore
// //       DocumentReference docRef = await _firestore
// //           .collection(_collectionName)
// //           .add(ticketData);

// //       // Fetch updated tickets
// //       await fetchAllTickets();
      
// //       return docRef.id;
// //     } catch (e) {
// //       _setError('Failed to create ticket: ${e.toString()}');
// //       return null;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }

// //   // Fetch all movie tickets
// //   Future<void> fetchAllTickets() async {
// //     try {
// //       _setLoading(true);
// //       _setError(null);

// //       QuerySnapshot snapshot = await _firestore
// //           .collection(_collectionName)
// //           .orderBy('createdAt', descending: true)
// //           .get();

// //       _tickets = snapshot.docs.map((doc) {
// //         return MovieTicket.fromMap(
// //           doc.data() as Map<String, dynamic>,
// //           doc.id,
// //         );
// //       }).toList();

// //       notifyListeners();
// //     } catch (e) {
// //       _setError('Failed to fetch tickets: ${e.toString()}');
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }

// //   // Fetch tickets by user email
// //   Future<List<MovieTicket>> fetchTicketsByUser(String email) async {
// //     try {
// //       _setLoading(true);
// //       _setError(null);

// //       QuerySnapshot snapshot = await _firestore
// //           .collection(_collectionName)
// //           .where('email', isEqualTo: email)
// //           .orderBy('createdAt', descending: true)
// //           .get();

// //       List<MovieTicket> userTickets = snapshot.docs.map((doc) {
// //         return MovieTicket.fromMap(
// //           doc.data() as Map<String, dynamic>,
// //           doc.id,
// //         );
// //       }).toList();

// //       return userTickets;
// //     } catch (e) {
// //       _setError('Failed to fetch user tickets: ${e.toString()}');
// //       return [];
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }

// //   // Update ticket status (for admin use)
// //   Future<bool> updateTicketStatus(String ticketId, String status) async {
// //     try {
// //       _setLoading(true);
// //       _setError(null);

// //       await _firestore
// //           .collection(_collectionName)
// //           .doc(ticketId)
// //           .update({'status': status});

// //       // Update local list
// //       int index = _tickets.indexWhere((ticket) => ticket.id == ticketId);
// //       if (index != -1) {
// //         _tickets[index] = _tickets[index].copyWith(status: status);
// //         notifyListeners();
// //       }

// //       return true;
// //     } catch (e) {
// //       _setError('Failed to update ticket status: ${e.toString()}');
// //       return false;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }

// //   // Delete a movie ticket
// //   Future<bool> deleteMovieTicket(String ticketId) async {
// //     try {
// //       _setLoading(true);
// //       _setError(null);

// //       // Find the ticket to get image URL
// //       MovieTicket? ticket = _tickets.firstWhere(
// //         (t) => t.id == ticketId,
// //         orElse: () => throw Exception('Ticket not found'),
// //       );

// //       // Delete image from Cloudinary if it exists
// //       if (ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty) {
// //         try {
// //           await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
// //         } catch (e) {
// //           print('Failed to delete image from Cloudinary: $e');
// //           // Continue with document deletion even if image deletion fails
// //         }
// //       }

// //       // Delete document from Firestore
// //       await _firestore.collection(_collectionName).doc(ticketId).delete();

// //       // Remove from local list
// //       _tickets.removeWhere((ticket) => ticket.id == ticketId);
// //       notifyListeners();

// //       return true;
// //     } catch (e) {
// //       _setError('Failed to delete ticket: ${e.toString()}');
// //       return false;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }

// //   // Get tickets by status
// //   List<MovieTicket> getTicketsByStatus(String status) {
// //     return _tickets.where((ticket) => ticket.status == status).toList();
// //   }

// //   // Get tickets by date range
// //   List<MovieTicket> getTicketsByDateRange(DateTime startDate, DateTime endDate) {
// //     return _tickets.where((ticket) {
// //       return ticket.showDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
// //              ticket.showDate.isBefore(endDate.add(const Duration(days: 1)));
// //     }).toList();
// //   }

// //   // Stream tickets for real-time updates
// //   Stream<List<MovieTicket>> streamTickets() {
// //     return _firestore
// //         .collection(_collectionName)
// //         .orderBy('createdAt', descending: true)
// //         .snapshots()
// //         .map((snapshot) {
// //       return snapshot.docs.map((doc) {
// //         return MovieTicket.fromMap(
// //           doc.data() as Map<String, dynamic>,
// //           doc.id,
// //         );
// //       }).toList();
// //     });
// //   }

// //   // Stream tickets by user
// //   Stream<List<MovieTicket>> streamUserTickets(String email) {
// //     return _firestore
// //         .collection(_collectionName)
// //         .where('email', isEqualTo: email)
// //         .orderBy('createdAt', descending: true)
// //         .snapshots()
// //         .map((snapshot) {
// //       return snapshot.docs.map((doc) {
// //         return MovieTicket.fromMap(
// //           doc.data() as Map<String, dynamic>,
// //           doc.id,
// //         );
// //       }).toList();
// //     });
// //   }

// //   // Clear error
// //   void clearError() {
// //     _setError(null);
// //   }
// // }













// import 'dart:io';
// import 'package:backup_ticket/model/movie_ticket_model.dart';
// import 'package:backup_ticket/services/cloudinary_image_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';

// class MovieTicketProvider with ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String _collectionName = 'movie_tickets';

//   List<MovieTicket> _tickets = [];
//   bool _isLoading = false;
//   String? _error;

//   // Getters
//   List<MovieTicket> get tickets => _tickets;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   // Set loading state
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   // Set error state
//   void _setError(String? error) {
//     _error = error;
//     notifyListeners();
//   }

//   // Upload image to Cloudinary
//   Future<String?> uploadTicketImage(XFile imageFile) async {
//     try {
//       _setLoading(true);
      
//       String? imageUrl;
      
//       if (kIsWeb) {
//         final bytes = await imageFile.readAsBytes();
//         imageUrl = await CloudinaryService.uploadImageFromBytes(bytes, imageFile.name);
//       } else {
//         final file = File(imageFile.path);
//         imageUrl = await CloudinaryService.uploadImage(file);
//       }
      
//       return imageUrl;
//     } catch (e) {
//       _setError('Failed to upload image: ${e.toString()}');
//       return null;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Upload QR code image to Cloudinary
//   Future<String?> uploadQrCodeImage(XFile qrCodeFile) async {
//     try {
//       _setLoading(true);
      
//       String? qrCodeUrl;
      
//       if (kIsWeb) {
//         final bytes = await qrCodeFile.readAsBytes();
//         qrCodeUrl = await CloudinaryService.uploadImageFromBytes(bytes, qrCodeFile.name);
//       } else {
//         final file = File(qrCodeFile.path);
//         qrCodeUrl = await CloudinaryService.uploadImage(file);
//       }
      
//       return qrCodeUrl;
//     } catch (e) {
//       _setError('Failed to upload QR code: ${e.toString()}');
//       return null;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Create a new movie ticket
//   Future<String?> createMovieTicket(
//     MovieTicket ticket, {
//     XFile? imageFile,
//     XFile? qrCodeFile, // New QR code parameter
//   }) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       String? imageUrl;
//       String? qrCodeUrl;
      
//       // Upload ticket image to Cloudinary if provided
//       if (imageFile != null) {
//         imageUrl = await uploadTicketImage(imageFile);
        
//         if (imageUrl == null) {
//           _setError('Failed to upload ticket image');
//           return null;
//         }
//       }

//       // Upload QR code image to Cloudinary if provided
//       if (qrCodeFile != null) {
//         qrCodeUrl = await uploadQrCodeImage(qrCodeFile);
        
//         if (qrCodeUrl == null) {
//           _setError('Failed to upload QR code image');
//           return null;
//         }
//       }

//       // Create ticket data with image URLs
//       Map<String, dynamic> ticketData = ticket.toMap();
//       if (imageUrl != null) {
//         ticketData['ticketImageUrl'] = imageUrl;
//       }
//       if (qrCodeUrl != null) {
//         ticketData['qrCodeImageUrl'] = qrCodeUrl;
//       }

//       // Add the ticket to Firestore
//       DocumentReference docRef = await _firestore
//           .collection(_collectionName)
//           .add(ticketData);

//       // Fetch updated tickets
//       await fetchAllTickets();
      
//       return docRef.id;
//     } catch (e) {
//       _setError('Failed to create ticket: ${e.toString()}');
//       return null;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Update movie ticket with new images
//   Future<bool> updateMovieTicket(
//     String ticketId,
//     MovieTicket updatedTicket, {
//     XFile? newImageFile,
//     XFile? newQrCodeFile,
//     bool removeExistingImage = false,
//     bool removeExistingQrCode = false,
//   }) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       // Find existing ticket
//       MovieTicket? existingTicket = _tickets.firstWhere(
//         (t) => t.id == ticketId,
//         orElse: () => throw Exception('Ticket not found'),
//       );

//       String? newImageUrl = existingTicket.ticketImageUrl;
//       String? newQrCodeUrl = existingTicket.qrCodeImageUrl;

//       // Handle ticket image update
//       if (removeExistingImage && existingTicket.ticketImageUrl != null) {
//         // Delete existing image from Cloudinary
//         try {
//           await CloudinaryService.deleteImage(existingTicket.ticketImageUrl!);
//         } catch (e) {
//           print('Failed to delete existing image: $e');
//         }
//         newImageUrl = null;
//       }

//       if (newImageFile != null) {
//         // Delete old image if exists
//         if (existingTicket.ticketImageUrl != null) {
//           try {
//             await CloudinaryService.deleteImage(existingTicket.ticketImageUrl!);
//           } catch (e) {
//             print('Failed to delete old image: $e');
//           }
//         }
//         // Upload new image
//         newImageUrl = await uploadTicketImage(newImageFile);
//         if (newImageUrl == null) {
//           _setError('Failed to upload new ticket image');
//           return false;
//         }
//       }

//       // Handle QR code image update
//       if (removeExistingQrCode && existingTicket.qrCodeImageUrl != null) {
//         // Delete existing QR code from Cloudinary
//         try {
//           await CloudinaryService.deleteImage(existingTicket.qrCodeImageUrl!);
//         } catch (e) {
//           print('Failed to delete existing QR code: $e');
//         }
//         newQrCodeUrl = null;
//       }

//       if (newQrCodeFile != null) {
//         // Delete old QR code if exists
//         if (existingTicket.qrCodeImageUrl != null) {
//           try {
//             await CloudinaryService.deleteImage(existingTicket.qrCodeImageUrl!);
//           } catch (e) {
//             print('Failed to delete old QR code: $e');
//           }
//         }
//         // Upload new QR code
//         newQrCodeUrl = await uploadQrCodeImage(newQrCodeFile);
//         if (newQrCodeUrl == null) {
//           _setError('Failed to upload new QR code image');
//           return false;
//         }
//       }

//       // Update ticket data
//       Map<String, dynamic> updateData = updatedTicket.toMap();
//       updateData['ticketImageUrl'] = newImageUrl;
//       updateData['qrCodeImageUrl'] = newQrCodeUrl;

//       // Update document in Firestore
//       await _firestore
//           .collection(_collectionName)
//           .doc(ticketId)
//           .update(updateData);

//       // Update local list
//       int index = _tickets.indexWhere((ticket) => ticket.id == ticketId);
//       if (index != -1) {
//         _tickets[index] = updatedTicket.copyWith(
//           id: ticketId,
//           ticketImageUrl: newImageUrl,
//           qrCodeImageUrl: newQrCodeUrl,
//         );
//         notifyListeners();
//       }

//       return true;
//     } catch (e) {
//       _setError('Failed to update ticket: ${e.toString()}');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Fetch all movie tickets
//   Future<void> fetchAllTickets() async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       QuerySnapshot snapshot = await _firestore
//           .collection(_collectionName)
//           .orderBy('createdAt', descending: true)
//           .get();

//       _tickets = snapshot.docs.map((doc) {
//         return MovieTicket.fromMap(
//           doc.data() as Map<String, dynamic>,
//           doc.id,
//         );
//       }).toList();

//       notifyListeners();
//     } catch (e) {
//       _setError('Failed to fetch tickets: ${e.toString()}');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Fetch tickets by user email
//   Future<List<MovieTicket>> fetchTicketsByUser(String email) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       QuerySnapshot snapshot = await _firestore
//           .collection(_collectionName)
//           .where('email', isEqualTo: email)
//           .orderBy('createdAt', descending: true)
//           .get();

//       List<MovieTicket> userTickets = snapshot.docs.map((doc) {
//         return MovieTicket.fromMap(
//           doc.data() as Map<String, dynamic>,
//           doc.id,
//         );
//       }).toList();

//       return userTickets;
//     } catch (e) {
//       _setError('Failed to fetch user tickets: ${e.toString()}');
//       return [];
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Update ticket status (for admin use)
//   Future<bool> updateTicketStatus(String ticketId, String status) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       await _firestore
//           .collection(_collectionName)
//           .doc(ticketId)
//           .update({'status': status});

//       // Update local list
//       int index = _tickets.indexWhere((ticket) => ticket.id == ticketId);
//       if (index != -1) {
//         _tickets[index] = _tickets[index].copyWith(status: status);
//         notifyListeners();
//       }

//       return true;
//     } catch (e) {
//       _setError('Failed to update ticket status: ${e.toString()}');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }// Delete a movie ticket
//   Future<bool> deleteMovieTicket(String ticketId) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       // Find the ticket to get image URLs
//       MovieTicket? ticket = _tickets.firstWhere(
//         (t) => t.id == ticketId,
//         orElse: () => throw Exception('Ticket not found'),
//       );

//       // Delete ticket image from Cloudinary if it exists
//       if (ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty) {
//         try {
//           await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
//         } catch (e) {
//           print('Failed to delete ticket image from Cloudinary: $e');
//         }
//       }

//       // Delete QR code image from Cloudinary if it exists
//       if (ticket.qrCodeImageUrl != null && ticket.qrCodeImageUrl!.isNotEmpty) {
//         try {
//           await CloudinaryService.deleteImage(ticket.qrCodeImageUrl!);
//         } catch (e) {
//           print('Failed to delete QR code image from Cloudinary: $e');
//         }
//       }

//       // Delete document from Firestore
//       await _firestore.collection(_collectionName).doc(ticketId).delete();

//       // Remove from local list
//       _tickets.removeWhere((ticket) => ticket.id == ticketId);
//       notifyListeners();

//       return true;
//     } catch (e) {
//       _setError('Failed to delete ticket: ${e.toString()}');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Get tickets by status
//   List<MovieTicket> getTicketsByStatus(String status) {
//     return _tickets.where((ticket) => ticket.status == status).toList();
//   }

//   // Get tickets by date range
//   List<MovieTicket> getTicketsByDateRange(DateTime startDate, DateTime endDate) {
//     return _tickets.where((ticket) {
//       return ticket.showDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
//              ticket.showDate.isBefore(endDate.add(const Duration(days: 1)));
//     }).toList();
//   }

//   // Stream tickets for real-time updates
//   Stream<List<MovieTicket>> streamTickets() {
//     return _firestore
//         .collection(_collectionName)
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return MovieTicket.fromMap(
//           // ignore: unnecessary_cast
//           doc.data() as Map<String, dynamic>,
//           doc.id,
//         );
//       }).toList();
//     });
//   }

//   // Stream tickets by user
//   Stream<List<MovieTicket>> streamUserTickets(String email) {
//     return _firestore
//         .collection(_collectionName)
//         .where('email', isEqualTo: email)
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return MovieTicket.fromMap(
//           doc.data() as Map<String, dynamic>,
//           doc.id,
//         );
//       }).toList();
//     });
//   }

//   // Clear error
//   void clearError() {
//     _setError(null);
//   }
// }















// import 'dart:io';
// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/model/movie_ticket_model.dart';
// import 'package:backup_ticket/services/cloudinary_image_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';

// class MovieTicketProvider with ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String _collectionName = 'movie_tickets';

//   List<MovieTicket> _tickets = [];
//   bool _isLoading = false;
//   String? _error;

//   // Getters
//   List<MovieTicket> get tickets => _tickets;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   // Set loading state
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   // Set error state
//   void _setError(String? error) {
//     _error = error;
//     notifyListeners();
//   }

//   // Upload image to Cloudinary
//   Future<String?> uploadTicketImage(XFile imageFile) async {
//     try {
//       _setLoading(true);

//       String? imageUrl;

//       if (kIsWeb) {
//         final bytes = await imageFile.readAsBytes();
//         imageUrl = await CloudinaryService.uploadImageFromBytes(bytes, imageFile.name);
//       } else {
//         final file = File(imageFile.path);
//         imageUrl = await CloudinaryService.uploadImage(file);
//       }

//       return imageUrl;
//     } catch (e) {
//       _setError('Failed to upload image: ${e.toString()}');
//       return null;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Upload QR code image to Cloudinary
//   Future<String?> uploadQrCodeImage(XFile qrCodeFile) async {
//     try {
//       _setLoading(true);

//       String? qrCodeUrl;

//       if (kIsWeb) {
//         final bytes = await qrCodeFile.readAsBytes();
//         qrCodeUrl = await CloudinaryService.uploadImageFromBytes(bytes, qrCodeFile.name);
//       } else {
//         final file = File(qrCodeFile.path);
//         qrCodeUrl = await CloudinaryService.uploadImage(file);
//       }

//       return qrCodeUrl;
//     } catch (e) {
//       _setError('Failed to upload QR code: ${e.toString()}');
//       return null;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Create a new movie ticket
//   Future<String?> createMovieTicket(
//     MovieTicket ticket, {
//     XFile? imageFile,
//     XFile? qrCodeFile,
//   }) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       String? imageUrl;
//       String? qrCodeUrl;

//       // Upload ticket image
//       if (imageFile != null) {
//         imageUrl = await uploadTicketImage(imageFile);
//         if (imageUrl == null) {
//           _setError('Failed to upload ticket image');
//           return null;
//         }
//       }

//       // Upload QR code
//       if (qrCodeFile != null) {
//         qrCodeUrl = await uploadQrCodeImage(qrCodeFile);
//         if (qrCodeUrl == null) {
//           _setError('Failed to upload QR code image');
//           return null;
//         }
//       }

//       // Get current userId from preferences
//       String? userId = await UserPreferences.getUserId();
//       if (userId == null) {
//         _setError("User not logged in");
//         return null;
//       }


//           Position position = await _getUserLocation();

//       // Create ticket data with userId and image URLs
//       Map<String, dynamic> ticketData = ticket.toMap();
//       ticketData['userId'] = userId;
//       if (imageUrl != null) ticketData['ticketImageUrl'] = imageUrl;
//       if (qrCodeUrl != null) ticketData['qrCodeImageUrl'] = qrCodeUrl;
//       ticketData['latitude'] = position.latitude;   // ✅ add latitude
//     ticketData['longitude'] = position.longitude; // ✅ add longitude
//       ticketData['createdAt'] = FieldValue.serverTimestamp();

//       // Save to Firestore
//       DocumentReference docRef =
//           await _firestore.collection(_collectionName).add(ticketData);

//       // Refresh local list
//       await fetchAllTickets();

//       return docRef.id;
//     } catch (e) {
//       _setError('Failed to create ticket: ${e.toString()}');
//       return null;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Update movie ticket
//   Future<bool> updateMovieTicket(
//     String ticketId,
//     MovieTicket updatedTicket, {
//     XFile? newImageFile,
//     XFile? newQrCodeFile,
//     bool removeExistingImage = false,
//     bool removeExistingQrCode = false,
//   }) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       MovieTicket? existingTicket = _tickets.firstWhere(
//         (t) => t.id == ticketId,
//         orElse: () => throw Exception('Ticket not found'),
//       );

//       String? newImageUrl = existingTicket.ticketImageUrl;
//       String? newQrCodeUrl = existingTicket.qrCodeImageUrl;

//       // Handle ticket image update
//       if (removeExistingImage && existingTicket.ticketImageUrl != null) {
//         try {
//           await CloudinaryService.deleteImage(existingTicket.ticketImageUrl!);
//         } catch (_) {}
//         newImageUrl = null;
//       }

//       if (newImageFile != null) {
//         if (existingTicket.ticketImageUrl != null) {
//           try {
//             await CloudinaryService.deleteImage(existingTicket.ticketImageUrl!);
//           } catch (_) {}
//         }
//         newImageUrl = await uploadTicketImage(newImageFile);
//         if (newImageUrl == null) {
//           _setError('Failed to upload new ticket image');
//           return false;
//         }
//       }

//       // Handle QR code update
//       if (removeExistingQrCode && existingTicket.qrCodeImageUrl != null) {
//         try {
//           await CloudinaryService.deleteImage(existingTicket.qrCodeImageUrl!);
//         } catch (_) {}
//         newQrCodeUrl = null;
//       }

//       if (newQrCodeFile != null) {
//         if (existingTicket.qrCodeImageUrl != null) {
//           try {
//             await CloudinaryService.deleteImage(existingTicket.qrCodeImageUrl!);
//           } catch (_) {}
//         }
//         newQrCodeUrl = await uploadQrCodeImage(newQrCodeFile);
//         if (newQrCodeUrl == null) {
//           _setError('Failed to upload new QR code image');
//           return false;
//         }
//       }

//       // Update Firestore
//       Map<String, dynamic> updateData = updatedTicket.toMap();
//       updateData['ticketImageUrl'] = newImageUrl;
//       updateData['qrCodeImageUrl'] = newQrCodeUrl;

//       await _firestore.collection(_collectionName).doc(ticketId).update(updateData);

//       // Update local cache
//       int index = _tickets.indexWhere((ticket) => ticket.id == ticketId);
//       if (index != -1) {
//         _tickets[index] = updatedTicket.copyWith(
//           id: ticketId,
//           ticketImageUrl: newImageUrl,
//           qrCodeImageUrl: newQrCodeUrl,
//         );
//         notifyListeners();
//       }

//       return true;
//     } catch (e) {
//       _setError('Failed to update ticket: ${e.toString()}');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Fetch all tickets (admin use)
//   Future<void> fetchAllTickets() async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       QuerySnapshot snapshot =
//           await _firestore.collection(_collectionName).orderBy('createdAt', descending: true).get();

//       _tickets = snapshot.docs.map((doc) {
//         return MovieTicket.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();

//       notifyListeners();
//     } catch (e) {
//       _setError('Failed to fetch tickets: ${e.toString()}');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Fetch tickets by current logged-in user
//   // Future<List<MovieTicket>> fetchCurrentUserTickets() async {
//   //   try {
//   //     _setLoading(true);
//   //     _setError(null);

//   //     String? userId = await UserPreferences.getUserId();
//   //     if (userId == null) {
//   //       _setError("User not logged in");
//   //       return [];
//   //     }

//   //     QuerySnapshot snapshot = await _firestore
//   //         .collection(_collectionName)
//   //         .where('userId', isEqualTo: userId)
//   //         .orderBy('createdAt', descending: true)
//   //         .get();

//   //     return snapshot.docs.map((doc) {
//   //       return MovieTicket.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//   //     }).toList();
//   //   } catch (e) {
//   //     _setError('Failed to fetch user tickets: ${e.toString()}');
//   //     return [];
//   //   } finally {
//   //     _setLoading(false);
//   //   }
//   // }



// Future<List<MovieTicket>> fetchCurrentUserTickets() async {
//   try {
//     _setLoading(true);
//     _setError(null);

//     String? userId = await UserPreferences.getUserId();
//     if (userId == null) {
//       _setError("User not logged in");
//       return [];
//     }

//     // Query without orderBy to avoid composite index requirement
//     QuerySnapshot snapshot = await _firestore
//         .collection(_collectionName)
//         .where('userId', isEqualTo: userId)
//         .get();

//     List<MovieTicket> tickets = snapshot.docs.map((doc) {
//       return MovieTicket.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//     }).toList();

//     // Sort in the app instead of in the query
//     tickets.sort((a, b) {
//       // Handle null createdAt values
//       if (a.createdAt == null && b.createdAt == null) return 0;
//       if (a.createdAt == null) return 1;
//       if (b.createdAt == null) return -1;
//       return b.createdAt!.compareTo(a.createdAt!); // Descending order (newest first)
//     });

//     return tickets;
//   } catch (e) {
//     _setError('Failed to fetch user tickets: ${e.toString()}');
//     return [];
//   } finally {
//     _setLoading(false);
//   }
// }
//   // Update ticket status
//   Future<bool> updateTicketStatus(String ticketId, String status) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       await _firestore.collection(_collectionName).doc(ticketId).update({'status': status});

//       int index = _tickets.indexWhere((ticket) => ticket.id == ticketId);
//       if (index != -1) {
//         _tickets[index] = _tickets[index].copyWith(status: status);
//         notifyListeners();
//       }

//       return true;
//     } catch (e) {
//       _setError('Failed to update ticket status: ${e.toString()}');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }





//   Future<Position> _getUserLocation() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Check if location services are enabled
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     throw Exception('Location services are disabled.');
//   }

//   // Check permission
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       throw Exception('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     throw Exception('Location permissions are permanently denied.');
//   }

//   return await Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.high,
//   );
// }




//   Future<MovieTicket?> getTicketByMovieName(String movieName) async {
//   try {
//     final snapshot = await _firestore
//         .collection(_collectionName)
//         .where('movieName', isEqualTo: movieName)
//         .limit(1)
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       final doc = snapshot.docs.first;
//       return MovieTicket.fromMap(doc.data(), doc.id);
//     }
//     return null;
//   } catch (e) {
//     debugPrint("Error fetching ticket by movieName: $e");
//     return null;
//   }
// }


//   // Delete ticket
//   Future<bool> deleteMovieTicket(String ticketId) async {
//     try {
//       _setLoading(true);
//       _setError(null);

//       MovieTicket? ticket = _tickets.firstWhere(
//         (t) => t.id == ticketId,
//         orElse: () => throw Exception('Ticket not found'),
//       );

//       if (ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty) {
//         try {
//           await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
//         } catch (_) {}
//       }

//       if (ticket.qrCodeImageUrl != null && ticket.qrCodeImageUrl!.isNotEmpty) {
//         try {
//           await CloudinaryService.deleteImage(ticket.qrCodeImageUrl!);
//         } catch (_) {}
//       }

//       await _firestore.collection(_collectionName).doc(ticketId).delete();

//       _tickets.removeWhere((ticket) => ticket.id == ticketId);
//       notifyListeners();

//       return true;
//     } catch (e) {
//       _setError('Failed to delete ticket: ${e.toString()}');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Helpers
//   List<MovieTicket> getTicketsByStatus(String status) {
//     return _tickets.where((ticket) => ticket.status == status).toList();
//   }

//   List<MovieTicket> getTicketsByDateRange(DateTime startDate, DateTime endDate) {
//     return _tickets.where((ticket) {
//       return ticket.showDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
//           ticket.showDate.isBefore(endDate.add(const Duration(days: 1)));
//     }).toList();
//   }

//   Stream<List<MovieTicket>> streamTickets() {
//     return _firestore
//         .collection(_collectionName)
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return MovieTicket.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();
//     });
//   }

//   Stream<List<MovieTicket>>streamUserTickets(String userId) {
//     return _firestore
//         .collection(_collectionName)
//         .where('userId', isEqualTo: userId)
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return MovieTicket.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();
//     });
//   }

//   void clearError() {
//     _setError(null);
//   }
// }













import 'dart:io';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/movie_ticket_model.dart';
import 'package:backup_ticket/services/cloudinary_image_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class MovieTicketProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'movie_tickets';

  List<MovieTicket> _tickets = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<MovieTicket> get tickets => _tickets;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error state
  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  // Upload image to Cloudinary
  Future<String?> uploadTicketImage(XFile imageFile) async {
    try {
      _setLoading(true);

      String? imageUrl;

      if (kIsWeb) {
        final bytes = await imageFile.readAsBytes();
        imageUrl = await CloudinaryService.uploadImageFromBytes(bytes, imageFile.name);
      } else {
        final file = File(imageFile.path);
        imageUrl = await CloudinaryService.uploadImage(file);
      }

      return imageUrl;
    } catch (e) {
      _setError('Failed to upload image: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Upload QR code image
  Future<String?> uploadQrCodeImage(XFile qrCodeFile) async {
    try {
      _setLoading(true);

      String? qrCodeUrl;

      if (kIsWeb) {
        final bytes = await qrCodeFile.readAsBytes();
        qrCodeUrl = await CloudinaryService.uploadImageFromBytes(bytes, qrCodeFile.name);
      } else {
        final file = File(qrCodeFile.path);
        qrCodeUrl = await CloudinaryService.uploadImage(file);
      }

      return qrCodeUrl;
    } catch (e) {
      _setError('Failed to upload QR code: ${e.toString()}');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Create a new movie ticket
  // Future<String?> createMovieTicket(
  //   MovieTicket ticket, {
  //   XFile? imageFile,
  //   XFile? qrCodeFile,
  // }) async {
  //   try {
  //     _setLoading(true);
  //     _setError(null);

  //     String? imageUrl;
  //     String? qrCodeUrl;

  //     if (imageFile != null) {
  //       imageUrl = await uploadTicketImage(imageFile);
  //       if (imageUrl == null) return null;
  //     }

  //     if (qrCodeFile != null) {
  //       qrCodeUrl = await uploadQrCodeImage(qrCodeFile);
  //       if (qrCodeUrl == null) return null;
  //     }

  //     String? userId = await UserPreferences.getUserId();
  //     if (userId == null) {
  //       _setError("User not logged in");
  //       return null;
  //     }

  //     // Position position = await _getUserLocation();

  //     Map<String, dynamic> ticketData = ticket.toMap();
  //     ticketData['userId'] = userId;
  //     ticketData['ticketImageUrl'] = imageUrl;
  //     ticketData['qrCodeImageUrl'] = qrCodeUrl;
  //     // ticketData['latitude'] = position.latitude;
  //     // ticketData['longitude'] = position.longitude;
  //     ticketData['createdAt'] = FieldValue.serverTimestamp();

  //     DocumentReference docRef =
  //         await _firestore.collection(_collectionName).add(ticketData);

  //     await fetchAllTickets();

  //     return docRef.id;
  //   } catch (e) {
  //     _setError('Failed to create ticket: ${e.toString()}');
  //     return null;
  //   } finally {
  //     _setLoading(false);
  //   }
  // }



// Create a new movie ticket
Future<String?> createMovieTicket(
  MovieTicket ticket, {
  XFile? imageFile,
  String? qrCodeLink, // Changed from XFile? qrCodeFile
}) async {
  try {
    _setLoading(true);
    _setError(null);

    String? imageUrl;

    if (imageFile != null) {
      imageUrl = await uploadTicketImage(imageFile);
      if (imageUrl == null) return null;
    }

    String? userId = await UserPreferences.getUserId();
    if (userId == null) {
      _setError("User not logged in");
      return null;
    }

    Map<String, dynamic> ticketData = ticket.toMap();
    ticketData['userId'] = userId;
    ticketData['ticketImageUrl'] = imageUrl;
    ticketData['qrCodeImageUrl'] = qrCodeLink; // Store the link directly
    ticketData['createdAt'] = FieldValue.serverTimestamp();

    DocumentReference docRef =
        await _firestore.collection(_collectionName).add(ticketData);

    await fetchAllTickets();

    return docRef.id;
  } catch (e) {
    _setError('Failed to create ticket: ${e.toString()}');
    return null;
  } finally {
    _setLoading(false);
  }
}

  // Update movie ticket
  // Future<bool> updateMovieTicket(
  //   String ticketId,
  //   MovieTicket updatedTicket, {
  //   XFile? newImageFile,
  //   XFile? newQrCodeFile,
  //   bool removeExistingImage = false,
  //   bool removeExistingQrCode = false,
  // }) async {
  //   try {
  //     _setLoading(true);
  //     _setError(null);

  //     MovieTicket? existingTicket = _tickets.firstWhere(
  //       (t) => t.id == ticketId,
  //       orElse: () => throw Exception('Ticket not found'),
  //     );

  //     String? newImageUrl = existingTicket.ticketImageUrl;
  //     String? newQrCodeUrl = existingTicket.qrCodeImageUrl;

  //     if (removeExistingImage && existingTicket.ticketImageUrl != null) {
  //       try {
  //         await CloudinaryService.deleteImage(existingTicket.ticketImageUrl!);
  //       } catch (_) {}
  //       newImageUrl = null;
  //     }

  //     if (newImageFile != null) {
  //       if (existingTicket.ticketImageUrl != null) {
  //         try {
  //           await CloudinaryService.deleteImage(existingTicket.ticketImageUrl!);
  //         } catch (_) {}
  //       }

  //       newImageUrl = await uploadTicketImage(newImageFile);
  //       if (newImageUrl == null) return false;
  //     }

  //     if (removeExistingQrCode && existingTicket.qrCodeImageUrl != null) {
  //       try {
  //         await CloudinaryService.deleteImage(existingTicket.qrCodeImageUrl!);
  //       } catch (_) {}
  //       newQrCodeUrl = null;
  //     }

  //     if (newQrCodeFile != null) {
  //       if (existingTicket.qrCodeImageUrl != null) {
  //         try {
  //           await CloudinaryService.deleteImage(existingTicket.qrCodeImageUrl!);
  //         } catch (_) {}
  //       }

  //       newQrCodeUrl = await uploadQrCodeImage(newQrCodeFile);
  //       if (newQrCodeUrl == null) return false;
  //     }

  //     Map<String, dynamic> updateData = updatedTicket.toMap();
  //     updateData['ticketImageUrl'] = newImageUrl;
  //     updateData['qrCodeImageUrl'] = newQrCodeUrl;

  //     await _firestore.collection(_collectionName).doc(ticketId).update(updateData);

  //     int index = _tickets.indexWhere((t) => t.id == ticketId);
  //     if (index != -1) {
  //       _tickets[index] = updatedTicket.copyWith(
  //         id: ticketId,
  //         ticketImageUrl: newImageUrl,
  //         qrCodeImageUrl: newQrCodeUrl,
  //       );
  //       notifyListeners();
  //     }

  //     return true;
  //   } catch (e) {
  //     _setError('Failed to update ticket: ${e.toString()}');
  //     return false;
  //   } finally {
  //     _setLoading(false);
  //   }
  // }



  Future<bool> updateMovieTicket(
  String ticketId,
  MovieTicket updatedTicket, {
  XFile? newImageFile,
  String? newQrCodeLink, // Changed from XFile? newQrCodeFile
  bool removeExistingImage = false,
  bool removeExistingQrCode = false,
}) async {
  try {
    _setLoading(true);
    _setError(null);

    MovieTicket? existingTicket = _tickets.firstWhere(
      (t) => t.id == ticketId,
      orElse: () => throw Exception('Ticket not found'),
    );

    String? newImageUrl = existingTicket.ticketImageUrl;
    String? qrCodeUrl = existingTicket.qrCodeImageUrl;

    if (removeExistingImage && existingTicket.ticketImageUrl != null) {
      try {
        await CloudinaryService.deleteImage(existingTicket.ticketImageUrl!);
      } catch (_) {}
      newImageUrl = null;
    }

    if (newImageFile != null) {
      if (existingTicket.ticketImageUrl != null) {
        try {
          await CloudinaryService.deleteImage(existingTicket.ticketImageUrl!);
        } catch (_) {}
      }

      newImageUrl = await uploadTicketImage(newImageFile);
      if (newImageUrl == null) return false;
    }

    // Handle QR code link
    if (removeExistingQrCode) {
      qrCodeUrl = null;
    }

    if (newQrCodeLink != null && newQrCodeLink.isNotEmpty) {
      qrCodeUrl = newQrCodeLink; // Simply store the new link
    }

    Map<String, dynamic> updateData = updatedTicket.toMap();
    updateData['ticketImageUrl'] = newImageUrl;
    updateData['qrCodeImageUrl'] = qrCodeUrl;

    await _firestore.collection(_collectionName).doc(ticketId).update(updateData);

    int index = _tickets.indexWhere((t) => t.id == ticketId);
    if (index != -1) {
      _tickets[index] = updatedTicket.copyWith(
        id: ticketId,
        ticketImageUrl: newImageUrl,
        qrCodeImageUrl: qrCodeUrl,
      );
      notifyListeners();
    }

    return true;
  } catch (e) {
    _setError('Failed to update ticket: ${e.toString()}');
    return false;
  } finally {
    _setLoading(false);
  }
}

  // Fetch all tickets
  Future<void> fetchAllTickets() async {
    try {
      _setLoading(true);
      _setError(null);

      QuerySnapshot snapshot = await _firestore
          .collection(_collectionName)
          .orderBy('createdAt', descending: true)
          .get();

      _tickets = snapshot.docs.map((doc) {
        return MovieTicket.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      notifyListeners();
    } catch (e) {
      _setError('Failed to fetch tickets: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Fetch tickets by logged in user
  Future<List<MovieTicket>> fetchCurrentUserTickets() async {
    try {
      _setLoading(true);
      _setError(null);

      String? userId = await UserPreferences.getUserId();
      if (userId == null) return [];

      QuerySnapshot snapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .get();

      List<MovieTicket> tickets = snapshot.docs.map((doc) {
        return MovieTicket.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      tickets.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return tickets;
    } catch (e) {
      _setError('Failed to fetch user tickets: ${e.toString()}');
      return [];
    } finally {
      _setLoading(false);
    }
  }

  // ⭐⭐⭐ UPDATE TICKET STATUS USING ENUM
  Future<bool> updateTicketStatus(String ticketId, TicketStatus status) async {
    try {
      _setLoading(true);
      _setError(null);

      await _firestore.collection(_collectionName).doc(ticketId)
          .update({'status': status.name});

      int index = _tickets.indexWhere((t) => t.id == ticketId);
      if (index != -1) {
        _tickets[index] = _tickets[index].copyWith(status: status);
        notifyListeners();
      }

      return true;
    } catch (e) {
      _setError('Failed to update ticket status: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Get user location
  // Future<Position> _getUserLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     throw Exception('Location services are disabled.');
  //   }

  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       throw Exception('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     throw Exception('Location permissions are permanently denied.');
  //   }

  //   return await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  // }
  // Fetch ticket by movieName
  Future<MovieTicket?> getTicketByMovieName(String movieName) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('movieName', isEqualTo: movieName)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        return MovieTicket.fromMap(doc.data(), doc.id);
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching ticket by movieName: $e");
      return null;
    }
  }



  // Update ticket quantity (for partial purchases)
Future<bool> updateTicketQuantity(String ticketId, int newQuantity) async {
  try {
    _setLoading(true);
    _setError(null);

    await _firestore
        .collection(_collectionName)
        .doc(ticketId)
        .update({'numberOfTickets': newQuantity});

    // Update local list
    int index = _tickets.indexWhere((t) => t.id == ticketId);
    if (index != -1) {
      _tickets[index] = _tickets[index].copyWith(
        numberOfTickets: newQuantity,
      );
      notifyListeners();
    }

    return true;
  } catch (e) {
    _setError('Failed to update ticket quantity: ${e.toString()}');
    return false;
  } finally {
    _setLoading(false);
  }
}

// Delete ticket (alias for deleteMovieTicket for consistency)
Future<bool> deleteTicket(String ticketId) async {
  return await deleteMovieTicket(ticketId);
}

  // Delete ticket
  // Future<bool> deleteMovieTicket(String ticketId) async {
  //   try {
  //     _setLoading(true);
  //     _setError(null);

  //     MovieTicket? ticket = _tickets.firstWhere(
  //       (t) => t.id == ticketId,
  //       orElse: () => throw Exception('Ticket not found'),
  //     );

  //     if (ticket.ticketImageUrl != null) {
  //       try {
  //         await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
  //       } catch (_) {}
  //     }

  //     if (ticket.qrCodeImageUrl != null) {
  //       try {
  //         await CloudinaryService.deleteImage(ticket.qrCodeImageUrl!);
  //       } catch (_) {}
  //     }

  //     await _firestore.collection(_collectionName).doc(ticketId).delete();

  //     _tickets.removeWhere((t) => t.id == ticketId);
  //     notifyListeners();

  //     return true;
  //   } catch (e) {
  //     _setError('Failed to delete ticket: ${e.toString()}');
  //     return false;
  //   } finally {
  //     _setLoading(false);
  //   }
  // }


  Future<bool> deleteMovieTicket(String ticketId) async {
  try {
    _setLoading(true);
    _setError(null);

    MovieTicket? ticket = _tickets.firstWhere(
      (t) => t.id == ticketId,
      orElse: () => throw Exception('Ticket not found'),
    );

    // Only delete ticket image from Cloudinary, not QR code (it's just a link now)
    if (ticket.ticketImageUrl != null) {
      try {
        await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
      } catch (_) {}
    }

    await _firestore.collection(_collectionName).doc(ticketId).delete();

    _tickets.removeWhere((t) => t.id == ticketId);
    notifyListeners();

    return true;
  } catch (e) {
    _setError('Failed to delete ticket: ${e.toString()}');
    return false;
  } finally {
    _setLoading(false);
  }
}

  // ⭐⭐⭐ Filter Using Enum
  List<MovieTicket> getTicketsByStatus(TicketStatus status) {
    return _tickets.where((t) => t.status == status).toList();
  }

  List<MovieTicket> getTicketsByDateRange(DateTime start, DateTime end) {
    return _tickets.where((ticket) {
      return ticket.showDate.isAfter(start.subtract(Duration(days: 1))) &&
             ticket.showDate.isBefore(end.add(Duration(days: 1)));
    }).toList();
  }

  Stream<List<MovieTicket>> streamTickets() {
    return _firestore
        .collection(_collectionName)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MovieTicket.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Stream<List<MovieTicket>> streamUserTickets(String userId) {
    return _firestore
        .collection(_collectionName)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MovieTicket.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  void clearError() {
    _setError(null);
  }
}
