import 'dart:convert';
import 'package:http/http.dart' as http; //menggunakan alias, jangan nabrak sintaksis dart

class ApiService { //nama kelas sesuai
  final String _baseUrl = 'https://jsonplaceholder.typicode.com'; //base url untuk ngehit endpoint

  Future<List<dynamic>> fetchPosts() async { //fungsi yang nunggu sesuatu terlebih dahulu/janji async bakal punya nilai. fuuture mengembalikan data kalo berhasil, kalo gagal ngembaliin error
    final response = await http.get(Uri.parse('$_baseUrl/posts'));
    if (response.statusCode == 200) { //http response sukses, kalo gagal 404,500 dll (ada aturan khusu)
      return json.decode(response.body);
    } else {
      throw Exception('Gagal mengambil data dari API');
    }
  }
}


