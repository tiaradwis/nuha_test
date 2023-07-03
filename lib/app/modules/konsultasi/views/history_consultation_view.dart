import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/controllers/history_consultation_controller.dart';
import 'package:sizer/sizer.dart';

class HistoryConsultationView extends GetView<HistoryConsultationController> {
  HistoryConsultationView({Key? key}) : super(key: key);
  final c = Get.find<HistoryConsultationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        leading: Container(
          width: 100,
          padding: EdgeInsets.only(left: 4.58.w),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Iconify(
              Mdi.arrow_left,
              size: 3.h,
              color: titleColor,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: titleColor,
        ),
        title: Text(
          'Riwayat Konsultasi',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 1.875.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.9167.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => ChipsChoice.single(
                    spacing: 3.3.w,
                    wrapped: true,
                    padding: EdgeInsets.symmetric(horizontal: 0.w),
                    value: c.tag.value,
                    onChanged: (val) {
                      c.tag.value = val;
                    },
                    choiceItems: const <C2Choice>[
                      C2Choice(value: 1, label: 'Menunggu Pembayaran'),
                      C2Choice(value: 2, label: 'Konfirmasi Pembayarani'),
                      C2Choice(value: 3, label: 'Siap Konsultasi'),
                      C2Choice(value: 4, label: 'Selesai'),
                    ],
                    choiceStyle: C2ChipStyle.filled(
                      foregroundStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              color: grey400,
                              fontWeight: FontWeight.w600,
                              fontSize: 9.sp),
                      color: grey50,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      selectedStyle: C2ChipStyle(
                        backgroundColor: buttonColor1,
                        foregroundStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                color: backgroundColor1,
                                fontWeight: FontWeight.w600,
                                fontSize: 9.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.9167.w),
              child: Obx(
                () => FutureBuilder(
                  future: (c.tag.value == 1)
                      ? c.getPendingHistory()
                      : (c.tag.value == 2)
                          ? c.getConfirmHistory()
                          : (c.tag.value == 3)
                              ? c.getSuccessHistory()
                              : c.getDoneHistory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: const Center(
                          child: CircularProgressIndicator(color: buttonColor1),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: c.historyList.length,
                        itemBuilder: (context, index) {
                          var datas = c.historyList[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 1.5.h),
                            child: Card(
                              color: backgroundColor1,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.375.h, horizontal: 3.33.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Konsultasi pada :',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 9.sp,
                                                color: const Color(0XFF0D4136),
                                              ),
                                        ),
                                        Text(
                                          datas.fixDateTimeConsultation,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 8.sp,
                                                color: grey400,
                                              ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: grey100,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                datas.consultantPhoto,
                                                height: 4.h,
                                                width: 4.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 1.h),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                datas.consultantName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: grey500,
                                                        fontSize: 9.sp),
                                              ),
                                              Text(
                                                datas.consultantCategory,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: grey400,
                                                        fontSize: 9.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: SizedBox(
                                            height: 3.5.h,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (c.tag.value == 1) {
                                                  c.getOrderDetail(
                                                    datas.historyId,
                                                    datas.consultantId,
                                                  );
                                                } else if (c.tag.value == 2) {
                                                  c.getProofOfPaymentImage(
                                                      datas.proofOfPayment);
                                                } else if (c.tag.value == 3) {
                                                  customShowDialog(
                                                    context,
                                                    datas.meetingLink,
                                                    datas.historyId,
                                                  );
                                                }
                                              },
                                              style: c.tag.value == 4
                                                  ? ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          buttonColor2,
                                                      foregroundColor:
                                                          buttonColor2,
                                                      disabledBackgroundColor:
                                                          buttonColor2,
                                                      disabledForegroundColor:
                                                          buttonColor2,
                                                      side: const BorderSide(
                                                          color: buttonColor2,
                                                          width: 1),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                    )
                                                  : ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          buttonColor2,
                                                      side: const BorderSide(
                                                          color: buttonColor2,
                                                          width: 1),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                    ),
                                              child: Text(
                                                c.tag.value == 1
                                                    ? 'Bayar Sekarang'
                                                    : c.tag.value == 2
                                                        ? 'Bukti Pembayaran'
                                                        : c.tag.value == 3
                                                            ? 'Link Pertemuan'
                                                            : 'Selesai',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: backgroundColor1,
                                                        fontSize: 8.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void customShowDialog(
      BuildContext context, String meetingLink, String paymentId) {
    c.meetingLinkC.text = meetingLink;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AnimationConfiguration.synchronized(
            child: FadeInAnimation(
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 250),
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                content: SizedBox(
                  width: 84.44.w,
                  height: 32.h,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Silahkan salin link berikut dan tempel link tersebut pada aplikasi Google Meet.',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                            ),
                            SizedBox(height: 2.h),
                            TextField(
                              autocorrect: false,
                              controller: c.meetingLinkC,
                              readOnly: true,
                              cursorColor: buttonColor1,
                              textInputAction: TextInputAction.next,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 2.h, vertical: 1.5.h),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: grey50),
                                    borderRadius: BorderRadius.circular(10)),
                                suffixIcon: IconButton(
                                  onPressed: () => c
                                      .copyTextToClipboard(c.meetingLinkC.text),
                                  splashRadius: 20,
                                  icon: const Iconify(
                                      MaterialSymbols.content_copy_outline),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: buttonColor1),
                                    child: Obx(
                                      () => Checkbox(
                                        activeColor: buttonColor1,
                                        value: c.isConsultationDone.value,
                                        onChanged: (value) =>
                                            c.isConsultationDone.toggle(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  "Saya telah melaksanakan konsultasi",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w400,
                                          color: grey900),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 32.w,
                              child: ElevatedButton(
                                onPressed: () {
                                  c.isConsultationDone.value = false;
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor2,
                                ),
                                child: Text(
                                  'Tutup',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11.sp,
                                          color: backgroundColor1),
                                ),
                              ),
                            ),
                            Obx(
                              () => SizedBox(
                                height: 40,
                                width: 32.w,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (c.isConsultationDone.isTrue) {
                                      c.isConsultationDone.value = false;
                                      c.consultationDone(paymentId);
                                    }
                                  },
                                  style: c.isConsultationDone.isFalse
                                      ? ElevatedButton.styleFrom(
                                          backgroundColor: grey500,
                                          foregroundColor: grey500,
                                        )
                                      : ElevatedButton.styleFrom(
                                          backgroundColor: buttonColor1,
                                        ),
                                  child: c.isLoadingConsultationDone.isFalse
                                      ? Text(
                                          'Selesai',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11.sp,
                                                  color: backgroundColor1),
                                        )
                                      : SizedBox(
                                          height: 1.5.h,
                                          width: 1.5.h,
                                          child:
                                              const CircularProgressIndicator(
                                            color: backgroundColor1,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
