import 'package:backup_ticket/constant/api_constant.dart';
import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/get_all_movie_ticket_model.dart';
import 'package:backup_ticket/provider/cart/cart_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/movie/get_movie_ticket_provider.dart';
import '../notifications/notification_screen.dart';
import '../Details/detail_screen.dart';

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
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  String _userName = "Guest";
String? _userProfileImage;

  String? _userId;
  final ScrollController _dateScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${widget.movieName}");

    _loadUserData();
    _loadTickets();
  }

  Future<void> _loadUserData() async {
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${widget.movieName}");
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${widget.categoryId}");

    print(
      "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${widget.assetImagePath}",
    );

    final user = await SharedPrefsHelper.getUser();
setState(() {
  _userName = user?.fullName ?? "Guest";
  _userId = user?.id;

  _userProfileImage = (user?.profileImage != null &&
          user!.profileImage!.isNotEmpty)
      ? '${ApiConstants.baseUrl}/${user.profileImage!.replaceAll('\\', '/')}'
      : null;
});

    print(
      "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$_userName",
    );

    print(
      "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$_userProfileImage",
    );



    // Load cart if user is logged in
    if (_userId != null) {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      await cartProvider.fetchCart(_userId!);
    }
  }

  Future<void> _loadTickets() async {
    final provider = Provider.of<GetMovieTicketProvider>(
      context,
      listen: false,
    );
    await provider.fetchAllMovieTickets(
      widget.categoryId.toString(),
      _selectedDate,
    );
    await provider.fetchAllMovieTicketsWithUserId(
      widget.categoryId.toString(),
      _selectedDate,
    );
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

  bool _isSameDate(DateTime apiDate, DateTime selectedDate) {
    final localApiDate = apiDate.toLocal();

    return localApiDate.year == selectedDate.year &&
        localApiDate.month == selectedDate.month &&
        localApiDate.day == selectedDate.day;
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
                    Row(
                      children: [
      CircleAvatar(
  radius: 40,
  backgroundColor: Colors.grey[300],
  backgroundImage:
      (_userProfileImage != null && _userProfileImage!.isNotEmpty)
          ? NetworkImage(_userProfileImage!)
          : null,
  child: (_userProfileImage == null || _userProfileImage!.isEmpty)
      ? const Icon(Icons.person, size: 40, color: Colors.grey)
      : null,
),

                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Hello,",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
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
                    Row(
                      children: [
                        // Cart Icon with Badge
                        // Consumer<CartProvider>(
                        //   builder: (context, cartProvider, child) {
                        //     final itemCount = cartProvider.cartItemCount;
                        //     return Stack(
                        //       children: [
                        //         GestureDetector(
                        //           onTap: () {
                        //             if (_userId == null) {
                        //               _showLoginRequiredDialog();
                        //             } else {
                        //               // Navigate to cart screen
                        //               // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                        //               ScaffoldMessenger.of(context).showSnackBar(
                        //                 const SnackBar(
                        //                   content: Text('Cart screen navigation here'),
                        //                 ),
                        //               );
                        //             }
                        //           },
                        //           child: Container(
                        //             padding: const EdgeInsets.all(8),
                        //             decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               shape: BoxShape.circle,
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: Colors.black26,
                        //                   blurRadius: 4,
                        //                   offset: Offset(0, 2),
                        //                 ),
                        //               ],
                        //             ),
                        //             child: const Icon(
                        //               Icons.shopping_cart_outlined,
                        //               color: Colors.black87,
                        //               size: 22,
                        //             ),
                        //           ),
                        //         ),
                        //         if (itemCount > 0)
                        //           Positioned(
                        //             right: 0,
                        //             top: 0,
                        //             child: Container(
                        //               padding: const EdgeInsets.all(4),
                        //               decoration: BoxDecoration(
                        //                 color: Colors.red,
                        //                 shape: BoxShape.circle,
                        //                 border: Border.all(color: Colors.white, width: 2),
                        //               ),
                        //               constraints: const BoxConstraints(
                        //                 minWidth: 20,
                        //                 minHeight: 20,
                        //               ),
                        //               child: Center(
                        //                 child: Text(
                        //                   itemCount > 9 ? '9+' : itemCount.toString(),
                        //                   style: const TextStyle(
                        //                     color: Colors.white,
                        //                     fontSize: 10,
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //       ],
                        //     );
                        //   },
                        // ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationScreen(),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<GetMovieTicketProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingAll) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.allTicketsError != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading tickets',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.allTicketsError!,
                    style: const TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadTickets,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Filter tickets by movie name, date, and search query
          // List<MovieTicket> filteredTickets =
          //     provider.allTickets.where((ticket) {
          //   final apiDate = ticket.showDate.toLocal();

          //   if (apiDate.year != _selectedDate.year ||
          //       apiDate.month != _selectedDate.month ||
          //       apiDate.day != _selectedDate.day) {
          //     return false;
          //   }

          //   if (_searchQuery.isNotEmpty) {
          //     final q = _searchQuery.toLowerCase();
          //     return ticket.theatrePlace.toLowerCase().contains(q) ||
          //         ticket.showTime.toLowerCase().contains(q) ||
          //         ticket.ticketCategory.toLowerCase().contains(q) ||
          //         ticket.fullName.toLowerCase().contains(q);
          //   }

          //   return true;
          // }).toList();
          print(
            "oooooooooooooooooooooooooooooooooooooooooooooooooooo${widget.assetImagePath}",
          );
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster + title
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: widget.assetImagePath != null
                              ? Image.network(
                                  widget.assetImagePath!,
                                  height: 250,
                                  width: 220,
                                  fit: BoxFit.fill,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const Divider(thickness: 1),

                // Date selector
                _buildDateSelector(),

                const SizedBox(height: 8),

                // Search
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                // Available header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Available Tickets",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${provider.allTickets.length} tickets",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                // Language / meta
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Text(
                    (widget.languages == null || widget.languages!.isEmpty)
                        ? "No languages available"
                        : widget.languages!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),

                // Tickets list or empty state
                _buildTicketsList(provider.allTickets),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget _buildDateSelector() {
  //   final dates = _generateDateList();

  //   return Container(
  //     height: 90,
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: ListView.builder(
  //       controller: _dateScrollController,
  //       scrollDirection: Axis.horizontal,
  //       padding: const EdgeInsets.symmetric(horizontal: 12),
  //       itemCount: dates.length,
  //       itemBuilder: (context, index) {
  //         final date = dates[index];
  //         final isSelected = _isSameDate(date, _selectedDate);
  //         final dayName = DateFormat('EEE').format(date).toUpperCase();
  //         final dayNumber = DateFormat('dd').format(date);
  //         final monthName = DateFormat('MMM').format(date).toUpperCase();

  //         return GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               _selectedDate = date;
  //             });
  //           },
  //           child: Container(
  //             width: 70,
  //             margin: const EdgeInsets.symmetric(horizontal: 4),
  //             decoration: BoxDecoration(
  //               color: isSelected ? const Color(0xFFE57373) : Colors.white,
  //               borderRadius: BorderRadius.circular(12),
  //               border: Border.all(
  //                 color: isSelected
  //                     ? const Color(0xFFE57373)
  //                     : Colors.grey.shade300,
  //                 width: 1.5,
  //               ),
  //               boxShadow: isSelected
  //                   ? [
  //                       BoxShadow(
  //                         color: const Color(0xFFE57373).withOpacity(0.3),
  //                         blurRadius: 8,
  //                         offset: const Offset(0, 4),
  //                       ),
  //                     ]
  //                   : [],
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   dayName,
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w600,
  //                     color: isSelected ? Colors.white : Colors.grey.shade600,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   dayNumber,
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                     color: isSelected ? Colors.white : Colors.black87,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 2),
  //                 Text(
  //                   monthName,
  //                   style: TextStyle(
  //                     fontSize: 11,
  //                     fontWeight: FontWeight.w500,
  //                     color: isSelected ? Colors.white : Colors.grey.shade600,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

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

          final isSelected =
              date.year == _selectedDate.year &&
              date.month == _selectedDate.month &&
              date.day == _selectedDate.day;

          final dayName = DateFormat('EEE').format(date).toUpperCase();
          final dayNumber = DateFormat('dd').format(date);
          final monthName = DateFormat('MMM').format(date).toUpperCase();

          return GestureDetector(
            onTap: () async {
              setState(() {
                _selectedDate = DateTime(date.year, date.month, date.day);
              });

              // 🔥 CALL API WITH SELECTED DATE
              await Provider.of<GetMovieTicketProvider>(
                context,
                listen: false,
              ).fetchAllMovieTickets(
                widget.categoryId.toString(),
                _selectedDate,
              );
            },
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE57373) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFE57373)
                      : Colors.grey.shade300,
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

  Widget _buildTicketsList(List<MovieTicket> tickets) {
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

  Widget _buildTicketCard(MovieTicket ticket) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final isInCart = cartProvider.isTicketInCart(ticket.id);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
                          ticket.theatrePlace,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '₹${ticket.pricePerTicket}/ticket',
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
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        DateFormat('dd/MM/yyyy').format(ticket.showDate),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        ticket.showTime,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // info chips
                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.airplane_ticket,
                        ticket.ticketType,
                        Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        Icons.confirmation_number,
                        '${ticket.noOfTickets} available',
                        Colors.orange,
                      ),
                                 _buildInfoChip(
                        Icons.theaters,
                        '${ticket.screen} ',
                        Colors.orange,
                      ),
                      // if (isInCart) ...[
                      //   const SizedBox(width: 8),
                      //   _buildInfoChip(Icons.shopping_cart, 'In Cart', Colors.green),
                      // ],
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       'Seat: ${ticket.selectedSeats.isNotEmpty ? ticket.selectedSeats[0] : "N/A"}',
                  //       style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  //     )
                  //   ],
                  // ),
                  // Wrap(
                  //   alignment: WrapAlignment.end,
                  //   spacing: 6,
                  //   runSpacing: 4,
                  //   children: ticket.selectedSeats.isNotEmpty
                  //       ? ticket.selectedSeats.map((seat) {
                  //           return Text(
                  //             seat,
                  //             style: const TextStyle(
                  //               fontSize: 13,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           );
                  //         }).toList()
                  //       : [
                  //           const Text(
                  //             'Seat: N/A',
                  //             style: TextStyle(
                  //               fontSize: 13,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ],
                  // ),



Wrap(
  alignment: WrapAlignment.end,
  spacing: 6,
  runSpacing: 4,
  children: ticket.selectedSeats.isNotEmpty
      ? ticket.selectedSeats.map((seat) {
          // Convert "Row C, Seat 2" → "C2"
          final parts = seat.split(',');
          String formattedSeat = seat;

          if (parts.length == 2) {
            final row = parts[0].replaceAll('Row', '').trim();
            final number = parts[1].replaceAll('Seat', '').trim();
            formattedSeat = '$row$number';
          }

          return Text(
            formattedSeat,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          );
        }).toList()
      : const [
          Text(
            'Seat: N/A',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                              ticket.fullName[0].toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            ticket.fullName,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'From: ₹${ticket.pricePerTicket}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void _showQuantitySelector(MovieTicket ticket) {
  //   int selectedQuantity = 1;
  //   List<String> selectedSeats = [];

  //   final int maxQty = ticket.noOfTickets;

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setModalState) {
  //           return Padding(
  //             padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom,
  //               left: 20,
  //               right: 20,
  //               top: 20,
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 // Header
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Text(
  //                       'Select Quantity',
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     IconButton(
  //                       icon: const Icon(Icons.close),
  //                       onPressed: () => Navigator.pop(context),
  //                       padding: EdgeInsets.zero,
  //                       constraints: const BoxConstraints(),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Text(
  //                   '${maxQty} ticket${maxQty > 1 ? 's' : ''} available',
  //                   style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
  //                 ),
  //                 const SizedBox(height: 20),

  //                 // Quantity Controls
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         color: selectedQuantity > 1
  //                             ? Colors.blue.shade50
  //                             : Colors.grey.shade100,
  //                         shape: BoxShape.circle,
  //                       ),
  //                       child: IconButton(
  //                         onPressed: selectedQuantity > 1
  //                             ? () {
  //                                 setModalState(() {
  //                                   selectedQuantity--;
  //                                   selectedSeats.clear();
  //                                 });
  //                               }
  //                             : null,
  //                         icon: const Icon(Icons.remove),
  //                         iconSize: 24,
  //                         color: selectedQuantity > 1
  //                             ? Colors.blue
  //                             : Colors.grey,
  //                       ),
  //                     ),

  //                     const SizedBox(width: 20),
  //                     Container(
  //                       width: 80,
  //                       padding: const EdgeInsets.symmetric(
  //                         horizontal: 20,
  //                         vertical: 12,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: Colors.blue.shade300,
  //                           width: 2,
  //                         ),
  //                         borderRadius: BorderRadius.circular(12),
  //                         color: Colors.blue.shade50,
  //                       ),
  //                       child: Text(
  //                         selectedQuantity.toString(),
  //                         textAlign: TextAlign.center,
  //                         style: const TextStyle(
  //                           fontSize: 24,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.blue,
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 20),
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         color: selectedQuantity < maxQty
  //                             ? Colors.blue.shade50
  //                             : Colors.grey.shade100,
  //                         shape: BoxShape.circle,
  //                       ),
  //                       child: IconButton(
  //                         onPressed: selectedQuantity < maxQty
  //                             ? () {
  //                                 setModalState(() {
  //                                   selectedQuantity++;
  //                                   selectedSeats.clear();
  //                                 });
  //                               }
  //                             : null,
  //                         icon: const Icon(Icons.add),
  //                         iconSize: 24,
  //                         color: selectedQuantity < maxQty
  //                             ? Colors.blue
  //                             : Colors.grey,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 24),

  //                 const SizedBox(height: 16),

  //                 // 🎯 Seat Selection Title
  //                 Text(
  //                   'Select Seats',
  //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                 ),

  //                 const SizedBox(height: 8),

  //                 Wrap(
  //                   spacing: 8,
  //                   runSpacing: 8,
  //                   children: ticket.selectedSeats.map((seat) {
  //                     final isSelected = selectedSeats.contains(seat);
  //                     final isDisabled =
  //                         !isSelected &&
  //                         selectedSeats.length >= selectedQuantity;

  //                     return GestureDetector(
  //                       onTap: isDisabled
  //                           ? null
  //                           : () {
  //                               setModalState(() {
  //                                 if (isSelected) {
  //                                   selectedSeats.remove(seat);
  //                                 } else {
  //                                   selectedSeats.add(seat);
  //                                 }
  //                               });
  //                             },
  //                       child: Container(
  //                         padding: const EdgeInsets.symmetric(
  //                           horizontal: 12,
  //                           vertical: 8,
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: isSelected
  //                               ? Colors.green
  //                               : isDisabled
  //                               ? Colors.grey.shade300
  //                               : Colors.blue.shade50,
  //                           borderRadius: BorderRadius.circular(8),
  //                           border: Border.all(
  //                             color: isSelected
  //                                 ? Colors.green
  //                                 : Colors.blue.shade200,
  //                           ),
  //                         ),
  //                         child: Text(
  //                           seat,
  //                           style: TextStyle(
  //                             color: isSelected
  //                                 ? Colors.white
  //                                 : isDisabled
  //                                 ? Colors.grey
  //                                 : Colors.black,
  //                             fontWeight: FontWeight.w600,
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   }).toList(),
  //                 ),

  //                 const SizedBox(height: 12),

  //                 // Helper text
  //                 Text(
  //                   'Selected ${selectedSeats.length} / $selectedQuantity seats',
  //                   style: TextStyle(
  //                     fontSize: 13,
  //                     color: selectedSeats.length == selectedQuantity
  //                         ? Colors.green
  //                         : Colors.red,
  //                   ),
  //                 ),

  //                 // Price breakdown
  //                 Container(
  //                   padding: const EdgeInsets.all(16),
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey.shade50,
  //                     borderRadius: BorderRadius.circular(12),
  //                     border: Border.all(color: Colors.grey.shade200),
  //                   ),
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           const Text(
  //                             'Price per ticket:',
  //                             style: TextStyle(fontSize: 14),
  //                           ),
  //                           Text(
  //                             '₹${ticket.pricePerTicket}',
  //                             style: const TextStyle(
  //                               fontWeight: FontWeight.w600,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       const SizedBox(height: 8),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             'Quantity:',
  //                             style: TextStyle(
  //                               fontSize: 14,
  //                               color: Colors.grey.shade700,
  //                             ),
  //                           ),
  //                           Text(
  //                             '$selectedQuantity',
  //                             style: const TextStyle(
  //                               fontWeight: FontWeight.w600,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       const Padding(
  //                         padding: EdgeInsets.symmetric(vertical: 12),
  //                         child: Divider(height: 1),
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           const Text(
  //                             'Total Amount:',
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           Text(
  //                             '₹${ticket.pricePerTicket * selectedQuantity}',
  //                             style: const TextStyle(
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.green,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),

  //                 const SizedBox(height: 20),

  //                 // Action buttons
  //                 Consumer<CartProvider>(
  //                   builder: (context, cartProvider, child) {
  //                     return Column(
  //                       children: [
  //                         // Add to Cart button
  //                         // SizedBox(
  //                         //   width: double.infinity,
  //                         //   child: ElevatedButton.icon(
  //                         //     onPressed: cartProvider.isLoading
  //                         //         ? null
  //                         //         : () async {
  //                         //             if (_userId == null) {
  //                         //                Navigator.push(
  //                         //         context,
  //                         //         MaterialPageRoute(
  //                         //           builder: (context) => DetailScreen(
  //                         //             ticketImageUrl: ticket.ticketImage,
  //                         //             selectedQuantity: selectedQuantity,
  //                         //             movieName: ticket.movieName,
  //                         //             pricePerTicket: ticket.pricePerTicket.toDouble(),
  //                         //           ),
  //                         //         ),
  //                         //       );
  //                         //               // Navigator.pop(context);
  //                         //               // _showLoginRequiredDialog();
  //                         //               return;
  //                         //             }

  //                         //             final success = await cartProvider.addToCart(
  //                         //               userId: _userId!,
  //                         //               ticketId: ticket.id,
  //                         //               quantity: selectedQuantity,
  //                         //               selectedSeats: ticket.selectedSeats,
  //                         //             );

  //                         //             if (success) {
  //                         //               Navigator.pop(context);
  //                         //               ScaffoldMessenger.of(context).showSnackBar(
  //                         //                 SnackBar(
  //                         //                   content: Text('Added $selectedQuantity ticket(s) to cart'),
  //                         //                   backgroundColor: Colors.green,
  //                         //                   action: SnackBarAction(
  //                         //                     label: 'View Cart',
  //                         //                     textColor: Colors.white,
  //                         //                     onPressed: () {
  //                         //                       // Navigate to cart
  //                         //                     },
  //                         //                   ),
  //                         //                 ),
  //                         //               );
  //                         //             } else {
  //                         //               ScaffoldMessenger.of(context).showSnackBar(
  //                         //                 SnackBar(
  //                         //                   content: Text(cartProvider.errorMessage),
  //                         //                   backgroundColor: Colors.red,
  //                         //                 ),
  //                         //               );
  //                         //             }
  //                         //           },
  //                         //     icon: cartProvider.isLoading
  //                         //         ? const SizedBox(
  //                         //             width: 20,
  //                         //             height: 20,
  //                         //             child: CircularProgressIndicator(
  //                         //               strokeWidth: 2,
  //                         //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //                         //             ),
  //                         //           )
  //                         //         : const Icon(Icons.add_shopping_cart, size: 20),
  //                         //     label: Text(
  //                         //       cartProvider.isLoading ? 'Adding...' : 'Buy Now',
  //                         //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                         //     ),
  //                         //     style: ElevatedButton.styleFrom(
  //                         //       backgroundColor: Colors.orange,
  //                         //       foregroundColor: Colors.white,
  //                         //       padding: const EdgeInsets.symmetric(vertical: 16),
  //                         //       shape: RoundedRectangleBorder(
  //                         //         borderRadius: BorderRadius.circular(12),
  //                         //       ),
  //                         //     ),
  //                         //   ),
  //                         // ),

  //                         // Replace the entire "Add to Cart button" section in _showQuantitySelector method
  //                         // Starting from line ~730
  //                         SizedBox(
  //                           width: double.infinity,
  //                           child: ElevatedButton.icon(
  //                             onPressed: cartProvider.isLoading
  //                                 ? null
  //                                 : () async {
  //                                     if (_userId == null) {
  //                                       // First close the bottom sheet
  //                                       // Navigator.pop(context);
  //                                       // Then navigate to DetailScreen
  //                                       Navigator.push(
  //                                         context,
  //                                         MaterialPageRoute(
  //                                           builder: (context) => DetailScreen(
  //                                             ticketImageUrl:
  //                                                 ticket.movieId.image,
  //                                             selectedQuantity:
  //                                                 selectedQuantity,
  //                                             movieName:
  //                                                 ticket.movieId.movieName,
  //                                             pricePerTicket: ticket
  //                                                 .pricePerTicket
  //                                                 .toDouble(),
  //                                           ),
  //                                         ),
  //                                       );
  //                                       return;
  //                                     }

  //                                     final success = await cartProvider
  //                                         .addToCart(
  //                                           userId: _userId!,
  //                                           ticketId: ticket.id,
  //                                           quantity: selectedQuantity,
  //                                           selectedSeats: ticket.selectedSeats,
  //                                         );

  //                                     if (success) {
  //                                       // Navigator.push(
  //                                       //   context,
  //                                       //   MaterialPageRoute(
  //                                       //     builder: (context) => DetailScreen(
  //                                       //       ticketImageUrl:
  //                                       //           ticket.ticketImage,
  //                                       //       selectedQuantity:
  //                                       //           selectedQuantity,
  //                                       //       movieName: ticket.movieName,
  //                                       //       pricePerTicket: ticket
  //                                       //           .pricePerTicket
  //                                       //           .toDouble(),
  //                                       //     ),
  //                                       //   ),
  //                                       // );

  //                                       Navigator.push(
  //                                         context,
  //                                         MaterialPageRoute(
  //                                           builder: (context) => DetailScreen(
  //                                             movieName: ticket.movieName,
  //                                             theatrePlace: ticket.theatrePlace,
  //                                             showDate: ticket.showDate,
  //                                             showTime: ticket.showTime,
  //                                             language:
  //                                                 ticket.language ?? 'N/A',
  //                                             ticketCategory:
  //                                                 ticket.ticketCategory,
  //                                             selectedSeats:
  //                                                 selectedSeats, // The seats selected in modal
  //                                             pricePerTicket: ticket
  //                                                 .pricePerTicket
  //                                                 .toDouble(),
  //                                             ticketImageUrl:
  //                                                 ticket.ticketImage,
  //                                             selectedQuantity:
  //                                                 selectedQuantity,
  //                                             ticketId: ticket.id,
  //                                           ),
  //                                         ),
  //                                       );

  //                                       // Navigator.pop(context);
  //                                       // ScaffoldMessenger.of(context).showSnackBar(
  //                                       //   SnackBar(
  //                                       //     content: Text('Added $selectedQuantity ticket(s) to cart'),
  //                                       //     backgroundColor: Colors.green,
  //                                       //     action: SnackBarAction(
  //                                       //       label: 'View Cart',
  //                                       //       textColor: Colors.white,
  //                                       //       onPressed: () {
  //                                       //         // Navigate to cart
  //                                       //       },
  //                                       //     ),
  //                                       //   ),
  //                                       // );
  //                                     } else {
  //                                       ScaffoldMessenger.of(
  //                                         context,
  //                                       ).showSnackBar(
  //                                         SnackBar(
  //                                           content: Text(
  //                                             cartProvider.errorMessage,
  //                                           ),
  //                                           backgroundColor: Colors.red,
  //                                         ),
  //                                       );
  //                                     }
  //                                   },
  //                             icon: cartProvider.isLoading
  //                                 ? const SizedBox(
  //                                     width: 20,
  //                                     height: 20,
  //                                     child: CircularProgressIndicator(
  //                                       strokeWidth: 2,
  //                                       valueColor:
  //                                           AlwaysStoppedAnimation<Color>(
  //                                             Colors.white,
  //                                           ),
  //                                     ),
  //                                   )
  //                                 : const Icon(
  //                                     Icons.add_shopping_cart,
  //                                     size: 20,
  //                                   ),
  //                             label: Text(
  //                               cartProvider.isLoading
  //                                   ? 'Adding...'
  //                                   : 'Buy Now',
  //                               style: const TextStyle(
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                             style: ElevatedButton.styleFrom(
  //                               backgroundColor: Colors.orange,
  //                               foregroundColor: Colors.white,
  //                               padding: const EdgeInsets.symmetric(
  //                                 vertical: 16,
  //                               ),
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(12),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         const SizedBox(height: 12),
  //                         // Buy Now button
  //                         // SizedBox(
  //                         //   width: double.infinity,
  //                         //   child: ElevatedButton(
  //                         //     onPressed: () {
  //                         //       Navigator.pop(context);
  //                         //       Navigator.push(
  //                         //         context,
  //                         //         MaterialPageRoute(
  //                         //           builder: (context) => DetailScreen(
  //                         //             ticketImageUrl: ticket.ticketImage,
  //                         //             selectedQuantity: selectedQuantity,
  //                         //             movieName: ticket.movieName,
  //                         //             pricePerTicket: ticket.pricePerTicket.toDouble(),
  //                         //           ),
  //                         //         ),
  //                         //       );
  //                         //     },
  //                         //     style: ElevatedButton.styleFrom(
  //                         //       backgroundColor: Colors.blue,
  //                         //       foregroundColor: Colors.white,
  //                         //       padding: const EdgeInsets.symmetric(vertical: 16),
  //                         //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //                         //     ),
  //                         //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
  //                         //       Text('Buy Now',
  //                         //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //                         //       SizedBox(width: 8),
  //                         //       Icon(Icons.arrow_forward, size: 20),
  //                         //     ]),
  //                         //   ),
  //                         // ),
  //                       ],
  //                     );
  //                   },
  //                 ),

  //                 const SizedBox(height: 20),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }




  void _showQuantitySelector(MovieTicket ticket) {
  int selectedQuantity = 1;
  List<String> selectedSeats = [];

  final int maxQty = ticket.noOfTickets;

  print("llllllllllllllllllllllllllllllllllllllllll${ticket.screen}");

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
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
                    const Text(
                      'Select Quantity',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${maxQty} ticket${maxQty > 1 ? 's' : ''} available',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),

                // Quantity Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: selectedQuantity > 1
                            ? Colors.blue.shade50
                            : Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: selectedQuantity > 1
                            ? () {
                                setModalState(() {
                                  selectedQuantity--;
                                  selectedSeats.clear();
                                });
                              }
                            : null,
                        icon: const Icon(Icons.remove),
                        iconSize: 24,
                        color: selectedQuantity > 1
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 80,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue.shade50,
                      ),
                      child: Text(
                        selectedQuantity.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: selectedQuantity < maxQty
                            ? Colors.blue.shade50
                            : Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: selectedQuantity < maxQty
                            ? () {
                                setModalState(() {
                                  selectedQuantity++;
                                  selectedSeats.clear();
                                });
                              }
                            : null,
                        icon: const Icon(Icons.add),
                        iconSize: 24,
                        color: selectedQuantity < maxQty
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                const SizedBox(height: 16),

                // 🎯 Seat Selection Title
                Text(
                  'Select Seats',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Wrap(
                //   spacing: 8,
                //   runSpacing: 8,
                //   children: ticket.selectedSeats.map((seat) {
                //     final isSelected = selectedSeats.contains(seat);
                //     final isDisabled =
                //         !isSelected && selectedSeats.length >= selectedQuantity;

                //     return GestureDetector(
                //       onTap: isDisabled
                //           ? null
                //           : () {
                //               setModalState(() {
                //                 if (isSelected) {
                //                   selectedSeats.remove(seat);
                //                 } else {
                //                   selectedSeats.add(seat);
                //                 }
                //               });
                //             },
                //       child: Container(
                //         padding: const EdgeInsets.symmetric(
                //           horizontal: 12,
                //           vertical: 8,
                //         ),
                //         decoration: BoxDecoration(
                //           color: isSelected
                //               ? Colors.green
                //               : isDisabled
                //                   ? Colors.grey.shade300
                //                   : Colors.blue.shade50,
                //           borderRadius: BorderRadius.circular(8),
                //           border: Border.all(
                //             color: isSelected
                //                 ? Colors.green
                //                 : Colors.blue.shade200,
                //           ),
                //         ),
                //         child: Text(
                //           seat,
                //           style: TextStyle(
                //             color: isSelected
                //                 ? Colors.white
                //                 : isDisabled
                //                     ? Colors.grey
                //                     : Colors.black,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //       ),
                //     );
                //   }).toList(),
                // ),


                Wrap(
  spacing: 8,
  runSpacing: 8,
  children: ticket.selectedSeats.map((seat) {
    final isSelected = selectedSeats.contains(seat);
    final isDisabled =
        !isSelected && selectedSeats.length >= selectedQuantity;

    // Convert "Row A, Seat 17" → "A17"
    String formattedSeat = seat;
    final parts = seat.split(',');
    if (parts.length == 2) {
      final row = parts[0].replaceAll('Row', '').trim();
      final number = parts[1].replaceAll('Seat', '').trim();
      formattedSeat = '$row$number';
    }

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              setModalState(() {
                if (isSelected) {
                  selectedSeats.remove(seat);
                } else {
                  selectedSeats.add(seat);
                }
              });
            },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green
              : isDisabled
                  ? Colors.grey.shade300
                  : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? Colors.green
                : Colors.blue.shade200,
          ),
        ),
        child: Text(
          formattedSeat, // ✅ HERE
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : isDisabled
                    ? Colors.grey
                    : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }).toList(),
),


                const SizedBox(height: 12),

                // Helper text
                Text(
                  'Selected ${selectedSeats.length} / $selectedQuantity seats',
                  style: TextStyle(
                    fontSize: 13,
                    color: selectedSeats.length == selectedQuantity
                        ? Colors.green
                        : Colors.red,
                  ),
                ),

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Price per ticket:',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '₹${ticket.pricePerTicket}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No.of Ticket:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Text(
                            '$selectedQuantity',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(height: 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹${ticket.pricePerTicket * selectedQuantity}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Buy Now Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: selectedSeats.length == selectedQuantity
                        ? () {
                            // Close the bottom sheet first
                            Navigator.pop(context);
                            
                            // Then navigate to DetailScreen with selected data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  movieName: ticket.movieId.movieName,
                                  theatrePlace: ticket.theatrePlace,
                                  showDate: ticket.showDate,
                                  showTime: ticket.showTime,
                                  language: ticket.language ?? 'N/A',
                                  ticketCategory: ticket.ticketCategory,
                                  selectedSeats: selectedSeats,
                                  pricePerTicket: ticket.pricePerTicket.toDouble(),
                                  ticketImageUrl: ticket.movieId.image,
                                  posterImage: ticket.movieId.image,
                                  selectedQuantity: selectedQuantity,
                                  ticketId: ticket.id,
                                  ticketType:ticket.ticketType,
                                  screen:ticket.screen
                                ),
                              ),
                            );
                          }
                        : null,
                    label: Text(
                      selectedSeats.length == selectedQuantity
                          ? 'Book Now'
                          : 'Select ${selectedQuantity - selectedSeats.length} more seat(s)',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedSeats.length == selectedQuantity
                          ? const Color.fromARGB(255, 52, 109, 224)
                          : Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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




  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Required'),
        content: const Text(
          'Please login to add items to cart and make purchases.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to login screen
              // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
