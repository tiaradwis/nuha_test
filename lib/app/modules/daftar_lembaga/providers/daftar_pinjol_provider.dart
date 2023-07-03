import 'dart:io';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nuha/app/modules/daftar_lembaga/daftar_pinjol_model.dart';

class DaftarPinjolProvider {
  static const String _baseUrl = 'http://nuha.my.id/api/';

  Future<DaftarPinjol> getDaftarPinjol(http.Client client) async {
    try {
      final response = await client.get(Uri.parse("${_baseUrl}daftarPinjol"));
      if (response.statusCode == 200) {
        return DaftarPinjol.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list Pinjol');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<DaftarPinjol> cariPinjol(String keyword) async {
    try {
      final response =
          await http.get(Uri.parse("${_baseUrl}daftarPinjol/search/$keyword"));
      if (response.statusCode == 200) {
        return DaftarPinjol.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data yang dicari');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
