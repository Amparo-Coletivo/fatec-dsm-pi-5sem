import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const CustomDrawer({Key? key, required this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.grey[900] : Colors.lightBlue;
    final headerColor = isDark ? Colors.grey[850] : Colors.blue[700];
    final textColor = Colors.white;

    return Drawer(
      child: Container(
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: headerColor,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mural das ONG's",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Olá, registre-se para continuar',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: textColor, height: 1),
            buildDrawerItem(Icons.home_outlined, 'Home', () {}, textColor, showDivider: true),
            buildDrawerItem(Icons.login, 'Login', () {}, textColor, showDivider: true),
            buildDrawerItem(Icons.app_registration, 'Registro', () {}, textColor, showDivider: true),
            buildDrawerItem(Icons.support_agent_outlined, 'Suporte', () {}, textColor, showDivider: false),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem(
    IconData icon,
    String title,
    VoidCallback onTap,
    Color textColor, {
    bool showDivider = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: textColor),
          title: Text(title, style: TextStyle(color: textColor)),
          onTap: onTap,
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: textColor),
          ),
      ],
    );
  }
}
