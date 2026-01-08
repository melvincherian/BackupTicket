
// import 'package:backup_ticket/provider/navbar/navbar_provider.dart';
// import 'package:backup_ticket/views/Home/bus_screen.dart';
// import 'package:backup_ticket/views/Home/sell_screen.dart';
// import 'package:backup_ticket/views/Home/movie_screen.dart';
// import 'package:backup_ticket/views/Home/profile_screen.dart';
// import 'package:backup_ticket/views/Home/train_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class NavbarScreen extends StatelessWidget {
//   const NavbarScreen({super.key});

//   final List<Widget> _screens = const [
//     MovieScreen(),   
//     BusScreen(),    
//     SellScreen(),   
//     TrainScreen(),  
//     ProfileScreen(),
    
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BottomNavbarProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           body: _screens[provider.currentIndex],
//           bottomNavigationBar: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.15),
//                   spreadRadius: 0,
//                   blurRadius: 20,
//                   offset: const Offset(0, -5),
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 10,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // LEFT SIDE
//                     Row(
//                       children: [
//                         _buildNavItem(
//                           context,
//                           icon: Icons.movie_outlined,
//                           selectedIcon: Icons.movie,
//                           label: 'Movie',
//                           index: 0,
//                           isSelected: provider.currentIndex == 0,
//                         ),
//                         const SizedBox(width: 12),
//                         _buildNavItem(
//                           context,
//                           icon: Icons.directions_bus_outlined,
//                           selectedIcon: Icons.directions_bus,
//                           label: 'Bus',
//                           index: 1,
//                           isSelected: provider.currentIndex == 1,
//                         ),
//                       ],
//                     ),

//                     // CENTER ADD BUTTON
//                     _buildCenterNavItem(
//                       context,
//                       icon: Icons.add_rounded,
//                       index: 2,
//                       isSelected: provider.currentIndex == 2,
//                     ),

//                     // RIGHT SIDE
//                     Row(
//                       children: [
//                         _buildNavItem(
//                           context,
//                           icon: Icons.train_outlined,
//                           selectedIcon: Icons.train,
//                           label: 'Train',
//                           index: 3,
//                           isSelected: provider.currentIndex == 3,
//                         ),
//                         const SizedBox(width: 12),
//                         _buildNavItem(
//                           context,
//                           icon: Icons.person_outline,
//                           selectedIcon: Icons.person,
//                           label: 'Profile',
//                           index: 4,
//                           isSelected: provider.currentIndex == 4,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // SIDE NAV ITEM
//   Widget _buildNavItem(
//     BuildContext context, {
//     required IconData icon,
//     required IconData selectedIcon,
//     required String label,
//     required int index,
//     required bool isSelected,
//   }) {
//     final provider = Provider.of<BottomNavbarProvider>(context, listen: false);

//     return GestureDetector(
//       onTap: () => provider.setIndex(index),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: EdgeInsets.symmetric(
//           vertical: 8,
//           horizontal: isSelected ? 14 : 10,
//         ),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? const Color(0xFF4A90E2).withOpacity(0.12)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               isSelected ? selectedIcon : icon,
//               color: isSelected ? const Color(0xFF4A90E2) : Colors.grey[600],
//               size: 24,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 10,
//                 color: isSelected ? const Color(0xFF4A90E2) : Colors.grey[600],
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // CENTER BIG BUTTON
//   Widget _buildCenterNavItem(
//     BuildContext context, {
//     required IconData icon,
//     required int index,
//     required bool isSelected,
//   }) {
//     final provider = Provider.of<BottomNavbarProvider>(context, listen: false);

//     return GestureDetector(
//       onTap: () => provider.setIndex(index),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10),
//         width: 60,
//         height: 60,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF4A90E2).withOpacity(0.4),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 32),
//       ),
//     );
//   }
// }














// import 'package:backup_ticket/views/Home/bus_screen.dart';
// import 'package:backup_ticket/views/Home/sell_screen.dart';
// import 'package:backup_ticket/views/Home/movie_screen.dart';
// import 'package:backup_ticket/views/Home/profile_screen.dart';
// import 'package:backup_ticket/views/Home/train_screen.dart';
// import 'package:flutter/material.dart';

// class NavbarScreen extends StatefulWidget {
//   final int initialIndex;

//   const NavbarScreen({
//     super.key,
//     this.initialIndex = 0,
//   });

