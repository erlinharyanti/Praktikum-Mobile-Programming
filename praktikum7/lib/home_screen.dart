import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/note.dart';
import 'add_note_screen.dart';
import 'edit_note_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadNotes(); // untuk memanggil data dari database saat awal halaman
  }

  Future<void> _loadNotes() async {
    final data = await dbHelper.getNotes();
    setState(() {
      notes = data; // update state agar ListView ter-render ulang
    });
  }

  Future<void> _deleteNote(int id) async {
    await dbHelper.deleteNote(id); // hapus data dari DB
    _loadNotes(); // refresh list setelah delete
  }

  void _showSnackbar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Catatan")),
      body: notes.isEmpty
          ? const Center(child: Text("Belum ada catatan"))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),

                    // Tambahkan 2 icon: edit & hapus
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // tombol edit
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            // buka halaman edit, kirim data note ke sana
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditNoteScreen(note: note),
                              ),
                            );

                            if (result == "updated") {
                              _showSnackbar("Catatan berhasil diperbarui ✅");
                            }
                            _loadNotes(); // refresh saat kembali
                          },
                        ),

                        // tombol delete
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // tampilkan dialog konfirmasi
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Hapus catatan?"),
                                actions: [
                                  TextButton(
                                    child: const Text("Batal"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: const Text("Hapus"),
                                    onPressed: () {
                                      _deleteNote(note.id!);
                                      Navigator.pop(context);
                                      _showSnackbar("Catatan berhasil dihapus");
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      // tombol tambah
      floatingActionButton: FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddNoteScreen()),
        );

        if (result == "added") {
          _showSnackbar("Catatan berhasil ditambahkan ✅");
        }

        _loadNotes();
      },
      child: const Icon(Icons.add),
    ),
    );
  }
}

