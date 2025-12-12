// // // providers/bus_ticket_provider.dart
// // import 'dart:io';
// // import 'package:backup_ticket/model/bus_ticket_model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:image_picker/image_picker.dart';
// // // import '../models/bus_ticket.dart'; // Import your model

// // class BusTicketProvider with ChangeNotifier {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseStorage _storage = FirebaseStorage.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final ImagePicker _imagePicker = ImagePicker();
  
// //   // Collection name
// //   static const String _collectionName = 'bus_tickets';
  
// //   bool _isLoading = false;
// //   bool get isLoading => _isLoading;
  
// //   List<BusTicket> _tickets = [];
// //   List<BusTicket> get tickets => _tickets;
  
// //   String? _selectedImagePath;
// //   String? get selectedImagePath => _selectedImagePath;
  
// //   // Set loading state
// //   void _setLoading(bool loading) {
// //     _isLoading = loading;
// //     notifyListeners();
// //   }
  
// //   // Pick image from gallery or camera
// //   Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
// //     try {
// //       final XFile? image = await _imagePicker.pickImage(
// //         source: source,
// //         maxWidth: 1024,
// //         maxHeight: 1024,
// //         imageQuality: 80,
// //       );
      
// //       if (image != null) {
// //         _selectedImagePath = image.path;
// //         notifyListeners();
// //       }
// //     } catch (e) {
// //       debugPrint('Error picking image: $e');
// //       throw Exception('Failed to pick image: $e');
// //     }
// //   }
  
// //   // Upload image to Firebase Storage
// //   Future<String?> _uploadImage(File imageFile) async {
// //     try {
// //       final String fileName = 'ticket_${DateTime.now().millisecondsSinceEpoch}.jpg';
// //       final Reference ref = _storage.ref().child('bus_tickets').child(fileName);
      
// //       final UploadTask uploadTask = ref.putFile(imageFile);
// //       final TaskSnapshot snapshot = await uploadTask;
      
// //       return await snapshot.ref.getDownloadURL();
// //     } catch (e) {
// //       debugPrint('Error uploading image: $e');
// //       return null;
// //     }
// //   }
  
// //   // Add new bus ticket
// //   Future<bool> addBusTicket(BusTicket ticket, {File? imageFile}) async {
// //     try {
// //       _setLoading(true);
      
// //       String? imageUrl;
// //       if (imageFile != null) {
// //         imageUrl = await _uploadImage(imageFile);
// //       }
      
// //       // Get current user ID
// //       final String sellerId = _auth.currentUser?.uid ?? 'anonymous';
      
// //       // Create ticket with image URL
// //       final ticketWithImage = ticket.copyWith(
// //         ticketImageUrl: imageUrl,
// //         sellerId: sellerId,
// //         createdAt: DateTime.now(),
// //       );
      
// //       // Add to Firestore
// //       final DocumentReference docRef = await _firestore
// //           .collection(_collectionName)
// //           .add(ticketWithImage.toMap());
      
// //       // Add to local list with document ID
// //       final newTicket = ticketWithImage.copyWith(id: docRef.id);
// //       _tickets.insert(0, newTicket);
      
// //       _selectedImagePath = null;
// //       _setLoading(false);
      
// //       return true;
// //     } catch (e) {
// //       _setLoading(false);
// //       debugPrint('Error adding bus ticket: $e');
// //       throw Exception('Failed to add bus ticket: $e');
// //     }
// //   }
  
// //   // Get all bus tickets for current user
// //   Future<void> fetchMyTickets() async {
// //     try {
// //       _setLoading(true);
      
// //       final String sellerId = _auth.currentUser?.uid ?? '';
// //       if (sellerId.isEmpty) {
// //         _setLoading(false);
// //         return;
// //       }
      
// //       final QuerySnapshot snapshot = await _firestore
// //           .collection(_collectionName)
// //           .where('sellerId', isEqualTo: sellerId)
// //           .orderBy('createdAt', descending: true)
// //           .get();
      
// //       _tickets = snapshot.docs.map((doc) => BusTicket.fromDocument(doc)).toList();
      
// //       _setLoading(false);
// //     } catch (e) {
// //       _setLoading(false);
// //       debugPrint('Error fetching tickets: $e');
// //       throw Exception('Failed to fetch tickets: $e');
// //     }
// //   }
  
// //   // Get all available tickets (for buyers)
// //   Future<List<BusTicket>> fetchAvailableTickets({
// //     String? fromLocation,
// //     String? toLocation,
// //     DateTime? travelDate,
// //   }) async {
// //     try {
// //       Query query = _firestore
// //           .collection(_collectionName)
// //           .where('status', isEqualTo: 'active');
      
// //       if (travelDate != null) {
// //         final startOfDay = DateTime(travelDate.year, travelDate.month, travelDate.day);
// //         final endOfDay = startOfDay.add(const Duration(days: 1));
        
// //         query = query
// //             .where('dateOfJourney', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
// //             .where('dateOfJourney', isLessThan: Timestamp.fromDate(endOfDay));
// //       }
      
// //       query = query.orderBy('dateOfJourney', descending: false);
      
// //       final QuerySnapshot snapshot = await query.get();
// //       List<BusTicket> availableTickets = snapshot.docs
// //           .map((doc) => BusTicket.fromDocument(doc))
// //           .toList();
      
// //       // Filter by locations if provided
// //       if (fromLocation != null && fromLocation.isNotEmpty) {
// //         availableTickets = availableTickets.where((ticket) =>
// //             ticket.pickupPoint.toLowerCase().contains(fromLocation.toLowerCase())).toList();
// //       }
      
// //       if (toLocation != null && toLocation.isNotEmpty) {
// //         availableTickets = availableTickets.where((ticket) =>
// //             ticket.dropPoint.toLowerCase().contains(toLocation.toLowerCase())).toList();
// //       }
      
// //       return availableTickets;
// //     } catch (e) {
// //       debugPrint('Error fetching available tickets: $e');
// //       throw Exception('Failed to fetch available tickets: $e');
// //     }
// //   }
  
// //   // Update ticket status
// //   Future<bool> updateTicketStatus(String ticketId, String status) async {
// //     try {
// //       await _firestore
// //           .collection(_collectionName)
// //           .doc(ticketId)
// //           .update({'status': status});
      
// //       // Update local list
// //       final index = _tickets.indexWhere((ticket) => ticket.id == ticketId);
// //       if (index != -1) {
// //         _tickets[index] = _tickets[index].copyWith(status: status);
// //         notifyListeners();
// //       }
      
// //       return true;
// //     } catch (e) {
// //       debugPrint('Error updating ticket status: $e');
// //       return false;
// //     }
// //   }
  
// //   // Delete ticket
// //   Future<bool> deleteTicket(String ticketId) async {
// //     try {
// //       // Delete from Firestore
// //       await _firestore.collection(_collectionName).doc(ticketId).delete();
      
