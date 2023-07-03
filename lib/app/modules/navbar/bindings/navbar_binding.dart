import 'package:get/get.dart';
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/laporankeuangan_controller.dart';
import 'package:nuha/app/modules/fincheck/controllers/fincheck_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/cari_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/detail_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/list_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/literasi_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/video_controller.dart';
import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';
import 'package:nuha/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<FincheckController>(
      () => FincheckController(),
    );
    Get.lazyPut<CashflowController>(
      () => CashflowController(),
    );
    Get.lazyPut<LiterasiController>(
      () => LiterasiController(),
    );
    Get.lazyPut<VideoController>(
      () => VideoController(),
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
    Get.lazyPut<LaporankeuanganController>(
      () => LaporankeuanganController(),
    );
  }
}
