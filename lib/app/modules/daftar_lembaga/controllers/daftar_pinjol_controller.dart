import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nuha/app/modules/daftar_lembaga/daftar_pinjol_model.dart';
import 'package:nuha/app/modules/daftar_lembaga/providers/daftar_pinjol_provider.dart';
import 'package:nuha/app/utility/result_state.dart';

class DaftarPinjolController extends GetxController
    with GetSingleTickerProviderStateMixin {
  DaftarPinjolController({
    required this.daftarPinjolProvider,
  });

  final DaftarPinjolProvider daftarPinjolProvider;
  RxString keyword = ''.obs;

  var resultState = ResultState.loading().obs;
  var resultStateSearch = ResultState.loading().obs;
  RxBool isSelected = false.obs;
  var isDataLoading = false.obs;

  late DaftarPinjol _daftarPinjol, _cariPinjol;

  DaftarPinjol get resultPinjol => _daftarPinjol;
  DaftarPinjol get resultSearch => _cariPinjol;

  TextEditingController searchC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchC = TextEditingController(text: keyword.value);
    getDaftarPinjol();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<dynamic> getDaftarPinjol() async {
    try {
      final data = await daftarPinjolProvider.getDaftarPinjol(http.Client());
      if (data.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(data);
        return _daftarPinjol = data;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
    }
  }

  void search(String data) {
    keyword.value = data;
    searchDataPinjol(keyword);
  }

  Future<dynamic> searchDataPinjol(keyword) async {
    try {
      final data = await daftarPinjolProvider.cariPinjol(keyword);
      if (data.data.isEmpty) {
        resultStateSearch.value = ResultState.noData();
        update();
      } else {
        resultStateSearch.value = ResultState.hasData(data);
        update();
        return _cariPinjol = data;
      }
    } catch (e) {
      print(e);
      update();
      // resultStateSearch.value = ResultState.error('An error occurred: $e');
    }
  }
}
