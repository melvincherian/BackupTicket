import 'dart:async';
import 'dart:convert';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/helper/static_helper.dart';
import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
import 'package:backup_ticket/provider/selltickets/sell_bus_ticket_provider.dart';
import 'package:backup_ticket/model/bus_ticket_model.dart';
import 'package:backup_ticket/views/busdetails/bus_details_screen.dart';
import 'package:backup_ticket/views/notifications/notification_screen.dart';
import 'package:extended_image/extended_image.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BusScreen extends StatefulWidget {
  const BusScreen({super.key});

  @override
  State<BusScreen> createState() => _BusScreenState();
}

class _BusScreenState extends State<BusScreen> {
  DateTime? _selectedDate;
  String _searchQuery = '';
  String _fromLocation = '';
  String _toLocation = '';
  String _userName = "Guest";

  final String _googleApiKey = 'AIzaSyBAgjZGzhUBDznc-wI5eGRHyjVTfENnLSs';
  List<Map<String, dynamic>> _fromSuggestions = [];
  List<Map<String, dynamic>> _toSuggestions = [];
  bool _showFromSuggestions = false;
  bool _showToSuggestions = false;
  Timer? _debounceTimer;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  // Filter variables
  RangeValues _priceRange = const RangeValues(0, 5000);
  double _maxPrice = 5000;
  double _minPrice = 0;
  Set<String> _selectedBusTypes = {};
  String _sortBy = 'none'; 
    bool isGuest = true;
  bool isLoading = true;
  String? userName;
  String? userProfileImage;

