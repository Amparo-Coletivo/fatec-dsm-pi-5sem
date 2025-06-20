import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DonationPage extends StatefulWidget {
  final Map<String, dynamic> ongData;

  const DonationPage({super.key, required this.ongData});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  bool _isLoading = false;

  final String pixCode =
      '00020126580014BR.GOV.BCB.PIX013635082858-8168-43eb-a553-8c7eb6cf8bd45204000053039865802BR5921Bruno Alves dos Anjos6009SAO PAULO62140510h8XXxMOu8G6304499E';

  // Caminho imagem do QR Code
  final String qrCodeImagePath = 'assets/images/qrpix.png';

  void _registerDonation() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      _showSnackbar('Você precisa estar logado para registrar a doação.',
          isError: true);
      return;
    }

    final ongId = widget.ongData['id'];
    if (ongId == null || ongId.toString().isEmpty) {
      _showSnackbar('ONG inválida (ID ausente ou vazio nos dados).',
          isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Supabase.instance.client.from('doacoes').insert({
        'user_id': user.id,
        'ong_id': ongId,
        'valor': null, // Valor não informado
        'status': 'pendente',
        'data': DateTime.now().toIso8601String(),
      });

      _showSnackbar('Doação registrada! Complete via PIX no seu banco.');
    } catch (e) {
      _showSnackbar('Erro ao registrar doação.', isError: true);
      debugPrint('Erro ao inserir doação: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _copyPixCode() {
    Clipboard.setData(ClipboardData(text: pixCode));
    _showSnackbar('Código PIX copiado para a área de transferência!');
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String ongName =
        widget.ongData['title'] ?? widget.ongData['nome'] ?? 'ONG';

    return Scaffold(
      appBar: AppBar(
        title: Text('Doar para $ongName'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Escaneie o QR Code abaixo ou copie o código Pix.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Mostrando a imagem do QR Code
              Center(
                child: Image.asset(
                  qrCodeImagePath,
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Código Pix (Copia e Cola):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SelectableText(
                  pixCode,
                  style: const TextStyle(fontSize: 14),
                ),
              ),

              const SizedBox(height: 8),

              ElevatedButton.icon(
                onPressed: _copyPixCode,
                icon: const Icon(Icons.copy),
                label: const Text('Copiar Código Pix'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _registerDonation,
                icon: const Icon(Icons.check_circle),
                label: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Registrar minha Doação'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
