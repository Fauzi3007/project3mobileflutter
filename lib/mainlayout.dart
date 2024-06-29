import 'package:flutter/material.dart';
import 'package:sipegpdam/views/absensi/absensi_page.dart';
import 'package:sipegpdam/views/home_page.dart';
import 'package:sipegpdam/views/profil/profile_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomePage(),
    const AbsensiPage(),
    const ProfilePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Absensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Data Diri',
          ),
        ],
      ),
    );
  }
}
