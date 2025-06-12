import 'package:flutter/material.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fazer uma Doação')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Função de doação ainda não implementada!'),
              ),
            );
          },
          child: const Text('Doar Agora'),
        ),
      ),
    );
  }
}
