import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/models/confirm_consultation_payment.dart';
import 'package:nuha/app/modules/konsultasi/models/consultation_history.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

class HistoryConsultationController extends GetxController {
  RxBool isSelected = false.obs;
  RxInt tag = RxInt(1);
  FirebaseAuth auth = FirebaseAuth.instance;
  RxList<ConsultationHistory> historyList = <ConsultationHistory>[].obs;
  TextEditingController meetingLinkC = TextEditingController();
  RxBool isConsultationDone = false.obs;
  RxBool isLoadingConsultationDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id', null);
  }

  String convertTimestampToDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formatDatetime =
        DateFormat('EEEE d MMMM yyyy, HH:mm', 'id_ID').format(dateTime);
    return formatDatetime;
  }

  String getTimeFromTimestamp(Timestamp timestamp) {
    DateTime datetime = timestamp.toDate();
    String formatDatetime = DateFormat('HH:mm').format(datetime);
    return formatDatetime;
  }

  Future<List<ConsultationHistory>> getPendingHistory() async {
    try {
      QuerySnapshot historyData = await FirebaseFirestore.instance
          .collection('consultation_transaction')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .where('paymentStatus', isEqualTo: 'Menunggu Pembayaran')
          .orderBy('createdAt', descending: true)
          .get();

      historyList.clear();

      for (DocumentSnapshot historyDoc in historyData.docs) {
        Map<String, dynamic> historyDatas =
            historyDoc.data() as Map<String, dynamic>;

        DocumentSnapshot consultantDoc = await FirebaseFirestore.instance
            .collection('consultant')
            .doc(historyDatas['consultantId'])
            .get();

        if (consultantDoc.exists) {
          Map<String, dynamic> consultantDatas =
              consultantDoc.data() as Map<String, dynamic>;

          var startDate =
              convertTimestampToDateTime(historyDatas['startDateTime']);
          var endDate = getTimeFromTimestamp(historyDatas['endDateTime']);
          var fixDateTimeConsultation = '$startDate - $endDate';

          ConsultationHistory consultationHistory = ConsultationHistory(
            historyId: historyDoc.id,
            scheduleId: historyDatas['scheduleId'],
            fixDateTimeConsultation: fixDateTimeConsultation,
            userId: historyDatas['userId'],
            consultantId: historyDatas['consultantId'],
            paymentStatus: historyDatas['paymentStatus'],
            consultantName: consultantDatas['name'],
            consultantCategory: consultantDatas['category'],
            consultantPhoto: consultantDatas['imageUrl'],
            proofOfPayment: historyDatas['proofOfPayment'],
            meetingLink: historyDatas['meetingLink'],
          );

          historyList.add(consultationHistory);
        }
      }

      return historyList;
    } catch (e) {
      Get.snackbar('Kesalahan', '$e');
      return historyList;
    }
  }

  Future<List<ConsultationHistory>> getConfirmHistory() async {
    try {
      QuerySnapshot historyData = await FirebaseFirestore.instance
          .collection('consultation_transaction')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .where('paymentStatus', isEqualTo: 'Menunggu Konfirmasi')
          .orderBy('createdAt', descending: true)
          .get();

      historyList.clear();

      for (DocumentSnapshot historyDoc in historyData.docs) {
        Map<String, dynamic> historyDatas =
            historyDoc.data() as Map<String, dynamic>;

        DocumentSnapshot consultantDoc = await FirebaseFirestore.instance
            .collection('consultant')
            .doc(historyDatas['consultantId'])
            .get();

        if (consultantDoc.exists) {
          Map<String, dynamic> consultantDatas =
              consultantDoc.data() as Map<String, dynamic>;

          var startDate =
              convertTimestampToDateTime(historyDatas['startDateTime']);
          var endDate = getTimeFromTimestamp(historyDatas['endDateTime']);
          var fixDateTimeConsultation = '$startDate - $endDate';

          ConsultationHistory consultationHistory = ConsultationHistory(
            historyId: historyDoc.id,
            scheduleId: historyDatas['scheduleId'],
            fixDateTimeConsultation: fixDateTimeConsultation,
            userId: historyDatas['userId'],
            consultantId: historyDatas['consultantId'],
            paymentStatus: historyDatas['paymentStatus'],
            consultantName: consultantDatas['name'],
            consultantCategory: consultantDatas['category'],
            consultantPhoto: consultantDatas['imageUrl'],
            proofOfPayment: historyDatas['proofOfPayment'],
            meetingLink: historyDatas['meetingLink'],
          );

          historyList.add(consultationHistory);
        }
      }

      return historyList;
    } catch (e) {
      Get.snackbar('Kesalahan', '$e');
      return historyList;
    }
  }

  Future<List<ConsultationHistory>> getSuccessHistory() async {
    try {
      QuerySnapshot historyData = await FirebaseFirestore.instance
          .collection('consultation_transaction')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .where('paymentStatus', isEqualTo: 'Siap Konsultasi')
          .orderBy('createdAt', descending: true)
          .get();

      historyList.clear();

      for (DocumentSnapshot historyDoc in historyData.docs) {
        Map<String, dynamic> historyDatas =
            historyDoc.data() as Map<String, dynamic>;

        DocumentSnapshot consultantDoc = await FirebaseFirestore.instance
            .collection('consultant')
            .doc(historyDatas['consultantId'])
            .get();

        if (consultantDoc.exists) {
          Map<String, dynamic> consultantDatas =
              consultantDoc.data() as Map<String, dynamic>;

          var startDate =
              convertTimestampToDateTime(historyDatas['startDateTime']);
          var endDate = getTimeFromTimestamp(historyDatas['endDateTime']);
          var fixDateTimeConsultation = '$startDate - $endDate';

          ConsultationHistory consultationHistory = ConsultationHistory(
            historyId: historyDoc.id,
            scheduleId: historyDatas['scheduleId'],
            fixDateTimeConsultation: fixDateTimeConsultation,
            userId: historyDatas['userId'],
            consultantId: historyDatas['consultantId'],
            paymentStatus: historyDatas['paymentStatus'],
            consultantName: consultantDatas['name'],
            consultantCategory: consultantDatas['category'],
            consultantPhoto: consultantDatas['imageUrl'],
            proofOfPayment: historyDatas['proofOfPayment'],
            meetingLink: historyDatas['meetingLink'],
          );

          historyList.add(consultationHistory);
        }
      }

      return historyList;
    } catch (e) {
      Get.snackbar('Kesalahan', '$e');
      return historyList;
    }
  }

  Future<List<ConsultationHistory>> getDoneHistory() async {
    try {
      QuerySnapshot historyData = await FirebaseFirestore.instance
          .collection('consultation_transaction')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .where('paymentStatus', isEqualTo: 'Selesai')
          .orderBy('createdAt', descending: true)
          .get();

      historyList.clear();

      for (DocumentSnapshot historyDoc in historyData.docs) {
        Map<String, dynamic> historyDatas =
            historyDoc.data() as Map<String, dynamic>;

        DocumentSnapshot consultantDoc = await FirebaseFirestore.instance
            .collection('consultant')
            .doc(historyDatas['consultantId'])
            .get();

        if (consultantDoc.exists) {
          Map<String, dynamic> consultantDatas =
              consultantDoc.data() as Map<String, dynamic>;

          var startDate =
              convertTimestampToDateTime(historyDatas['startDateTime']);
          var endDate = getTimeFromTimestamp(historyDatas['endDateTime']);
          var fixDateTimeConsultation = '$startDate - $endDate';

          ConsultationHistory consultationHistory = ConsultationHistory(
            historyId: historyDoc.id,
            scheduleId: historyDatas['scheduleId'],
            fixDateTimeConsultation: fixDateTimeConsultation,
            userId: historyDatas['userId'],
            consultantId: historyDatas['consultantId'],
            paymentStatus: historyDatas['paymentStatus'],
            consultantName: consultantDatas['name'],
            consultantCategory: consultantDatas['category'],
            consultantPhoto: consultantDatas['imageUrl'],
            proofOfPayment: historyDatas['proofOfPayment'],
            meetingLink: historyDatas['meetingLink'],
          );

          historyList.add(consultationHistory);
        }
      }

      return historyList;
    } catch (e) {
      Get.snackbar('Kesalahan', '$e');
      return historyList;
    }
  }

  Future<void> getOrderDetail(
    String historyId,
    String consultantId,
  ) async {
    try {
      ConfirmConsultationPayment confirmConsultationPayment =
          ConfirmConsultationPayment(
        historyId: historyId,
        consultantId: consultantId,
      );

      Get.toNamed(Routes.CONFIRM_CONSULTATION_PAYMENT,
          arguments: confirmConsultationPayment);
    } catch (e) {
      Get.snackbar('Kesalahan', '$e');
    }
  }

  void getProofOfPaymentImage(String imageUrl) {
    Get.dialog(
      Image.network(
        imageUrl,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  void getMeetingLink() {
    Get.defaultDialog(
      title: 'Perhatian',
      titleStyle: Theme.of(Get.context!).textTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.w600, fontSize: 15.sp, color: grey900),
      middleText: 'Apakah kamu yakin ingin mengkonfirmasi pembayaranmu?',
      middleTextStyle: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w400, fontSize: 11.sp, color: grey900),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: buttonColor2,
                  backgroundColor: backgroundColor1,
                  side: const BorderSide(color: buttonColor2, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    'Batalkan',
                    style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: buttonColor2),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor2,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    'Setuju',
                    style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: backgroundColor1),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void copyTextToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      const SnackBar(content: Text('Link berhasil disalin ke clipboard')),
    );
  }

  Future<void> consultationDone(String paymentId) async {
    try {
      isLoadingConsultationDone.value = true;

      await FirebaseFirestore.instance
          .collection('consultation_transaction')
          .doc(paymentId)
          .update({'paymentStatus': 'Selesai'});

      isLoadingConsultationDone.value = false;
      Get.back();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }
}
