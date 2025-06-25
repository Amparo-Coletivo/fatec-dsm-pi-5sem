import 'package:amparo_coletivo/presentation/pages/perfil_page.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'categories.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;

  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _currentIndex;

  final List<Widget> _pages = const [
    HomePage(),
    Categories(),
    PerfilPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // USA o índice recebido
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
            activeIcon: Icon(Icons.home, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: '',
            activeIcon: Icon(Icons.volunteer_activism, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
            activeIcon: Icon(Icons.search, size: 30),
          ),
        ],
      ),
    );
  }
}
