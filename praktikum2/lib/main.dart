import 'package:flutter/material.dart';
import 'package:praktikum2/input_mahasiswa_page.dart';
import 'package:praktikum2/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainPage());
  }
}

// Main Page
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, dynamic>? mahasiswa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Main Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Text("Go to Profile Page"),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputMahasiswaPage()),
                );

                if (result != null) {
                  setState(() {
                    mahasiswa = result as Map<String, dynamic>;
                  });
                }
              },
              child: Text("Input Mahasiswa"),
            ),
            const SizedBox(height: 10),

            //Tampilkan data mahasiswa jika ada
            if (mahasiswa != null) ...[
              Text("Nama: ${mahasiswa!['nama']}"),
              Text("Umur: ${mahasiswa!['umur']}"),
              Text("Alamat: ${mahasiswa!['alamat']}"),
              Text("Kontak: ${mahasiswa!['kontak']}"),
            ],
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed:
                  (mahasiswa != null &&
                      mahasiswa!['kontak'] != null &&
                      mahasiswa!['kontak'] != "")
                  ? () async {
                      final Uri url = Uri(
                        scheme: 'tel',
                        path: mahasiswa!['kontak'],
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Tidak dapat melakukan panggilan."),
                          ),
                        );
                      }
                    }
                  : null,
              child: Text("Call"),
            ),
          ],
        ),
      ),
    );
  }
}
