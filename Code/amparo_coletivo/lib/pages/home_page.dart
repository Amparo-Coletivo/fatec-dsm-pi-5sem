import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 3)); // Simula carregamento
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mural das ONGs')),
      body: Skeletonizer(
        enabled: _loading,
        enableSwitchAnimation: true,
        child: ListView(
          children: const [
            CardWidget(
              title: 'ONG Esperança',
              description: 'Distribuímos alimentos para famílias carentes.',
            ),
            CardWidget(
              title: 'Amigos dos Animais',
              description: 'Resgatamos e cuidamos de animais abandonados.',
            ),
          ],
        ),
      ),
    );
  }
}
