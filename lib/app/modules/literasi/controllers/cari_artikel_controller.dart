import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/cari_artikel_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';
import 'package:nuha/app/utility/result_state.dart';

class CariArtikelController extends GetxController {
  final ListArtikelProvider listArtikelProvider;
  RxString keyword = ''.obs;

  CariArtikelController({
    required this.listArtikelProvider,
    keyword = '',
  }) {
    searchArtikelResult(keyword);
  }

  var resultState = ResultState.loading().obs;

  late CariArtikel _cariArtikel;
  CariArtikel get resultCariArtikel => _cariArtikel;
  TextEditingController searchC = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    searchC = TextEditingController(text: keyword.value);
  }

  void search(String data) {
    keyword.value = data;
    searchArtikelResult(keyword);
  }

  Future<dynamic> searchArtikelResult(keyword) async {
    try {
      final artikel = await listArtikelProvider.cariArtikel(keyword);
      if (artikel.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(artikel);
        return _cariArtikel = artikel;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
    }
  }
}
