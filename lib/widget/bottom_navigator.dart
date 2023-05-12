import 'package:flutter/material.dart';
import 'package:news_app_proyek/screen/home_screen.dart';
import 'package:news_app_proyek/screen/likednews_screen.dart';
import 'package:news_app_proyek/screen/profile_screen.dart';
import 'package:news_app_proyek/screen/savednews_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;

  List<Widget> screenOptions = [
    const HomeScreen(),
    const SavedNewsScreen(),
    const LikedNewsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: screenOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Like',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(size: 20),
        selectedIconTheme: const IconThemeData(size: 32),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            if (index == selectedIndex) {
              if (HomeScreen.scrollController.hasClients) {
                HomeScreen.scrollController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            }
          });
        },
        elevation: 20,
      ),
    );
  }
}
