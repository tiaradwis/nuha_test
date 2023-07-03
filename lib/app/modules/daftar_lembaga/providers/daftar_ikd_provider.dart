import 'dart:io';

import '../daftar_ikd_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DaftarIkdProvider {
  static const String _baseUrl = 'http://nuha.my.id/api/';

  Future<DaftarIkd> getDaftarIKD(http.Client client) async {
    try {
      final response = await client.get(Uri.parse("${_baseUrl}daftarIKD"));
      if (response.statusCode == 200) {
        return DaftarIkd.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list IKD');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<DaftarIkd> cariIKD(String keyword) async {
    try {
      final response =
          await http.get(Uri.parse("${_baseUrl}daftarIKD/search/$keyword"));
      if (response.statusCode == 200) {
        return DaftarIkd.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data yang dicari');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
