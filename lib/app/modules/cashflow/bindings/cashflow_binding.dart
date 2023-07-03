import 'package:get/get.dart';

import 'package:nuha/app/modules/cashflow/controllers/anggaran_create_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/anggaran_detail_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/anggaran_edit_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/laporankeuangan_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_create_controller.dart';
import 'package:nuha/app/modules/navbar/controllers/navbar_controller.dart';

import '../controllers/cashflow_controller.dart';

class CashflowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnggaranEditController>(
      () => AnggaranEditController(),
    );
    Get.lazyPut<AnggaranDetailController>(
      () => AnggaranDetailController(),
    );
    Get.lazyPut<AnggaranCreateController>(
      () => AnggaranCreateController(),
    );
    Get.lazyPut<TransaksiController>(
      () => TransaksiController(),
    );
    Get.lazyPut<TransaksiCreateController>(
      () => TransaksiCreateController(),
    );
    Get.lazyPut<LaporankeuanganController>(
      () => LaporankeuanganController(),
    );
    Get.lazyPut<CashflowController>(
      () => CashflowController(),
    );

    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
    Get.lazyPut<LaporankeuanganController>(
      () => LaporankeuanganController(),
    );
  }
}