//   @override
//   State<NavbarScreen> createState() => _NavbarScreenState();
// }

// class _NavbarScreenState extends State<NavbarScreen> {
//   late int _currentIndex;

//   final List<Widget> _screens = const [
//     MovieScreen(),
//     // BusScreen(),
//     SellScreen(),
//     // TrainScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }

//   /// ================= BOTTOM BAR =================
//   Widget _buildBottomBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.15),
//             blurRadius: 20,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               /// LEFT
//               Row(
//                 children: [
//                   _buildNavItem(
//                     icon: Icons.movie_outlined,
//                     selectedIcon: Icons.movie,
//                     label: 'Movie',
//                     index: 0,
//                   ),
//                   // const SizedBox(width: 12),
//                   // _buildNavItem(
//                   //   icon: Icons.directions_bus_outlined,
//                   //   selectedIcon: Icons.directions_bus,
//                   //   label: 'Bus',
//                   //   index: 1,
//                   // ),
//                 ],
//               ),

//               /// CENTER BUTTON
//               _buildCenterNavItem(
//                 icon: Icons.add_rounded,
//                 index: 2,
//               ),

//               /// RIGHT
//               Row(
//                 children: [
//                   // _buildNavItem(
//                   //   icon: Icons.train_outlined,
//                   //   selectedIcon: Icons.train,
//                   //   label: 'Train',
//                   //   index: 3,
//                   // ),
//                   // const SizedBox(width: 12),
//                   _buildNavItem(
//                     icon: Icons.person_outline,
//                     selectedIcon: Icons.person,
//                     label: 'Profile',
//                     index: 4,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// ================= SIDE NAV ITEM =================
//   Widget _buildNavItem({
//     required IconData icon,
//     required IconData selectedIcon,
//     required String label,
//     required int index,
//   }) {
//     final bool isSelected = _currentIndex == index;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _currentIndex = index;
//         });
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: EdgeInsets.symmetric(
//           vertical: 8,
//           horizontal: isSelected ? 14 : 10,
//         ),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? const Color(0xFF4A90E2).withOpacity(0.12)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               isSelected ? selectedIcon : icon,
//               color: isSelected ? const Color(0xFF4A90E2) : Colors.grey[600],
//               size: 24,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 10,
//                 color:
//                     isSelected ? const Color(0xFF4A90E2) : Colors.grey[600],
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ================= CENTER BIG BUTTON =================
//   Widget _buildCenterNavItem({
//     required IconData icon,
//     required int index,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _currentIndex = index;
//         });
//       },
//       child: Container(
//         width: 60,
//         height: 60,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF4A90E2).withOpacity(0.4),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 32),
//       ),
//     );
//   }
// }




















import 'package:backup_ticket/views/Home/movie_screen.dart';
import 'package:backup_ticket/views/Home/profile_screen.dart';
import 'package:backup_ticket/views/Home/sell_screen.dart';
import 'package:flutter/material.dart';

class NavbarScreen extends StatefulWidget {
  final int initialIndex;

  const NavbarScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  late int _currentIndex;

  /// ✅ SCREENS (INDEXES MUST MATCH NAV ITEMS)
  final List<Widget> _screens = const [
    MovieScreen(),   // index 0
    SellScreen(),    // index 1 (CENTER)
    ProfileScreen(), // index 2
  ];

  @override
  void initState() {
    super.initState();

    /// ✅ SAFE INITIAL INDEX
    _currentIndex = widget.initialIndex.clamp(0, _screens.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  /// ================= BOTTOM BAR =================
  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// LEFT
              _buildNavItem(
                icon: Icons.movie_outlined,
                selectedIcon: Icons.movie,
                label: 'Movie',
                index: 0,
              ),

              /// CENTER (SELL)
              _buildCenterNavItem(
                icon: Icons.add_rounded,
                index: 1,
              ),

              /// RIGHT
              _buildNavItem(
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'Profile',
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= SIDE NAV ITEM =================
  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
  }) {
    final bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: isSelected ? 14 : 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4A90E2).withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? const Color(0xFF4A90E2) : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color:
                    isSelected ? const Color(0xFF4A90E2) : Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= CENTER BIG BUTTON =================
  Widget _buildCenterNavItem({
    required IconData icon,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A90E2).withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 32),
      ),
    );
  }
}
