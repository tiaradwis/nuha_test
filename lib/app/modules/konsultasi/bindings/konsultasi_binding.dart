import 'package:get/get.dart';

import 'package:nuha/app/modules/konsultasi/controllers/history_consultation_controller.dart';
import 'package:nuha/app/modules/konsultasi/controllers/order_constultation_controller.dart';
import 'package:nuha/app/modules/konsultasi/controllers/payment_confirmation_controller.dart';
import 'package:nuha/app/modules/konsultasi/controllers/schedule_consultation_controller.dart';

import '../controllers/konsultasi_controller.dart';

class KonsultasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentConfirmationController>(
      () => PaymentConfirmationController(),
    );
    Get.lazyPut<OrderConstultationController>(
      () => OrderConstultationController(),
    );
    Get.lazyPut<HistoryConsultationController>(
      () => HistoryConsultationController(),
    );
    Get.lazyPut<HistoryConsultationController>(
      () => HistoryConsultationController(),
      tag: 'payment-confirmation',
    );
    Get.lazyPut<KonsultasiController>(
      () => KonsultasiController(),
    );
    Get.lazyPut<ScheduleConsultationController>(
      () => ScheduleConsultationController(consultantId: Get.arguments),
    );
  }
}
