import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../notifications/notification_screen.dart';
import '../Details/detail_screen.dart';
import '../Home/image_detail_screen.dart' as _dummy; // avoid analyzer unused import if needed

class ImageDetailScreen extends StatefulWidget {
  final String? languages;
  final String movieName;
  final String? assetImagePath;
  final String? categoryId;

  const ImageDetailScreen({
    super.key,
    required this.movieName,
    this.assetImagePath,
    this.categoryId,
    this.languages,
  });

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  DateTime _selectedDate = DateTime.now();
  String _userName = "Guest";
  final ScrollController _dateScrollController = ScrollController();

  // --- STATIC TICKETS (Maps used — no models / providers) ---
  final List<Map<String, dynamic>> _staticTickets = [
    {
      "theatrePlace": "Cinemax, Calicut",
      "pricePerTicket": 150.0,
      "showDate": DateTime.now(),
      "showTime": "19:30",
      "ticketType": "Silver",
      "numberOfTickets": 4,
      "seatNumbers": ["A1,A2,A3,A4"],
      "fullName": "Rahul",
      "ticketImageUrl": "assets/narasimha.png",
      "language": "Malayalam",
    },
    {
      "theatrePlace": "PVR Mall",
      "pricePerTicket": 200.0,
      "showDate": DateTime.now().add(const Duration(days: 1)),
      "showTime": "17:00",
      "ticketType": "Gold",
      "numberOfTickets": 2,
      "seatNumbers": ["B5,B6"],
      "fullName": "Anita",
      "ticketImageUrl": "assets/veeramallu.png",
      "language": "Telugu",
    },
    {
      "theatrePlace": "Grand Cinema Hall",
      "pricePerTicket": 250.0,
      "showDate": DateTime.now().add(const Duration(days: 2)),
      "showTime": "20:15",
      "ticketType": "Platinum",
      "numberOfTickets": 6,
      "seatNumbers": ["C1,C2,C3,C4,C5,C6"],
      "fullName": "Suresh",
      "ticketImageUrl": "assets/kubera.png",
      "language": "Tamil",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserName(); 
  }

  Future<void> _loadUserName() async {
    setState(() {
      _userName = "Guest";
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _dateScrollController.dispose();
    super.dispose();
  }

  List<DateTime> _generateDateList() {
    List<DateTime> dates = [];
    DateTime today = DateTime.now();
    for (int i = 0; i < 30; i++) {
      dates.add(today.add(Duration(days: i)));
    }
    return dates;
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    // Filter static tickets by selected date
    List<Map<String, dynamic>> filteredTickets = _staticTickets.where((t) {
      final DateTime dt = t["showDate"] as DateTime;
      if (!_isSameDate(dt, _selectedDate)) return false;
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        return (t["theatrePlace"] as String).toLowerCase().contains(q) ||
            (t["showTime"] as String).toLowerCase().contains(q) ||
            (t["ticketType"] as String).toLowerCase().contains(q) ||
            (t["fullName"] as String).toLowerCase().contains(q);
      }
      return true;
    }).toList();

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
                    // LEFT: Avatar + Name
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Hello,",
                              style:
                                  TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                            Text(
                              _userName,
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

                    // RIGHT: Notifications
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                      child: Container(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster + title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: widget.assetImagePath != null
                        ? Image.asset(
                            widget.assetImagePath!,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 220,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.movie, size: 60),
                          ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.movieName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1),

            // Date selector
            _buildDateSelector(),

            const SizedBox(height: 8),

            // Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: (v) {
                  setState(() {
                    _searchQuery = v.trim().toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search tickets by theatre, time, or type...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

            // Available header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Available Tickets",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${filteredTickets.length} tickets",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Language / meta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                (widget.languages == null || widget.languages!.isEmpty)
                    ? "No languages available"
                    : widget.languages!,
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            // Tickets list or empty state
            _buildTicketsList(filteredTickets),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    final dates = _generateDateList();

    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        controller: _dateScrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = _isSameDate(date, _selectedDate);
          final dayName = DateFormat('EEE').format(date).toUpperCase();
          final dayNumber = DateFormat('dd').format(date);
          final monthName = DateFormat('MMM').format(date).toUpperCase();

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE57373) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? const Color(0xFFE57373) : Colors.grey.shade300,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFFE57373).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dayNumber,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    monthName,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
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

  Widget _buildTicketsList(List<Map<String, dynamic>> tickets) {
    if (tickets.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.movie_filter, size: 60, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                _searchQuery.isEmpty
                    ? "No tickets available for ${DateFormat('MMM dd, yyyy').format(_selectedDate)}"
                    : "No tickets found matching your search",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _searchQuery.isEmpty
                    ? "Try selecting a different date"
                    : "Try a different search term",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return _buildTicketCard(ticket);
      },
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> ticket) {
    final DateTime showDate = ticket["showDate"] as DateTime;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showQuantitySelector(ticket),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Theatre and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      ticket["theatrePlace"] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '₹${(ticket["pricePerTicket"] as double).toStringAsFixed(0)}/ticket',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // date & time
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat('dd/MM/yyyy').format(showDate),
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    ticket["showTime"] as String,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // info chips
              Row(
                children: [
                  _buildInfoChip(Icons.airplane_ticket, ticket["ticketType"] as String, Colors.blue),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                      Icons.confirmation_number, '${ticket["numberOfTickets"]} available', Colors.orange),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Seat: ${(ticket["seatNumbers"] as List<String>)[0].split(',')[0]}',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  )
                ],
              ),

              const SizedBox(height: 10),

              // seller & price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          (ticket["fullName"] as String)[0].toUpperCase(),
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        ticket["fullName"] as String,
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  Text(
                    'From: ₹${(ticket["pricePerTicket"] as double).toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Quantity selector bottom sheet (uses the Map ticket)
  void _showQuantitySelector(Map<String, dynamic> ticket) {
    int selectedQuantity = 1;
    final int maxQty = ticket["numberOfTickets"] as int;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Select Quantity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('${maxQty} ticket${maxQty > 1 ? 's' : ''} available',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                  const SizedBox(height: 20),

                  // Quantity Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: selectedQuantity > 1 ? Colors.blue.shade50 : Colors.grey.shade100, shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: selectedQuantity > 1
                              ? () {
                                  setModalState(() {
                                    selectedQuantity--;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.remove),
                          iconSize: 24,
                          color: selectedQuantity > 1 ? Colors.blue : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 80,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade300, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue.shade50,
                        ),
                        child: Text(selectedQuantity.toString(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(color: selectedQuantity < maxQty ? Colors.blue.shade50 : Colors.grey.shade100, shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: selectedQuantity < maxQty
                              ? () {
                                  setModalState(() {
                                    selectedQuantity++;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.add),
                          iconSize: 24,
                          color: selectedQuantity < maxQty ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Price breakdown
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          const Text('Price per ticket:', style: TextStyle(fontSize: 14)),
                          Text('₹${(ticket["pricePerTicket"] as double).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        ]),
                        const SizedBox(height: 8),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('Quantity:', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                          Text('$selectedQuantity', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        ]),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          const Text('Total Amount:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('₹${((ticket["pricePerTicket"] as double) * selectedQuantity).toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                        ]),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // close sheet
                        // Navigate to DetailScreen — passing `null` as ticket (replace later if you wire model)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              // ticket: null,
                              ticketImageUrl: widget.assetImagePath,
                              selectedQuantity: selectedQuantity, movieName: '', pricePerTicket: 500,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                        Text('Continue to Purchase', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 20),
                      ]),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500)),
      ]),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // keep analyzer happy
  }
}
