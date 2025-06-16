import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:amparo_coletivo/presentation/pages/change_password.dart'; // <- IMPORTANTE!

class CustomDrawer extends StatelessWidget {
  final Function? onLogout;

  const CustomDrawer({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Drawer(
      child: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Row(
                children: [
                  Icon(Icons.list, color: Colors.white),
                  SizedBox(width: 16.0),
                  Text(
                    'Mural das ONGs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                user != null ? 'Bem-vindo!' : 'Olá, registre-se para continuar',
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            const Divider(color: Colors.white24, height: 1),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
            ),
            const Divider(color: Colors.white24, height: 1),

            // Se estiver deslogado
            if (user == null) ...[
              ListTile(
                leading: const Icon(Icons.login, color: Colors.white),
                title:
                    const Text('Login', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login');
                },
              ),
              const Divider(color: Colors.white24, height: 1),
              ListTile(
                leading:
                    const Icon(Icons.app_registration, color: Colors.white),
                title: const Text('Registro',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/register');
                },
              ),
              const Divider(color: Colors.white24, height: 1),
            ],

            // Se estiver logado
            if (user != null) ...[
              ListTile(
                leading: const Icon(Icons.password, color: Colors.white),
                title: const Text('Trocar senha',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ChangePasswordPage()),
                  );
                },
              ),
              const Divider(color: Colors.white24, height: 1),
            ],

            ListTile(
              leading: const Icon(Icons.support_agent, color: Colors.white),
              title:
                  const Text('Suporte', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Adicione rota se tiver uma tela de suporte
              },
            ),

            // Se estiver logado, mostrar logout no final
            if (user != null && onLogout != null) ...[
              const Spacer(),
              const Divider(color: Colors.white24, height: 1),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title:
                    const Text('Sair', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  await Supabase.instance.client.auth.signOut();

                  if (context.mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login', (route) => false);
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
