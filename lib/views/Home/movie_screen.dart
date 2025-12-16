// import 'package:flutter/material.dart';
// import '../Home/image_detail_screen.dart';
// import '../Details/detail_screen.dart';
// import '../notifications/notification_screen.dart';
// import '../search/search_screen.dart';
// import '../seeall/see_all_screen.dart';

// class MovieScreen extends StatefulWidget {
//   const MovieScreen({super.key});

//   @override
//   State<MovieScreen> createState() => _MovieScreenState();
// }

// class _MovieScreenState extends State<MovieScreen> {
//   PageController _pageController = PageController(viewportFraction: 0.55);
//   int _currentPage = 0;

//   final String _userName = "Guest";

//   final List<Map<String, dynamic>> _categories = [
//     {
//       "id": "1",
//       "name": "Mahavatar Narasimha",
//       "image": "assets/narasimha.png",
//       "tags": ["UA", "Action", "IMAX"]
//     },
//     {
//       "id": "2",
//       "name": "Veeramahulu",
//       "image": "assets/veeramallu.png",
//       "tags": ["UA", "Drama"]
//     },
//     {
//       "id": "3",
//       "name": "Kubera",
//       "image": "assets/kubera.png",
//       "tags": ["A", "Action"]
//     },
//   ];

//   // Static nearby tickets
//   final List<Map<String, dynamic>> _tickets = [
//     {
//       "movie": "Narasimha",
//       "language": "Malayalam",
//       "theatre": "Cinemax, Calicut",
//       "date": "12 Dec",
//       "time": "7:30 PM",
//       "price": 150,
//       "image": "assets/narasimha.png",
//     },
//     {
//       "movie": "Veeramahulu",
//       "language": "Telugu",
//       "theatre": "PVR Mall",
//       "date": "13 Dec",
//       "time": "5:00 PM",
//       "price": 200,
//       "image": "assets/veeramallu.png",
//     },
//   ];

//   @override
//   void initState() {
//     _pageController.addListener(() {
//       setState(() {
//         _currentPage = _pageController.page!.round();
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildHeader(),
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildSearchBar(),
//                     _buildOngoingSection(),
//                     _buildCategoryList(),
//                     const SizedBox(height: 20),
//                     _buildNearbyHeader(),
//                     _buildNearbyTickets(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // HEADER
//   PreferredSizeWidget _buildHeader() {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(90),
//       child: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         flexibleSpace: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(25),
//             bottomRight: Radius.circular(25),
//           ),
//           child: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             child: SafeArea(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // LEFT: Avatar + Name
//                   Row(
//                     children: [
//                       const CircleAvatar(
//                         radius: 22,
//                         backgroundColor: Colors.white,
//                         child: CircleAvatar(
//                           radius: 20,
//                           backgroundColor: Colors.grey,
//                           child: Icon(Icons.person, color: Colors.white),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Hello,",
//                             style: TextStyle(color: Colors.white70, fontSize: 14),
//                           ),
//                           Text(
//                             _userName,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),

