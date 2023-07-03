import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/models/confirm_consultation_payment.dart';
import 'package:sizer/sizer.dart';

class PaymentConfirmationController extends GetxController {
  ConfirmConsultationPayment confirmConsultationPayment = Get.arguments;
  RxList<String> paymentMethodList = <String>[].obs;
  RxString currentPaymentMethod = ''.obs;
  RxBool isPaymentMethodSelected = false.obs;
  final GlobalKey<ExpansionTileCardState> mandiriCard = GlobalKey();
  final GlobalKey<ExpansionTileCardState> bcaCard = GlobalKey();
  final GlobalKey<ExpansionTileCardState> bniCard = GlobalKey();
  final GlobalKey<ExpansionTileCardState> bsiCard = GlobalKey();
  final GlobalKey<ExpansionTileCardState> briCard = GlobalKey();
  final GlobalKey<ExpansionTileCardState> gopayCard = GlobalKey();
  final GlobalKey<ExpansionTileCardState> danaCard = GlobalKey();
  final GlobalKey<ExpansionTileCardState> linkajaCard = GlobalKey();
  RxInt totalFixedPrice = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isUploadLoaing = false.obs;

  //upload image
  XFile? image;
  RxBool uploadedImage = false.obs;
  final storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    initializeDateFormatting('id', null);
    paymentMethodList.value = [
      'Bank Mandiri',
      'Bank BCA',
      'Bank BNI',
      'Bank BSI',
      'Bank BRI',
      'GoPay',
      'DANA',
      'LinkAja',
    ];
    super.onInit();
  }

  String convertTimestampToDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formatDatetime =
        DateFormat('EEEE d MMM yyyy, HH:mm', 'id_ID').format(dateTime);
    return formatDatetime;
  }

  String getTimeFromTimestamp(Timestamp timestamp) {
    DateTime datetime = timestamp.toDate();
    String formatDatetime = DateFormat('HH:mm').format(datetime);
    return formatDatetime;
  }

  Future<void> getDetailData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> consultantDoc =
          await FirebaseFirestore.instance
              .collection('consultant')
              .doc(confirmConsultationPayment.consultantId)
              .get();

      final DocumentSnapshot<Map<String, dynamic>> transactionDoc =
          await FirebaseFirestore.instance
              .collection('consultation_transaction')
              .doc(confirmConsultationPayment.historyId)
              .get();

      var startDate =
          convertTimestampToDateTime(transactionDoc['startDateTime']);
      var endDate = getTimeFromTimestamp(transactionDoc['endDateTime']);
      var fixDateTimeConsultation = '$startDate - $endDate';
      var consultantPrice = consultantDoc.data()!['price'];

      if (consultantDoc.exists && transactionDoc.exists) {
        confirmConsultationPayment = ConfirmConsultationPayment(
          historyId: confirmConsultationPayment.historyId,
          consultantId: confirmConsultationPayment.consultantId,
          consultantImg: consultantDoc.data()!['imageUrl'],
          consultantName: consultantDoc.data()!['name'],
          consultantCategory: consultantDoc.data()!['category'],
          consultantPrice: consultantPrice,
          fixScheduleTime: fixDateTimeConsultation,
          totalPrice: int.parse(transactionDoc['total']),
          paymentMethod: transactionDoc['selectedPaymentMethod'],
        );
        totalFixedPrice.value = int.parse(transactionDoc['total']);
        currentPaymentMethod.value = confirmConsultationPayment.paymentMethod!;
        isPaymentMethodSelected.value = true;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePaymentMethod() async {
    try {
      isLoading.value = true;

      await FirebaseFirestore.instance
          .collection('consultation_transaction')
          .doc(confirmConsultationPayment.historyId)
          .update({
        'selectedPaymentMethod': currentPaymentMethod.value,
      });

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('$e');
    }
  }

  Widget paymentMethodDetails(
    BuildContext context,
    keyCard,
    paymentMethodValue,
    logo,
    paymentName,
    titlePayment,
    nomorBody,
    bodyPayment,
    String? titlePayment2,
    String? nomorBody2,
    String? bodyPayment2,
    String? titlePayment3,
    String? nomorBody3,
    String? bodyPayment3,
  ) {
    return ExpansionTileCard(
      key: keyCard,
      trailing: Obx(
        () => Radio(
          activeColor: buttonColor1,
          overlayColor:
              MaterialStateProperty.all(buttonColor1.withOpacity(0.2)),
          value: paymentMethodValue,
          groupValue: currentPaymentMethod.value,
          onChanged: (value) {
            currentPaymentMethod.value = value.toString();
            isPaymentMethodSelected.value = true;
          },
        ),
      ),
      title: Row(
        children: [
          SizedBox(
            width: 50,
            child: Image.asset(
              logo,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            paymentName,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
        ],
      ),
      children: <Widget>[
        const Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 2.h,
            ),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titlePayment,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            nomorBody,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          flex: 15,
                          child: Text(
                            bodyPayment,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                titlePayment2 != null &&
                        nomorBody2 != null &&
                        bodyPayment2 != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titlePayment2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  nomorBody2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                ),
                              ),
                              SizedBox(width: 1.w),
                              Expanded(
                                flex: 15,
                                child: Text(
                                  bodyPayment2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
                titlePayment3 != null &&
                        nomorBody3 != null &&
                        bodyPayment3 != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titlePayment3,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  nomorBody3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                ),
                              ),
                              SizedBox(width: 1.w),
                              Expanded(
                                flex: 15,
                                child: Text(
                                  bodyPayment3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
                SizedBox(height: 0.75.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pickProofOfPaymentImage(String pickType) async {
    final ImagePicker picker = ImagePicker();
    if (pickType == "kamera") {
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      update();
    }
  }

  void resetImage() async {
    image = null;
    update();
  }

  Future<void> uploadProofOfPayment() async {
    try {
      isUploadLoaing.value = true;
      String uid = auth.currentUser!.uid;
      String dateNow = DateTime.now().toIso8601String();
      if (image != null) {
        String ext = image!.name.split(".").last;
        await storage
            .ref(uid)
            .child("payment_proof_$dateNow.$ext")
            .putFile(File(image!.path));

        String proofOfPaymentURL = await storage
            .ref(uid)
            .child("payment_proof_$dateNow.$ext")
            .getDownloadURL();

        if (confirmConsultationPayment.paymentMethod ==
            currentPaymentMethod.value) {
          await FirebaseFirestore.instance
              .collection('consultation_transaction')
              .doc(confirmConsultationPayment.historyId)
              .update({
            'proofOfPayment': proofOfPaymentURL,
            'paymentStatus': 'Menunggu Konfirmasi',
          });
        } else {
          await FirebaseFirestore.instance
              .collection('consultation_transaction')
              .doc(confirmConsultationPayment.historyId)
              .update({
            'proofOfPayment': proofOfPaymentURL,
            'paymentStatus': 'Menunggu Konfirmasi',
            'selectedPaymentMethod': currentPaymentMethod.value,
          });
        }

        isUploadLoaing.value = false;
        Get.back();
        Get.back();
        Get.defaultDialog(
          title: 'Perhatian',
          titleStyle: Theme.of(Get.context!).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w600, fontSize: 15.sp, color: grey900),
          middleText: 'Saat ini pembayaranmu sedang kami proses. Mohon tunggu',
          middleTextStyle: Theme.of(Get.context!)
              .textTheme
              .bodyMedium!
              .copyWith(
                  fontWeight: FontWeight.w400, fontSize: 11.sp, color: grey900),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor2,
                  side: const BorderSide(color: buttonColor2, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    'Oke',
                    style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: backgroundColor1),
                  ),
                ),
              ),
            )
          ],
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