// //       // Remove from local list
// //       _tickets.removeWhere((ticket) => ticket.id == ticketId);
// //       notifyListeners();
      
// //       return true;
// //     } catch (e) {
// //       debugPrint('Error deleting ticket: $e');
// //       return false;
// //     }
// //   }
  
// //   // Get ticket by ID
// //   Future<BusTicket?> getTicketById(String ticketId) async {
// //     try {
// //       final DocumentSnapshot doc = await _firestore
// //           .collection(_collectionName)
// //           .doc(ticketId)
// //           .get();
      
// //       if (doc.exists) {
// //         return BusTicket.fromDocument(doc);
// //       }
// //       return null;
// //     } catch (e) {
// //       debugPrint('Error getting ticket by ID: $e');
// //       return null;
// //     }
// //   }
  
// //   // Search tickets
// //   Future<List<BusTicket>> searchTickets(String searchQuery) async {
// //     try {
// //       final QuerySnapshot snapshot = await _firestore
// //           .collection(_collectionName)
// //           .where('status', isEqualTo: 'active')
// //           .get();
      
// //       final List<BusTicket> allTickets = snapshot.docs
// //           .map((doc) => BusTicket.fromDocument(doc))
// //           .toList();
      
// //       // Filter tickets based on search query
// //       return allTickets.where((ticket) =>
// //           ticket.busName.toLowerCase().contains(searchQuery.toLowerCase()) ||
// //           ticket.pickupPoint.toLowerCase().contains(searchQuery.toLowerCase()) ||
// //           ticket.dropPoint.toLowerCase().contains(searchQuery.toLowerCase()) ||
// //           ticket.ticketType.toLowerCase().contains(searchQuery.toLowerCase())
// //       ).toList();
// //     } catch (e) {
// //       debugPrint('Error searching tickets: $e');
// //       return [];
// //     }
// //   }
  
// //   // Get ticket statistics for seller
// //   Future<Map<String, int>> getTicketStatistics() async {
// //     try {
// //       final String sellerId = _auth.currentUser?.uid ?? '';
// //       if (sellerId.isEmpty) {
// //         return {'total': 0, 'active': 0, 'sold': 0, 'cancelled': 0};
// //       }
      
// //       final QuerySnapshot snapshot = await _firestore
// //           .collection(_collectionName)
// //           .where('sellerId', isEqualTo: sellerId)
// //           .get();
      
// //       final List<BusTicket> tickets = snapshot.docs
// //           .map((doc) => BusTicket.fromDocument(doc))
// //           .toList();
      
// //       return {
// //         'total': tickets.length,
// //         'active': tickets.where((t) => t.status == 'active').length,
// //         'sold': tickets.where((t) => t.status == 'sold').length,
// //         'cancelled': tickets.where((t) => t.status == 'cancelled').length,
// //       };
// //     } catch (e) {
// //       debugPrint('Error getting statistics: $e');
// //       return {'total': 0, 'active': 0, 'sold': 0, 'cancelled': 0};
// //     }
// //   }
  
// //   // Clear selected image
// //   void clearSelectedImage() {
// //     _selectedImagePath = null;
// //     notifyListeners();
// //   }
  
// //   // Clear all tickets
// //   void clearTickets() {
// //     _tickets.clear();
// //     notifyListeners();
// //   }
// // }



















// // providers/bus_ticket_provider.dart
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:backup_ticket/model/bus_ticket_model.dart';
// import 'package:backup_ticket/services/cloudinary_image_services.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';

// class BusTicketProvider with ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final ImagePicker _imagePicker = ImagePicker();
  
//   // Collection name
//   static const String _collectionName = 'bus_tickets';
  
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
  
//   bool _isImageUploading = false;
//   bool get isImageUploading => _isImageUploading;
  
//   List<BusTicket> _tickets = [];
//   List<BusTicket> get tickets => _tickets;
  
//   String? _selectedImagePath;
//   String? get selectedImagePath => _selectedImagePath;
  
//   XFile? _selectedImageFile;
//   XFile? get selectedImageFile => _selectedImageFile;
  
//   // Set loading state
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }
  
//   // Set image uploading state
//   void _setImageUploading(bool uploading) {
//     _isImageUploading = uploading;
//     notifyListeners();
//   }
  
//   // Pick image from gallery or camera
//   Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
//     try {
//       final XFile? image = await _imagePicker.pickImage(
//         source: source,
//         maxWidth: 1024,
//         maxHeight: 1024,
//         imageQuality: 80,
//       );
      
//       if (image != null) {
//         _selectedImagePath = image.path;
//         _selectedImageFile = image;
//         notifyListeners();
//       }
//     } catch (e) {
//       debugPrint('Error picking image: $e');
//       throw Exception('Failed to pick image: $e');
//     }
//   }
  
//   // Upload image to Cloudinary
//   Future<String?> _uploadImageToCloudinary(XFile imageFile) async {
//     try {
//       _setImageUploading(true);
      
//       String? imageUrl;
      
//       if (kIsWeb) {
//         // For web platform, read as bytes
//         final Uint8List imageBytes = await imageFile.readAsBytes();
//         final String fileName = 'bus_ticket_${DateTime.now().millisecondsSinceEpoch}.jpg';
//         imageUrl = await CloudinaryService.uploadImageFromBytes(imageBytes, fileName);
//       } else {
//         // For mobile/desktop platforms, use file path
//         final File file = File(imageFile.path);
//         imageUrl = await CloudinaryService.uploadImage(file);
//       }
      
//       _setImageUploading(false);
      
//       if (imageUrl != null) {
//         debugPrint('Image uploaded successfully to Cloudinary: $imageUrl');
//       } else {
//         debugPrint('Failed to upload image to Cloudinary');
//       }
      
//       return imageUrl;
//     } catch (e) {
//       _setImageUploading(false);
//       debugPrint('Error uploading image to Cloudinary: $e');
//       return null;
//     }
//   }
  
//   // Add new bus ticket
//   Future<bool> addBusTicket(BusTicket ticket, {File? imageFile}) async {
//     try {
//       _setLoading(true);
      
//       String? imageUrl;
      
//       // Upload image to Cloudinary if available
//       if (_selectedImageFile != null) {
//         imageUrl = await _uploadImageToCloudinary(_selectedImageFile!);
        
//         if (imageUrl == null) {
//           _setLoading(false);
//           throw Exception('Failed to upload image to Cloudinary');
//         }
//       } else if (imageFile != null) {
//         // Fallback for direct file upload
//         imageUrl = await CloudinaryService.uploadImage(imageFile);
        
//         if (imageUrl == null) {
//           _setLoading(false);
//           throw Exception('Failed to upload image to Cloudinary');
//         }
//       }
      
