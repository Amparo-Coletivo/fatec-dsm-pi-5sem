import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:amparo_coletivo/shared/widgets/custom_drawer.dart';
import 'package:amparo_coletivo/presentation/pages/donation.dart';

class OngsPage extends StatelessWidget {
  final Map<String, dynamic> ongData;

  const OngsPage({super.key, required this.ongData});

  @override
  Widget build(BuildContext context) {
    final String title = ongData['title'] ?? 'ONG sem nome';
    final String description = ongData['sobre_ong'] ?? 'Sem descrição';
    final String imagePath = ongData['image_url'] ?? 'assets/imagem_padrao.jpg';

    final List<String> imagensCarrossel = [
      ongData['foto_relevante1'] ?? 'assets/imagem1.jpg',
      ongData['foto_relevante2'] ?? 'assets/imagem2.jpg',
      ongData['foto_relevante3'] ?? 'assets/imagem3.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfólio'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo da ONG
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ClipOval(
                      child: imagePath.startsWith("http")
                          ? Image.network(
                              imagePath,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              imagePath,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Carrossel
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    "Fotos relevantes:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(
                  height: 130.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                ),
                items: imagensCarrossel.map((item) {
                  final bool isNetwork = item.startsWith("http");
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[100],
                      image: DecorationImage(
                        image: isNetwork
                            ? NetworkImage(item)
                            : const AssetImage('assets/imagem_padrao.jpg')
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Descrição
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    "Informações adicionais:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                ),
                child: Text(
                  description.isNotEmpty ? description : "Sobre......",
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 30),

              // Botão Doar
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonationPage(ongData: ongData),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Doar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
