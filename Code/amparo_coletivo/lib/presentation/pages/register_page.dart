import 'package:flutter/material.dart';
import 'package:amparo_coletivo/config/theme_config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _selectedGender;

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 56.0,
            color: Colors.blue,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: AppTheme.themeData.primaryColor),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                Text(
                  'Registre-se',
                  style: TextStyle(
                    color: AppTheme.themeData.primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nome:'),
                  const SizedBox(height: 6),
                  TextFormField(
                      decoration: _inputDecoration('Digite seu nome')),
                  const SizedBox(height: 12),
                  const Text('Sobrenome:'),
                  const SizedBox(height: 6),
                  TextFormField(
                      decoration: _inputDecoration('Digite seu sobrenome')),
                  const SizedBox(height: 12),
                  const Text('E-mail:'),
                  const SizedBox(height: 6),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration('example@gmail.com'),
                  ),
                  const SizedBox(height: 12),
                  const Text('Senha:'),
                  const SizedBox(height: 6),
                  TextFormField(
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
                      onPressed: () {
                        // lógica de cadastro
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE6C649),
                        minimumSize: const Size(200, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: const Text(
                        'Inscreva-se',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Footer
          Container(
            height: 56.0,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon:
                      Icon(Icons.home, color: AppTheme.themeData.primaryColor),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.favorite,
                      color: AppTheme.themeData.primaryColor),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.person,
                      color: AppTheme.themeData.primaryColor),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
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
