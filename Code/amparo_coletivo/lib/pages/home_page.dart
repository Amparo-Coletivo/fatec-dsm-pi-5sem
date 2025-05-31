import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:amparo_coletivo/shared/widgets/custom_drawer.dart';

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
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _loading = false;
    });
  }

  void _handleLogout() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Logout efetuado')));
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: _loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mural das ONG's"),
          backgroundColor: Colors.lightBlue,
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
          ),
        ),
        drawer: CustomDrawer(onLogout: _handleLogout),
        body: ListView(
          children: [
            ongCarousel("ONG's para arrecadação de roupas:", [
              ongItem(imagePath: 'assets/images/ong1.png'),
              ongItem(),
              ongItem(),
            ]),
            ongCarousel("ONG's para alimentos não perecíveis:", [
              ongItem(),
              ongItem(),
              ongItem(),
            ]),
            ongCarousel("ONG's favoritas:", [ongItem(), ongItem(), ongItem()]),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget ongItem({String? imagePath}) {
    return Skeleton.leaf(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
          image:
              imagePath != null
                  ? DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  )
                  : null,
        ),
      ),
    );
  }

  Widget ongCarousel(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton.keep(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  Skeleton.ignore(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: items,
                    ),
                  ),
                  Skeleton.ignore(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    ),
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
