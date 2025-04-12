import 'package:flutter/material.dart';
import 'package:perpus_flutter/screens/pengusulan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:perpus_flutter/components/bottom_nav_screen.dart';
import 'package:perpus_flutter/components/info_card.dart';
import 'package:perpus_flutter/components/book_card.dart';
import 'package:perpus_flutter/components/app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) return;

    final response = await http.post(
      Uri.parse('http://192.168.1.39:8000/api/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      await prefs.remove('token');
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 239, 239, 239),
          appBar: CustomAppBar(),
          body: RefreshIndicator(
            onRefresh: () async => setState(() {}),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeText(),
                  InfoCard(
                    title: 'Selamat datang',
                    description:
                        'Di Perpustakaan Indramayu. Mari ajukan usulan buku!',
                    iconPath: 'assets/welcome.svg',
                  ),
                  InfoCard(
                    title: 'Pengusulan',
                    description:
                        'Saatnya mengusulkan buku agar koleksi perpustakaan semakin menarik!',
                    iconPath: 'assets/pengusulan_login.svg',
                    buttonText: "Lihat Usulan",
                    onButtonPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Pengusulan()),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  _buildSearchBar(),
                  SizedBox(height: 16),
                  _buildCategoryChips(),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BookCard(
                          title: 'Bintang',
                          image: 'assets/book_images/bintang.jpeg',
                        ),
                        BookCard(
                          title: 'Hujan',
                          image: 'assets/book_images/hujan.jpeg',
                        ),
                        BookCard(
                          title: 'Laut Bercerita',
                          image: 'assets/book_images/laut_bercerita.jpg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavComponent(
            selectedIndex:
                0, // Pastikan ini sesuai dengan indeks halaman Dashboard
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
      },
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, Alfin',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Ayo mulai mengusulkan buku.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari Usulan ...',
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = ['Fiksi', 'Novel', 'Drama', 'Non-Fiksi'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          categories
              .map(
                (category) => Chip(
                  label: Text(category),
                  backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: const Color.fromARGB(255, 236, 236, 236),
                      width: 2,
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}
