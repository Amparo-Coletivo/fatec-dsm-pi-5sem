import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme_notifier.dart';
import 'home_page.dart';
import 'donation_page.dart';
import 'neo_home.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Lista de páginas
  final List<Widget> _pages = const [
    HomePage(),
    DonationPage(),
    NeoHomePage(),
  ];

  // Títulos das páginas
  final List<String> _titles = ['Início', 'Doações', 'Buscar'];

  // Ao tocar em uma aba
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Troca de tema (Claro, Escuro, Sistema)
  void _changeTheme(String value) {
    final themeNotifier = context.read<ThemeNotifier>();
    switch (value) {
      case 'Claro':
        themeNotifier.setTheme(ThemeMode.light);
        break;
      case 'Escuro':
        themeNotifier.setTheme(ThemeMode.dark);
        break;
      case 'Sistema':
        themeNotifier.setTheme(ThemeMode.system);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: [
          PopupMenuButton<String>(
            onSelected: _changeTheme,
            icon: const Icon(Icons.brightness_6),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'Claro', child: Text('Tema Claro')),
              PopupMenuItem(value: 'Escuro', child: Text('Tema Escuro')),
              PopupMenuItem(value: 'Sistema', child: Text('Seguir Sistema')),
            ],
          ),
        ],
      ),
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
