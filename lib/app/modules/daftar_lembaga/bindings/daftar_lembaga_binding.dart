import 'package:get/get.dart';

import 'package:nuha/app/modules/daftar_lembaga/controllers/daftar_pinjol_controller.dart';
import 'package:nuha/app/modules/daftar_lembaga/providers/daftar_ikd_provider.dart';
import 'package:nuha/app/modules/daftar_lembaga/providers/daftar_pinjol_provider.dart';

import '../controllers/daftar_lembaga_controller.dart';

class DaftarLembagaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarPinjolController>(
      () => DaftarPinjolController(
        daftarPinjolProvider: DaftarPinjolProvider(),
      ),
    );
    Get.lazyPut<DaftarLembagaController>(
      () => DaftarLembagaController(
        daftarIkdProvider: DaftarIkdProvider(),
      ),
    );
  }
}
