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

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://fxmmeqkovweeoybhoncf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ4bW1lcWtvdndlZW95YmhvbmNmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU2MjEwMjcsImV4cCI6MjA2MTE5NzAyN30.NTnJEqGrsHfmbiyz3Eq2DHdVfks_63mGv1f_LBNJBOs',
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

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amparo Coletivo',
        theme: AppTheme.themeData,
        darkTheme: ThemeData.dark(),
        themeMode: themeNotifier.themeMode,
        routes: {
          '/': (context) => const MainNavigation(), //tela principal
          '/login': (context) => const LoginPage(), //tela de login
          '/register': (context) => const RegisterPage(), //tela de cadastro
          '/about': (context) => const AboutOngPage(), //tela sobre as ONG's
        });
  }
}
