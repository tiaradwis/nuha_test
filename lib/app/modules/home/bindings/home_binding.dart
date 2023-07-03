import 'package:get/get.dart';

import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/literasi_controller.dart';
import 'package:nuha/app/modules/profile/controllers/profile_controller.dart';
import 'package:nuha/app/modules/zis/controllers/zis_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<CashflowController>(
      () => CashflowController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<LiterasiController>(
      () => LiterasiController(),
    );
    Get.lazyPut<ZisController>(
      () => ZisController(),
    );
  }
}
