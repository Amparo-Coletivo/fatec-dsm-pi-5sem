import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amparo_coletivo/pages/main_navigation.dart';
import 'config/theme_config.dart';
import 'config/theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amparo Coletivo',
      home: const MainNavigation(),
      theme: AppTheme.themeData,
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.themeMode,
    );
  }
}
