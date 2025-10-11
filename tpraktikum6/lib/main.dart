import 'package:flutter/material.dart';
import 'hasil_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulir Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/',
      routes: {
        '/': (context) => const FormMahasiswaPage(),
        '/hasil': (context) => const HasilPage(), // <--- route ke halaman hasil
      },
    );
  }
}

class FormMahasiswaPage extends StatefulWidget {
  const FormMahasiswaPage({super.key});

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final cNama = TextEditingController();
  final cNpm = TextEditingController();
  final cEmail = TextEditingController();
  final cAlamat = TextEditingController();
  final cNoHp = TextEditingController();

  DateTime? tglLahir;
  TimeOfDay? jamBimbingan;
  String? jenisKelamin;

  String get tglLahirLabel => tglLahir == null
      ? 'Pilih Tanggal Lahir'
      : '${tglLahir!.day}/${tglLahir!.month}/${tglLahir!.year}';

  String get jamLabel => jamBimbingan == null
      ? 'Pilih Jam Bimbingan'
      : '${jamBimbingan!.hour}:${jamBimbingan!.minute}';

  @override
  void dispose() {
    cNama.dispose();
    cNpm.dispose();
    cEmail.dispose();
    cAlamat.dispose();
    cNoHp.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (res != null) setState(() => tglLahir = res);
  }

  Future<void> _pickTime() async {
    final res = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (res != null) setState(() => jamBimbingan = res);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate() ||
        tglLahir == null ||
        jamBimbingan == null ||
        jenisKelamin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data belum lengkap!')),
      );
      return;
    }

    final data = {
      'nama': cNama.text,
      'npm': cNpm.text,
      'email': cEmail.text,
      'alamat': cAlamat.text,
      'noHp': cNoHp.text,
      'jenisKelamin': jenisKelamin!,
      'tglLahir': tglLahirLabel,
      'jamBimbingan': jamLabel,
    };

    Navigator.pushNamed(
      context,
      '/hasil',
      arguments: data,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Formulir Mahasiswa')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: cNama,
                  decoration: const InputDecoration(
                      labelText: 'Nama', prefixIcon: Icon(Icons.person)),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Nama harus diisi' : null,
                ),
                TextFormField(
                  controller: cNpm,
                  decoration: const InputDecoration(
                      labelText: 'NPM', prefixIcon: Icon(Icons.badge)),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'NPM harus diisi' : null,
                ),
                TextFormField(
                  controller: cEmail,
                  decoration: const InputDecoration(
                      labelText: 'Email', prefixIcon: Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email harus diisi';
                    final ok =
                        RegExp(r'^[^@]+@unsika\.ac\.id$').hasMatch(v.trim());
                    return ok ? null : 'Email harus domain @unsika.ac.id';
                  },
                ),
                TextFormField(
                  controller: cAlamat,
                  decoration: const InputDecoration(
                      labelText: 'Alamat', prefixIcon: Icon(Icons.home)),
                  maxLines: 3,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Alamat harus diisi' : null,
                ),
                TextFormField(
                  controller: cNoHp,
                  decoration: const InputDecoration(
                      labelText: 'Nomor HP', prefixIcon: Icon(Icons.phone)),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor HP harus diisi';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Nomor HP harus berupa angka';
                    }
                    if (value.length < 10) {
                      return 'Nomor HP minimal 10 digit';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Jenis Kelamin'),
                  items: const [
                    DropdownMenuItem(
                        value: 'Laki-laki', child: Text('Laki-laki')),
                    DropdownMenuItem(
                        value: 'Perempuan', child: Text('Perempuan')),
                  ],
                  onChanged: (v) => setState(() => jenisKelamin = v),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Jenis kelamin harus dipilih'
                      : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: Text(tglLahirLabel),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickTime,
                  child: Text(jamLabel),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _simpan,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan & Lihat Hasil'),
                ),
              ],
            ),
          ),
        ),
      );
}
