import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:amparo_coletivo/presentation/info_ongs/ongs_page.dart';

class ListaOngsPorCategoriaPage extends StatefulWidget {
  final String category;

  const ListaOngsPorCategoriaPage({super.key, required this.category});

  @override
  State<ListaOngsPorCategoriaPage> createState() =>
      _ListaOngsPorCategoriaPageState();
}

class _ListaOngsPorCategoriaPageState extends State<ListaOngsPorCategoriaPage> {
  List<Map<String, dynamic>> ongs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    carregarOngs();
  }

  Future<void> carregarOngs() async {
    try {
      final response = await Supabase.instance.client
          .from('ongs')
          .select()
          .eq('category', widget.category);

      setState(() {
        ongs = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Erro ao carregar ONGs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ONGs de ${widget.category}')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ongs.isEmpty
              ? const Center(child: Text('Nenhuma ONG encontrada.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: ongs.length,
                  itemBuilder: (context, index) {
                    final ong = ongs[index];

                    return Card(
                      child: ListTile(
                        title: Text(ong['title'] ?? 'Sem nome'),
                        subtitle: Text(ong['description'] ?? 'Sem descrição'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OngsPage(ongData: ong),
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
