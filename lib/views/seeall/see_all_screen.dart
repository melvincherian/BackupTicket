// import 'package:backup_ticket/helper/auth_helper.dart';
// import 'package:backup_ticket/helper/static_helper.dart';
// import 'package:backup_ticket/views/Home/image_detail_screen.dart';
// import 'package:backup_ticket/views/notifications/notification_screen.dart';
// import 'package:backup_ticket/views/search/search_screen.dart';
// import 'package:flutter/material.dart';

// class MovieCategory {
//   final String name;
//   final String imageUrl;
//   final List<String> tags;
//   final List<String> languages;

//   MovieCategory({
//     required this.name,
//     required this.imageUrl,
//     required this.tags,
//     required this.languages,
//   });
// }

// class SeeAllScreen extends StatefulWidget {
//   const SeeAllScreen({super.key});

//   @override
//   State<SeeAllScreen> createState() => _SeeAllScreenState();
// }

// class _SeeAllScreenState extends State<SeeAllScreen> {
//   String _userName = "Guest";
//   bool _isLoading = false;
//   String? _error;

//   List<MovieCategory> categories = [
//     MovieCategory(
//       name: "Action",
//       imageUrl:
//           "assets/veeramallu.png",
//       tags: ["Thriller", "Fast"],
//       languages: ["English", "Hindi"],
//     ),
//     MovieCategory(
//       name: "Romance",
//       imageUrl:
//           "assets/veeramallu.png",
//       tags: ["Love", "Drama"],
//       languages: ["Malayalam"],
//     ),
//     MovieCategory(
//       name: "Comedy",
//       imageUrl:
//           "assets/veeramallu.png",
//       tags: ["Fun", "Family"],
//       languages: ["Tamil", "Telugu"],
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadUserName();
//   }

//   Future<void> _loadUserName() async {
//     final name = await UserPreferences.getName();
//     if (mounted && name != null && name.isNotEmpty) {
//       setState(() {
//         _userName = name;
//       });
//     }
//   }

//   Future<void> _refresh() async {
//     setState(() => _isLoading = true);
//     await Future.delayed(const Duration(seconds: 1));
//     setState(() => _isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(90),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           flexibleSpace: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(25),
//               bottomRight: Radius.circular(25),
//             ),
//             child: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//               child: SafeArea(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [

//                         CircleAvatar(child: Icon(Icons.person),),
                      
