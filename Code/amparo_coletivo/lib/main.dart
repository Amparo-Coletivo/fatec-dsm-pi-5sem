// Arquivo principal do aplicativo Amparo Coletivo

import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:amparo_coletivo/presentation/pages/main_navigation.dart';
import 'config/theme_config.dart';
import 'config/theme_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

// Importando as páginas
import 'package:amparo_coletivo/presentation/pages/auth/register_page.dart';
import 'package:amparo_coletivo/presentation/pages/auth/login_page.dart';
import 'package:amparo_coletivo/presentation/pages/change_password.dart';
import 'package:amparo_coletivo/presentation/pages/admin_page.dart';
import 'package:amparo_coletivo/presentation/pages/auth/esqueci_senha_page.dart';
import 'package:amparo_coletivo/presentation/pages/about_ong_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://luooeidsfkypyctvytok.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx1b29laWRzZmt5cHljdHZ5dG9rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAyMDMzNjcsImV4cCI6MjA2NTc3OTM2N30.kM_S-oLmRTTuBkbpKW2MUn3Ngl7ic0ZaGb-sltYzB0E',
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = provider.Provider.of<ThemeNotifier>(context);

    // Pegando o usuário logado
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      logger.i('Auth UID: ${user.id}');
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amparo Coletivo',
      theme: AppTheme.themeData,
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.themeMode,
      routes: {
        '/': (context) => const MainNavigation(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/change_password': (context) => const ChangePasswordPage(),
        '/admin': (context) => const AdminPage(),
        '/forgot_password': (context) => const EsqueciSenhaPage(),
        '/about': (context) => const AboutOngPage(
              ongData: {
                'title': 'Amparo Coletivo',
                'description':
                    'O Amparo Coletivo é uma plataforma dedicada a conectar ONGs e pessoas que desejam ajudar. Nosso objetivo é facilitar o acesso a informações sobre ONGs, promovendo a transparência e a solidariedade.',
                'imageUrl':
                    // TODO: Substituir pela URL real da imagem da ONG
                    'https://picsum.photos/200/300',
                'contactEmail': 'AmparoColetivo.suporte@gmail.com'
              },
            ),
      },
    );
  }
}
