import 'package:flutter/material.dart';
import 'package:amparo_coletivo/shared/widgets/custom_drawer.dart'; // ajuste o caminho se necessário

class AboutOngPage extends StatelessWidget {
  const AboutOngPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController carouselController =
        PageController(viewportFraction: 0.85);

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Sobre a ONG'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/pagamentos'); // <- AQUI FOI A MUDANÇA
        },
        label: const Text('Doar'),
        icon: const Icon(Icons.volunteer_activism),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/perfil');
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/exemplo_ong.png',
                width: MediaQuery.of(context).size.width * 0.9,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  alignment: Alignment.center,
                  child: const Text("Logo não encontrada"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    "Sobre a ONG",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "A Associação Sempre a Seu Lado atua no resgate e acolhimento de animais em situação de vulnerabilidade, promovendo o bem-estar e adoção responsável.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: carouselController,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.blue.shade400,
                        child: Center(
                          child: Text(
                            'Destaque ${index + 1}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
