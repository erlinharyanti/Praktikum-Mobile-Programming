import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Berita',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: const NewsListPage(),
    );
  }
}

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  // Data berita
  final List<Map<String, String>> news = const [
    {
      "title": "Ciri Unik Gajah Afrika vs Asia, Mana yang Paling Cerdas?",
      "subtitle": "Mengenal perbedaan menarik antara dua spesies gajah terbesar di dunia.",
      "image": "source/Gajahnews.jpg"
    },
    {
      "title":
          "Gen Z Pilih Hustle Culture atau Work Life Balance? Ini Penjelasannya",
      "subtitle":
          "Tren baru dunia kerja yang dipilih anak muda, produktif tanpa mengorbankan hidup sehat.",
      "image": "source/News2.jpg"
    },
    {
      "title": "Anda Mungkin Jauh Lebih Menarik Daripada yang Anda Kira",
      "subtitle":
          "Penelitian terbaru menunjukkan bahwa orang sering meremehkan daya tarik dirinya.",
      "image": "source/News.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Berita"),
      ),
      body: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          final item = news[index];
          return ListTile(
            leading: Image.asset(
              item["image"]!,
              width: 60,
              fit: BoxFit.cover,
            ),
            title: Text(item["title"]!),
            subtitle: Text(item["subtitle"]!),
            trailing: const Icon(Icons.bookmark_border),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Mengalihkan ke halaman berita"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
