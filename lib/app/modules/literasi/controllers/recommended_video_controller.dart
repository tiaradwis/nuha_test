import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/recommended_video_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_video_provider.dart';
import 'package:nuha/app/utility/result_state.dart';

class RecommendedVideoController extends GetxController {
  ListVideoProvider listVideoProvider;
  RecommendedVideoController(
      {required this.listVideoProvider, required String idVideo}) {
    fetchRecommendedVideo(idVideo);
  }

  var resultState = ResultState.loading().obs;
  RxBool isLoading = false.obs;

  String _message = '';
  late RecommendedVideo _recommendedVideo;

  RecommendedVideo get result => _recommendedVideo;
  String get message => _message;

  Future<dynamic> fetchRecommendedVideo(idVideo) async {
    try {
      final recommen = await listVideoProvider.getRecommendVideoById(idVideo);
      if (recommen.data.isEmpty) {
        resultState.value = ResultState.noData();
        return _message = 'Data Kosong';
      } else {
        resultState.value = ResultState.hasData(recommen);
        return _recommendedVideo = recommen;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      return _message = '$e';
    }
  }
}
