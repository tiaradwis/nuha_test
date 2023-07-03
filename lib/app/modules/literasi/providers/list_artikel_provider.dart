import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nuha/app/modules/literasi/models/cari_artikel_model.dart';
import 'package:nuha/app/modules/literasi/models/detail_artikel_model.dart';
import 'dart:convert';
import 'package:nuha/app/modules/literasi/models/list_artikel_model.dart';
import 'package:nuha/app/modules/literasi/models/recommended_artikel_model.dart';

class ListArtikelProvider {
  static const String _baseUrl = 'https://nuha.my.id/api/';

  Future<ListArtikel> getListArtikel(http.Client client) async {
    try {
      final response = await client.get(Uri.parse("${_baseUrl}article"));
      if (response.statusCode == 200) {
        return ListArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list artikel');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListArtikel> getListKeuanganSyariahArtikel(http.Client client) async {
    try {
      final response = await client
          .get(Uri.parse("${_baseUrl}article/category/Keuangan%20Syariah"));
      if (response.statusCode == 200) {
        return ListArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list artikel');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListArtikel> getListTabunganSyariahArtikel(http.Client client) async {
    try {
      final response = await client
          .get(Uri.parse("${_baseUrl}article/category/Tabungan%20Syariah"));
      if (response.statusCode == 200) {
        return ListArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list artikel');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<CariArtikel> cariArtikel(String keyword) async {
    try {
      final response =
          await http.get(Uri.parse("${_baseUrl}article/search/$keyword"));
      if (response.statusCode == 200) {
        return CariArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data artikel yang dicari');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DetailArtikel> getDetailArtikel(String idArtikel) async {
    try {
      final response =
          await http.get(Uri.parse("${_baseUrl}article/$idArtikel"));
      if (response.statusCode == 200) {
        return DetailArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data detail artikel!!!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RecommendedArticle> getRecommendArticleById(String idArtikel) async {
    try {
      final response = await http.get(Uri.parse(
          "https://nuharekomendasiartikelapi-production.up.railway.app/recommend/article?id=$idArtikel"));
      if (response.statusCode == 200) {
        return RecommendedArticle.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data detail artikel!!!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
