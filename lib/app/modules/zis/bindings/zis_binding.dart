import 'package:get/get.dart';

import '../controllers/zis_controller.dart';

class ZisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZisController>(
      () => ZisController(),
    );
  }
}
