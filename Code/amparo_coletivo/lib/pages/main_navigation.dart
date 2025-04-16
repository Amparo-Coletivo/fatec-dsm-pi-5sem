import 'package:flutter/material.dart';
import 'home_page.dart';
import 'donation_page.dart';
import 'search_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [HomePage(), DonationPage(), SearchPage()];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue.shade200,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 5,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
            activeIcon: Icon(
              Icons.home,
              size: 30,
              semanticLabel: 'Home', // Acessibilidade
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: '',
            activeIcon: Icon(
              Icons.volunteer_activism,
              size: 30,
              semanticLabel: 'Doar', // Acessibilidade
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
            activeIcon: Icon(
              Icons.search,
              size: 30,
              semanticLabel: 'Buscar', // Acessibilidade
            ),
          ),
        ],
      ),
    );
  }
}
