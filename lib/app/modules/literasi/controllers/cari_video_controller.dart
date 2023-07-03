import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/cari_video_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_video_provider.dart';
import 'package:nuha/app/utility/result_state.dart';

class CariVideoController extends GetxController {
  final ListVideoProvider listVideoProvider;
  RxString keyword = ''.obs;

  CariVideoController({
    required this.listVideoProvider,
    keyword = '',
  }) {
    searchVideoResult(keyword);
  }

  var resultState = ResultState.loading().obs;

  late CariVideo _cariVideo;
  CariVideo get resultCariVideo => _cariVideo;
  TextEditingController searchC = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    searchC = TextEditingController(text: keyword.value);
  }

  void search(String data) {
    keyword.value = data;
    searchVideoResult(keyword);
  }

  Future<dynamic> searchVideoResult(keyword) async {
    try {
      final video = await listVideoProvider.cariVideo(keyword);
      if (video.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(video);
        return _cariVideo = video;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
    }
  }
}
