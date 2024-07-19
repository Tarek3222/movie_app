import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomGoogleNav extends StatelessWidget {
  const CustomGoogleNav({super.key, required this.currentIndex, required this.onTap});
  final int currentIndex ;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return GNav(
        selectedIndex: currentIndex,
        onTabChange: onTap,
        // backgroundColor: Colors.white,
        gap: 7,
        padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        activeColor: Colors.red,
        rippleColor: Colors.yellow,
        tabActiveBorder: Border.all(color: Colors.black, width: 1),
        curve: Curves.easeOutExpo,
        iconSize: 26,
        duration:const Duration(milliseconds: 500),
        haptic: true,
        color: Colors.red[800],
        tabs:const [
          GButton(
            icon: Icons.home,
            text: 'Home',
            backgroundColor: Colors.white,
          ),
           GButton(
            icon: Icons.search,
            text: 'Search',
            backgroundColor: Colors.white,
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Favorites',
            backgroundColor: Colors.white,
          ),
        ]);
  }
}