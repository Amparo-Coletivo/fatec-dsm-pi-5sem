import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:amparo_coletivo/shared/widgets/custom_drawer.dart';
import 'package:amparo_coletivo/config/theme_notifier.dart';
import 'package:amparo_coletivo/presentation/info_ongs/ongs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  List<Map<String, dynamic>> allOngs = [];
  List<Map<String, dynamic>> destaques = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final client = Supabase.instance.client;

    final destaqueResponse = await client
        .from('ongs')
        .select(
            'id, title, description, sobre_ong, image_url, foto_relevante1, foto_relevante2, foto_relevante3, pix_copia_cola, category, created_at, highlighted')
        .eq('highlighted', true)
        .order('created_at');

    final todasResponse = await client
        .from('ongs')
        .select(
            'id, title, description, sobre_ong, image_url, foto_relevante1, foto_relevante2, foto_relevante3, pix_copia_cola, category, created_at, highlighted')
        .order('created_at');

    setState(() {
      destaques = List<Map<String, dynamic>>.from(destaqueResponse);
      allOngs = List<Map<String, dynamic>>.from(todasResponse);
      _loading = false;
    });
  }

  void _changeTheme(String value) {
    final themeNotifier = context.read<ThemeNotifier>();
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
        title: const Text("Mural das ONGs"),
        backgroundColor: Colors.lightBlue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _changeTheme,
            icon: const Icon(Icons.brightness_6),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'Claro', child: Text('Tema Claro')),
              PopupMenuItem(value: 'Escuro', child: Text('Tema Escuro')),
              PopupMenuItem(value: 'Sistema', child: Text('Seguir Sistema')),
            ],
          ),
        ],
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
              "Todas as ONGs:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...allOngs.map((ong) => _ongCard(ong)),
          ],
        ),
      ),
    );
  }

  Widget _seasonalCarousel() {
    if (destaques.isEmpty) {
      return const Text("Nenhuma ONG em destaque no momento.");
    }

    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: destaques.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final ong = destaques[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OngsPage(ongData: ong),
                ),
              );
            },
            child: Container(
              width: 220,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade400,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(blurRadius: 4, color: Colors.black12),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      child: ong['image_url'] != null
                          ? Image.network(
                              ong['image_url'],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/placeholder.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      ong['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _ongCard(Map<String, dynamic> ong) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ong['image_url'] != null && ong['image_url'].startsWith("http")
              ? Image.network(
                  ong['image_url'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/placeholder.jpg',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
        ),
        title: Text(
          ong['title'] ?? 'Sem nome',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          ong['description'] ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OngsPage(ongData: ong),
            ),
          );
        },
      ),
    );
  }
}
