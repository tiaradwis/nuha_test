import 'package:get/get.dart';

import 'package:nuha/app/modules/literasi/controllers/bookmark_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/bookmark_video_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/bookmarked_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/bookmarked_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/bookmarked_video_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/cari_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/cari_video_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/detail_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/detail_video_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/komentar_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/komentar_video_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/list_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/list_video_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/recommended_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/recommended_video_controller.dart';
import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';
import 'package:nuha/app/modules/literasi/providers/list_video_provider.dart';

import '../controllers/literasi_controller.dart';

class LiterasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecommendedVideoController>(
      () => RecommendedVideoController(
          listVideoProvider: ListVideoProvider(), idVideo: Get.arguments),
    );
    Get.lazyPut<CariVideoController>(
      () => CariVideoController(listVideoProvider: ListVideoProvider()),
    );
    Get.lazyPut<BookmarkedVideoController>(
      () => BookmarkedVideoController(),
    );
    Get.lazyPut<BookmarkedController>(
      () => BookmarkedController(),
    );
    Get.lazyPut<KomentarVideoController>(
      () => KomentarVideoController(idVideo: Get.arguments),
    );
    Get.lazyPut<DetailVideoController>(
      () => DetailVideoController(
          listVideoProvider: ListVideoProvider(), idVideo: Get.arguments),
    );
    Get.lazyPut<KomentarArtikelController>(
      () => KomentarArtikelController(idArtikel: Get.arguments),
    );
    Get.lazyPut<BookmarkArtikelController>(
      () => BookmarkArtikelController(artikelId: Get.arguments),
    );
    Get.lazyPut<BookmarkVideoController>(
      () => BookmarkVideoController(videoId: Get.arguments),
    );
    Get.lazyPut<LiterasiController>(
      () => LiterasiController(),
    );
    Get.lazyPut<BookmarkedArtikelController>(
      () => BookmarkedArtikelController(),
    );
    Get.lazyPut<ListVideoController>(
      () => ListVideoController(listVideoProvider: ListVideoProvider()),
    );
    Get.lazyPut<ListArtikelController>(
      () => ListArtikelController(listArtikelProvider: ListArtikelProvider()),
    );
    Get.lazyPut<CariArtikelController>(
      () => CariArtikelController(listArtikelProvider: ListArtikelProvider()),
    );
    Get.lazyPut<DetailArtikelController>(
      () => DetailArtikelController(
          listArtikelProvider: ListArtikelProvider(), idArtikel: Get.arguments),
    );
    Get.lazyPut<RecommendedArtikelController>(
      () => RecommendedArtikelController(
          listArtikelProvider: ListArtikelProvider(), idArtikel: Get.arguments),
    );
  }
}
