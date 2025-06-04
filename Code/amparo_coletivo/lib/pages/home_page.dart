import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:amparo_coletivo/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true; // Controla se os dados ainda estão carregando

  @override
  void initState() {
    super.initState();
    _loadData(); // Simula o carregamento de dados
  }

  // Simula uma requisição de dados com atraso
  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _loading = false;
    });
  }

  // Função chamada ao realizar logout
  void _handleLogout() {
    Navigator.of(context).pop(); // Fecha o drawer
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout efetuado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mural das ONG's"),
        backgroundColor: Colors.lightBlue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(), // Abre o drawer
          ),
        ),
      ),
      drawer: CustomDrawer(
          onLogout: _handleLogout), // Drawer personalizado com logout
      body: Skeletonizer(
        enabled: _loading, // Ativa os skeletons durante o carregamento
        enableSwitchAnimation: true,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _seasonalHighlights(), // Seção de campanhas sazonais
            const SizedBox(height: 16),
            _featuredONGCard(), // Card de destaque de uma ONG
            const SizedBox(height: 24),
            // Carrossel de ONGs com imagens
            ongCarousel("ONGs aleatórias", [
              ongItem(imagePath: 'assets/images/ong1.png'),
              ongItem(imagePath: 'assets/images/ong2.png'),
              ongItem(imagePath: 'assets/images/ong3.png'),
            ]),
            const SizedBox(
                height: 80), // Espaço final para não encostar no bottom nav
          ],
        ),
      ),
    );
  }

  /// Seção de Destaques Sazonais
  Widget _seasonalHighlights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Destaques Sazonais",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text("🧣 Campanha do Agasalho - Doe roupas de inverno!"),
        Text("🍲 Natal Solidário - Ajude com cestas básicas."),
        Text("📚 Volta às Aulas - Doe materiais escolares."),
      ],
    );
  }

  /// Card da ONG em Destaque
  Widget _featuredONGCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem no topo do card com borda arredondada
          Expanded(
            child: Image.asset(
              'assets/images/ong1.png',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Informações da ONG
          Expanded(
            flex: 2,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ONG Esperança Viva",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "A ONG Esperança Viva atua há mais de 10 anos acolhendo famílias em situação de vulnerabilidade com ações sociais, alimentos e educação básica.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Carrossel horizontal com lista de ONGs
  Widget ongCarousel(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => items[index],
            ),
          ),
        ],
      ),
    );
  }

  /// Card individual com imagem para o carrossel de ONGs
  Widget ongItem({String? imagePath}) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
        image: imagePath != null
            ? DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }
}
