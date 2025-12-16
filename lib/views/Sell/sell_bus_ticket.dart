import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/helper/static_helper.dart';
import 'package:backup_ticket/provider/selltickets/sell_bus_ticket_provider.dart';
import 'package:backup_ticket/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:backup_ticket/model/bus_ticket_model.dart';

// Passenger model to hold individual passenger details
class Passenger {
  String name;
  String gender;
  String age;

  Passenger({required this.name, required this.gender, required this.age});
}

class SellBusTicket extends StatefulWidget {
  const SellBusTicket({super.key});

  @override
  State<SellBusTicket> createState() => _SellBusTicketState();
}

class _SellBusTicketState extends State<SellBusTicket> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _busNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final _pickupPointController = TextEditingController();
  final _dropPointController = TextEditingController();
  final _pnrController = TextEditingController();
  final _bookingIdController = TextEditingController();

  // Form state variables
  bool _agreeToTerms = false;
  String? _selectedGender;
  String? _selectedTicketType;
  String? _selectedTicketCount;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectDeparturetime;
  final String _googleApiKey = 'AIzaSyBAgjZGzhUBDznc-wI5eGRHyjVTfENnLSs';
  List<Map<String, dynamic>> _fromSuggestions = [];
  List<Map<String, dynamic>> _toSuggestions = [];
  bool _showFromSuggestions = false;
  bool _showToSuggestions = false;
  Timer? _debounceTimer;

  // List to hold multiple passengers
  List<Passenger> _passengers = [];
  List<Map<String, TextEditingController>> _passengerControllers = [];

  // List to hold seat numbers
  List<TextEditingController> _seatControllers = [];

  @override
  void initState() {
    super.initState();
    // // Set default values
    // _fullNameController.text = '';
    // _phoneController.text = '';
    // _emailController.text = '';
    _selectedGender = 'Male';
    _selectedTicketCount = '1';

    // Add listener to calculate total price
    _priceController.addListener(_calculateTotalPrice);
    _loadUserData();
    // Initialize with one passenger and one seat
    _addPassenger();
    _addSeat();
  }

  Future<List<Map<String, dynamic>>> _fetchPlaceSuggestions(
    String input,
  ) async {
    if (input.isEmpty) return [];

    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=(cities)&components=country:in&key=$_googleApiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          List<Map<String, dynamic>> suggestions = [];
          for (var prediction in data['predictions']) {
            suggestions.add({
              'description': prediction['description'],
              'place_id': prediction['place_id'],
              'main_text': prediction['structured_formatting']['main_text'],
            });
          }
          return suggestions;
        }
      }
    } catch (e) {
      print('Error fetching places: $e');
    }

    return [];
  }

  void _updateFromSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        _fromSuggestions = [];
        _showFromSuggestions = false;
      });
      return;
    }

    // Cancel previous timer
    _debounceTimer?.cancel();

    // Create new timer (wait 500ms after user stops typing)
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final suggestions = await _fetchPlaceSuggestions(query);
      setState(() {
        _fromSuggestions = suggestions;
        _showFromSuggestions = suggestions.isNotEmpty;
      });
    });
  }

  void _updateToSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        _toSuggestions = [];
        _showToSuggestions = false;
      });
      return;
    }

    // Cancel previous timer
    _debounceTimer?.cancel();

    // Create new timer (wait 500ms after user stops typing)
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final suggestions = await _fetchPlaceSuggestions(query);
      setState(() {
        _toSuggestions = suggestions;
        _showToSuggestions = suggestions.isNotEmpty;
      });
    });
  }

  Future<bool> _isUserLoggedIn() async {
    final userId = await UserPreferences.getUserId();
    return userId != null && userId != 'guest';
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Login Required',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Please login to sell tickets. Guest users cannot sell tickets.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF214194),
              ),
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadUserData() async {
    final name = await UserPreferences.getName();
    final phone = await UserPreferences.getMobileNumber();
    final email = await UserPreferences.getEmail();

    if (mounted) {
      setState(() {
        if (name != null) _fullNameController.text = name;
        if (phone != null) _phoneController.text = phone;
        if (email != null) _emailController.text = email;
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _busNameController.dispose();
    _priceController.dispose();
    _totalPriceController.dispose();
    _pickupPointController.dispose();
    _dropPointController.dispose();
    _pnrController.dispose();
    _bookingIdController.dispose();

    // Dispose passenger controllers
    for (var controllers in _passengerControllers) {
      controllers['name']?.dispose();
      controllers['age']?.dispose();
      controllers['gender']?.dispose();
      // controllers['seat']?.dispose();
    }

    // Dispose seat controllers
    for (var controller in _seatControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addPassenger() {
    setState(() {
      _passengerControllers.add({
        'name': TextEditingController(),
        'age': TextEditingController(),
        'gender': TextEditingController(text: 'Male'),
        'seat': TextEditingController(),
      });
    });
  }

  void _removePassenger(int index) {
    if (_passengerControllers.length > 1) {
      setState(() {
        _passengerControllers[index]['name']?.dispose();
        _passengerControllers[index]['age']?.dispose();
        _passengerControllers[index]['gender']?.dispose();
        _passengerControllers[index]['seat']?.dispose();
        _passengerControllers.removeAt(index);
      });
    }
  }

  void _addSeat() {
    setState(() {
      _seatControllers.add(TextEditingController());
    });
  }

  void _removeSeat(int index) {
    if (_seatControllers.length > 1) {
      setState(() {
        _seatControllers[index].dispose();
        _seatControllers.removeAt(index);
      });
    }
  }

  void _updateSeatCount(int count) {
    setState(() {
      // If new count is greater than current, add seats
      while (_seatControllers.length < count) {
        _seatControllers.add(TextEditingController());
      }

      // If new count is less than current, remove seats
      while (_seatControllers.length > count) {
        final index = _seatControllers.length - 1;
        _seatControllers[index].dispose();
        _seatControllers.removeAt(index);
      }
    });
  }

  // NEW METHOD: Update passenger count based on ticket count
  void _updatePassengerCount(int count) {
    setState(() {
      // If new count is greater than current, add passengers
      while (_passengerControllers.length < count) {
        _passengerControllers.add({
          'name': TextEditingController(),
          'age': TextEditingController(),
          'gender': TextEditingController(text: 'Male'),
          // 'seat': TextEditingController(),
        });
      }

      // If new count is less than current, remove passengers
      while (_passengerControllers.length > count) {
        final index = _passengerControllers.length - 1;
        _passengerControllers[index]['name']?.dispose();
        _passengerControllers[index]['age']?.dispose();
        _passengerControllers[index]['gender']?.dispose();
        // _passengerControllers[index]['seat']?.dispose();
        _passengerControllers.removeAt(index);
      }
    });
  }

  void _calculateTotalPrice() {
    if (_priceController.text.isNotEmpty && _selectedTicketCount != null) {
      final price = double.tryParse(_priceController.text) ?? 0;
      final count = int.tryParse(_selectedTicketCount!) ?? 1;
      final total = price * count;
      _totalPriceController.text = total.toString();
    }
  }

  Future<void> _handleImagePicker(BusTicketProvider provider) async {
    try {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          height: 170,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Select Image Source',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      provider.pickImage(source: ImageSource.camera);
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.camera_alt, size: 30),
                        Text('Camera'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      provider.pickImage(source: ImageSource.gallery);
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.photo_library, size: 30),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      _showSnackBar('Error picking image: $e', isError: true);
    }
  }
  Future<void> _handleSubmit() async {
    bool isLoggedIn = await _isUserLoggedIn();
    if (!isLoggedIn) {
      _showLoginDialog();
      return;
    }
    if (!_formKey.currentState!.validate()) {
      _showSnackBar('Please fill all required fields', isError: true);
      return;
    }

    if (!_agreeToTerms) {
      _showSnackBar('Please agree to terms and conditions', isError: true);
      return;
    }

    if (_selectedDate == null || _selectedTime == null) {
      _showSnackBar('Please select date and time', isError: true);
      return;
    }

    final provider = Provider.of<BusTicketProvider>(context, listen: false);

    try {
      // Create DateTime for journey
      final journeyDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      // Validate that we have the same number of seats as passengers
      final ticketCount = int.parse(_selectedTicketCount!);
      if (_seatControllers.length != ticketCount ||
          _passengerControllers.length != ticketCount) {
        _showSnackBar(
          'Number of seats must match number of passengers',
          isError: true,
        );
        return;
      }

      // Convert passenger controllers to PassengerDetail objects with seat numbers
      List<PassengerDetail> passengersList = [];
      for (int i = 0; i < _passengerControllers.length; i++) {
        final controllers = _passengerControllers[i];
        final seatController = _seatControllers[i];

        passengersList.add(
          PassengerDetail(
            name: controllers['name']!.text.trim(),
            gender: controllers['gender']!.text.trim(),
            age: int.tryParse(controllers['age']!.text.trim()) ?? 0,
            seatNumber: seatController.text
                .trim(), // Assign seat from seatControllers
          ),
        );
      }

      // Create list of seat numbers from seat controllers
      List<String> seatNumbers = _seatControllers
          .map((controller) => controller.text.trim())
          .toList();

      // Create BusTicket object
      final ticket = BusTicket(
        id: '',
        fullName: _fullNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        gender: _selectedGender!,
        busName: _busNameController.text.trim(),
        pnrNumber: _pnrController.text.trim(),
        bookingId: _bookingIdController.text.trim(),
        dateOfJourney: journeyDateTime,
        boardingTime:
            '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
        departuretime:
            '${_selectDeparturetime!.hour.toString().padLeft(2, '0')}:${_selectDeparturetime!.minute.toString().padLeft(2, '0')}',
        ticketType: _selectedTicketType!,
        numberOfTickets: int.parse(_selectedTicketCount!),
        pricePerTicket: double.parse(_priceController.text),
        totalPrice: double.parse(_totalPriceController.text),
        pickupPoint: _pickupPointController.text.trim(),
        dropPoint: _dropPointController.text.trim(),
        passengers: passengersList,
        status: 'active',
        sellerId: '', // Will be set by provider
        createdAt: DateTime.now(),
        ticketImageUrl: null,
        seatNumbers: seatNumbers, // Assign seat numbers list
      );

      // Get image file if selected
      File? imageFile;
      if (provider.selectedImagePath != null) {
        imageFile = File(provider.selectedImagePath!);
      }

      // Add ticket
      final success = await provider.addBusTicket(ticket, imageFile: imageFile);

      if (success) {
        _showSnackBar(
          'Thanks for uploaded your ticket our team will check and notify you once get uploaded',
        );
        _resetForm();
        // Optionally navigate back or to another screen
        Navigator.pop(context);
      } else {
        _showSnackBar('Failed to add ticket', isError: true);
      }
    } catch (e) {
      _showSnackBar('Error: $e', isError: true);
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _fullNameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _busNameController.clear();
    _priceController.clear();
    _totalPriceController.clear();
    _pickupPointController.clear();
    _dropPointController.clear();
    _pnrController.clear();
    _bookingIdController.clear();

    setState(() {
      _agreeToTerms = false;
      _selectedGender = null;
      _selectedTicketType = null;
      _selectedTicketCount = null;
      _selectedDate = null;
      _selectedTime = null;

      // Clear passenger controllers
      for (var controllers in _passengerControllers) {
        controllers['name']?.dispose();
        controllers['age']?.dispose();
        controllers['gender']?.dispose();
        // controllers['seat']?.dispose();
      }
      _passengerControllers.clear();
      _addPassenger(); // Add one default passenger

      // Clear seat controllers
      for (var controller in _seatControllers) {
        controller.dispose();
      }
      _seatControllers.clear();
      _addSeat(); // Add one default seat
    });

    final provider = Provider.of<BusTicketProvider>(context, listen: false);
    provider.clearSelectedImage();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECEFF1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Sell Bus Tickets',
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Consumer<BusTicketProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    'Full Name',
                    'User',
                    _fullNameController,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Phone Number',
                    '123456789',
                    _phoneController,
                    required: true,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'E-Mail',
                    'abc@gmail.com',
                    _emailController,
                    required: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  // _buildDropdownField(
                  //   'Gender',
                  //   'Male',
                  //   ['Male', 'Female', 'Other'],
                  //   _selectedGender,
                  //   (value) {
                  //     setState(() {
                  //       _selectedGender = value;
                  //     });
                  //   },
                  //   required: true,
                  // ),
                  const SizedBox(height: 16),

                  // Replace your existing _buildTextField calls for From and To with these:

                  // From Field with Suggestions
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From *',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _pickupPointController,
                        onChanged: (value) {
                          _updateFromSuggestions(value);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'From is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter pickup point',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                      if (_showFromSuggestions && _fromSuggestions.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: _fromSuggestions.length,
                            itemBuilder: (context, index) {
                              final suggestion = _fromSuggestions[index];
                              return ListTile(
                                dense: true,
                                leading: const Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                title: Text(
                                  suggestion['main_text'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  suggestion['description'] ?? '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  setState(() {
                                    _pickupPointController.text =
                                        suggestion['main_text'] ?? '';
                                    _showFromSuggestions = false;
                                    _fromSuggestions = [];
                                  });
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),

                  // _buildTextField(
                  //   'From',
                  //   'Enter pickup point',
                  //   _pickupPointController,
                  //   required: true,
                  // ),
                  // const SizedBox(height: 16),
                  // _buildTextField(
                  //   'To',
                  //   'Enter drop point',
                  //   _dropPointController,
                  //   required: true,
                  // ),
                  const SizedBox(height: 16),

                  // To Field with Suggestions
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To *',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _dropPointController,
                        onChanged: (value) {
                          _updateToSuggestions(value);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'To is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter drop point',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                      if (_showToSuggestions && _toSuggestions.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: _toSuggestions.length,
                            itemBuilder: (context, index) {
                              final suggestion = _toSuggestions[index];
                              return ListTile(
                                dense: true,
                                leading: const Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                title: Text(
                                  suggestion['main_text'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  suggestion['description'] ?? '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  setState(() {
                                    _dropPointController.text =
                                        suggestion['main_text'] ?? '';
                                    _showToSuggestions = false;
                                    _toSuggestions = [];
                                  });
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildDateField(
                    'Date of Journey',
                    _selectedDate != null
                        ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                        : '29/01/2024',
                  ),
                  const SizedBox(height: 16),

                  _buildTimeField(
                    'Boarding Time',
                    _selectedTime != null
                        ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                        : '',
                  ),
                  const SizedBox(height: 16),

                  _builddepartureTimeField(
                    'Departure Time',
                    _selectDeparturetime != null
                        ? '${_selectDeparturetime!.hour.toString().padLeft(2, '0')}:${_selectDeparturetime!.minute.toString().padLeft(2, '0')}'
                        : '',
                  ),

                  const SizedBox(height: 16),

                  _buildTextField(
                    'Bus Name',
                    'Enter bus name',
                    _busNameController,
                    required: true,
                  ),

                  const SizedBox(height: 16),

                  // const SizedBox(height: 16),
                  _buildDropdownField(
                    'Number of Tickets',
                    '1',
                    ['1', '2', '3', '4', '5', '6'],
                    _selectedTicketCount,
                    (value) {
                      setState(() {
                        _selectedTicketCount = value;
                        _calculateTotalPrice();
                        // Update both seat count AND passenger count
                        final count = int.parse(value!);
                        _updateSeatCount(count);
                        _updatePassengerCount(count);
                      });
                    },
                    required: true,
                  ),
                  const SizedBox(height: 16),

                  // Seat Numbers Section
                  // _buildSeatSection(),
                  const SizedBox(height: 16),

                  _buildDropdownField(
                    'Ticket Type',
                    'Select',
                    [
                      'A/C Sleeper',
                      'A/C Seater',
                      'Non A/C Sleeper',
                      'Non A/C Seater',
                    ],
                    _selectedTicketType,
                    (value) {
                      setState(() {
                        _selectedTicketType = value;
                      });
                    },
                    required: true,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    'Bus Partner PNR',
                    'Enter PNR number',
                    _pnrController,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Booking ID',
                    'Enter booking ID',
                    _bookingIdController,
                    required: true,
                  ),
                  const SizedBox(height: 16),

                  const SizedBox(height: 16),

                  const SizedBox(height: 16),
                  _buildTextField(
                    'Price per Ticket',
                    'Enter price per ticket',
                    _priceController,
                    required: true,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildTextField(
                          'Total Price',
                          'Auto-calculated',
                          _totalPriceController,
                          readOnly: true,
                        ),
                      ),
                      const Expanded(flex: 2, child: SizedBox()),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const SizedBox(height: 24),

                  // Passenger Details Section
                  _buildPassengerSection(),

                  const SizedBox(height: 24),
                  _buildFileUploadField('Upload Ticket', provider),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreeToTerms = value ?? false;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      const Expanded(
                        child: Text(
                          'I agree to the terms and conditions',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: (_agreeToTerms && !provider.isLoading)
                          ? _handleSubmit
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF214194),
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: provider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSeatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Seat Numbers',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter seat number for each ticket (${_selectedTicketCount ?? '1'} seat${(_selectedTicketCount != null && int.parse(_selectedTicketCount!) > 1) ? 's' : ''})',
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(_seatControllers.length, (index) {
            return SizedBox(
              width:
                  (MediaQuery.of(context).size.width - 56) /
                  3, // 3 items per row with spacing
              child: _buildSeatBox(index),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSeatBox(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seat ${index + 1} *',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _seatControllers[index],
          keyboardType: TextInputType.text,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Required';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'e.g. A1',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.white,
            errorStyle: const TextStyle(fontSize: 10),
          ),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildPassengerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Passenger Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total passengers: ${_passengerControllers.length}',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _passengerControllers.length,
          itemBuilder: (context, index) {
            return _buildPassengerCard(index);
          },
        ),
      ],
    );
  }

  Widget _buildPassengerCard(int index) {
    final controllers = _passengerControllers[index];
    String? selectedGender = controllers['gender']?.text;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Passenger ${index + 1}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF214194),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextField(
              'Passenger Name',
              'Enter passenger name',
              controllers['name']!,
              required: true,
            ),
            const SizedBox(height: 12),
            _buildSeatSection(),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender *',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedGender,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Gender is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Select',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: ['Male', 'Female', 'Other'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            controllers['gender']?.text = value ?? 'Male';
                          });
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // _buildSeatSection(),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    'Age',
                    'Age',
                    controllers['age']!,
                    required: true,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // _buildTextField(
            //   'Seat Number',
            //   'e.g. A1',
            //   controllers['seat']!,
            //   required: true,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    bool required = false,
    bool readOnly = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          required ? '$label *' : label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          inputFormatters: label == 'Age'
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ]
              : [],
          validator: required
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '$label is required';
                  }
                  if (label == 'E-Mail' &&
                      !RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  if (label == 'Phone Number' && value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  if (label == 'Age') {
                    final age = int.tryParse(value);
                    if (age == null || age < 1 || age > 120) {
                      return 'Please enter a valid age';
                    }
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              // BorderSide(color: Colors.blue, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: readOnly ? Colors.grey[100] : Colors.white,
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    String hint,
    List<String> items,
    String? selectedValue,
    Function(String?) onChanged, {
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          required ? '$label *' : label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          validator: required
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '$label is required';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              setState(() {
                _selectedDate = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                      : hint,
                  style: TextStyle(
                    fontSize: 14,
                    color: _selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
                const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: _selectedTime ?? TimeOfDay.now(),
            );
            if (picked != null) {
              // Get current time
              final now = DateTime.now();
              final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

              // Convert TimeOfDay to minutes for comparison
              final pickedMinutes = picked.hour * 60 + picked.minute;
              final currentMinutes = currentTime.hour * 60 + currentTime.minute;

              // Check if selected date is today
              final isToday =
                  _selectedDate != null &&
                  _selectedDate!.year == now.year &&
                  _selectedDate!.month == now.month &&
                  _selectedDate!.day == now.day;

              // If it's today, check if time is at least 1 hour from now
              if (isToday && pickedMinutes < (currentMinutes + 60)) {
                _showSnackBar(
                  'Boarding time must be at least 1 hour from current time',
                  isError: true,
                );
                return;
              }

              setState(() {
                _selectedTime = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTime != null
                      ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                      : hint,
                  style: TextStyle(
                    fontSize: 14,
                    color: _selectedTime != null ? Colors.black : Colors.grey,
                  ),
                ),
                const Icon(Icons.access_time, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _builddepartureTimeField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: _selectDeparturetime ?? TimeOfDay.now(),
            );
            if (picked != null) {
              setState(() {
                _selectDeparturetime = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectDeparturetime != null
                      ? '${_selectDeparturetime!.hour.toString().padLeft(2, '0')}:${_selectDeparturetime!.minute.toString().padLeft(2, '0')}'
                      : hint,
                  style: TextStyle(
                    fontSize: 14,
                    color: _selectDeparturetime != null
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
                const Icon(Icons.access_time, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileUploadField(String label, BusTicketProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _handleImagePicker(provider),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[50],
            ),
            child: provider.selectedImagePath != null
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(provider.selectedImagePath!),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => provider.clearSelectedImage(),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        'Upload File',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
