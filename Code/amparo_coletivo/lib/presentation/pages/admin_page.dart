import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _titleController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _highlighted = false;
  bool _isLoading = false;

  final supabase = Supabase.instance.client;

  Future<void> _submitOng() async {
    final title = _titleController.text.trim();
    final imageUrl = _imageUrlController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || imageUrl.isEmpty || description.isEmpty) {
      _showSnackbar('Preencha todos os campos', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await supabase.from('ongs').insert({
        'title': title,
        'image_url': imageUrl,
        'description': description,
        'highlighted': _highlighted,
        'created_at': DateTime.now().toIso8601String(),
      });

      setState(() => _isLoading = false);
      _showSnackbar('ONG cadastrada com sucesso!');
      _clearForm();
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackbar('Erro inesperado: $e', isError: true);
    }
  }

  void _clearForm() {
    _titleController.clear();
    _imageUrlController.clear();
    _descriptionController.clear();
    setState(() => _highlighted = false);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administração de ONGs"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Nome da ONG'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'URL da Imagem'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text("Destaque"),
                Switch(
                  value: _highlighted,
                  onChanged: (value) {
                    setState(() => _highlighted = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _submitOng,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              icon: const Icon(Icons.add),
              label: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : const Text("Cadastrar ONG"),
            ),
          ],
        ),
      ),
    );
  }
}
