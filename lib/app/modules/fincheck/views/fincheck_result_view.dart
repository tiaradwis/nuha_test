import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/fincheck/controllers/fincheck_controller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'dart:math' as math;
import 'package:screenshot/screenshot.dart';

import 'package:iconify_flutter/icons/bi.dart';

class FincheckResultView extends GetView<FincheckController> {
  FincheckResultView({Key? key}) : super(key: key);

  final currencyFormat = NumberFormat.currency(locale: 'id_ID');
  final c = Get.find<FincheckController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: titleColor,
            size: 18.sp,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 7.778.w,
          ),
          children: [
            SizedBox(
              height: 0.5.h,
            ),
            GradientText(
              "Hasil Analisa",
              style: Theme.of(context).textTheme.displaySmall!,
              colors: const [
                buttonColor1,
                buttonColor2,
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Stack(
              children: [
                SizedBox(
                  height: 37.h,
                  child: Center(
                      child: Screenshot(
                    controller: c.screenshotController,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            axisLineStyle: AxisLineStyle(thickness: 30),
                            showLabels: false,
                            showAxisLine: false,
                            showTicks: false,
                            startAngle: 180,
                            endAngle: 0,
                            minimum: 0,
                            maximum: 99,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startValue: 0,
                                  endValue: 33,
                                  color: errColor.withOpacity(0.7),
                                  label: 'Buruk',
                                  sizeUnit: GaugeSizeUnit.factor,
                                  labelStyle: GaugeTextStyle(
                                      fontFamily: 'Times',
                                      fontSize: 12.sp,
                                      color: Colors.white),
                                  startWidth: 0.4,
                                  endWidth: 0.4),
                              GaugeRange(
                                startValue: 33,
                                endValue: 66,
                                color: buttonColor2.withOpacity(0.7),
                                label: 'Baik',
                                labelStyle: GaugeTextStyle(
                                    fontFamily: 'Times',
                                    fontSize: 12.sp,
                                    color: Colors.white),
                                startWidth: 0.4,
                                endWidth: 0.4,
                                sizeUnit: GaugeSizeUnit.factor,
                              ),
                              GaugeRange(
                                startValue: 66,
                                endValue: 100,
                                color: buttonColor1.withOpacity(0.7),
                                label: 'Sangat Baik',
                                labelStyle: GaugeTextStyle(
                                    fontFamily: 'Times',
                                    fontSize: 12.sp,
                                    color: Colors.white),
                                sizeUnit: GaugeSizeUnit.factor,
                                startWidth: 0.4,
                                endWidth: 0.4,
                              ),
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                value: c.gaugePoint,
                                needleColor: grey900,
                              )
                            ])
                      ],
                    ),
                  )),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 21.h),
                    padding: EdgeInsets.all(1.h),
                    height: 10.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: backgroundColor2,
                    ),
                    child: Text(
                      c.simpulan,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: grey900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 34.h),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: c.streamData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const SizedBox();
                      } else {
                        final data =
                            snapshot.data!.docs.map((e) => e.data()).toList();

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: StickyGroupedListView<dynamic, String>(
                            shrinkWrap: true,
                            elements: data,
                            groupBy: (dynamic element) =>
                                (element['resultStatus']),
                            groupSeparatorBuilder: (dynamic element) =>
                                element['resultStatus'] == "Bad"
                                    ? Container(
                                        color: backgroundColor1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Perlu diperbaiki!",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(color: grey900),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        color: backgroundColor1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Text(
                                              "Pertahankan ya!",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(color: grey900),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            )
                                          ],
                                        ),
                                      ),
                            itemBuilder: (context, dynamic element) =>
                                Container(
                              padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
                              margin: EdgeInsets.only(top: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: element["resultStatus"] == "Bad"
                                      ? buttonColor2.withOpacity(0.6)
                                      : buttonColor1.withOpacity(0.6),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${element["title"]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: grey900,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: "Rp",
                                                decimalDigits: 0)
                                            .format(element["nominal"]),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: grey900),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 68.w,
                                        child: Center(
                                          child: SfLinearGauge(
                                            showTicks: false,
                                            showLabels: false,
                                            axisTrackStyle:
                                                const LinearAxisTrackStyle(
                                                    color: grey50),
                                            interval: 100,
                                            markerPointers: [
                                              LinearWidgetPointer(
                                                value: element["idealPoint"],
                                                child: Container(
                                                    height: 1.75.h,
                                                    width: 1.w,
                                                    color: dark),
                                              ),
                                              LinearWidgetPointer(
                                                  value: element["point"],
                                                  child: element[
                                                              "resultStatus"] ==
                                                          "Bad"
                                                      ? Iconify(
                                                          Ph.warning_circle_fill,
                                                          size: 15.sp,
                                                          color: Colors.orange,
                                                        )
                                                      : Iconify(
                                                          MaterialSymbols
                                                              .check_circle_rounded,
                                                          size: 15.sp,
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 5, 92, 50),
                                                        )),
                                            ],
                                            barPointers: [
                                              LinearBarPointer(
                                                  color:
                                                      element["resultStatus"] ==
                                                              "Bad"
                                                          ? buttonColor2
                                                              .withOpacity(0.7)
                                                          : buttonColor1
                                                              .withOpacity(0.7),
                                                  value: element["point"],
                                                  position:
                                                      LinearElementPosition
                                                          .cross),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.sp,
                                        width: 15.sp,
                                        child: Obx(() => IconButton(
                                              padding: const EdgeInsets.all(0),
                                              iconSize: 15.sp,
                                              onPressed: () {
                                                c.toggleDescriptionVisibility();
                                              },
                                              icon: c.isVisible.isFalse
                                                  ? Transform(
                                                      alignment:
                                                          Alignment.center,
                                                      transform:
                                                          Matrix4.rotationX(
                                                              math.pi),
                                                      child: Iconify(
                                                        MaterialSymbols
                                                            .arrow_drop_down_circle_outline_rounded,
                                                        size: 15.sp,
                                                        color: dark,
                                                      ),
                                                    )
                                                  : Iconify(
                                                      MaterialSymbols
                                                          .arrow_drop_down_circle_outline_rounded,
                                                      size: 15.sp,
                                                      color: dark,
                                                    ),
                                            )),
                                      )
                                    ],
                                  ),
                                  Obx(() => SizedBox(
                                        child: c.isVisible.isFalse
                                            ? Container()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text("Deskripsi: ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              color: dark,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  Text(
                                                      "${element["description"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                            color: dark,
                                                          )),
                                                  element["resultStatus"] ==
                                                          "Good"
                                                      ? Container()
                                                      : Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Text(
                                                                "Apa yang perlu dilakukan?",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        color:
                                                                            dark,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                            Text(
                                                                "${element["toDo"]} ${NumberFormat.currency(locale: 'id', symbol: "Rp", decimalDigits: 0).format(element["selisih"])}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                      color:
                                                                          dark,
                                                                    )),
                                                          ],
                                                        ),
                                                ],
                                              ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
            const Divider(),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              "Laporan Cek Kesehatan Keuangan",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: grey900,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Row(
              children: [
                Iconify(
                  Bi.file_pdf_fill,
                  color: errColor,
                  size: 2.h,
                ),
                SizedBox(
                  width: 1.w,
                ),
                TextButton(
                  onPressed: () {
                    c.screenshotController
                        .capture(delay: const Duration(milliseconds: 10))
                        .then((capturedImage) async {
                      c.getPdf(capturedImage!, "Cek Kesehatan Keuangan");
                    }).catchError((onError) {
                      c.errMsg("Terjadi kesalahan, coba lagi nanti!");
                    });
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(double.infinity, 1.h),
                    ),
                  ),
                  child: Text(
                    "Unduh PDF Hasil Perhitungan",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.lightBlue,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}
