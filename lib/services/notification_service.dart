
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize notifications
  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions for Android 13+
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }

  void _onNotificationTapped(NotificationResponse notificationResponse) {
    // Handle notification tap - navigate to relevant screen
    print('Notification tapped: ${notificationResponse.payload}');
  }

  // Show ticket purchase notification
  Future<void> showTicketPurchaseNotification({
    required String movieName,
    required int numberOfTickets,
    required double totalPrice,
    required String paymentMethod,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'ticket_purchase_channel',
      'Ticket Purchases',
      channelDescription: 'Notifications for ticket purchases',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      color: Color(0xFF1976D2),
      playSound: true,
      enableVibration: true,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond, // Unique notification ID
      'Ticket Purchase Successful! 🎉',
      'Your $numberOfTickets ticket(s) for "$movieName" has been confirmed. Total: ₹$totalPrice via $paymentMethod',
      notificationDetails,
      payload: 'ticket_purchase',
    );
  }

  // Show bus ticket purchase notification
  Future<void> showBusTicketPurchaseNotification({
    required String busName,
    required String pickupPoint,
    required String dropPoint,
    required int numberOfTickets,
    required double totalPrice,
    required String paymentMethod,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'bus_ticket_purchase_channel',
      'Bus Ticket Purchases',
      channelDescription: 'Notifications for bus ticket purchases',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      color: Color(0xFF1976D2),
      playSound: true,
      enableVibration: true,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond,
      'Bus Ticket Booked! 🚌',
      '$numberOfTickets ticket(s) for "$busName" from $pickupPoint to $dropPoint. Total: ₹${totalPrice.toStringAsFixed(2)} via $paymentMethod',
      notificationDetails,
      payload: 'bus_ticket_purchase',
    );
  }

  // Show ticket download notification
  Future<void> showTicketDownloadNotification({
    required String movieName,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'ticket_download_channel',
      'Ticket Downloads',
      channelDescription: 'Notifications for ticket downloads',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      color: Color(0xFF1976D2),
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond + 1,
      'Ticket Downloaded 📥',
      'Your ticket for "$movieName" has been downloaded successfully.',
      notificationDetails,
      payload: 'ticket_download',
    );
  }

  // Save notification to Firestore
  Future<void> saveNotificationToFirestore({
    required String userId,
    required String title,
    required String message,
    required String type,
    String? ticketId,
    String? imageUrl,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('notifications').add({
        'userId': userId,
        'title': title,
        'message': message,
        'type': type, // 'purchase', 'download', 'share'
        'ticketId': ticketId,
        'imageUrl': imageUrl,
        'isRead': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving notification: $e');
    }
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // Cancel specific notification
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}