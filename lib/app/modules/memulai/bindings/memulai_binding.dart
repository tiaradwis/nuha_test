import 'package:get/get.dart';

import '../controllers/memulai_controller.dart';

class MemulaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemulaiController>(
      () => MemulaiController(),
    );
  }
}
