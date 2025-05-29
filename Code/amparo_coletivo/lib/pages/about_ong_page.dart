import 'package:flutter/material.dart';

class AboutOngPage extends StatelessWidget {
  const AboutOngPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController carouselController = PageController(viewportFraction: 0.85);

    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Olá, registre-se para continuar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              _drawerItem(icon: Icons.home_outlined, text: 'Home', onTap: () {}),
              _drawerDivider(),
              _drawerItem(icon: Icons.login, text: 'Login', onTap: () {}),
              _drawerDivider(),
              _drawerItem(icon: Icons.badge_outlined, text: 'Registro', onTap: () {}),
              _drawerDivider(),
              _drawerItem(icon: Icons.live_help_outlined, text: 'Suporte', onTap: () {}),
              _drawerDivider(),
            ],
          ),
        ),
      ),
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
          // Lógica de doação
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
          // Navegação
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Banner com logo
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/logo_ong.png',
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

            // Texto sobre a ONG
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
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

            // Carrossel com bordas arredondadas
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
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 80), // Espaço para o botão flutuante
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(text, style: const TextStyle(color: Colors.black)),
      onTap: onTap,
    );
  }

  Widget _drawerDivider() {
    return const Divider(color: Colors.white, thickness: 1, height: 0);
  }
}