//       // Get current user ID
//       final String sellerId = _auth.currentUser?.uid ?? 'anonymous';
      
//       // Create ticket with Cloudinary image URL
//       final ticketWithImage = ticket.copyWith(
//         ticketImageUrl: imageUrl,
//         sellerId: sellerId,
//         createdAt: DateTime.now(),
//       );
      
//       // Add to Firestore
//       final DocumentReference docRef = await _firestore
//           .collection(_collectionName)
//           .add(ticketWithImage.toMap());
      
//       // Add to local list with document ID
//       final newTicket = ticketWithImage.copyWith(id: docRef.id);
//       _tickets.insert(0, newTicket);
      
//       // Clear selected image after successful upload
//       _selectedImagePath = null;
//       _selectedImageFile = null;
//       _setLoading(false);
      
//       return true;
//     } catch (e) {
//       _setLoading(false);
//       debugPrint('Error adding bus ticket: $e');
//       throw Exception('Failed to add bus ticket: $e');
//     }
//   }
  
//   // Get all bus tickets for current user
//   Future<void> fetchMyTickets() async {
//     try {
//       _setLoading(true);
      
//       final String sellerId = _auth.currentUser?.uid ?? '';
//       if (sellerId.isEmpty) {
//         _setLoading(false);
//         return;
//       }
      
//       final QuerySnapshot snapshot = await _firestore
//           .collection(_collectionName)
//           .where('sellerId', isEqualTo: sellerId)
//           .orderBy('createdAt', descending: true)
//           .get();
      
//       _tickets = snapshot.docs.map((doc) => BusTicket.fromDocument(doc)).toList();
      
//       _setLoading(false);
//     } catch (e) {
//       _setLoading(false);
//       debugPrint('Error fetching tickets: $e');
//       throw Exception('Failed to fetch tickets: $e');
//     }
//   }
  
//   // Get all available tickets (for buyers)
//   Future<List<BusTicket>> fetchAvailableTickets({
//     String? fromLocation,
//     String? toLocation,
//     DateTime? travelDate,
//   }) async {
//     try {
//       Query query = _firestore
//           .collection(_collectionName)
//           .where('status', isEqualTo: 'active');
      
//       if (travelDate != null) {
//         final startOfDay = DateTime(travelDate.year, travelDate.month, travelDate.day);
//         final endOfDay = startOfDay.add(const Duration(days: 1));
        
//         query = query
//             .where('dateOfJourney', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
//             .where('dateOfJourney', isLessThan: Timestamp.fromDate(endOfDay));
//       }
      
//       query = query.orderBy('dateOfJourney', descending: false);
      
//       final QuerySnapshot snapshot = await query.get();
//       List<BusTicket> availableTickets = snapshot.docs
//           .map((doc) => BusTicket.fromDocument(doc))
//           .toList();
      
//       // Filter by locations if provided
//       if (fromLocation != null && fromLocation.isNotEmpty) {
//         availableTickets = availableTickets.where((ticket) =>
//             ticket.pickupPoint.toLowerCase().contains(fromLocation.toLowerCase())).toList();
//       }
      
//       if (toLocation != null && toLocation.isNotEmpty) {
//         availableTickets = availableTickets.where((ticket) =>
//             ticket.dropPoint.toLowerCase().contains(toLocation.toLowerCase())).toList();
//       }
      
//       return availableTickets;
//     } catch (e) {
//       debugPrint('Error fetching available tickets: $e');
//       throw Exception('Failed to fetch available tickets: $e');
//     }
//   }
  
//   // Update ticket status
//   Future<bool> updateTicketStatus(String ticketId, String status) async {
//     try {
//       await _firestore
//           .collection(_collectionName)
//           .doc(ticketId)
//           .update({'status': status});
      
//       // Update local list
//       final index = _tickets.indexWhere((ticket) => ticket.id == ticketId);
//       if (index != -1) {
//         _tickets[index] = _tickets[index].copyWith(status: status);
//         notifyListeners();
//       }
      
//       return true;
//     } catch (e) {
//       debugPrint('Error updating ticket status: $e');
//       return false;
//     }
//   }
  
//   // Delete ticket with Cloudinary image cleanup
//   Future<bool> deleteTicket(String ticketId) async {
//     try {
//       // Get ticket data first to retrieve image URL
//       final ticket = await getTicketById(ticketId);
      
//       // Delete from Firestore
//       await _firestore.collection(_collectionName).doc(ticketId).delete();
      
//       // Delete image from Cloudinary if exists
//       if (ticket?.ticketImageUrl != null && ticket!.ticketImageUrl!.isNotEmpty) {
//         final success = await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
//         if (!success) {
//           debugPrint('Warning: Failed to delete image from Cloudinary: ${ticket.ticketImageUrl}');
//           // Continue with ticket deletion even if image deletion fails
//         }
//       }
      
//       // Remove from local list
//       _tickets.removeWhere((ticket) => ticket.id == ticketId);
//       notifyListeners();
      
//       return true;
//     } catch (e) {
//       debugPrint('Error deleting ticket: $e');
//       return false;
//     }
//   }
  
//   // Get ticket by ID
//   Future<BusTicket?> getTicketById(String ticketId) async {
//     try {
//       final DocumentSnapshot doc = await _firestore
//           .collection(_collectionName)
//           .doc(ticketId)
//           .get();
      
//       if (doc.exists) {
//         return BusTicket.fromDocument(doc);
//       }
//       return null;
//     } catch (e) {
//       debugPrint('Error getting ticket by ID: $e');
//       return null;
//     }
//   }
  
//   // Search tickets
//   Future<List<BusTicket>> searchTickets(String searchQuery) async {
//     try {
//       final QuerySnapshot snapshot = await _firestore
//           .collection(_collectionName)
//           .where('status', isEqualTo: 'active')
//           .get();
      
//       final List<BusTicket> allTickets = snapshot.docs
//           .map((doc) => BusTicket.fromDocument(doc))
//           .toList();
      
//       // Filter tickets based on search query
//       return allTickets.where((ticket) =>
//           ticket.busName.toLowerCase().contains(searchQuery.toLowerCase()) ||
//           ticket.pickupPoint.toLowerCase().contains(searchQuery.toLowerCase()) ||
//           ticket.dropPoint.toLowerCase().contains(searchQuery.toLowerCase()) ||
//           ticket.ticketType.toLowerCase().contains(searchQuery.toLowerCase())
//       ).toList();
//     } catch (e) {
//       debugPrint('Error searching tickets: $e');
//       return [];
//     }
//   }
  
//   // Get ticket statistics for seller
//   Future<Map<String, int>> getTicketStatistics() async {
//     try {
//       final String sellerId = _auth.currentUser?.uid ?? '';
//       if (sellerId.isEmpty) {
//         return {'total': 0, 'active': 0, 'sold': 0, 'cancelled': 0};
//       }
      
