import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DonationPage extends StatefulWidget {
  final Map<String, dynamic> ongData;

  const DonationPage({super.key, required this.ongData});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final _amountController = TextEditingController();
  bool _isLoading = false;

  void _confirmDonation() async {
    final amountText = _amountController.text.trim().replaceAll(',', '.');
    final double? amount = double.tryParse(amountText);

    if (amount == null || amount <= 0) {
      _showSnackbar('Insira um valor válido para a doação.', isError: true);
      return;
    }

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      _showSnackbar('Você precisa estar logado para doar.', isError: true);
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
        'valor': amount,
        'status': 'pendente',
        'data': DateTime.now().toIso8601String(),
      });

      _showSnackbar('Doação registrada com sucesso!');
      _amountController.clear();
    } catch (e) {
      _showSnackbar('Erro ao registrar doação.', isError: true);
      debugPrint('Erro ao inserir doação: $e');
    } finally {
      setState(() => _isLoading = false);
    }
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
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quanto você deseja doar?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor em R\$',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _confirmDonation,
                icon: const Icon(Icons.volunteer_activism),
                label: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Confirmar Doação'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