  @override
  void initState() {
    _loadUserProfile();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTickets();
      _loadUserName();
    });
  }



    Future<void> _loadUserProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await SharedPrefsHelper.getUser();
      final isLoggedIn = await SharedPrefsHelper.isLoggedIn();

      setState(() {
        isGuest = !isLoggedIn || user == null;
        if (!isGuest && user != null) {
          userName = user.fullName;
          userProfileImage = user.profileImage;
        } else {
          userName = null;
          userProfileImage = null;
        }
        isLoading = false;
      });
    } catch (e) {
      print('Error loading user profile: $e');
      setState(() {
        isGuest = true;
        userName = null;
        userProfileImage = null;
        isLoading = false;
      });
    }
  }

  Future<void> _loadUserName() async {
    final name = await UserPreferences.getName();
    if (mounted && name != null && name.isNotEmpty) {
      setState(() {
        _userName = name;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
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

  Future<void> _loadTickets() async {
    final provider = Provider.of<BusTicketProvider>(context, listen: false);
    try {
      await provider.fetchMyTickets();
      // Calculate max and min prices from available tickets
      if (provider.tickets.isNotEmpty) {
        setState(() {
          _maxPrice = provider.tickets
              .map((t) => t.totalPrice)
              .reduce((a, b) => a > b ? a : b);
          _minPrice = provider.tickets
              .map((t) => t.totalPrice)
              .reduce((a, b) => a < b ? a : b);
          _priceRange = RangeValues(_minPrice, _maxPrice);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading tickets: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1976D2),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _loadTickets();
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedDate = null;
      _searchQuery = '';
      _fromLocation = '';
      _toLocation = '';
      _searchController.clear();
      _fromController.clear();
      _toController.clear();
      _priceRange = RangeValues(_minPrice, _maxPrice);
      _selectedBusTypes.clear();
      _sortBy = 'none';
    });
    _loadTickets();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setModalState(() {
                              _priceRange = RangeValues(_minPrice, _maxPrice);
                              _selectedBusTypes.clear();
                              _sortBy = 'none';
                            });
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                  ),

                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sort By Section
                          const Text(
                            'Sort By',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildSortChip(
                                'Price: Low to High',
                                'price_low',
                                setModalState,
                              ),
                              _buildSortChip(
                                'Price: High to Low',
                                'price_high',
                                setModalState,
                              ),
                              _buildSortChip(
                                'Departure: Early',
                                'time_early',
                                setModalState,
                              ),
                              _buildSortChip(
                                'Departure: Late',
                                'time_late',
                                setModalState,
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Price Range Section
                          const Text(
                            'Price Range',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${_priceRange.start.round()}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '₹${_priceRange.end.round()}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          RangeSlider(
                            values: _priceRange,
                            min: _minPrice,
                            max: _maxPrice,
                            divisions: 20,
                            activeColor: const Color(0xFF1976D2),
                            inactiveColor: Colors.grey.shade300,
                            onChanged: (RangeValues values) {
                              setModalState(() {
                                _priceRange = values;
                              });
                            },
                          ),

                          const SizedBox(height: 24),

                          // Bus Type Section
                          const Text(
                            'Bus Type',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildBusTypeChip('AC', setModalState),
                              _buildBusTypeChip('Non-AC', setModalState),
                              _buildBusTypeChip('Sleeper', setModalState),
                              _buildBusTypeChip('Seater', setModalState),
                            ],
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  // Apply Button
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Update main state with filter values
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1976D2),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSortChip(String label, String value, StateSetter setModalState) {
    final isSelected = _sortBy == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setModalState(() {
          _sortBy = selected ? value : 'none';
        });
      },
      selectedColor: const Color(0xFF1976D2),
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontSize: 13,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  Widget _buildBusTypeChip(String label, StateSetter setModalState) {
    final isSelected = _selectedBusTypes.contains(label);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setModalState(() {
          if (selected) {
            _selectedBusTypes.add(label);
          } else {
            _selectedBusTypes.remove(label);
          }
        });
      },
      selectedColor: const Color(0xFF1976D2),
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontSize: 13,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  void _showTicketSelectionPopup(BusTicket ticket) {
    int selectedTicketCount = 1;
    int maxTickets = ticket.numberOfTickets;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select Tickets',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey),
                            onPressed: () => Navigator.pop(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.directions_bus,
                                        size: 18,
                                        color: Color(0xFF1976D2),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          ticket.busName,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          ticket.pickupPoint,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          ticket.dropPoint,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Available Tickets: $maxTickets',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(
                                    0xFF1976D2,
                                  ).withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Number of Tickets',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: selectedTicketCount > 1
                                              ? const Color(0xFF1976D2)
                                              : Colors.grey[300],
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          onPressed: selectedTicketCount > 1
                                              ? () {
                                                  setDialogState(() {
                                                    selectedTicketCount--;
                                                  });
                                                }
                                              : null,
                                          padding: const EdgeInsets.all(8),
                                          constraints: const BoxConstraints(),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE3F2FD),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          selectedTicketCount.toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1976D2),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color:
                                              selectedTicketCount < maxTickets
                                              ? const Color(0xFF1976D2)
                                              : Colors.grey[300],
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          onPressed:
                                              selectedTicketCount < maxTickets
                                              ? () {
                                                  setDialogState(() {
                                                    selectedTicketCount++;
                                                  });
                                                }
                                              : null,
                                          padding: const EdgeInsets.all(8),
                                          constraints: const BoxConstraints(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Amount',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '₹ ${(ticket.totalPrice * selectedTicketCount).toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1976D2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusDetailsScreen(
                                  ticket: ticket,
                                  nooftickets: selectedTicketCount.toString(),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1976D2),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Proceed to Book',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // In your _applyFiltersAndSort method, add this filter at the beginning

  List<BusTicket> _applyFiltersAndSort(List<BusTicket> tickets) {
    List<BusTicket> filtered = tickets;

    // ADD THIS LINE - Filter out sold tickets
    filtered = filtered.where((ticket) => ticket.status != 'sold').toList();

    // Apply location filters
    if (_fromLocation.isNotEmpty) {
      filtered = filtered.where((ticket) {
        return ticket.pickupPoint.toLowerCase().contains(_fromLocation);
      }).toList();
    }

    if (_toLocation.isNotEmpty) {
      filtered = filtered.where((ticket) {
        return ticket.dropPoint.toLowerCase().contains(_toLocation);
      }).toList();
    }

    // Rest of your existing filtering code...
    // Apply search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((ticket) {
        return ticket.busName.toLowerCase().contains(_searchQuery) ||
            ticket.pickupPoint.toLowerCase().contains(_searchQuery) ||
            ticket.dropPoint.toLowerCase().contains(_searchQuery) ||
            ticket.ticketType.toLowerCase().contains(_searchQuery);
      }).toList();
    }

    // Apply price range filter
    filtered = filtered.where((ticket) {
      return ticket.totalPrice >= _priceRange.start &&
          ticket.totalPrice <= _priceRange.end;
    }).toList();

    // Apply bus type filter
    if (_selectedBusTypes.isNotEmpty) {
      filtered = filtered.where((ticket) {
        return _selectedBusTypes.any(
          (type) =>
              ticket.ticketType.toLowerCase().contains(type.toLowerCase()),
        );
      }).toList();
    }

    // Apply sorting
    switch (_sortBy) {
      case 'price_low':
        filtered.sort((a, b) => a.totalPrice.compareTo(b.totalPrice));
        break;
      case 'price_high':
        filtered.sort((a, b) => b.totalPrice.compareTo(a.totalPrice));
        break;
      case 'time_early':
        filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case 'time_late':
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    return filtered;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side (profile image and name)
                    Row(
                      children: [
                        // Profile Image
                        Consumer<UserProfileProvider>(
                          builder: (context, profileProvider, child) {
                            return CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    profileProvider.profileImageUrl != null &&
                                        profileProvider
                                            .profileImageUrl!
                                            .isNotEmpty
                                    ? NetworkImage(
                                        profileProvider.profileImageUrl!,
                                      )
                                    : null,
                                backgroundColor: Colors.grey[300],
                                child:
                                    profileProvider.profileImageUrl == null ||
                                        profileProvider.profileImageUrl!.isEmpty
                                    ? const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                        size: 24,
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        // Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Hello,",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              userName.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.notifications_none,
                          color: Colors.black87,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.trip_origin,
                                      color: Color(0xFF1976D2),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        controller: _fromController,
                                        decoration: const InputDecoration(
                                          hintText: 'From',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          _updateFromSuggestions(value);
                                        },
                                      ),
                                    ),
                                    if (_fromController.text.isNotEmpty)
                                      IconButton(
                                        icon: const Icon(Icons.clear, size: 18),
                                        onPressed: () {
                                          setState(() {
                                            _fromController.clear();
                                            _fromLocation = '';
                                            _showFromSuggestions = false;
                                          });
                                        },
                                      ),
                                  ],
                                ),
                                if (_showFromSuggestions)
                                  Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 200,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        top: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: _fromSuggestions.length,
                                      itemBuilder: (context, index) {
                                        final suggestion =
                                            _fromSuggestions[index];
                                        return ListTile(
                                          dense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                          leading: const Icon(
                                            Icons.location_on,
                                            size: 20,
                                            color: Color(0xFF1976D2),
                                          ),
                                          title: Text(
                                            suggestion['main_text'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Text(
                                            suggestion['description'],
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _fromController.text =
                                                  suggestion['main_text'];
                                              _fromLocation =
                                                  suggestion['main_text']
                                                      .toLowerCase();
                                              _showFromSuggestions = false;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Container(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 12.0),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.grey.shade300),
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       const Icon(Icons.trip_origin,
                          //           color: Color(0xFF1976D2), size: 20),
                          //       const SizedBox(width: 12),
                          //       Expanded(
                          //         child: TextField(
                          //           controller: _fromController,
                          //           decoration: const InputDecoration(
                          //             hintText: 'From',
                          //             hintStyle: TextStyle(
                          //                 color: Colors.grey, fontSize: 16),
                          //             border: InputBorder.none,
                          //           ),
                          //           onChanged: (value) {
                          //             setState(() {
                          //               _fromLocation = value.toLowerCase();
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(height: 12),

                          // Container(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 12.0),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.grey.shade300),
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       const Icon(Icons.location_on,
                          //           color: Colors.red, size: 20),
                          //       const SizedBox(width: 12),
                          //       Expanded(
                          //         child: TextField(
                          //           controller: _toController,
                          //           decoration: const InputDecoration(
                          //             hintText: 'To',
                          //             hintStyle: TextStyle(
                          //                 color: Colors.grey, fontSize: 16),
                          //             border: InputBorder.none,
                          //           ),
                          //           onChanged: (value) {
                          //             setState(() {
                          //               _toLocation = value.toLowerCase();
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        controller: _toController,
                                        decoration: const InputDecoration(
                                          hintText: 'To',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          _updateToSuggestions(value);
                                        },
                                      ),
                                    ),
                                    if (_toController.text.isNotEmpty)
                                      IconButton(
                                        icon: const Icon(Icons.clear, size: 18),
                                        onPressed: () {
                                          setState(() {
                                            _toController.clear();
                                            _toLocation = '';
                                            _showToSuggestions = false;
                                          });
                                        },
                                      ),
                                  ],
                                ),
                                if (_showToSuggestions)
                                  Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 200,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        top: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: _toSuggestions.length,
                                      itemBuilder: (context, index) {
                                        final suggestion =
                                            _toSuggestions[index];
                                        return ListTile(
                                          dense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                          leading: const Icon(
                                            Icons.location_on,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                          title: Text(
                                            suggestion['main_text'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Text(
                                            suggestion['description'],
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _toController.text =
                                                  suggestion['main_text'];
                                              _toLocation =
                                                  suggestion['main_text']
                                                      .toLowerCase();
                                              _showToSuggestions = false;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: _selectDate,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          color: Color(0xFF1976D2),
                                          size: 18,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            _selectedDate != null
                                                ? DateFormat(
                                                    'dd MMM, yyyy',
                                                  ).format(_selectedDate!)
                                                : 'Date of Journey',
                                            style: TextStyle(
                                              color: _selectedDate != null
                                                  ? Colors.black87
                                                  : Colors.grey,
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF1976D2),
                                      Color(0xFF0D47A1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: _loadTickets,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 14,
                                      ),
                                      child: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  hintText: 'Search buses, routes...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _searchQuery = value.toLowerCase();
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1976D2),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _showFilterBottomSheet,
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.tune,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      if (_selectedBusTypes.isNotEmpty ||
                                          _sortBy != 'none')
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: 4,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          constraints: const BoxConstraints(
                                            minWidth: 8,
                                            minHeight: 8,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_selectedDate != null ||
                      _fromLocation.isNotEmpty ||
                      _toLocation.isNotEmpty ||
                      _selectedBusTypes.isNotEmpty ||
                      _sortBy != 'none')
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              if (_fromLocation.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Chip(
                                    label: Text(
                                      'From: $_fromLocation',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    deleteIcon: const Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
                                    onDeleted: () {
                                      setState(() {
                                        _fromLocation = '';
                                        _fromController.clear();
                                      });
                                    },
                                    backgroundColor: const Color(0xFFE3F2FD),
                                  ),
                                ),
                              if (_toLocation.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Chip(
                                    label: Text(
                                      'To: $_toLocation',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    deleteIcon: const Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
                                    onDeleted: () {
                                      setState(() {
                                        _toLocation = '';
                                        _toController.clear();
                                      });
                                    },
                                    backgroundColor: const Color(0xFFFFE0E0),
                                  ),
                                ),
                              if (_selectedDate != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Chip(
                                    label: Text(
                                      DateFormat(
                                        'MMM dd, yyyy',
                                      ).format(_selectedDate!),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    deleteIcon: const Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
                                    onDeleted: () {
                                      setState(() {
                                        _selectedDate = null;
                                      });
                                    },
                                    backgroundColor: const Color(0xFFFFF3E0),
                                  ),
                                ),
                              if (_sortBy != 'none')
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Chip(
                                    label: Text(
                                      'Sorted: ${_sortBy.replaceAll('_', ' ')}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    deleteIcon: const Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
                                    onDeleted: () {
                                      setState(() {
                                        _sortBy = 'none';
                                      });
                                    },
                                    backgroundColor: const Color(0xFFE8F5E9),
                                  ),
                                ),
                              if (_selectedBusTypes.isNotEmpty)
                                ..._selectedBusTypes.map(
                                  (type) => Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Chip(
                                      label: Text(
                                        type,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        size: 18,
                                      ),
                                      onDeleted: () {
                                        setState(() {
                                          _selectedBusTypes.remove(type);
                                        });
                                      },
                                      backgroundColor: const Color(0xFFFCE4EC),
                                    ),
                                  ),
                                ),
                              TextButton.icon(
                                onPressed: _clearFilters,
                                icon: const Icon(Icons.clear_all, size: 18),
                                label: const Text('Clear All'),
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF1976D2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Available Nearby Bus Tickets',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              color: Color(0xFF1976D2),
                            ),
                            onPressed: _loadTickets,
                            tooltip: 'Refresh',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<BusTicketProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            heightFactor: 4,
                            child: CircularProgressIndicator(
                              color: Color(0xFF1976D2),
                            ),
                          ),
                        );
                      }

                      List<BusTicket> filteredTickets = _applyFiltersAndSort(
                        provider.tickets,
                      );

                      if (filteredTickets.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.confirmation_number_outlined,
                                    size: 80,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _searchQuery.isNotEmpty ||
                                            _fromLocation.isNotEmpty ||
                                            _toLocation.isNotEmpty ||
                                            _selectedBusTypes.isNotEmpty
                                        ? 'No tickets found matching your filters'
                                        : _selectedDate != null
                                        ? 'No tickets available for selected date'
                                        : 'No tickets available',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton.icon(
                                    onPressed: _clearFilters,
                                    icon: const Icon(Icons.clear_all),
                                    label: const Text('Clear Filters'),
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color(0xFF1976D2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final ticket = filteredTickets[index];
                          return GestureDetector(
                            onTap: () {
                              _showTicketSelectionPopup(ticket);
                            },
                            child: _buildBusTicketCard(ticket),
                          );
                        }, childCount: filteredTickets.length),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildBusTicketCard(BusTicket ticket) {
    final isAC =
        ticket.ticketType.toLowerCase().contains('ac') &&
        !ticket.ticketType.toLowerCase().contains('non');

    final badgeColor = isAC ? const Color(0xFFE3F2FD) : const Color(0xFFFFF3E0);
    final badgeTextColor = isAC
        ? const Color(0xFF1976D2)
        : const Color(0xFFFF9800);

    final departureTime = DateFormat('HH:mm').format(ticket.createdAt);
    final arrivalTime = DateFormat('HH:mm').format(ticket.dateOfJourney);
        final dateOfJourney = DateFormat(
      'MMM dd, yyyy',
    ).format(ticket.dateOfJourney);


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // ---------------------- TOP ROW ----------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.directions_bus, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          ticket.busName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        ticket.ticketType,
                        style: TextStyle(
                          fontSize: 12,
                          color: badgeTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
               SizedBox(height: 10,),
                Row(
                  children: [
                    Text('${dateOfJourney}',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),

                const SizedBox(height: 10),

                // ---------------------- ROUTE LINE ----------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          ticket.pickupPoint,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${ticket.departuretime}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    // ---- Center Route UI Same as Image ----
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ● left dot
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4A90E2),
                                shape: BoxShape.circle,
                              ),
                            ),

                            // --- dashed line ---
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      (constraints.maxWidth / 10).floor(),
                                      (index) => Container(
                                        width: 5,
                                        height: 2,
                                        color: Color(0xFF4A90E2),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // ---- bus icon inside blue circle ----
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF4A90E2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.train,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),

                            // --- dashed line ---
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      (constraints.maxWidth / 10).floor(),
                                      (index) => Container(
                                        width: 5,
                                        height: 2,
                                        color: Color(0xFF4A90E2),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // ● right dot
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4A90E2),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        Text(
                          ticket.dropPoint,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          arrivalTime,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ---------------------- DOTTED LINE SEPARATOR ----------------------
                Row(
                  children: List.generate(
                    150 ~/ 5,
                    (index) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 1.5,
                        decoration: BoxDecoration(
                          color: index % 2 == 0 ? const Color.fromARGB(255, 34, 34, 34) : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ---------------------- BOTTOM PRICE + SELECT ----------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹ ${ticket.totalPrice.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                         Text(
                          "Seat :${ticket.seatNumbers}",
                          style: TextStyle(fontSize: 11, color: Colors.blue),
                        ),

                              Text(
                          "${ticket.gender}",
                          style: TextStyle(fontSize: 11, color: Colors.blue),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          "Select",
                          style: TextStyle(
                            color: Color(0xFF4A90E2),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Color(0xFF4A90E2),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Add this TicketClipper class if you don't have it
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
