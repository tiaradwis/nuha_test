import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nuha/app/modules/daftar_lembaga/daftar_ikd_model.dart';
import 'package:nuha/app/modules/daftar_lembaga/providers/daftar_ikd_provider.dart';
import 'package:nuha/app/utility/result_state.dart';

class DaftarLembagaController extends GetxController
    with GetSingleTickerProviderStateMixin {
  DaftarLembagaController({
    required this.daftarIkdProvider,
  });

  final DaftarIkdProvider daftarIkdProvider;
  late TabController tabs;
  RxString keyword = ''.obs;

  var resultState = ResultState.loading().obs;
  var resultStateSearch = ResultState.loading().obs;
  RxBool isSelected = false.obs;
  var isDataLoading = false.obs;

  late DaftarIkd _daftarIkd, _cariIKD;
  DaftarIkd get resultIKD => _daftarIkd;
  DaftarIkd get resultSearch => _cariIKD;

  TextEditingController searchC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    tabs = TabController(length: 2, vsync: this);
    searchC = TextEditingController(text: keyword.value);
    getDaftarIKD();
  }

  @override
  void onClose() {
    tabs.dispose();
    super.onClose();
  }

  final List<Tab> daftarLembagaTabs = <Tab>[
    const Tab(
      text: 'Data IKD',
    ),
    const Tab(
      text: 'Data Pinjol',
    )
  ];

  Future<dynamic> getDaftarIKD() async {
    try {
      final data = await daftarIkdProvider.getDaftarIKD(http.Client());
      if (data.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(data);
        return _daftarIkd = data;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
    }
  }

  void search(String data) {
    keyword.value = data;
    searchDataIKD(keyword);
  }

  Future<dynamic> searchDataIKD(keyword) async {
    try {
      final data = await daftarIkdProvider.cariIKD(keyword);
      if (data.data.isEmpty) {
        resultStateSearch.value = ResultState.noData();
        update();
      } else {
        resultStateSearch.value = ResultState.hasData(data);
        update();
        return _cariIKD = data;
      }
    } catch (e) {
      print(e);
      update();
      // resultStateSearch.value = ResultState.error('An error occurred: $e');
    }
  }
}