//       final QuerySnapshot snapshot = await _firestore
//           .collection(_collectionName)
//           .where('sellerId', isEqualTo: sellerId)
//           .get();
      
//       final List<BusTicket> tickets = snapshot.docs
//           .map((doc) => BusTicket.fromDocument(doc))
//           .toList();
      
//       return {
//         'total': tickets.length,
//         'active': tickets.where((t) => t.status == 'active').length,
//         'sold': tickets.where((t) => t.status == 'sold').length,
//         'cancelled': tickets.where((t) => t.status == 'cancelled').length,
//       };
//     } catch (e) {
//       debugPrint('Error getting statistics: $e');
//       return {'total': 0, 'active': 0, 'sold': 0, 'cancelled': 0};
//     }
//   }
  
//   // Get optimized image URL from Cloudinary
//   String getOptimizedImageUrl(String originalUrl, {
//     int? width,
//     int? height,
//     String quality = 'auto',
//     String format = 'auto',
//   }) {
//     return CloudinaryService.transformImageUrl(
//       originalUrl,
//       width: width,
//       height: height,
//       quality: quality,
//       format: format,
//     );
//   }
  
//   // Get thumbnail image URL
//   String getThumbnailUrl(String originalUrl) {
//     return getOptimizedImageUrl(
//       originalUrl,
//       width: 200,
//       height: 200,
//       quality: '80',
//     );
//   }
  
//   // Get full-size optimized image URL
//   String getFullSizeImageUrl(String originalUrl) {
//     return getOptimizedImageUrl(
//       originalUrl,
//       width: 1200,
//       quality: 'auto',
//       format: 'auto',
//     );
//   }
  
//   // Clear selected image
//   void clearSelectedImage() {
//     _selectedImagePath = null;
//     _selectedImageFile = null;
//     notifyListeners();
//   }
  
//   // Clear all tickets
//   void clearTickets() {
//     _tickets.clear();
//     notifyListeners();
//   }
  
//   // Bulk upload images (for multiple ticket images)
//   Future<List<String?>> uploadMultipleImages(List<XFile> imageFiles) async {
//     try {
//       _setImageUploading(true);
      
//       List<String?> imageUrls = [];
      
//       for (XFile imageFile in imageFiles) {
//         final String? imageUrl = await _uploadImageToCloudinary(imageFile);
//         imageUrls.add(imageUrl);
//       }
      
//       _setImageUploading(false);
//       return imageUrls;
//     } catch (e) {
//       _setImageUploading(false);
//       debugPrint('Error uploading multiple images: $e');
//       return [];
//     }
//   }
  
//   // Update ticket image
//   Future<bool> updateTicketImage(String ticketId, XFile newImageFile) async {
//     try {
//       _setImageUploading(true);
      
//       // Get current ticket to get old image URL
//       final ticket = await getTicketById(ticketId);
//       if (ticket == null) {
//         _setImageUploading(false);
//         return false;
//       }
      
//       // Upload new image
//       final String? newImageUrl = await _uploadImageToCloudinary(newImageFile);
//       if (newImageUrl == null) {
//         _setImageUploading(false);
//         return false;
//       }
      
//       // Update ticket in Firestore
//       await _firestore
//           .collection(_collectionName)
//           .doc(ticketId)
//           .update({'ticketImageUrl': newImageUrl});
      
//       // Delete old image from Cloudinary if exists
//       if (ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty) {
//         await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
//       }
      
//       // Update local list
//       final index = _tickets.indexWhere((t) => t.id == ticketId);
//       if (index != -1) {
//         _tickets[index] = _tickets[index].copyWith(ticketImageUrl: newImageUrl);
//         notifyListeners();
//       }
      
//       _setImageUploading(false);
//       return true;
//     } catch (e) {
//       _setImageUploading(false);
//       debugPrint('Error updating ticket image: $e');
//       return false;
//     }
//   }
// }














// import 'dart:io';
// import 'dart:typed_data';
// import 'package:backup_ticket/model/bus_ticket_model.dart';
// import 'package:backup_ticket/services/cloudinary_image_services.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';

// class BusTicketProvider with ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final ImagePicker _imagePicker = ImagePicker();
  
//   // Collection name
//   static const String _collectionName = 'bus_tickets';
  
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
  
//   bool _isImageUploading = false;
//   bool get isImageUploading => _isImageUploading;
  
//   List<BusTicket> _tickets = [];
//   List<BusTicket> get tickets => _tickets;
  
//   String? _selectedImagePath;
//   String? get selectedImagePath => _selectedImagePath;
  
//   XFile? _selectedImageFile;
//   XFile? get selectedImageFile => _selectedImageFile;
  
//   // Set loading state
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }
  
//   // Set image uploading state
//   void _setImageUploading(bool uploading) {
//     _isImageUploading = uploading;
//     notifyListeners();
//   }
  
//   // Pick image from gallery or camera
//   Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
//     try {
//       final XFile? image = await _imagePicker.pickImage(
//         source: source,
//         maxWidth: 1024,
//         maxHeight: 1024,
//         imageQuality: 80,
//       );
      
//       if (image != null) {
//         _selectedImagePath = image.path;
//         _selectedImageFile = image;
//         notifyListeners();
//       }
//     } catch (e) {
//       debugPrint('Error picking image: $e');
//       throw Exception('Failed to pick image: $e');
//     }
//   }
  
//   // Upload image to Cloudinary
//   Future<String?> _uploadImageToCloudinary(XFile imageFile) async {
//     try {
//       _setImageUploading(true);
      
//       String? imageUrl;
      
//       if (kIsWeb) {
//         // For web platform, read as bytes
//         final Uint8List imageBytes = await imageFile.readAsBytes();
//         final String fileName = 'bus_ticket_${DateTime.now().millisecondsSinceEpoch}.jpg';
//         imageUrl = await CloudinaryService.uploadImageFromBytes(imageBytes, fileName);
//       } else {
//         // For mobile/desktop platforms, use file path
//         final File file = File(imageFile.path);
//         imageUrl = await CloudinaryService.uploadImage(file);
//       }
      
//       _setImageUploading(false);
      
//       if (imageUrl != null) {
//         debugPrint('Image uploaded successfully to Cloudinary: $imageUrl');
//       } else {
//         debugPrint('Failed to upload image to Cloudinary');
//       }
      
//       return imageUrl;
//     } catch (e) {
//       _setImageUploading(false);
//       debugPrint('Error uploading image to Cloudinary: $e');
//       return null;
//     }
//   }
  
//   // Add new bus ticket
//   Future<bool> addBusTicket(BusTicket ticket, {File? imageFile}) async {
//     try {
//       _setLoading(true);
      
//       String? imageUrl;
      
