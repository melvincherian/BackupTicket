import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/model/movie_ticket_model.dart';
import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
import 'package:backup_ticket/provider/movie/movie_category_provider.dart';
import 'package:backup_ticket/provider/selltickets/sell_movie_ticket_provider.dart';
import 'package:backup_ticket/views/Details/detail_screen.dart';
import 'package:backup_ticket/views/Home/image_detail_screen.dart';
import 'package:backup_ticket/views/notifications/notification_screen.dart';
import 'package:backup_ticket/views/search/search_screen.dart';
import 'package:backup_ticket/views/seeall/see_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  // Location-related state variables
  Position? _userPosition;
  List<MovieTicket> _nearbyTickets = [];
  bool _isLoadingLocation = false;
  double _maxDistanceKm = 10.0; // Default 10km radius

  String _userName = "Guest";
  String _userId = "";

  PageController _pageController = PageController(viewportFraction: 0.55);
  int _currentPage = 0;

  int _selectedMovieIndex = -1;

  // Static movie images that will cycle through
  // final List<String> _staticMovieImages = [
  //   'assets/ogposter.jpg',
  //   'assets/mirai.jpeg',
  //   'assets/littlehearts.jpg',
  // ];

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    super.initState();

    _initializeData();
    // Fetch tickets when the screen loads
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<MovieTicketProvider>().fetchAllTickets();
    //   _getCurrentLocation(); // Get user location
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<MovieTicketProvider>().fetchAllTickets();
    //   context.read<MovieCategoryProvider>().fetchCategories();
    //   context.read<UserProfileProvider>().loadUserProfile(_userId);

    //   // _getCurrentLocation();
    //   _loadUserName();
    // });
  }

  //  Future<void> _loadUserName() async {
  //   final name = await UserPreferences.getName();
  //   if (mounted && name != null && name.isNotEmpty) {
  //     setState(() {
  //       _userName = name;
  //     });
  //   }
  // }

  Future<void> _initializeData() async {
    // Load user data first
    await _loadUserName();

    // Then load everything else after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieTicketProvider>().fetchAllTickets();
      context.read<MovieCategoryProvider>().fetchCategories();

      // Load user profile with the userId we just got
      if (_userId.isNotEmpty) {
        context.read<UserProfileProvider>().loadUserProfile(_userId);
      }
    });
  }


  Future<void> _loadUserName() async {
    final name = await UserPreferences.getName();
    final userId = await UserPreferences.getUserId(); // <-- Fetch userId

    if (mounted &&
        name != null &&
        name.isNotEmpty &&
        userId != null &&
        userId.isNotEmpty) {
      setState(() {
        _userName = name;
        _userId = userId;
      });
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Search Bar
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(16.0),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(),
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
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Search',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Ongoing Movies Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ongoing Movies',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeeAllScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Movies Horizontal List - Modified to show dynamic movie names
                    // Consumer<MovieTicketProvider>(
                    //   builder: (context, provider, child) {
                    //     if (provider.isLoading) {
                    //       return SizedBox(
                    //         height: 280,
                    //         child: Center(child: CircularProgressIndicator()),
                    //       );
                    //     }

                    //     final uniqueMovieNames = _getUniqueMovieNames(
                    //       provider.tickets,
                    //     );

                    //     // If no movies added yet, show default movies
                    //     if (uniqueMovieNames.isEmpty) {
                    //       return SizedBox(
                    //         height: 280,
                    //         child: ListView(
                    //           scrollDirection: Axis.horizontal,
                    //           padding: const EdgeInsets.symmetric(
                    //             horizontal: 16.0,
                    //           ),
                    //           children: [
                    //             _buildMovieCard(
                    //               'assets/narasimha.png',
                    //               'Mahavtar Narasimha',
                    //               ['13+', 'Action', 'IMAX'],
                    //             ),
                    //             _buildMovieCard(
                    //               'assets/veeramallu.png',
                    //               'Veeramahulu',
                    //               ['UA', 'Drama', 'Thriller'],
                    //             ),
                    //             _buildMovieCard('assets/kubera.png', 'Kubera', [
                    //               'A',
                    //               'Action',
                    //               '2D',
                    //             ]),
                    //           ],
                    //         ),
                    //       );
                    //     }

                    //     // Show dynamic movie names with static images
                    //     return SizedBox(
                    //       height: 280,
                    //       child: ListView.builder(
                    //         scrollDirection: Axis.horizontal,
                    //         padding: const EdgeInsets.symmetric(
                    //           horizontal: 16.0,
                    //         ),
                    //         itemCount: uniqueMovieNames.length,
                    //         itemBuilder: (context, index) {
                    //           final movieName = uniqueMovieNames[index];
                    //           // Use static images in rotation
                    //           final imageIndex =
                    //               index % _staticMovieImages.length;
                    //           final imagePath = _staticMovieImages[imageIndex];

                    //           // Get sample badges based on movie name or use default
                    //           final badges = _getBadgesForMovie(movieName);

                    //           return GestureDetector(
                    //             onTap: () {
                    //               // You can navigate to detail screen with this movie's data
                    //               Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                   builder: (context) => DetailScreen(),
                    //                   settings: RouteSettings(
                    //                     arguments: movieName,
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //             child: _buildMovieCard(
                    //               imagePath,
                    //               movieName,
                    //               badges,
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     );
                    //   },
                    // ),

                    // Ongoing Movies Section - Modified to show categories
                    Consumer<MovieCategoryProvider>(
                      builder: (context, categoryProvider, child) {
                        if (categoryProvider.isLoading) {
                          return SizedBox(
                            height: 280,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final categories = categoryProvider.activeCategories;

                        // If no categories added yet, show placeholder
                        if (categories.isEmpty) {
                          return SizedBox(
                            height: 280,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.category_outlined,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'No categories available',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        // Show dynamic categories
                        // return SizedBox(
                        //   height: 280,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     padding: const EdgeInsets.symmetric(
                        //       horizontal: 16.0,
                        //     ),
                        //     itemCount: categories.length,
                        //     itemBuilder: (context, index) {
                        //       final category = categories[index];

                        //       return GestureDetector(
                        //         onTap: () {
                        //           // Navigate to category-specific movies or detail screen
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //               builder: (context) => ImageDetailScreen(
                        //                 movieName: category.name,
                        //                 assetImagePath: category.imageUrl,
                        //                 languages: category.languages
                        //                     .toString(),
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //         child: _buildCategoryCard(
                        //           category.imageUrl,
                        //           category.name,
                        //           category.tags,
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // );

                        return SizedBox(
                          height: 310,
                          // width: 430,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: index == _currentPage ? 0 : 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: index == _currentPage
                                      ? [
                                          // BoxShadow(
                                          //   color: Colors.black.withOpacity(
                                          //     0.3,
                                          //   ),
                                          //   blurRadius: 15,
                                          //   spreadRadius: 2,
                                          //   offset: Offset(0, 6),
                                          // ),
                                        ]
                                      : [],
                                  border: index == _currentPage
                                      ? Border.all(
                                          color: Colors
                                              .transparent, // Makes border invisible
                                          width: 3,
                                        )
                                      : null,

                                  // border: index == _currentPage
                                  //     ? Border.all(
                                  //         // color: const Color.fromARGB(255, 181, 181, 181),
                                  //         width: 3,
                                  //       )
                                  //     : null,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageDetailScreen(
                                          movieName: category.name,
                                          categoryId: category.id,
                                          assetImagePath: category.imageUrl,
                                        ),
                                      ),
                                    );
                                  },
                                  child: _buildCategoryCard(
                                    category.imageUrl,
                                    category.name,
                                    category.tags,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Nearby Resale Tickets Section Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Text(
                            'Nearby Resale Tickets',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeeAllScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 15),
                        ],
                      ),
                    ),

                    // Location-based Nearby Tickets Section
                    _buildNearbyTicketsSection(),

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



  Widget _buildNearbyTicketsSection() {
  return Consumer<MovieCategoryProvider>(
    builder: (context, categoryProvider, child) {
      if (categoryProvider.isLoading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (categoryProvider.error != null) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Error: ${categoryProvider.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => categoryProvider.fetchCategories(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      }

      final categories = categoryProvider.activeCategories;

      if (categories.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Icon(
                  Icons.category_outlined,
                  size: 48,
                  color: Colors.grey,
                ),
                const SizedBox(height: 8),
                Text(
                  'No movie categories available',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      }

      // Display only first 4 categories (for "See All" functionality)
      final displayCategories = categories.take(4).toList();

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: displayCategories.length,
        itemBuilder: (context, index) {
          return _buildCategoryTicketCard(context, displayCategories[index]);
        },
      );
    },
  );
}



Widget _buildCategoryTicketCard(BuildContext context, dynamic category) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageDetailScreen(
            movieName: category.name,
            categoryId: category.id,
            assetImagePath: category.imageUrl,
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
          // Movie Category Poster
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                category.imageUrl,
                fit: BoxFit.cover,
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
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.movie,
                      color: Colors.grey,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Movie Category Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                         Row(
            children: [
                 Text('${category.languages[0]}')
            ],
          ),
                
                // Show tags/badges
                // Wrap(
                //   spacing: 4,
                //   runSpacing: 4,
                //   children: category.tags.take(3).map<Widget>((tag) {
                //     return Container(
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 8,
                //         vertical: 4,
                //       ),
                //       decoration: BoxDecoration(
                //         color: Colors.grey[600],
                //         borderRadius: BorderRadius.circular(4),
                //       ),
                //       child: Text(
                //         tag,
                //         style: const TextStyle(
                //           color: Colors.white,
                //           fontSize: 10,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     );
                //   }).toList(),
                // ),
              ],
            ),
          ),

 

          // Arrow icon to indicate clickable
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[600],
          ),
        ],
      ),
      
    ),
  );
}

  // Build the nearby tickets section with location filtering
  // Widget _buildNearbyTicketsSection() {
  //   return Consumer<MovieTicketProvider>(
  //     builder: (context, provider, child) {
  //       if (provider.isLoading || _isLoadingLocation) {
  //         return const Center(
  //           child: Padding(
  //             padding: EdgeInsets.all(20.0),
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       }

  //       if (provider.error != null) {
  //         return Center(
  //           child: Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Column(
  //               children: [
  //                 Text(
  //                   'Error: ${provider.error}',
  //                   style: const TextStyle(color: Colors.red),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 const SizedBox(height: 10),
  //                 ElevatedButton(
  //                   onPressed: () => provider.fetchAllTickets(),
  //                   child: const Text('Retry'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       }

  //       // Use nearby tickets if location is available, otherwise show all tickets
  //       List<MovieTicket> ticketsToShow = _userPosition != null
  //           ? _nearbyTickets
  //           : provider.tickets;

  //       if (ticketsToShow.isEmpty) {
  //         return Center(
  //           child: Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Column(
  //               children: [
  //                 Icon(
  //                   _userPosition != null
  //                       ? Icons.location_off
  //                       : Icons.movie_outlined,
  //                   size: 48,
  //                   color: Colors.grey,
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Text(
  //                   _userPosition != null
  //                       ? 'No tickets found within ${_maxDistanceKm.toInt()}km'
  //                       : 'No tickets available',
  //                   style: const TextStyle(fontSize: 16, color: Colors.grey),
  //                 ),
  //                 if (_userPosition != null) ...[
  //                   const SizedBox(height: 8),
  //                   TextButton(
  //                     onPressed: () {
  //                       setState(() {
  //                         _maxDistanceKm = _maxDistanceKm == 10 ? 50 : 10;
  //                       });
  //                       _filterNearbyTickets();
  //                     },
  //                     child: Text(
  //                       'Search within ${_maxDistanceKm == 10 ? 50 : 10}km instead',
  //                       style: const TextStyle(color: Colors.blue),
  //                     ),
  //                   ),
  //                 ],
  //               ],
  //             ),
  //           ),
  //         );
  //       }

  //       // Display only first 4 tickets (for "See All" functionality)
  //       final displayTickets = ticketsToShow.take(4).toList();

  //       return Column(
  //         children: [
  //           // Distance filter controls (optional)
  //           if (_userPosition != null)
  //             Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 16.0,
  //                 vertical: 8.0,
  //               ),
  //               child: Row(
  //                 children: [
  //                   // const Text('Within: '),
  //                   // DropdownButton<double>(
  //                   //   value: _maxDistanceKm,
  //                   //   items: [5.0, 10.0, 25.0, 50.0].map((distance) {
  //                   //     return DropdownMenuItem(
  //                   //       value: distance,
  //                   //       child: Text('${distance.toInt()}km'),
  //                   //     );
  //                   //   }).toList(),
  //                   //   onChanged: (newDistance) {
  //                   //     if (newDistance != null) {
  //                   //       setState(() {
  //                   //         _maxDistanceKm = newDistance;
  //                   //       });
  //                   //       _filterNearbyTickets();
  //                   //     }
  //                   //   },
  //                   // ),
  //                   const Spacer(),
  //                   // TextButton.icon(
  //                   //   onPressed: _getCurrentLocation,
  //                   //   icon: const Icon(Icons.location_city, size: 16),
  //                   //   label: const Text('Refresh Location'),
  //                   //   style: TextButton.styleFrom(
  //                   //     foregroundColor: Colors.blue,
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
  //             ),

  //           // Tickets list
  //           ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //             itemCount: displayTickets.length,
  //             itemBuilder: (context, index) {
  //               return _buildResaleTicketCard(context, displayTickets[index]);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Helper method to generate badges for movies
  // Widget _buildCategoryCard(String imageUrl, String title, List<String> tags) {
  //   return Container(
  //     width: 160,
  //     margin: const EdgeInsets.only(right: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         // Category Image with Stack
  //         Stack(
  //           children: [
  //             Container(
  //               height: 220,
  //               width: 160,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(12),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black.withOpacity(0.2),
  //                     spreadRadius: 1,
  //                     blurRadius: 8,
  //                     offset: const Offset(0, 4),
  //                   ),
  //                 ],
  //               ),
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(12),
  //                 child: Image.network(
  //                   imageUrl,
  //                   fit: BoxFit.cover,
  //                   loadingBuilder: (context, child, loadingProgress) {
  //                     if (loadingProgress == null) return child;
  //                     return Center(
  //                       child: CircularProgressIndicator(
  //                         value: loadingProgress.expectedTotalBytes != null
  //                             ? loadingProgress.cumulativeBytesLoaded /
  //                                   loadingProgress.expectedTotalBytes!
  //                             : null,
  //                       ),
  //                     );
  //                   },
  //                   errorBuilder: (context, error, stackTrace) {
  //                     return Container(
  //                       color: Colors.grey[300],
  //                       child: const Icon(
  //                         Icons.movie,
  //                         size: 40,
  //                         color: Colors.grey,
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),

  //         const SizedBox(height: 8),

  //         // Category Title
  //         Text(
  //           title,
  //           style: const TextStyle(
  //             fontSize: 14,
  //             fontWeight: FontWeight.w600,
  //             color: Colors.black87,
  //           ),
  //           maxLines: 2,
  //           textAlign: TextAlign.center,
  //           overflow: TextOverflow.ellipsis,
  //         ),

  //         const SizedBox(height: 6),

  //         // Tags Row - Show first 3 tags
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: tags.take(3).map((tag) => _buildBadge(tag)).toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCategoryCard(String imageUrl, String title, List<String> tags) {
    return Container(
      margin: const EdgeInsets.all(0), // Small margin for padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Category Image with Stack
          Expanded(
            child: Container(
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
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
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
          ),

          const SizedBox(height: 8),

          // Category Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 6),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            children: tags.take(3).map((tag) => _buildBadge(tag)).toList(),
          ),

          const SizedBox(height: 8),
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
      case 'U':
        backgroundColor = Colors.grey[700]!;
        break;
      case 'Action':
      case 'Drama':
      case 'Thriller':
      case 'Comedy':
      case 'Romance':
        backgroundColor = Colors.grey[600]!;
        break;
      case 'IMAX':
      case '2D':
      case 'HD':
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

  Widget _buildResaleTicketCard(BuildContext context, MovieTicket ticket) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              ticket: ticket,
              image: ticket.ticketImageUrl,
              noftickets: ticket.numberOfTickets.toString(),
            ),
            settings: RouteSettings(arguments: ticket), // Pass ticket data
          ),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => NearbyTickets(),
        //     settings: RouteSettings(arguments: ticket), // Pass ticket data
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
            // Movie Poster - Using Firebase image or fallback
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child:
                    ticket.ticketImageUrl != null &&
                        ticket.ticketImageUrl!.isNotEmpty
                    ? Image.network(
                        ticket.ticketImageUrl!,
                        fit: BoxFit.cover,
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
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.movie,
                              color: Colors.grey,
                              size: 30,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.movie,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),

            // Movie Details - Using Firebase data
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.movieName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${ticket.language ?? "Tamil"}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 125, 125, 125),
                    ),
                  ),

                  Text(
                    '${_formatDate(ticket.showDate)} ${ticket.showTime}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    '${ticket.theatrePlace}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 154, 154, 154),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Text(
                  //   'No of tickets: ${ticket.numberOfTickets}',
                  //   style: const TextStyle(fontSize: 14, color: Colors.black),
                  // ),
                  const SizedBox(height: 2),

                  // Add distance info
                  if (_userPosition != null &&
                      ticket.latitude != null &&
                      ticket.longitude != null) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        // const Icon(
                        //   Icons.location_on,
                        //   size: 12,
                        //   color: Colors.green,
                        // ),
                        const SizedBox(width: 2),
                        // Text(
                        //   _getDistanceText(ticket),
                        //   style: const TextStyle(
                        //     fontSize: 11,
                        //     color: Colors.green,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                ],
              ),
            ),

            // Price - Using Firebase data
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${ticket.pricePerTicket.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to format date
  String _formatDate(DateTime date) {
    const months = [
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
