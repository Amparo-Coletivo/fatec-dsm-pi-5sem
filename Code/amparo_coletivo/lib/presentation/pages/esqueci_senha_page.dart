import 'package:flutter/material.dart';


class EsqueciSenhaPage extends StatefulWidget {
  const EsqueciSenhaPage({super.key});

  @override
  State<EsqueciSenhaPage> createState() => _EsqueciSenhaPageState();
}

class _EsqueciSenhaPageState extends State<EsqueciSenhaPage> {
  final TextEditingController _emailController = TextEditingController();

  void _enviarSolicitacao() {
    final email = _emailController.text.trim();
    if (email.isNotEmpty && email.contains('@')) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Solicitação enviada'),
          content: Text('Enviamos um link de redefinição para $email'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite um e-mail válido')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Esqueceu sua senha?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Digite seu e-mail e enviaremos um link para redefinir sua senha.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.email),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _enviarSolicitacao,
                icon: const Icon(Icons.send),
                label: const Text('Enviar link'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
