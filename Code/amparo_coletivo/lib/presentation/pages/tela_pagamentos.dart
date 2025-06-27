import 'package:flutter/material.dart';

class TelaPagamentos extends StatelessWidget {
  const TelaPagamentos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
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
        title: const Text('Pagamento'),
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Ajude a ONG com uma doação',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/pix_banner.png',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Text("Banner não encontrado"),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Doe via PIX',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/qrcode_pix.png',
                    width: 180,
                    height: 180,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 180,
                      height: 180,
                      color: Colors.grey.shade200,
                      child: const Center(child: Text('QR Code não encontrado')),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Chave PIX: doacoes@associacao.org',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Obrigado!'),
                    content: const Text('Sua doação foi recebida com sucesso.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Fechar'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.volunteer_activism),
              label: const Text('Confirmar Doação'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
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
