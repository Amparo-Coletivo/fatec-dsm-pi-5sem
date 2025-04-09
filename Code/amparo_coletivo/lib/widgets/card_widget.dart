import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String description;

  const CardWidget({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      shadowColor: Colors.grey,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFF1E90FF), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E90FF),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
            ),
          ],
        ),
      ),
    );
  }
}
