import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:amparo_coletivo/shared/widgets/custom_drawer.dart';
import 'package:amparo_coletivo/config/theme_config.dart';

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
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }

  void _handleLogout() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout efetuado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mural das Ongs"),
        backgroundColor: Colors.lightBlue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: CustomDrawer(onLogout: _handleLogout),
      body: Skeletonizer(
        enabled: _loading,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "Destaques sazonais:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _seasonalCarousel(),
            const SizedBox(height: 24),
            const Text(
              "Veja mais:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _featuredONGCard(
              imagePath: 'assets/images/ong1.png',
              title: "Sempre ao seu lado",
              description:
                  "A ONG Sempre ao seu lado cuida de animais abandonados, oferece tratamentos veterinários e promove adoções conscientes. Está presente em várias cidades com voluntários dedicados.",
            ),
          ],
        ),
      ),
    );
  }

  /// Carrossel de ONGs sazonais
  Widget _seasonalCarousel() {
    final List<Map<String, String>> seasonalONGs = [
      {
        'image': 'assets/images/ong1.png',
        'title': 'ONG Agasalho',
        'desc': 'Campanha do Agasalho: doe roupas e cobertores.'
      },
      {
        'image': 'assets/images/natal_solidario.jpg',
        'title': 'Natal Solidário',
        'desc': 'Distribuição de cestas básicas e brinquedos.'
      },
      {
        'image': 'assets/images/aulas.png',
        'title': 'Volta às Aulas',
        'desc': 'Arrecadação de mochilas e material escolar.'
      },
    ];

    return SizedBox(
      height: 220, // Altura suficiente para imagem e texto
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: seasonalONGs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final ong = seasonalONGs[index];
          return Container(
            width: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black12,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      ong['image']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ong['title']!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.themeData.primaryColor),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ong['desc']!,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Card de ONG em "Veja mais", com altura dinâmica do texto
  Widget _featuredONGCard({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
