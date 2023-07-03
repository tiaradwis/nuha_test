import 'package:get/get.dart';

import '../controllers/fincheck_controller.dart';

class FincheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FincheckController>(
      () => FincheckController(),
    );
  }
}
