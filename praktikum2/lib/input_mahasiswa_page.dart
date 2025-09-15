import 'package:flutter/material.dart';

class InputMahasiswaPage extends StatefulWidget {
  @override
  _InputMahasiswaPageState createState() => _InputMahasiswaPageState();
}

class _InputMahasiswaPageState extends State<InputMahasiswaPage> {
  final namaController = TextEditingController();
  final umurController = TextEditingController();
  final alamatController = TextEditingController();
  final kontakController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input Mahasiswa")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: umurController,
              decoration: InputDecoration(labelText: "Umur"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: alamatController,
              decoration: InputDecoration(labelText: "Alamat"),
            ),
            TextField(
              controller: kontakController,
              decoration: InputDecoration(labelText: "Kontak (No HP)"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (namaController.text.isEmpty ||
                    umurController.text.isEmpty ||
                    alamatController.text.isEmpty ||
                    kontakController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Semua field harus diisi!")),
                  );
                } else {
                  final mahasiswa = {
                    "nama": namaController.text,
                    "umur": umurController.text,
                    "alamat": alamatController.text,
                    "kontak": kontakController.text,
                  };
                  Navigator.pop(context, mahasiswa);
                }
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
