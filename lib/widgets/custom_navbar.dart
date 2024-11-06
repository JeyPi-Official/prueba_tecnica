import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: GNav(
        // Navbar personalizada
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
        gap: 8,
        backgroundColor: Colors.black,
        tabBackgroundGradient: const LinearGradient(
          colors: [Colors.pinkAccent, Colors.purple],
        ),
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.white24,
        tabs: const [
          GButton(
            icon: Icons.calculate_outlined,
            text: 'Propinas',
          ),
          GButton(
            icon: Icons.list_alt_outlined,
            text: 'Tareas',
          ),
          GButton(
            icon: Icons.image_outlined,
            text: 'API',
          ),
        ],
      ),
    );
  }
}
