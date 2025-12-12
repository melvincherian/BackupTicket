import 'package:backup_ticket/helper/auth_helper.dart';
import 'package:backup_ticket/provider/auth/user_profile_provider.dart';
import 'package:backup_ticket/views/auth/login_screen.dart';
import 'package:backup_ticket/views/deleteaccount/delete_account.dart';
import 'package:backup_ticket/views/movies/create_movie.dart';
import 'package:backup_ticket/views/notifications/notification_screen.dart';
import 'package:backup_ticket/views/postedtickets/posted_tickets.dart';
import 'package:backup_ticket/views/privacy/help_screen.dart';
import 'package:backup_ticket/views/profile/my_profile.dart';
import 'package:backup_ticket/views/purchasedtickets/purchased_tickets.dart';
import 'package:backup_ticket/views/referearn/refer_earn_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isGuest = true;
  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // Future<void> _loadUserProfile() async {
  //   try {
  //     String? userId = await UserPreferences.getUserId();
  //     if (userId != null && userId.isNotEmpty && mounted) {
  //       final profileProvider = Provider.of<UserProfileProvider>(
  //         context,
  //         listen: false,
  //       );
  //       await profileProvider.loadUserProfile(userId);
  //     }
  //   } catch (e) {
  //     print('Error loading user profile: $e');
  //   }
  // }

  Future<void> _loadUserProfile() async {
    try {
      String? userId = await UserPreferences.getUserId();

      setState(() {
        isGuest = userId == null || userId.isEmpty;
      });

      if (!isGuest && mounted) {
        final profileProvider = Provider.of<UserProfileProvider>(
          context,
          listen: false,
        );
        await profileProvider.loadUserProfile(userId!);
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open the URL'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening URL: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _logout(BuildContext context) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      try {
        // Clear user preferences
        await UserPreferences.clearUser();

        // Clear provider data
        if (mounted) {
          Provider.of<UserProfileProvider>(
            context,
            listen: false,
          ).clearUserData();
        }

        // Navigate to login screen and remove all previous routes
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        // Handle any errors during logout
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error during logout: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Widget _buildProfileImage(String? profileImageUrl) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: (profileImageUrl != null && profileImageUrl.isNotEmpty)
                ? Image.network(
                    profileImageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                  )
                : Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
          ),
        ),

        /// Edit icon
        Positioned(
          bottom: -2,
          right: -2,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit, size: 14, color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profilerectangle.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Status bar spacing
                const SizedBox(height: 20),

                // Profile section
                Consumer<UserProfileProvider>(
                  builder: (context, profileProvider, child) {
                    return Column(
                      children: [
                        // Profile image with edit icon
                        GestureDetector(
                          onTap: () async {
                            // Navigate to profile edit screen
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyProfile(),
                              ),
                            );
                            // Reload profile after returning from edit screen
                            _loadUserProfile();
                          },
                          child: _buildProfileImage(
                            profileProvider.profileImageUrl,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // User name
                        if (profileProvider.isLoading)
                          const CircularProgressIndicator(color: Colors.white)
                        else
                          Text(
                            profileProvider.name ?? "Guest",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Profile card
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 280,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          // Profile title
                          const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Menu items
                          _buildMenuItem(
                            icon: Icons.person_outline,
                            iconColor: const Color(0xFF4A90E2),
                            title: 'My Profile',
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyProfile(),
                                ),
                              );
                              // Reload profile after returning
                              _loadUserProfile();
                            },
                          ),

                          _buildMenuItem(
                            icon: Icons.confirmation_number_outlined,
                            iconColor: const Color(0xFF8B5CF6),
                            title: 'My Posted Tickets',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostedTickets(),
                                ),
                              );
                            },
                          ),

                          _buildMenuItem(
                            icon: Icons.receipt_outlined,
                            iconColor: const Color(0xFF06B6D4),
                            title: 'My Purchased Tickets',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PurchasedTickets(),
                                ),
                              );
                            },
                          ),

                          _buildMenuItem(
                            icon: Icons.notification_add,
                            iconColor: const Color.fromARGB(255, 6, 212, 51),
                            title: 'Notifications',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen(),
                                ),
                              );
                            },
                          ),

                          _buildMenuItem(
                            icon: Icons.movie,
                            iconColor: const Color(0xFF06B6D4),
                            title: 'Movies',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CreateMovie(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),

                          // Support & Settings section
                          const Row(
                            children: [
                              Text(
                                'Support & Settings',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          _buildMenuItem(
                            icon: Icons.privacy_tip_outlined,
                            iconColor: const Color(0xFFF59E0B),
                            title: 'Privacy Policy',
                            onTap: () {
                              _launchURL(
                                'https://backupticket-f3cc6.web.app/privacy-policy',
                              );
                            },
                          ),

                          _buildMenuItem(
                            icon: Icons.info_outline,
                            iconColor: const Color(0xFF06B6D4),
                            title: 'About Us',
                            onTap: () {
                              _launchURL(
                                'https://backupticket-f3cc6.web.app/about',
                              );
                            },
                          ),

                          _buildMenuItem(
                            icon: Icons.delete,
                            iconColor: const Color(0xFFF59E0B),
                            title: 'Delete Account',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeleteAccountScreen(),
                                ),
                              );
                            },
                          ),

                          // _buildMenuItem(
                          //   icon: Icons.description,
                          //   iconColor: const Color.fromARGB(255, 241, 11, 245),
                          //   title: 'Terms & Conditions',
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) =>TermsConditions(),
                          //       ),
                          //     );
                          //   },
                          // ),
                          _buildMenuItem(
                            icon: Icons.card_giftcard,
                            iconColor: const Color(0xFFF59E0B),
                            title: 'Refer & Earn',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReferEarnScreen(),
                                ),
                              );
                            },
                          ),
                          _buildMenuItem(
                            icon: Icons.help_outline,
                            iconColor: const Color(0xFF4A90E2),
                            title: 'Help',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HelpScreen(),
                                ),
                              );
                            },
                          ),

                          isGuest
                              ? _buildMenuItem(
                                  icon: Icons.login,
                                  iconColor: const Color(0xFF4A90E2),
                                  title: 'Login',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                  showDivider: false,
                                )
                              : _buildMenuItem(
                                  icon: Icons.logout_outlined,
                                  iconColor: const Color(0xFF8B5CF6),
                                  title: 'Logout',
                                  onTap: () {
                                    _logout(context);
                                  },
                                  showDivider: false,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, thickness: 0.5, color: Color(0xFFE5E5E5)),
      ],
    );
  }
}
