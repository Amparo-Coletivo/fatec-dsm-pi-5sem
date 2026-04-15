import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:amparo_coletivo/shared/widgets/custom_drawer.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String? nomeCompleto;
  String? genero;
  String? bio;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
  }

  Future<void> _carregarDadosUsuario() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client
        .from('usuarios')
        .select('first_name, last_name, gender, bio')
        .eq('id', user.id)
        .single();

    if (!mounted) return;

    setState(() {
      nomeCompleto = "${response['first_name']} ${response['last_name']}";
      genero = response['gender'];
      bio = response['bio'];
      carregando = false;
    });
  }

  Future<void> _editarBio(BuildContext context) async {
    final TextEditingController bioController =
        TextEditingController(text: bio ?? "");
    int charCount = bioController.text.length;
    const int maxChars = 150;

    final resultado = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Editar descrição'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: bioController,
                    maxLength: maxChars,
                    maxLines: 4,
                    onChanged: (value) {
                      setState(() {
                        charCount = value.length;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Escreva algo sobre você...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$charCount/$maxChars',
                      style: TextStyle(
                        fontSize: 12,
                        color: charCount >= maxChars
                            ? Colors.red
                            : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, bioController.text),
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );

    if (resultado != null) {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await Supabase.instance.client
            .from('usuarios')
            .update({'bio': resultado}).eq('id', user.id);

        if (!mounted) return;

        setState(() {
          bio = resultado;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Descrição atualizada com sucesso')),
        );
      }
    }
  }

  void _handleLogout(BuildContext context) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout efetuado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Perfil"),
          backgroundColor: Colors.lightBlue,
        ),
        body: const Center(
          child: Text(
            "Faça login para acessar o perfil.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do Usuário"),
        backgroundColor: Colors.lightBlue,
      ),
      drawer: CustomDrawer(onLogout: () => _handleLogout(context)),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  nomeCompleto ?? 'Usuário',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  genero != null ? 'Gênero: $genero' : '',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 24),

                // Bio/Descrição do usuário
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bio != null && bio!.isNotEmpty
                            ? bio!
                            : "Digite algo sobre você!",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.edit, size: 18),
                          onPressed: () => _editarBio(context),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Total de doações (futuro)
                Column(
                  children: [
                    const Text("Total de doações"),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: const Text("0", style: TextStyle(fontSize: 20)),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
