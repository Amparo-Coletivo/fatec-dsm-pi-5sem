import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:amparo_coletivo/presentation/pages/main_navigation.dart';
import 'config/theme_config.dart';
import 'config/theme_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

import 'package:amparo_coletivo/presentation/pages/auth/register_page.dart';
import 'package:amparo_coletivo/presentation/pages/auth/login_page.dart';
import 'package:amparo_coletivo/presentation/pages/about_ong_page.dart';
import 'package:amparo_coletivo/presentation/pages/change_password.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://atmvktiqiscdbfogvplw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0bXZrdGlxaXNjZGJmb2d2cGx3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk1MjA0OTcsImV4cCI6MjA2NTA5NjQ5N30.l0IxG1LXF_NJ-EfsT0aYxDNeRhEvmhCZS2jqcs1cU-Q',
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
        '/about': (context) => const AboutOngPage(),
        '/trocar_senha': (context) => const ChangePasswordPage(),
      },
    );
  }
}
