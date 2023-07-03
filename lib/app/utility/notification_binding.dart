import 'package:get/get.dart';
import 'package:nuha/app/utility/notification_service_controller.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<NotificationServiceController>(NotificationServiceController());
  }
}