//                         const SizedBox(width: 12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text("Hello,",
//                                 style: TextStyle(
//                                     color: Colors.white70, fontSize: 14)),
//                             Text(
//                               _userName,
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => NotificationScreen()),
//                       ),
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(Icons.notifications_none,
//                             color: Colors.black87),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: Column(
//         children: [
//           GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => SearchScreen()),
//             ),
//             child: Container(
//               margin: const EdgeInsets.all(16),
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(),
//               ),
//               child: const Row(
//                 children: [
//                   Icon(Icons.search, color: Colors.grey),
//                   SizedBox(width: 12),
//                   Text("Search", style: TextStyle(color: Colors.grey)),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: _refresh,
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : categories.isEmpty
//                       ? const Center(child: Text("No categories available"))
//                       : GridView.builder(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 12,
//                             mainAxisSpacing: 12,
//                             childAspectRatio: 0.75,
//                           ),
//                           itemCount: categories.length,
//                           itemBuilder: (context, index) {
//                             final category = categories[index];
//                             return _buildCategoryCard(
//                               category,
//                               () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => ImageDetailScreen(
//                                       movieName: category.name,
//                                       assetImagePath: category.imageUrl,
//                                       languages:
//                                           category.languages.join(", "),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryCard(MovieCategory category, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.network(
//                   category.imageUrl,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) =>
//                       const Icon(Icons.category, size: 48),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(category.name,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w600, fontSize: 16),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis),
//                   const SizedBox(height: 4),
//                   Text(category.tags.join(" • "),
//                       style:
//                           const TextStyle(fontSize: 12, color: Colors.grey)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
















import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/helper/static_helper.dart';
import 'package:backup_ticket/views/Home/image_detail_screen.dart';
import 'package:backup_ticket/views/notifications/notification_screen.dart';
import 'package:backup_ticket/views/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieCategory {
  final String id;
  final String movieId;
  final String movieName;
  final String language;
  final String theatrePlace;
  final String showDate;
  final String showTime;
  final String ticketCategory;
  final int noOfTickets;
  final int pricePerTicket;
  final int totalPrice;
  final String ticketImage;
  final String status;

  MovieCategory({
    required this.id,
    required this.movieId,
    required this.movieName,
    required this.language,
    required this.theatrePlace,
    required this.showDate,
    required this.showTime,
    required this.ticketCategory,
    required this.noOfTickets,
    required this.pricePerTicket,
    required this.totalPrice,
    required this.ticketImage,
    required this.status,
  });

  factory MovieCategory.fromJson(Map<String, dynamic> json) {
    return MovieCategory(
      id: json['_id'] ?? '',
      movieId: json['movieId']?['_id'] ?? '',
      movieName: json['MovieName'] ?? 'Unknown Movie',
      language: json['language'] ?? 'N/A',
      theatrePlace: json['theatrePlace'] ?? 'N/A',
      showDate: json['showDate'] ?? '',
      showTime: json['showTime'] ?? '',
      ticketCategory: json['ticketCategory'] ?? '',
      noOfTickets: json['noOfTickets'] ?? 0,
      pricePerTicket: json['pricePerTicket'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      ticketImage: json['ticketImage'] ?? '',
      status: json['status'] ?? 'pending',
    );
  }
}

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  String _userName = "Guest";
  bool _isLoading = false;
  String? _error;
  List<MovieCategory> categories = [];

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _fetchOngoingMovies();
  }

  Future<void> _loadUserName() async {
    final name = await UserPreferences.getName();
    if (mounted && name != null && name.isNotEmpty) {
      setState(() {
        _userName = name;
      });
    }
  }

  Future<void> _fetchOngoingMovies() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:8127/api/admin/ongoingmovies'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['movies'] != null) {
          setState(() {
            categories = (data['movies'] as List)
                .map((movie) => MovieCategory.fromJson(movie))
                .toList();
            _isLoading = false;
          });
        } else {
          setState(() {
            _error = 'Failed to load movies';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _error = 'Server error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Network error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _refresh() async {
    await _fetchOngoingMovies();
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
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
                        const CircleAvatar(child: Icon(Icons.person)),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Hello,",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 14)),
                            Text(
                              _userName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NotificationScreen()),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_none,
                            color: Colors.black87),
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
      body: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SearchScreen()),
            ),
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 12),
                  Text("Search", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_error!,
                                  style: const TextStyle(color: Colors.red)),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _fetchOngoingMovies,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        )
                      : categories.isEmpty
                          ? const Center(
                              child: Text("No ongoing movies available"))
                          : GridView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.65,
                              ),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return _buildCategoryCard(
                                  category,
                                  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ImageDetailScreen(
                                          movieName: category.movieName,
                                          assetImagePath: category.ticketImage,
                                          languages: category.language,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(MovieCategory category, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: category.ticketImage.isNotEmpty
                    ? Image.network(
                        category.ticketImage,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.movie, size: 48),
                        ),
                      )
                    : Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.movie, size: 48),
                      ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category.movieName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      category.language,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Row(
                    //   children: [
                    //     const Icon(Icons.location_on,
                    //         size: 12, color: Colors.grey),
                    //     const SizedBox(width: 2),
                    //     // Expanded(
                    //     //   child: Text(
                    //     //     category.theatrePlace,
                    //     //     style: const TextStyle(
                    //     //         fontSize: 11, color: Colors.grey),
                    //     //     maxLines: 1,
                    //     //     overflow: TextOverflow.ellipsis,
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       category.showTime,
                    //       style: const TextStyle(
                    //           fontSize: 11,
                    //           color: Color(0xFF1976D2),
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //     Container(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 6, vertical: 2),
                    //       decoration: BoxDecoration(
                    //         color: category.status == 'sold'
                    //             ? Colors.green.shade100
                    //             : Colors.orange.shade100,
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //       child: Text(
                    //         category.status.toUpperCase(),
                    //         style: TextStyle(
                    //           fontSize: 9,
                    //           color: category.status == 'sold'
                    //               ? Colors.green.shade700
                    //               : Colors.orange.shade700,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}