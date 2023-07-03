import 'package:get/get.dart';

import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_darurat_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_kendaraan_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_pendidikan_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_pensiun_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_pernikahan_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_rumah_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_umroh_controller.dart';
import '../controllers/perencanaan_keuangan_controller.dart';

class PerencanaanKeuanganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PkUmrohController>(
      () => PkUmrohController(),
    );
    Get.lazyPut<PkRumahController>(
      () => PkRumahController(),
    );
    Get.lazyPut<PkPernikahanController>(
      () => PkPernikahanController(),
    );
    Get.lazyPut<PkPensiunController>(
      () => PkPensiunController(),
    );
    Get.lazyPut<PkPendidikanController>(
      () => PkPendidikanController(),
    );
    Get.lazyPut<PkKendaraanController>(
      () => PkKendaraanController(),
    );
    Get.lazyPut<PkDaruratController>(
      () => PkDaruratController(),
    );
    Get.lazyPut<PerencanaanKeuanganController>(
      () => PerencanaanKeuanganController(),
    );
  }
}
