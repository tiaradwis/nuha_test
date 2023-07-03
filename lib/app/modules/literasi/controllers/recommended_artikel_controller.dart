import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/recommended_artikel_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';
import 'package:nuha/app/utility/result_state.dart';

class RecommendedArtikelController extends GetxController {
  ListArtikelProvider listArtikelProvider;
  RecommendedArtikelController(
      {required this.listArtikelProvider, required String idArtikel}) {
    fetchRecommendedArtikel(idArtikel);
  }

  var resultState = ResultState.loading().obs;
  RxBool isLoading = false.obs;

  String _message = '';
  late RecommendedArticle _recommendedArticle;

  RecommendedArticle get result => _recommendedArticle;
  String get message => _message;

  Future<dynamic> fetchRecommendedArtikel(idArtikel) async {
    try {
      final recommen =
          await listArtikelProvider.getRecommendArticleById(idArtikel);
      if (recommen.data.isEmpty) {
        resultState.value = ResultState.noData();
        return _message = 'Data Kosong';
      } else {
        resultState.value = ResultState.hasData(recommen);
        return _recommendedArticle = recommen;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      return _message = '$e';
    }
  }
}