//                   // RIGHT: Notification
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => NotificationScreen()));
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(Icons.notifications_none,
//                           color: Colors.black87, size: 22),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // SEARCH BAR
//   Widget _buildSearchBar() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (_) => SearchScreen()));
//       },
//       child: Container(
//         margin: const EdgeInsets.all(16),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         height: 50,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(25),
//           border: Border.all(color: Colors.black87),
//         ),
//         child: const Row(
//           children: [
//             Icon(Icons.search, color: Colors.grey),
//             SizedBox(width: 12),
//             Text('Search', style: TextStyle(color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }

//   // ONGOING MOVIES HEADER
//   Widget _buildOngoingSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             "Ongoing Movies",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => SeeAllScreen()),
//               );
//             },
//             child: const Text("See All", style: TextStyle(color: Colors.black)),
//           ),
//         ],
//       ),
//     );
//   }

//   // CATEGORY CAROUSEL
//   Widget _buildCategoryList() {
//     return SizedBox(
//       height: 310,
//       child: PageView.builder(
//         controller: _pageController,
//         itemCount: _categories.length,
//         itemBuilder: (context, index) {
//           final c = _categories[index];
//           return AnimatedContainer(
//             duration: const Duration(milliseconds: 250),
//             margin: EdgeInsets.symmetric(
//                 horizontal: 8, vertical: index == _currentPage ? 0 : 20),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ImageDetailScreen(
//                       movieName: c["name"],
//                       categoryId: c["id"],
//                       assetImagePath: c["image"],
//                     ),
//                   ),
//                 );
//               },
//               child: _buildCategoryCard(c),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCategoryCard(Map<String, dynamic> c) {
//     return Column(
//       children: [
//         Expanded(
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.asset(
//               c["image"],
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           c["name"],
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         const SizedBox(height: 6),
//         Wrap(
//           spacing: 6,
//           children: c["tags"].map<Widget>((t) => _buildTag(t)).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildTag(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: Colors.grey[700],
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(text,
//           style: const TextStyle(fontSize: 10, color: Colors.white)),
//     );
//   }

//   // NEARBY HEADER
//   Widget _buildNearbyHeader() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: const [
//           Text(
//             "Nearby Resale Tickets",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//           ),
//           Spacer(),
//           Icon(Icons.arrow_forward_ios, size: 15),
//         ],
//       ),
//     );
//   }

//   // STATIC NEARBY TICKETS
//   Widget _buildNearbyTickets() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.all(16),
//       itemCount: _tickets.length,
//       itemBuilder: (context, index) {
//         final t = _tickets[index];
//         return _buildTicketCard(t);
//       },
//     );
//   }

//   Widget _buildTicketCard(Map<String, dynamic> t) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => DetailScreen( movieName: 'hhhhhh', pricePerTicket: 400,), // static UI only
//           ),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           border: Border.all(),
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(6),
//               child: Image.asset(
//                 t["image"],
//                 width: 60,
//                 height: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(t["movie"],
//                       style:
//                           const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                   Text(t["language"], style: const TextStyle(color: Colors.grey)),
//                   Text("${t["date"]}  ${t["time"]}",
//                       style: const TextStyle(fontWeight: FontWeight.bold)),
//                   Text(t["theatre"],
//                       style: const TextStyle(color: Colors.grey)),
//                 ],
//               ),
//             ),
//             Text("₹${t["price"]}",
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:backup_ticket/model/ongoing_movie_model.dart';
import 'package:backup_ticket/provider/ongoing/ongoing_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Home/image_detail_screen.dart';
import '../Details/detail_screen.dart';
import '../notifications/notification_screen.dart';
import '../search/search_screen.dart';
import '../seeall/see_all_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  PageController _pageController = PageController(viewportFraction: 0.55);
  int _currentPage = 0;

  final String _userName = "Guest";

  final List<Map<String, dynamic>> _categories = [
    {
      "id": "1",
      "name": "Mahavatar Narasimha",
      "image": "assets/narasimha.png",
      "tags": ["UA", "Action", "IMAX"],
    },
    {
      "id": "2",
      "name": "Veeramahulu",
      "image": "assets/veeramallu.png",
      "tags": ["UA", "Drama"],
    },
    {
      "id": "3",
      "name": "Kubera",
      "image": "assets/kubera.png",
      "tags": ["A", "Action"],
    },
  ];

  // Static nearby tickets
  final List<Map<String, dynamic>> _tickets = [
    {
      "movie": "Narasimha",
      "language": "Malayalam",
      "theatre": "Cinemax, Calicut",
      "date": "12 Dec",
      "time": "7:30 PM",
      "price": 150,
      "image": "assets/narasimha.png",
    },
    {
      "movie": "Veeramahulu",
      "language": "Telugu",
      "theatre": "PVR Mall",
      "date": "13 Dec",
      "time": "5:00 PM",
      "price": 200,
      "image": "assets/veeramallu.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });

    // Fetch ongoing movies when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OngoingMoviesProvider>().fetchOngoingMovies();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    _buildOngoingSection(),
                    _buildCategoryList(),
                    const SizedBox(height: 20),
                    _buildNearbyHeader(),
                    _buildNearbyTickets(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HEADER
  PreferredSizeWidget _buildHeader() {
    return PreferredSize(
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

                  // RIGHT: Notification
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NotificationScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
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
    );
  }

  // SEARCH BAR
  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SearchScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black87),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 12),
            Text('Search', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // ONGOING MOVIES HEADER
  Widget _buildOngoingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Ongoing Movies",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SeeAllScreen()),
              );
            },
            child: const Text("See All", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  // CATEGORY CAROUSEL - NOW INTEGRATED WITH API
  Widget _buildCategoryList() {
    return Consumer<OngoingMoviesProvider>(
      builder: (context, provider, child) {
        if (provider.state == MovieState.loading) {
          return SizedBox(
            height: 310,
            child: Center(
              child: CircularProgressIndicator(color: Color(0xFF1976D2)),
            ),
          );
        }

        if (provider.state == MovieState.error) {
          return SizedBox(
            height: 310,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 12),
                  Text(
                    'Failed to load movies',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      provider.fetchOngoingMovies();
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // If no movies from API, show static categories
        final movies = provider.movies.isEmpty ? _categories : provider.movies;

        if (provider.movies.isEmpty) {
          // Use static data
          return SizedBox(
            height: 310,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final c = _categories[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: index == _currentPage ? 0 : 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => ImageDetailScreen(
                      //       movieName: c["name"],
                      //       categoryId: c["id"],
                      //       assetImagePath: c["image"],
                      //     ),
                      //   ),
                      // );
                    },
                    child: _buildStaticCategoryCard(c),
                  ),
                );
              },
            ),
          );
        }

        // Use API data
        return SizedBox(
          height: 310,
          child: PageView.builder(
            controller: _pageController,
            itemCount: provider.movies.length,
            itemBuilder: (context, index) {
              final movie = provider.movies[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: index == _currentPage ? 0 : 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => DetailScreen(
                    //       movieName: movie.movieName,
                    //       pricePerTicket: movie.pricePerTicket.toDouble(),
                    //     ),
                    //   ),
                    // );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ImageDetailScreen(
                          movieName: movie.movieName,
                          categoryId: movie.id,
                          assetImagePath: movie.ticketImage,
                        ),
                      ),
                    );
                  },
                  child: _buildApiCategoryCard(movie),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStaticCategoryCard(Map<String, dynamic> c) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              c["image"],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          c["name"],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          children: c["tags"].map<Widget>((t) => _buildTag(t)).toList(),
        ),
      ],
    );
  }

  Widget _buildApiCategoryCard(OngoingMovie movie) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              movie.ticketImage,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.movie, size: 48, color: Colors.grey[600]),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.movieName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          children: [
            _buildTag(movie.ticketCategory),
            _buildTag(movie.language.split(',').first.trim()),
          ],
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10, color: Colors.white),
      ),
    );
  }

  // NEARBY HEADER
  Widget _buildNearbyHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Text(
            "Nearby Resale Tickets",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 15),
        ],
      ),
    );
  }

  // NEARBY TICKETS - NOW INTEGRATED WITH API
  Widget _buildNearbyTickets() {
    return Consumer<OngoingMoviesProvider>(
      builder: (context, provider, child) {
        if (provider.state == MovieState.loading) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: CircularProgressIndicator(color: Color(0xFF1976D2)),
            ),
          );
        }

        if (provider.state == MovieState.error) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.error_outline, size: 36, color: Colors.red),
                  SizedBox(height: 8),
                  Text(
                    'Failed to load tickets',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          );
        }

        // If no movies from API, show static tickets
        if (provider.movies.isEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: _tickets.length,
            itemBuilder: (context, index) {
              final t = _tickets[index];
              return _buildStaticTicketCard(t);
            },
          );
        }

        // Use API data
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: provider.movies.length,
          itemBuilder: (context, index) {
            final movie = provider.movies[index];
            return _buildApiTicketCard(movie);
          },
        );
      },
    );
  }

  Widget _buildStaticTicketCard(Map<String, dynamic> t) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DetailScreen(movieName: t["movie"], pricePerTicket: t["price"]),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                t["image"],
                width: 60,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t["movie"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    t["language"],
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "${t["date"]}  ${t["time"]}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    t["theatre"],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              "₹${t["price"]}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApiTicketCard(OngoingMovie movie) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => DetailScreen(
        //       movieName: movie.movieName,
        //       pricePerTicket: movie.pricePerTicket.toDouble(),
        //     ),
        //   ),
        // );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageDetailScreen(
              movieName: movie.movieName,
              categoryId: movie.id,
              assetImagePath: movie.ticketImage,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                movie.ticketImage,
                width: 60,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(Icons.movie, color: Colors.grey[600]),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.movieName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    movie.language,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "${_formatDate(movie.showDate)}  ${movie.showTime}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    movie.theatrePlace,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              "₹${movie.totalPrice}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }
}
