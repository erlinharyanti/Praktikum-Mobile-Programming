import 'package:flutter/material.dart';
import 'login.dart'; 
import '../session_manager.dart'; 

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
              onPressed: () => Navigator.of(context).pop(false), 
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(true), 
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await SessionManager.clearSession(); 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ), 
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
            icon: const Icon(Icons.logout),
            onPressed: () => _confirmLogout(context),
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
              'images/Png.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
