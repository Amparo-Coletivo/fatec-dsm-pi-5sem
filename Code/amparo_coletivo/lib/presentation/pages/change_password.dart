import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:amparo_coletivo/shared/widgets/custom_drawer.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  bool _isLoading = false;

  void _changePassword() async {
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem')),
      );
      return;
    }

    if (newPassword.length < 6) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('A senha deve ter no mínimo 6 caracteres')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha alterada com sucesso!')),
      );

      _newPasswordController.clear();
      _confirmPasswordController.clear();

      // Volta para a tela anterior ou navega para a Home, se quiser
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao alterar senha: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trocar Senha"),
        backgroundColor: Colors.blue,
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Digite sua nova senha:"),
            ),
            TextField(
              controller: _newPasswordController,
              obscureText: _isObscure1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.purple[50],
                suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure1 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isObscure1 = !_isObscure1),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Confirme sua nova senha:"),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: _isObscure2,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.purple[50],
                suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure2 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isObscure2 = !_isObscure2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _changePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Alterar senha"),
            ),
          ],
        ),
      ),
    );
  }
}
