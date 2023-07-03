import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/list_artikel_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';
import 'package:http/http.dart' as http;
import 'package:nuha/app/utility/result_state.dart';

class ListArtikelController extends GetxController {
  final ListArtikelProvider listArtikelProvider;
  ListArtikelController({required this.listArtikelProvider});

  var resultState = ResultState.loading().obs;
  RxBool isSelected = false.obs;
  RxInt tag = 1.obs;
  var isDataLoading = false.obs;

  late ListArtikel _listArtikel;
  ListArtikel get result => _listArtikel;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<dynamic> getListArtikel() async {
    try {
      final artikel = await listArtikelProvider.getListArtikel(http.Client());
      if (artikel.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(artikel);

        return _listArtikel = artikel;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
    }
  }

  Future<dynamic> getListKeuanganSyariahArtikel() async {
    try {
      final artikel = await listArtikelProvider
          .getListKeuanganSyariahArtikel(http.Client());
      if (artikel.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(artikel);
        return _listArtikel = artikel;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
    }
  }

  Future<dynamic> getListTabunganSyariahArtikel() async {
    try {
      final artikel = await listArtikelProvider
          .getListTabunganSyariahArtikel(http.Client());
      if (artikel.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(artikel);
        return _listArtikel = artikel;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
    }
  }
}
