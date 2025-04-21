import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme_notifier.dart';
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

  // Lista de páginas
  final List<Widget> _pages = const [HomePage(), DonationPage(), SearchPage()];

  // Títulos das páginas
  final List<String> _titles = ['Início', 'Doações', 'Buscar'];

  // Função chamada quando uma aba é selecionada
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Função para alterar o tema
  void _changeTheme(String value) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
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
            itemBuilder:
                (context) => const [
                  PopupMenuItem(value: 'Claro', child: Text('Tema Claro')),
                  PopupMenuItem(value: 'Escuro', child: Text('Tema Escuro')),
                  PopupMenuItem(
                    value: 'Sistema',
                    child: Text('Seguir Sistema'),
                  ),
                ],
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
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
            activeIcon: Icon(Icons.home, size: 30, semanticLabel: 'Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: '',
            activeIcon: Icon(
              Icons.volunteer_activism,
              size: 30,
              semanticLabel: 'Doar',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
            activeIcon: Icon(Icons.search, size: 30, semanticLabel: 'Buscar'),
          ),
        ],
      ),
    );
  }
}
