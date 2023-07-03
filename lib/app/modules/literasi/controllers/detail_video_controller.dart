import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/detail_video_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_video_provider.dart';
import 'package:nuha/app/utility/result_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailVideoController extends GetxController {
  ListVideoProvider listVideoProvider;
  DetailVideoController(
      {required this.listVideoProvider, required String idVideo}) {
    fetchDetailVideo(idVideo);
  }
  YoutubePlayerController youtubeC = YoutubePlayerController(
    initialVideoId: '',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      controlsVisibleAtStart: true,
      enableCaption: true,
      useHybridComposition: true,
    ),
  );

  var resultState = ResultState.loading().obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxBool isBookmarked = false.obs;

  String _message = '';
  late DetailVideo _detailVideo;

  DetailVideo get resultDetailVideo => _detailVideo;
  String get message => _message;

  Future<dynamic> fetchDetailVideo(idVideo) async {
    try {
      final video = await listVideoProvider.getDetailVideo(idVideo);
      if (video.data.toJson().isEmpty) {
        resultState.value = ResultState.noData();
        return _message = 'Data Kosong';
      } else {
        resultState.value = ResultState.hasData(video);
        return _detailVideo = video;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      return _message = '$e';
    }
  }
}
