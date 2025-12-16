















import 'package:cloud_firestore/cloud_firestore.dart';

// Passenger model for individual passenger details
class PassengerDetail {
  final String name;
  final String gender;
  final int age;
  final String seatNumber; // Add seat number to passenger

  PassengerDetail({
    required this.name,
    required this.gender,
    required this.age,
    required this.seatNumber, // Add this
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'age': age,
      'seatNumber': seatNumber, // Add this
    };
  }

  // Create from Map
  factory PassengerDetail.fromMap(Map<String, dynamic> map) {
    return PassengerDetail(
      name: map['name'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age'] ?? 0,
      seatNumber: map['seatNumber'] ?? '', // Add this
    );
  }
}

class BusTicket {
  final String? id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String gender;
  final String busName;
  final String pnrNumber;
  final String bookingId;
  final DateTime dateOfJourney;
  final String boardingTime;
  final String ticketType;
  final int numberOfTickets;
  final double pricePerTicket;
  final double totalPrice;
  final String pickupPoint;
  final String dropPoint;
  final List<PassengerDetail> passengers;
  final List<String> seatNumbers; // Add this for backward compatibility
  final String? ticketImageUrl;
  final DateTime createdAt;
  final String sellerId;
  final String status;
  final String?departuretime;
  
  BusTicket({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.gender,
    required this.busName,
    required this.pnrNumber,
    required this.bookingId,
    required this.dateOfJourney,
    required this.boardingTime,
    required this.ticketType,
    required this.numberOfTickets,
    required this.pricePerTicket,
    required this.totalPrice,
    required this.pickupPoint,
    required this.dropPoint,
    this.passengers = const [],
    this.seatNumbers = const [], // Initialize empty list
    this.ticketImageUrl,
    required this.createdAt,
    required this.sellerId,
    this.departuretime,
    this.status = 'active',
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'gender': gender,
      'busName': busName,
      'pnrNumber': pnrNumber,
      'bookingId': bookingId,
      'dateOfJourney': Timestamp.fromDate(dateOfJourney),
      'boardingTime': boardingTime,
      'ticketType': ticketType,
      'numberOfTickets': numberOfTickets,
      'pricePerTicket': pricePerTicket,
      'totalPrice': totalPrice,
      'pickupPoint': pickupPoint,
      'dropPoint': dropPoint,
      'passengers': passengers.map((p) => p.toMap()).toList(),
      'seatNumbers': seatNumbers, // Add this
      'ticketImageUrl': ticketImageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'sellerId': sellerId,
      'status': status,
      'departureTime':departuretime,
    };
  }

  // Create from Firestore document
  factory BusTicket.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    // Parse passengers list
    List<PassengerDetail> passengersList = [];
    if (data['passengers'] != null) {
      passengersList = (data['passengers'] as List)
          .map((p) => PassengerDetail.fromMap(p as Map<String, dynamic>))
          .toList();
    }
    
    // Parse seat numbers list
    List<String> seatNumbersList = [];
    if (data['seatNumbers'] != null) {
      seatNumbersList = (data['seatNumbers'] as List).cast<String>();
    }
    
    return BusTicket(
      id: doc.id,
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'] ?? '',
      gender: data['gender'] ?? '',
      busName: data['busName'] ?? '',
      pnrNumber: data['pnrNumber'] ?? '',
      bookingId: data['bookingId'] ?? '',
      dateOfJourney: (data['dateOfJourney'] as Timestamp).toDate(),
      boardingTime: data['boardingTime'] ?? '',
      ticketType: data['ticketType'] ?? '',
      numberOfTickets: data['numberOfTickets'] ?? 0,
      pricePerTicket: (data['pricePerTicket'] ?? 0).toDouble(),
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      pickupPoint: data['pickupPoint'] ?? '',
      dropPoint: data['dropPoint'] ?? '',
      passengers: passengersList,
      seatNumbers: seatNumbersList, // Add this
      ticketImageUrl: data['ticketImageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      sellerId: data['sellerId'] ?? '',
      status: data['status'] ?? 'active',
      departuretime: data['departureTime']??''
    );
  }

  // Create a copy with updated fields
  BusTicket copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? gender,
    String? busName,
    String? pnrNumber,
    String? bookingId,
    DateTime? dateOfJourney,
    String? boardingTime,
    String? ticketType,
    int? numberOfTickets,
    double? pricePerTicket,
    double? totalPrice,
    String? pickupPoint,
    String? dropPoint,
    List<PassengerDetail>? passengers,
    List<String>? seatNumbers, // Add this
    String? ticketImageUrl,
    DateTime? createdAt,
    String? sellerId,
    String? status,
    String?departureTime,
  }) {
    return BusTicket(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      busName: busName ?? this.busName,
      pnrNumber: pnrNumber ?? this.pnrNumber,
      bookingId: bookingId ?? this.bookingId,
      dateOfJourney: dateOfJourney ?? this.dateOfJourney,
      boardingTime: boardingTime ?? this.boardingTime,
      ticketType: ticketType ?? this.ticketType,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      pricePerTicket: pricePerTicket ?? this.pricePerTicket,
      totalPrice: totalPrice ?? this.totalPrice,
      pickupPoint: pickupPoint ?? this.pickupPoint,
      dropPoint: dropPoint ?? this.dropPoint,
      passengers: passengers ?? this.passengers,
      seatNumbers: seatNumbers ?? this.seatNumbers, // Add this
      ticketImageUrl: ticketImageUrl ?? this.ticketImageUrl,
      createdAt: createdAt ?? this.createdAt,
      sellerId: sellerId ?? this.sellerId,
      status: status ?? this.status,
      departuretime: departureTime??this.departuretime
    );
  }
}