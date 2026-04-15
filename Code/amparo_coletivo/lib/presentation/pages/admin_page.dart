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
  final _pixCodeController = TextEditingController();
  final _sobreOngController = TextEditingController();
  final _foto1Controller = TextEditingController();
  final _foto2Controller = TextEditingController();
  final _foto3Controller = TextEditingController();

  String? _categorySelecionada;
  bool _highlighted = false;
  bool _isLoading = false;

  final supabase = Supabase.instance.client;

  final List<String> _category = [
    'Saúde',
    'Educação',
    'Meio Ambiente',
    'Animais',
    'Moradia',
    'Outros',
  ];

  Future<void> _submitOng() async {
    final title = _titleController.text.trim();
    final imageUrl = _imageUrlController.text.trim();
    final description = _descriptionController.text.trim();
    final sobreOng = _sobreOngController.text.trim();
    final pixCode = _pixCodeController.text.trim();
    final foto1 = _foto1Controller.text.trim();
    final foto2 = _foto2Controller.text.trim();
    final foto3 = _foto3Controller.text.trim();

    if (title.isEmpty ||
        imageUrl.isEmpty ||
        description.isEmpty ||
        pixCode.isEmpty ||
        _categorySelecionada == null) {
      _showSnackbar(
          'Preencha todos os campos obrigatórios (inclusive categoria)',
          isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await supabase.from('ongs').insert({
        'title': title,
        'image_url': imageUrl,
        'description': description,
        'sobre_ong': sobreOng,
        'highlighted': _highlighted,
        'pix_copia_cola': pixCode,
        'category': _categorySelecionada,
        'foto_relevante1': foto1,
        'foto_relevante2': foto2,
        'foto_relevante3': foto3,
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
    _sobreOngController.clear();
    _pixCodeController.clear();
    _foto1Controller.clear();
    _foto2Controller.clear();
    _foto3Controller.clear();
    setState(() {
      _highlighted = false;
      _categorySelecionada = null;
    });
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
              decoration: const InputDecoration(labelText: 'Descrição curta'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _sobreOngController,
              decoration: const InputDecoration(
                  labelText: 'Descrição detalhada (Sobre a ONG)'),
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _pixCodeController,
              decoration:
                  const InputDecoration(labelText: 'Chave Pix (copia e cola)'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _foto1Controller,
              decoration:
                  const InputDecoration(labelText: 'URL da Foto Relevante 1'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _foto2Controller,
              decoration:
                  const InputDecoration(labelText: 'URL da Foto Relevante 2'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _foto3Controller,
              decoration:
                  const InputDecoration(labelText: 'URL da Foto Relevante 3'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Categoria'),
              value: _categorySelecionada,
              items: _category
                  .map((cat) => DropdownMenuItem<String>(
                        value: cat,
                        child: Text(cat),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _categorySelecionada = value);
              },
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