//       // Upload image to Cloudinary if available
//       if (_selectedImageFile != null) {
//         imageUrl = await _uploadImageToCloudinary(_selectedImageFile!);
        
//         if (imageUrl == null) {
//           _setLoading(false);
//           throw Exception('Failed to upload image to Cloudinary');
//         }
//       } else if (imageFile != null) {
//         // Fallback for direct file upload
//         imageUrl = await CloudinaryService.uploadImage(imageFile);
        
//         if (imageUrl == null) {
//           _setLoading(false);
//           throw Exception('Failed to upload image to Cloudinary');
//         }
//       }
      
//       // Get current user ID
//       final String sellerId = _auth.currentUser?.uid ?? 'anonymous';
      
//       // Create ticket with Cloudinary image URL
//       final ticketWithImage = ticket.copyWith(
//         ticketImageUrl: imageUrl,
//         sellerId: sellerId,
//         createdAt: DateTime.now(),
//       );
      
//       // Add to Firestore
//       final DocumentReference docRef = await _firestore
//           .collection(_collectionName)
//           .add(ticketWithImage.toMap());
      
//       // Add to local list with document ID
//       final newTicket = ticketWithImage.copyWith(id: docRef.id);
//       _tickets.insert(0, newTicket);
      
//       // Clear selected image after successful upload
//       _selectedImagePath = null;
//       _selectedImageFile = null;
//       _setLoading(false);
      
//       return true;
//     } catch (e) {
//       _setLoading(false);
//       debugPrint('Error adding bus ticket: $e');
//       throw Exception('Failed to add bus ticket: $e');
//     }
//   }
  
//   // Get all bus tickets for current user
//   Future<void> fetchMyTickets() async {
//     try {
//       _setLoading(true);
      
//       final String sellerId = _auth.currentUser?.uid ?? '';
//       if (sellerId.isEmpty) {
//         _setLoading(false);
//         return;
//       }
      
//       final QuerySnapshot snapshot = await _firestore
//           .collection(_collectionName)
//           .where('sellerId', isEqualTo: sellerId)
//           .orderBy('createdAt', descending: true)
//           .get();
      
//       _tickets = snapshot.docs.map((doc) => BusTicket.fromDocument(doc)).toList();
      
//       _setLoading(false);
//     } catch (e) {
//       _setLoading(false);
//       debugPrint('Error fetching tickets: $e');
//       throw Exception('Failed to fetch tickets: $e');
//     }
//   }
  
//   // Get all available tickets (for buyers) - UPDATED TO SET _tickets
//   Future<void> fetchAvailableTickets({
//     String? fromLocation,
//     String? toLocation,
//     DateTime? travelDate,
//   }) async {
//     try {
//       _setLoading(true);
      
//       Query query = _firestore.collection(_collectionName);
      
//       // Apply filters based on whether date is selected or not
//       if (travelDate != null) {
//         final startOfDay = DateTime(travelDate.year, travelDate.month, travelDate.day);
//         final endOfDay = startOfDay.add(const Duration(days: 1));
        
//         // When date filter is applied, query by date range first
//         query = query
//             .where('dateOfJourney', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
//             .where('dateOfJourney', isLessThan: Timestamp.fromDate(endOfDay))
//             .orderBy('dateOfJourney', descending: false);
//       } else {
//         // Without date filter, just order by date
//         query = query.orderBy('dateOfJourney', descending: false);
//       }
      
//       final QuerySnapshot snapshot = await query.get();
      
//       // Filter status and locations in code to avoid index requirements
//       List<BusTicket> availableTickets = snapshot.docs
//           .map((doc) => BusTicket.fromDocument(doc))
//           .where((ticket) => ticket.status == 'active')
//           .toList();
      
//       // Filter by locations if provided
//       if (fromLocation != null && fromLocation.isNotEmpty) {
//         availableTickets = availableTickets.where((ticket) =>
//             ticket.pickupPoint.toLowerCase().contains(fromLocation.toLowerCase())).toList();
//       }
      
//       if (toLocation != null && toLocation.isNotEmpty) {
//         availableTickets = availableTickets.where((ticket) =>
//             ticket.dropPoint.toLowerCase().contains(toLocation.toLowerCase())).toList();
//       }
      
//       // Update the provider's tickets list
//       _tickets = availableTickets;
      
//       _setLoading(false);
//     } catch (e) {
//       _setLoading(false);
//       debugPrint('Error fetching available tickets: $e');
//       throw Exception('Failed to fetch available tickets: $e');
//     }
//   }
  
//   // Update ticket status
//   Future<bool> updateTicketStatus(String ticketId, String status) async {
//     try {
//       await _firestore
//           .collection(_collectionName)
//           .doc(ticketId)
//           .update({'status': status});
      
//       // Update local list
//       final index = _tickets.indexWhere((ticket) => ticket.id == ticketId);
//       if (index != -1) {
//         _tickets[index] = _tickets[index].copyWith(status: status);
//         notifyListeners();
//       }
      
//       return true;
//     } catch (e) {
//       debugPrint('Error updating ticket status: $e');
//       return false;
//     }
//   }
  
//   // Delete ticket with Cloudinary image cleanup
//   Future<bool> deleteTicket(String ticketId) async {
//     try {
//       // Get ticket data first to retrieve image URL
//       final ticket = await getTicketById(ticketId);
      
//       // Delete from Firestore
//       await _firestore.collection(_collectionName).doc(ticketId).delete();
      
//       // Delete image from Cloudinary if exists
//       if (ticket?.ticketImageUrl != null && ticket!.ticketImageUrl!.isNotEmpty) {
//         final success = await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
//         if (!success) {
//           debugPrint('Warning: Failed to delete image from Cloudinary: ${ticket.ticketImageUrl}');
//           // Continue with ticket deletion even if image deletion fails
//         }
//       }
      
//       // Remove from local list
//       _tickets.removeWhere((ticket) => ticket.id == ticketId);
//       notifyListeners();
      
//       return true;
//     } catch (e) {
//       debugPrint('Error deleting ticket: $e');
//       return false;
//     }
//   }
  
//   // Get ticket by ID
//   Future<BusTicket?> getTicketById(String ticketId) async {
//     try {
//       final DocumentSnapshot doc = await _firestore
//           .collection(_collectionName)
//           .doc(ticketId)
//           .get();
      
//       if (doc.exists) {
//         return BusTicket.fromDocument(doc);
//       }
//       return null;
//     } catch (e) {
//       debugPrint('Error getting ticket by ID: $e');
//       return null;
//     }
//   }
  
//   // Search tickets
//   Future<List<BusTicket>> searchTickets(String searchQuery) async {
//     try {
//       final QuerySnapshot snapshot = await _firestore
//           .collection(_collectionName)
//           .orderBy('dateOfJourney', descending: false)
//           .get();
      
