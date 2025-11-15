import 'package:flutter/material.dart';
import 'package:praktikum9/models/hewan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HewanScreen(),
    );
  }
}

class HewanScreen extends StatefulWidget {
  @override
  State<HewanScreen> createState() => _HewanScreenState();
}

class _HewanScreenState extends State<HewanScreen> {
  Hewan kucing = Hewan('Mimi', 4.5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Hewan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Berat ${kucing.nama}: ${kucing.berat.toStringAsFixed(2)} kg',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),

            // Tombol Makan
            ElevatedButton(
              onPressed: () {
                setState(() {
                  kucing.makan(1.0); // tambah 1kg
                });
              },
              child: const Text('Makan (+1 kg)'),
            ),

            const SizedBox(height: 10),

            // Tombol Lari
            ElevatedButton(
              onPressed: () {
                setState(() {
                  kucing.lari(0.5); // kurangi 0.5kg
                });
              },
              child: const Text('Lari (-0.5 kg)'),
            ),
          ],
        ),
      ),
    );
  }
}
