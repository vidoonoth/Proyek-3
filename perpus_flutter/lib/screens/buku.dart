import 'package:flutter/material.dart';
import 'package:perpus_flutter/components/bottom_nav_screen.dart';
import 'package:perpus_flutter/components/book_card.dart';
import 'package:perpus_flutter/components/app_bar.dart';

class BukuScreen extends StatelessWidget {
  const BukuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Tambahkan padding agar lebih rapi
        child: Wrap(
          spacing: 0, // Jarak horizontal antar kartu
          runSpacing: 12, // Jarak vertikal antar kartu
          alignment: WrapAlignment.spaceAround,
          // Rata tengah dengan jarak merata
          children: [
            BookCard(
              title: 'Bintang',
              image: 'assets/book_images/bintang.jpeg',
            ),
            BookCard(title: 'Hujan', image: 'assets/book_images/hujan.jpeg'),
            BookCard(
              title: 'Laut Bercerita',
              image: 'assets/book_images/laut_bercerita.jpg',
            ),
            BookCard(
              title: 'Laskar Pelangi',
              image: 'assets/book_images/laskar_pelangi.jpg',
            ),
            BookCard(
              title: 'Filosofi Kopi',
              image: 'assets/book_images/filosofi_kopi.jpg',
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavComponent(
        selectedIndex: 1, // Pastikan ini sesuai dengan indeks halaman Dashboard
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/buku');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/usulan');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/informasi');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/profil');
          }
        },
      ),
    );
  }
}
