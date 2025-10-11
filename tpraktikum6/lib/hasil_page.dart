import 'package:flutter/material.dart';

class HasilPage extends StatelessWidget {
  const HasilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Formulir')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // rata kiri
          children: [
            Text('Nama: ${data['nama']}'),
            Text('NPM: ${data['npm']}'),
            Text('Email: ${data['email']}'),
            Text('Alamat: ${data['alamat']}'),
            Text('Nomor HP: ${data['noHp']}'),
            Text('Jenis Kelamin: ${data['jenisKelamin']}'),
            Text('Tanggal Lahir: ${data['tglLahir']}'),
            Text('Jam Bimbingan: ${data['jamBimbingan']}'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Form'),
            ),
          ],
        ),
      ),
    );
  }
}
