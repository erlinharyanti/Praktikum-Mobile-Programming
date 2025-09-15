import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nama Aplikasi: My Flutter App"),
            Text("Versi: 1.0.0"),
            Text("Pengembang: Erlin"),
          ],
        ),
      ),
    );
  }
}