//       final List<BusTicket> allTickets = snapshot.docs
//           .map((doc) => BusTicket.fromDocument(doc))
//           .where((ticket) => ticket.status == 'active')
//           .toList();
      
//       // Filter tickets based on search query
//       return allTickets.where((ticket) =>
//           ticket.busName.toLowerCase().contains(searchQuery.toLowerCase()) ||
//           ticket.pickupPoint.toLowerCase().contains(searchQuery.toLowerCase()) ||
//           ticket.dropPoint.toLowerCase().contains(searchQuery.toLowerCase()) ||
//           ticket.ticketType.toLowerCase().contains(searchQuery.toLowerCase())
//       ).toList();
//     } catch (e) {
//       debugPrint('Error searching tickets: $e');
//       return [];
//     }
//   }
  
//   // Get ticket statistics for seller
//   Future<Map<String, int>> getTicketStatistics() async {
//     try {
//       final String sellerId = _auth.currentUser?.uid ?? '';
//       if (sellerId.isEmpty) {
//         return {'total': 0, 'active': 0, 'sold': 0, 'cancelled': 0};
//       }
      
//       final QuerySnapshot snapshot = await _firestore
//           .collection(_collectionName)
//           .where('sellerId', isEqualTo: sellerId)
//           .get();
      
//       final List<BusTicket> tickets = snapshot.docs
//           .map((doc) => BusTicket.fromDocument(doc))
//           .toList();
      
//       return {
//         'total': tickets.length,
//         'active': tickets.where((t) => t.status == 'active').length,
//         'sold': tickets.where((t) => t.status == 'sold').length,
//         'cancelled': tickets.where((t) => t.status == 'cancelled').length,
//       };
//     } catch (e) {
//       debugPrint('Error getting statistics: $e');
//       return {'total': 0, 'active': 0, 'sold': 0, 'cancelled': 0};
//     }
//   }
  
//   // Get optimized image URL from Cloudinary
//   String getOptimizedImageUrl(String originalUrl, {
//     int? width,
//     int? height,
//     String quality = 'auto',
//     String format = 'auto',
//   }) {
//     return CloudinaryService.transformImageUrl(
//       originalUrl,
//       width: width,
//       height: height,
//       quality: quality,
//       format: format,
//     );
//   }
  
//   // Get thumbnail image URL
//   String getThumbnailUrl(String originalUrl) {
//     return getOptimizedImageUrl(
//       originalUrl,
//       width: 200,
//       height: 200,
//       quality: '80',
//     );
//   }
  
//   // Get full-size optimized image URL
//   String getFullSizeImageUrl(String originalUrl) {
//     return getOptimizedImageUrl(
//       originalUrl,
//       width: 1200,
//       quality: 'auto',
//       format: 'auto',
//     );
//   }
  
//   // Clear selected image
//   void clearSelectedImage() {
//     _selectedImagePath = null;
//     _selectedImageFile = null;
//     notifyListeners();
//   }
  
//   // Clear all tickets
//   void clearTickets() {
//     _tickets.clear();
//     notifyListeners();
//   }
  
//   // Bulk upload images (for multiple ticket images)
//   Future<List<String?>> uploadMultipleImages(List<XFile> imageFiles) async {
//     try {
//       _setImageUploading(true);
      
//       List<String?> imageUrls = [];
      
//       for (XFile imageFile in imageFiles) {
//         final String? imageUrl = await _uploadImageToCloudinary(imageFile);
//         imageUrls.add(imageUrl);
//       }
      
//       _setImageUploading(false);
//       return imageUrls;
//     } catch (e) {
//       _setImageUploading(false);
//       debugPrint('Error uploading multiple images: $e');
//       return [];
//     }
//   }
  
//   // Update ticket image
//   Future<bool> updateTicketImage(String ticketId, XFile newImageFile) async {
//     try {
//       _setImageUploading(true);
      
//       // Get current ticket to get old image URL
//       final ticket = await getTicketById(ticketId);
//       if (ticket == null) {
//         _setImageUploading(false);
//         return false;
//       }
      
//       // Upload new image
//       final String? newImageUrl = await _uploadImageToCloudinary(newImageFile);
//       if (newImageUrl == null) {
//         _setImageUploading(false);
//         return false;
//       }
      
//       // Update ticket in Firestore
//       await _firestore
//           .collection(_collectionName)
//           .doc(ticketId)
//           .update({'ticketImageUrl': newImageUrl});
      
//       // Delete old image from Cloudinary if exists
//       if (ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty) {
//         await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
//       }
      
//       // Update local list
//       final index = _tickets.indexWhere((t) => t.id == ticketId);
//       if (index != -1) {
//         _tickets[index] = _tickets[index].copyWith(ticketImageUrl: newImageUrl);
//         notifyListeners();
//       }
      
//       _setImageUploading(false);
//       return true;
//     } catch (e) {
//       _setImageUploading(false);
//       debugPrint('Error updating ticket image: $e');
//       return false;
//     }
//   }
// }
















