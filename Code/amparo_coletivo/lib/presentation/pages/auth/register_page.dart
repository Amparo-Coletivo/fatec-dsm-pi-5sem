import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:amparo_coletivo/presentation/pages/main_navigation.dart';

var logger = Logger();

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _selectedGender;
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _loading = false;

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> _signUp() async {
    final nome = _nomeController.text.trim();
    final sobrenome = _sobrenomeController.text.trim();
    final email = _emailController.text.trim();
    final senha = _senhaController.text.trim();

    if (email.isEmpty ||
        senha.isEmpty ||
        nome.isEmpty ||
        sobrenome.isEmpty ||
        _selectedGender == null) {
      _showError('Preencha todos os campos.');
      return;
    }

    setState(() => _loading = true);

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: senha,
      );

      final user = response.user;

      if (user == null) {
        _showError('Erro no cadastro: usuário não criado.');
        return;
      }

      await Supabase.instance.client.from('usuarios').insert({
        'id': user.id,
        'first_name': nome,
        'last_name': sobrenome,
        'gender': _selectedGender,
        'email': email,
      });

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
    } catch (e) {
      logger.e('Erro no cadastro: $e');
      _showError('Erro ao registrar. Verifique os dados ou tente novamente.');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registre-se'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nome:'),
            const SizedBox(height: 6),
            TextFormField(
                controller: _nomeController,
                decoration: _inputDecoration('Digite seu nome')),
            const SizedBox(height: 12),
            const Text('Sobrenome:'),
            const SizedBox(height: 6),
            TextFormField(
                controller: _sobrenomeController,
                decoration: _inputDecoration('Digite seu sobrenome')),
            const SizedBox(height: 12),
            const Text('E-mail:'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration('example@gmail.com'),
            ),
            const SizedBox(height: 12),
            const Text('Senha:'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _senhaController,
              obscureText: true,
              decoration: _inputDecoration('Digite sua senha'),
            ),
            const SizedBox(height: 16),
            const Text('Gênero:'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _genderOption('male', Icons.male, 'Masculino'),
                const SizedBox(width: 16),
                _genderOption('female', Icons.female, 'Feminino'),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _loading ? null : _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE6C649),
                  minimumSize: const Size(200, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0)),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'Inscreva-se',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderOption(String gender, IconData icon, String label) {
    final isSelected = _selectedGender == gender;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = gender;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade50 : Colors.grey[200],
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey,
              width: isSelected ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Icon(icon, size: 32, color: Colors.blue),
              const SizedBox(height: 4),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
