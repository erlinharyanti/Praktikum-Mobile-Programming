import 'package:flutter/material.dart';
import 'login.dart'; // Halaman LoginPage
import '../session_manager.dart'; // Pastikan mengimpor SessionManager

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Tidak logout
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(true), // Konfirmasi logout
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await SessionManager.clearSession(); // Menghapus data sesi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ), // Navigasi ke LoginPage
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Ikon logout
            onPressed: () => _confirmLogout(context), // Konfirmasi logout
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Halo Apa Kabar!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'images/Png.jpg', // Path gambar
              width: 200, // Lebar gambar
              height: 200, // Tinggi gambar
              fit: BoxFit.cover, // Menyesuaikan gambar
            ),
          ],
        ),
      ),
    );
  }
}