import 'dart:io';
import 'dart:typed_data';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/bus_ticket_model.dart';
import 'package:backup_ticket/services/cloudinary_image_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class BusTicketProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  
  // Collection name
  static const String _collectionName = 'bus_tickets';
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  bool _isImageUploading = false;
  bool get isImageUploading => _isImageUploading;
  
  List<BusTicket> _tickets = [];
  List<BusTicket> get tickets => _tickets;
  
  String? _selectedImagePath;
  String? get selectedImagePath => _selectedImagePath;
  
  XFile? _selectedImageFile;
  XFile? get selectedImageFile => _selectedImageFile;
  
  String? _error;
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
  
  // Set image uploading state
  void _setImageUploading(bool uploading) {
    _isImageUploading = uploading;
    notifyListeners();
  }
  
  // Pick image from gallery or camera
  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      
      if (image != null) {
        _selectedImagePath = image.path;
        _selectedImageFile = image;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      _setError('Failed to pick image: $e');
    }
  }
  
  // Upload image to Cloudinary
  Future<String?> _uploadImageToCloudinary(XFile imageFile) async {
    try {
      _setImageUploading(true);
      
      String? imageUrl;
      
      if (kIsWeb) {
        // For web platform, read as bytes
        final Uint8List imageBytes = await imageFile.readAsBytes();
        final String fileName = 'bus_ticket_${DateTime.now().millisecondsSinceEpoch}.jpg';
        imageUrl = await CloudinaryService.uploadImageFromBytes(imageBytes, fileName);
      } else {
        // For mobile/desktop platforms, use file path
        final File file = File(imageFile.path);
        imageUrl = await CloudinaryService.uploadImage(file);
      }
      
      _setImageUploading(false);
      
      if (imageUrl != null) {
        debugPrint('Image uploaded successfully to Cloudinary: $imageUrl');
      } else {
        debugPrint('Failed to upload image to Cloudinary');
      }
      
      return imageUrl;
    } catch (e) {
      _setImageUploading(false);
      debugPrint('Error uploading image to Cloudinary: $e');
      _setError('Failed to upload image: $e');
      return null;
    }
  }
  
  // Add new bus ticket
  Future<bool> addBusTicket(BusTicket ticket, {File? imageFile}) async {
    try {
      _setLoading(true);
      _setError(null);
      
      String? imageUrl;
      
      // Upload image to Cloudinary if available
      if (_selectedImageFile != null) {
        imageUrl = await _uploadImageToCloudinary(_selectedImageFile!);
        
        if (imageUrl == null) {
          _setLoading(false);
          _setError('Failed to upload image to Cloudinary');
          return false;
        }
      } else if (imageFile != null) {
        // Fallback for direct file upload
        imageUrl = await CloudinaryService.uploadImage(imageFile);
        
        if (imageUrl == null) {
          _setLoading(false);
          _setError('Failed to upload image to Cloudinary');
          return false;
        }
      }
      
      // Get current user ID using UserPreferences
      String? userId = await UserPreferences.getUserId();
      if (userId == null) {
        _setLoading(false);
        _setError("User not logged in");
        return false;
      }
      
      // Create ticket with Cloudinary image URL and userId
      final ticketWithImage = ticket.copyWith(
        ticketImageUrl: imageUrl,
        sellerId: userId, // Using userId here (you may want to rename this field in your model)
        createdAt: DateTime.now(),
      );
      
      // Add to Firestore
      final DocumentReference docRef = await _firestore
          .collection(_collectionName)
          .add(ticketWithImage.toMap());
      
      // Add to local list with document ID
      final newTicket = ticketWithImage.copyWith(id: docRef.id);
      _tickets.insert(0, newTicket);
      
      // Clear selected image after successful upload
      _selectedImagePath = null;
      _selectedImageFile = null;
      _setLoading(false);
       
      return true;
    } catch (e) {
      _setLoading(false);
      debugPrint('Error adding bus ticket: $e');
      _setError('Failed to add bus ticket: $e');
      return false;
    }
  }
  
  // Get all bus tickets for current user
  // Future<void> fetchMyTickets() async {
  //   try {
  //     _setLoading(true);
  //     _setError(null);
      
  //     String? userId = await UserPreferences.getUserId();
  //     if (userId == null) {
  //       _setLoading(false);
  //       _setError("User not logged in");
  //       return;
  //     }
      
  //     final QuerySnapshot snapshot = await _firestore
  //         .collection(_collectionName)
  //         .where('sellerId', isEqualTo: userId)
  //         .orderBy('createdAt', descending: true)
  //         .get();
      
  //     _tickets = snapshot.docs.map((doc) => BusTicket.fromDocument(doc)).toList();
      
  //     _setLoading(false);
  //   } catch (e) {
  //     _setLoading(false);
  //     debugPrint('Error fetching tickets: $e');
  //     _setError('Failed to fetch tickets: $e');
  //   }
  // }



 // Replace the fetchMyTickets method in your BusTicketProvider with this:

