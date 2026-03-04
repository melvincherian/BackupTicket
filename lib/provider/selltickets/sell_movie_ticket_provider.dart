import 'dart:io';
import 'package:backup_ticket/helper/static_helper.dart';
import 'package:backup_ticket/model/movie_ticket_model.dart';
import 'package:backup_ticket/services/cloudinary_image_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
