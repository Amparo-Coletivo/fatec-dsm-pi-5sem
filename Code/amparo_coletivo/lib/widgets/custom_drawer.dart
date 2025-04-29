import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const CustomDrawer({Key? key, required this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.lightBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue[700],
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mural das ONG's",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Olá, USER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white, height: 1),
            buildDrawerItem(Icons.home_outlined, 'Home', () {}, showDivider: true),
            buildDrawerItem(Icons.person_outline, 'Minha conta', () {}, showDivider: true),
            buildDrawerItem(Icons.lock_outline, 'Trocar senha', () {}, showDivider: true),
            buildDrawerItem(Icons.history, 'Histórico de pagamentos', () {}, showDivider: true),
            buildDrawerItem(Icons.support_agent_outlined, 'Suporte', () {}, showDivider: true),
            buildDrawerItem(Icons.logout, 'Sair', onLogout, showDivider: false),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool showDivider = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(title, style: const TextStyle(color: Colors.white)),
          onTap: onTap,
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Colors.white),
          ),
      ],
    );
  }
}
