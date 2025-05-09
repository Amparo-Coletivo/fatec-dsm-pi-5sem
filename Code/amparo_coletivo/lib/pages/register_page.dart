import 'package:flutter/material.dart';


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
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Expanded(
                  child: Text(
                    'Registre-se',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
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
                                color: _selectedGender == 'male' 
                                    ? Colors.blue 
                                    : Colors.grey,
                                width: _selectedGender == 'male' ? 2.0 : 1.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Image.asset(
                              'assets/images/male_icon.png',
                              height: 40.0,
                              width: 40.0,
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
                                color: _selectedGender == 'female' 
                                    ? Colors.blue 
                                    : Colors.grey,
                                width: _selectedGender == 'female' ? 2.0 : 1.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Image.asset(
                              'assets/images/female_icon.png',
                              height: 40.0,
                              width: 40.0,
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
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    // Navigate to home
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    // Navigate to favorites
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.white),
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
