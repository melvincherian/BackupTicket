// // // import 'package:flutter/material.dart';

// // // class NearbyTickets extends StatelessWidget {
// // //   const NearbyTickets({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: PreferredSize(
// // //         preferredSize: const Size.fromHeight(90),
// // //         child: AppBar(
// // //           automaticallyImplyLeading: false,
// // //           elevation: 0,
// // //           flexibleSpace: ClipRRect(
// // //             borderRadius: const BorderRadius.only(
// // //               bottomLeft: Radius.circular(25),
// // //               bottomRight: Radius.circular(25),
// // //             ),
// // //             child: Container(
// // //               decoration: const BoxDecoration(
// // //                 gradient: LinearGradient(
// // //                   colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
// // //                   begin: Alignment.topLeft,
// // //                   end: Alignment.bottomRight,
// // //                 ),
// // //               ),
// // //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
// // //               child: SafeArea(
// // //                 child: Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     // Left side (location)
// // //                     Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       mainAxisAlignment: MainAxisAlignment.center,
// // //                       children: [
// // //                         Row(
// // //                           children: const [
// // //                             Icon(Icons.send, color: Colors.white, size: 18),
// // //                             SizedBox(width: 5),
// // //                             Text(
// // //                               "Hyderabad, Telangana..",
// // //                               style: TextStyle(
// // //                                 color: Colors.white,
// // //                                 fontSize: 16,
// // //                                 fontWeight: FontWeight.w600,
// // //                               ),
// // //                             ),
// // //                             Icon(
// // //                               Icons.keyboard_arrow_down,
// // //                               color: Colors.white,
// // //                               size: 20,
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         SizedBox(height: 2),
// // //                         const Text(
// // //                           "       Hyderabad, Telangana, India",
// // //                           style: TextStyle(color: Colors.white, fontSize: 12),
// // //                         ),
// // //                       ],
// // //                     ),

// // //                     // Right side (notification)
// // //                     Container(
// // //                       padding: const EdgeInsets.all(8),
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white,
// // //                         shape: BoxShape.circle,
// // //                         boxShadow: [
// // //                           BoxShadow(
// // //                             color: Colors.black26,
// // //                             blurRadius: 4,
// // //                             offset: Offset(0, 2),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       child: const Icon(
// // //                         Icons.notifications_none,
// // //                         color: Colors.black87,
// // //                         size: 22,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //       backgroundColor: const Color(0xFFF5F5F5),
// // //       body: SafeArea(
// // //         child: Column(
// // //           children: [
// // //             Expanded(
// // //               child: SingleChildScrollView(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     SizedBox(height: 20),
// // //                     SizedBox(
// // //                       height: 280,
// // //                       child: ListView(
// // //                         scrollDirection: Axis.horizontal,
// // //                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //                         children: [
// // //                           SizedBox(width: 90),
// // //                           GestureDetector(
// // //                             onTap: () {
// // //                               // Navigator.push(
// // //                               //   context,
// // //                               //   MaterialPageRoute(
// // //                               //     builder: (context) => MovieDetailScreen(),
// // //                               //   ),
// // //                               // );
// // //                             },
// // //                             child: _buildMovieCard(
// // //                               'assets/kubera.png',
// // //                               'Kuberaa',
// // //                               ['13+', 'Action', 'IMAX'],
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),

// // //                     Divider(),
// // //                     const SizedBox(height: 10),

// // //                     // Nearby Resale Tickets Section
// // //                     Padding(
// // //                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //                       child: Row(
// // //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                         children: [
// // //                           const Text(
// // //                             'Available Tickets',
// // //                             style: TextStyle(
// // //                               fontSize: 18,
// // //                               fontWeight: FontWeight.w600,
// // //                               color: Colors.black87,
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                     SizedBox(height: 10),

// // //                     // Resale Tickets List
// // //                     ListView.builder(
// // //                       shrinkWrap: true,
// // //                       physics: const NeverScrollableScrollPhysics(),
// // //                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //                       itemCount: 3,
// // //                       itemBuilder: (context, index) {
// // //                         return _buildResaleTicketCard();
// // //                       },
// // //                     ),

// // //                     const SizedBox(height: 16),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildMovieCard(String imagePath, String title, List<String> badges) {
// // //     return Container(
// // //       width: 160,
// // //       margin: const EdgeInsets.only(right: 16),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.center,
// // //         children: [
// // //           // Movie Poster with Stack
// // //           Stack(
// // //             children: [
// // //               Container(
// // //                 height: 220,
// // //                 width: 160,
// // //                 decoration: BoxDecoration(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   boxShadow: [
// // //                     BoxShadow(
// // //                       color: Colors.black.withOpacity(0.2),
// // //                       spreadRadius: 1,
// // //                       blurRadius: 8,
// // //                       offset: const Offset(0, 4),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 child: ClipRRect(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   child: Image.asset(
// // //                     imagePath,
// // //                     fit: BoxFit.cover,
// // //                     errorBuilder: (context, error, stackTrace) {
// // //                       return Container(
// // //                         color: Colors.grey[300],
// // //                         child: const Icon(
// // //                           Icons.movie,
// // //                           size: 40,
// // //                           color: Colors.grey,
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),

