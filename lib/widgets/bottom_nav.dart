import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: const Color(0xFF666666),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: const Color(0xFF666666),

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.grain),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_vert),
          label: 'More',
        ),
      ],
      currentIndex: 0, // Current selected tab
      onTap: (index) {
        // Handle navigation to different tabs
        // You can use Navigator.push or any other navigation method
      },
    );
  }
}