// Get all bus tickets for current user
Future<void> fetchMyTickets() async {
  try {
    _setLoading(true);
    _setError(null);
    
    // String? userId = await UserPreferences.getUserId();
    // if (userId == null) {
    //   _setLoading(false);
    //   _setError("User not logged in");
    //   return;
    // }
    
    // Remove orderBy from the query to avoid index requirement
    // final QuerySnapshot snapshot = await _firestore
    //     .collection(_collectionName)
    //     .where('sellerId', isEqualTo: userId)
    //     .get();

       final QuerySnapshot snapshot = await _firestore
        .collection(_collectionName)
        .where('sellerId',)
        .get();
    
    // Convert to list and sort in memory
    _tickets = snapshot.docs
        .map((doc) => BusTicket.fromDocument(doc))
        .toList()
      ..sort((a, b) {
        // Sort by createdAt in descending order (newest first)
        if (a.createdAt == null && b.createdAt == null) return 0;
        if (a.createdAt == null) return 1;
        if (b.createdAt == null) return -1;
        return b.createdAt!.compareTo(a.createdAt!);
      });
    
    _setLoading(false);
  } catch (e) {
    _setLoading(false);
    debugPrint('Error fetching tickets: $e');
    _setError('Failed to fetch tickets: $e');
  }
} 
  // Get all available tickets (for buyers) - UPDATED TO SET _tickets
  Future<void> fetchAvailableTickets({
    String? fromLocation,
    String? toLocation,
    DateTime? travelDate,
  }) async {
    try {
      _setLoading(true);
      _setError(null);
      
      Query query = _firestore.collection(_collectionName);
      
      // Apply filters based on whether date is selected or not
      if (travelDate != null) {
        final startOfDay = DateTime(travelDate.year, travelDate.month, travelDate.day);
        final endOfDay = startOfDay.add(const Duration(days: 1));
        
        // When date filter is applied, query by date range first
        query = query
            .where('dateOfJourney', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
            .where('dateOfJourney', isLessThan: Timestamp.fromDate(endOfDay))
            .orderBy('dateOfJourney', descending: false);
      } else {
        // Without date filter, just order by date
        query = query.orderBy('dateOfJourney', descending: false);
      }
      
      final QuerySnapshot snapshot = await query.get();
      
      // Filter status and locations in code to avoid index requirements
      List<BusTicket> availableTickets = snapshot.docs
          .map((doc) => BusTicket.fromDocument(doc))
          .where((ticket) => ticket.status == 'active')
          .toList();
      
      // Filter by locations if provided
      if (fromLocation != null && fromLocation.isNotEmpty) {
        availableTickets = availableTickets.where((ticket) =>
            ticket.pickupPoint.toLowerCase().contains(fromLocation.toLowerCase())).toList();
      }
      
      if (toLocation != null && toLocation.isNotEmpty) {
        availableTickets = availableTickets.where((ticket) =>
            ticket.dropPoint.toLowerCase().contains(toLocation.toLowerCase())).toList();
      }
      
      // Update the provider's tickets list
      _tickets = availableTickets;
      
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      debugPrint('Error fetching available tickets: $e');
      _setError('Failed to fetch available tickets: $e');
    }
  }
  
  // Update ticket status
  Future<bool> updateTicketStatus(String ticketId, String status) async {
    try {
      _setError(null);
      
      await _firestore
          .collection(_collectionName)
          .doc(ticketId)
          .update({'status': status});
      
      // Update local list
      final index = _tickets.indexWhere((ticket) => ticket.id == ticketId);
      if (index != -1) {
        _tickets[index] = _tickets[index].copyWith(status: status);
        notifyListeners();
      }
      
      return true;
    } catch (e) {
      debugPrint('Error updating ticket status: $e');
      _setError('Failed to update ticket status: $e');
      return false;
    }
  }
  
  // Delete ticket with Cloudinary image cleanup
  Future<bool> deleteTicket(String ticketId) async {
    try {
      _setLoading(true);
      _setError(null);
      
      // Get ticket data first to retrieve image URL
      final ticket = await getTicketById(ticketId);
      
      // Delete from Firestore
      await _firestore.collection(_collectionName).doc(ticketId).delete();
      
      // Delete image from Cloudinary if exists
      if (ticket?.ticketImageUrl != null && ticket!.ticketImageUrl!.isNotEmpty) {
        final success = await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
        if (!success) {
          debugPrint('Warning: Failed to delete image from Cloudinary: ${ticket.ticketImageUrl}');
          // Continue with ticket deletion even if image deletion fails
        }
      }
      
      // Remove from local list
      _tickets.removeWhere((ticket) => ticket.id == ticketId);
      notifyListeners();
      
      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      debugPrint('Error deleting ticket: $e');
      _setError('Failed to delete ticket: $e');
      return false;
    }
  }
  
  // Get ticket by ID
  Future<BusTicket?> getTicketById(String ticketId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_collectionName)
          .doc(ticketId)
          .get();
      
      if (doc.exists) {
        return BusTicket.fromDocument(doc);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting ticket by ID: $e');
      _setError('Failed to get ticket: $e');
      return null;
    }
  }
  
  // Search tickets
  Future<List<BusTicket>> searchTickets(String searchQuery) async {
    try {
      _setError(null);
      
      final QuerySnapshot snapshot = await _firestore
          .collection(_collectionName)
          .orderBy('dateOfJourney', descending: false)
          .get();
      
      final List<BusTicket> allTickets = snapshot.docs
          .map((doc) => BusTicket.fromDocument(doc))
          .where((ticket) => ticket.status == 'active')
          .toList();
      
      // Filter tickets based on search query
      return allTickets.where((ticket) =>
          ticket.busName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          ticket.pickupPoint.toLowerCase().contains(searchQuery.toLowerCase()) ||
          ticket.dropPoint.toLowerCase().contains(searchQuery.toLowerCase()) ||
          ticket.ticketType.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    } catch (e) {
      debugPrint('Error searching tickets: $e');
      _setError('Failed to search tickets: $e');
      return [];
    }
  }
  
  // Get ticket statistics for seller
  Future<Map<String, int>> getTicketStatistics() async {
    try {
      _setError(null);
      
      String? userId = await UserPreferences.getUserId();
      if (userId == null) {
        return {'total': 0, 'active': 0, 'sold': 0, 'cancelled': 0};
      }
      
      final QuerySnapshot snapshot = await _firestore
          .collection(_collectionName)
          .where('sellerId', isEqualTo: userId)
          .get();
      
      final List<BusTicket> tickets = snapshot.docs
          .map((doc) => BusTicket.fromDocument(doc))
          .toList();
      
      return {
        'total': tickets.length,
        'active': tickets.where((t) => t.status == 'active').length,
        'sold': tickets.where((t) => t.status == 'sold').length,
        'cancelled': tickets.where((t) => t.status == 'cancelled').length,
      };
    } catch (e) {
      debugPrint('Error getting statistics: $e');
      _setError('Failed to get statistics: $e');
      return {'total': 0, 'active': 0, 'sold': 0, 'cancelled': 0};
    }
  }
  
  // Get optimized image URL from Cloudinary
  String getOptimizedImageUrl(String originalUrl, {
    int? width,
    int? height,
    String quality = 'auto',
    String format = 'auto',
  }) {
    return CloudinaryService.transformImageUrl(
      originalUrl,
      width: width,
      height: height,
      quality: quality,
      format: format,
    );
  }
  
  // Get thumbnail image URL
  String getThumbnailUrl(String originalUrl) {
    return getOptimizedImageUrl(
      originalUrl,
      width: 200,
      height: 200,
      quality: '80',
    );
  }
  
  // Get full-size optimized image URL
  String getFullSizeImageUrl(String originalUrl) {
    return getOptimizedImageUrl(
      originalUrl,
      width: 1200,
      quality: 'auto',
      format: 'auto',
    );
  }
  
  // Clear selected image
  void clearSelectedImage() {
    _selectedImagePath = null;
    _selectedImageFile = null;
    notifyListeners();
  }
  
  // Clear all tickets
  void clearTickets() {
    _tickets.clear();
    notifyListeners();
  }
  
  // Clear error
  void clearError() {
    _setError(null);
  }
  
  // Bulk upload images (for multiple ticket images)
  Future<List<String?>> uploadMultipleImages(List<XFile> imageFiles) async {
    try {
      _setImageUploading(true);
      
      List<String?> imageUrls = [];
      
      for (XFile imageFile in imageFiles) {
        final String? imageUrl = await _uploadImageToCloudinary(imageFile);
        imageUrls.add(imageUrl);
      }
      
      _setImageUploading(false);
      return imageUrls;
    } catch (e) {
      _setImageUploading(false);
      debugPrint('Error uploading multiple images: $e');
      _setError('Failed to upload multiple images: $e');
      return [];
    }
  }
  
  // Update ticket image
  Future<bool> updateTicketImage(String ticketId, XFile newImageFile) async {
    try {
      _setImageUploading(true);
      _setError(null);
      
      // Get current ticket to get old image URL
      final ticket = await getTicketById(ticketId);
      if (ticket == null) {
        _setImageUploading(false);
        _setError('Ticket not found');
        return false;
      }
      
      // Upload new image
      final String? newImageUrl = await _uploadImageToCloudinary(newImageFile);
      if (newImageUrl == null) {
        _setImageUploading(false);
        return false;
      }
      
      // Update ticket in Firestore
      await _firestore
          .collection(_collectionName)
          .doc(ticketId)
          .update({'ticketImageUrl': newImageUrl});
      
      // Delete old image from Cloudinary if exists
      if (ticket.ticketImageUrl != null && ticket.ticketImageUrl!.isNotEmpty) {
        await CloudinaryService.deleteImage(ticket.ticketImageUrl!);
      }
      
      // Update local list
      final index = _tickets.indexWhere((t) => t.id == ticketId);
      if (index != -1) {
        _tickets[index] = _tickets[index].copyWith(ticketImageUrl: newImageUrl);
        notifyListeners();
      }
      
      _setImageUploading(false);
      return true;
    } catch (e) {
      _setImageUploading(false);
      debugPrint('Error updating ticket image: $e');
      _setError('Failed to update ticket image: $e');
      return false;
    }
  }
  
  // Stream tickets for real-time updates
  Stream<List<BusTicket>> streamUserTickets(String userId) {
    return _firestore
        .collection(_collectionName)
        .where('sellerId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => BusTicket.fromDocument(doc))
          .toList();
    });
  }
}