// // //           const SizedBox(height: 8),

// // //           // Movie Title
// // //           Text(
// // //             title,
// // //             style: const TextStyle(
// // //               fontSize: 14,
// // //               fontWeight: FontWeight.w600,
// // //               color: Colors.black87,
// // //             ),
// // //             maxLines: 2,
// // //             textAlign: TextAlign.center,
// // //             overflow: TextOverflow.ellipsis,
// // //           ),

// // //           const SizedBox(height: 6),

// // //           // Badges Row
// // //           Row(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: badges.map((badge) => _buildBadge(badge)).toList(),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildBadge(String text) {
// // //     Color backgroundColor;
// // //     Color textColor = Colors.white;

// // //     switch (text) {
// // //       case '13+':
// // //       case 'UA':
// // //       case 'A':
// // //         backgroundColor = Colors.grey[700]!;
// // //         break;
// // //       case 'Action':
// // //       case 'Drama':
// // //       case 'Thriller':
// // //         backgroundColor = Colors.grey[600]!;
// // //         break;
// // //       case 'IMAX':
// // //       case '2D':
// // //         backgroundColor = Colors.grey[600]!;
// // //         break;
// // //       default:
// // //         backgroundColor = Colors.grey[600]!;
// // //     }

// // //     return Container(
// // //       margin: const EdgeInsets.only(right: 4),
// // //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// // //       decoration: BoxDecoration(
// // //         color: backgroundColor,
// // //         borderRadius: BorderRadius.circular(4),
// // //       ),
// // //       child: Text(
// // //         text,
// // //         style: TextStyle(
// // //           color: textColor,
// // //           fontSize: 10,
// // //           fontWeight: FontWeight.w500,
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildResaleTicketCard() {
// // //     return Container(
// // //       margin: const EdgeInsets.only(bottom: 12),
// // //       padding: const EdgeInsets.all(12),
// // //       decoration: BoxDecoration(
// // //         border: Border.all(),
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.grey.withOpacity(0.1),
// // //             spreadRadius: 1,
// // //             blurRadius: 8,
// // //             offset: const Offset(0, 2),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           // Movie Poster
// // //           Container(
// // //             width: 60,
// // //             height: 80,
// // //             decoration: BoxDecoration(
// // //               color: Colors.grey[300],
// // //               borderRadius: BorderRadius.circular(6),
// // //               image: const DecorationImage(
// // //                 image: AssetImage('assets/kubera.png'),
// // //                 fit: BoxFit.cover,
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(width: 12),

// // //           // Movie Details
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 const Text(
// // //                   'Kuberaa',
// // //                   style: TextStyle(
// // //                     fontSize: 16,
// // //                     fontWeight: FontWeight.w600,
// // //                     color: Colors.black87,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 4),
// // //                 const Text(
// // //                   '3D.Telungu',
// // //                   style: TextStyle(fontSize: 12, color: Colors.grey),
// // //                 ),
// // //                 const SizedBox(height: 4),

// // //                 const Text(
// // //                   '4 Aug 8:30 PM',
// // //                   style: TextStyle(fontSize: 14, color: Colors.black),
// // //                 ),
// // //                 const SizedBox(height: 2),
// // //                 const Text(
// // //                   'INOX:GVK One,Hyderabad',
// // //                   style: TextStyle(fontSize: 12, color: Colors.grey),
// // //                 ),
// // //                 const SizedBox(height: 8),
// // //               ],
// // //             ),
// // //           ),

// // //           // Price
// // //           const Column(
// // //             crossAxisAlignment: CrossAxisAlignment.end,
// // //             children: [
// // //               Text(
// // //                 '₹200',
// // //                 style: TextStyle(
// // //                   fontSize: 18,
// // //                   fontWeight: FontWeight.w600,
// // //                   color: Colors.black87,
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

























import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/helper/static_helper.dart';
import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backup_ticket/model/movie_ticket_model.dart';

class NearbyTickets extends StatefulWidget {
  const NearbyTickets({super.key});

  @override
  State<NearbyTickets> createState() => _NearbyTicketsState();
}

class _NearbyTicketsState extends State<NearbyTickets> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

    String _userName = "Guest"; 

  @override
  void initState() {
    _loadUserName();
    super.initState();
    // Fetch tickets when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieTicketProvider>().fetchAllTickets();
    });
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
    super.dispose();
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
                    // Left side (location)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row(
                        //   children: const [
                        //     Icon(Icons.send, color: Colors.white, size: 18),
                        //     SizedBox(width: 5),
                        //     Text(
                        //       "Hyderabad, Telangana..",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //     Icon(
                        //       Icons.keyboard_arrow_down,
                        //       color: Colors.white,
                        //       size: 20,
                        //     ),
                        //   ],
                        // ),

                         Row(
                          children: [
                            const Icon(Icons.person, color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              "Hello, $_userName",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 2),
                        // const Text(
                        //   "       Hyderabad, Telangana, India",
                        //   style: TextStyle(color: Colors.white, fontSize: 12),
                        // ),
                      ],
                    ),

                    // Right side (notification)
                    // Container(
                    //   padding: const EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     shape: BoxShape.circle,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black26,
                    //         blurRadius: 4,
                    //         offset: Offset(0, 2),
                    //       ),
                    //     ],
                    //   ),
                    //   child: const Icon(
                    //     Icons.notifications_none,
                    //     color: Colors.black87,
                    //     size: 22,
                    //   ),
                    // ),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    // Dynamic Movie Cards Section
                    Consumer<MovieTicketProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading && provider.tickets.isEmpty) {
                          return SizedBox(
                            height: 280,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (provider.tickets.isEmpty) {
                          return SizedBox(
                            height: 280,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              children: [
                                SizedBox(width: 90),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => MovieDetailScreen(),
                                    //   ),
                                    // );
                                  },
                                  child: _buildMovieCard(
                                    null,
                                    'Kuberaa',
                                    ['13+', 'Action', 'IMAX'],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Get unique movies from tickets
                        List<MovieTicket> uniqueMovies = [];
                        Set<String> seenMovies = {};
                        
                        for (var ticket in provider.tickets) {
                          if (!seenMovies.contains(ticket.movieName)) {
                            uniqueMovies.add(ticket);
                            seenMovies.add(ticket.movieName);
                          }
                        }

                        return SizedBox(
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            itemCount: uniqueMovies.length + 1, // +1 for initial spacing
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return SizedBox(width: 90);
                              }
                              
                              final ticket = uniqueMovies[index - 1];
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => MovieDetailScreen(ticket: ticket),
                                  //   ),
                                  // );
                                },
                                child: _buildMovieCard(
                                  ticket.ticketImageUrl,
                                  ticket.movieName,
                                  [
                                    // ticket.certification ?? '13+',
                                    // ticket.genre ?? 'Action',
                                    // ticket.format ?? 'IMAX'
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),

                    Divider(),
                    const SizedBox(height: 10),

                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search tickets by movie, theatre, or time...',
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
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Nearby Resale Tickets Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Available Tickets',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    // Resale Tickets List - Fixed ListView issue
                    Consumer<MovieTicketProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (provider.error != null) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: Colors.red[300],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Error: ${provider.error}',
                                    style: TextStyle(
                                      color: Colors.red[600],
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      provider.clearError();
                                      provider.fetchAllTickets();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        if (provider.tickets.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.confirmation_number_outlined,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'No tickets available',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        // Filter tickets based on search query
                        List<MovieTicket> filteredTickets = provider.tickets.where((ticket) {
                          if (_searchQuery.isEmpty) return true;
                          
                          final searchableText = 
                              '${ticket.movieName} ${ticket.theatrePlace} ${ticket.showTime}'
                                  .toLowerCase();
                          
                          return searchableText.contains(_searchQuery);
                        }).toList();

                        // Show message if no results found
                        if (filteredTickets.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No tickets found for "$_searchQuery"',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        // Display filtered tickets
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: filteredTickets.map((ticket) {
                              return _buildResaleTicketCard(ticket);
                            }).toList(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieCard(String? imageUrl, String title, List<String> badges) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Movie Poster with Stack
          Stack(
            children: [
              Container(
                height: 220,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imageUrl != null && imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.grey[300],
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/kubera.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.movie,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Image.asset(
                          'assets/kubera.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.movie,
                                size: 40,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Movie Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 6),

          // Badges Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: badges.map((badge) => _buildBadge(badge)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    Color backgroundColor;
    Color textColor = Colors.white;

    switch (text) {
      case '13+':
      case 'UA':
      case 'A':
        backgroundColor = Colors.grey[700]!;
        break;
      case 'Action':
      case 'Drama':
      case 'Thriller':
        backgroundColor = Colors.grey[600]!;
        break;
      case 'IMAX':
      case '2D':
        backgroundColor = Colors.grey[600]!;
        break;
      default:
        backgroundColor = Colors.grey[600]!;
    }

    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildResaleTicketCard([MovieTicket? ticket]) {
    // Use ticket data if available, otherwise use default values
    final movieName = ticket?.movieName ?? 'Kuberaa';
    final format = ticket?.showDate ?? '3D';
    final showDateTime = ticket?.showTime ?? '4 Aug 8:30 PM';
    final theaterName = ticket?.theatrePlace ?? 'INOX:GVK One,Hyderabad';
    final price = ticket?.totalPrice ?? 200;
    final imageUrl = ticket?.ticketImageUrl;

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailScreen(ticketId: ticket!.id),
        //   ),
        // );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Movie Poster
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/kubera.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.movie,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          );
                        },
                      )
                    : Image.asset(
                        'assets/kubera.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.movie,
                              size: 30,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(width: 12),

            // Movie Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const SizedBox(height: 4),
                  Text(
                    showDateTime,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    theaterName,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${price.toString()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}