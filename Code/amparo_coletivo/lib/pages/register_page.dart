import 'package:flutter/material.dart';
import 'package:amparo_coletivo/config/theme_config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _selectedGender;

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
                  icon: Icon(Icons.arrow_back, color: AppTheme.themeData.primaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Text(
                    'Registre-se',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.themeData.primaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 48.0), // Balance the back button
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
                  const SizedBox(height: 4.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12.0),
                  const Text('Sobrenome:'),
                  const SizedBox(height: 4.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12.0),
                  const Text('E-mail:'),
                  const SizedBox(height: 4.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12.0),
                  const Text('Senha:'),
                  const SizedBox(height: 4.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16.0),
                  const Text('Gênero:'),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGender = 'male';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    _selectedGender == 'male'
                                        ? Colors.blue
                                        : Colors.grey,
                                width: _selectedGender == 'male' ? 2.0 : 1.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Icon(
                              Icons.male_outlined,
                              color: AppTheme.themeData.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGender = 'female';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    _selectedGender == 'female'
                                        ? Colors.blue
                                        : Colors.grey,
                                width: _selectedGender == 'female' ? 2.0 : 1.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Icon(
                              Icons.female_outlined,
                              color: AppTheme.themeData.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Registration logic
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
                  icon: Icon(Icons.home, color: AppTheme.themeData.primaryColor),
                  onPressed: () {
                    // Navigate to home
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: AppTheme.themeData.primaryColor),
                  onPressed: () {
                    // Navigate to favorites
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person, color: AppTheme.themeData.primaryColor),
                  onPressed: () {
                    // Navigate to profile
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
