import 'package:flutter/material.dart';
import 'package:amparo_coletivo/presentation/pages/list_by_category.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  final List<String> categorias = const [
    'Saúde',
    'Educação',
    'Meio Ambiente',
    'Animais',
    'Moradia',
    'Outros',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias de ONGs'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final categoria = categorias[index];

          return Card(
            child: ListTile(
              title: Text(categoria),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ListaOngsPorCategoriaPage(category: categoria),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
