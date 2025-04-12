import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String image;

  const BookCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 238, 241),
        borderRadius: BorderRadius.circular(12),
      ),
      width: 80,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            height: 120, // Tentukan tinggi agar tidak error
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
