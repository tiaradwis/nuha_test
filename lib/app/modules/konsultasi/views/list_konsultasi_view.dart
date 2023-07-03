import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/cil.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/models/consultant_model.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

import '../controllers/konsultasi_controller.dart';

class ListKonsultasiView extends GetView<KonsultasiController> {
  ListKonsultasiView({Key? key}) : super(key: key);
  final konsultasiC = Get.put(KonsultasiController());

  @override
  Widget build(BuildContext context) {
    // konsultasiC.fetchData();
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 4.6.w),
          child: Text(
            'Konsultasi',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 4.6.w),
            child: IconButton(
              onPressed: () => Get.toNamed(Routes.RIWAYAT_KONSULTASI),
              icon: Iconify(
                MaterialSymbols.history,
                size: 18.sp,
                color: titleColor,
              ),
            ),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
      ),
      body: AnimationLimiter(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      value: konsultasiC.tag.value,
                      onChanged: (val) {
                        konsultasiC.tag.value = val;
                      },
                      choiceItems: const <C2Choice>[
                        C2Choice(value: 1, label: 'Semua'),
                        C2Choice(value: 2, label: 'Dana Pensiun'),
                        C2Choice(value: 3, label: 'Pajak'),
                        C2Choice(value: 4, label: 'Perencanaan Keuangan'),
                        C2Choice(value: 5, label: 'Review Keuangan'),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
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
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 7.9167.w),
              //   child: TextField(
              //     onTap: () {},
              //     readOnly: true,
              //     cursorColor: buttonColor1,
              //     autocorrect: false,
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodySmall!
              //         .copyWith(
              //             fontWeight: FontWeight.w400,
              //             fontSize: 9.sp,
              //             color: grey400),
              //     decoration: InputDecoration(
              //       hintText: 'Cari konsultan disini',
              //       hintStyle: Theme.of(context)
              //           .textTheme
              //           .bodySmall!
              //           .copyWith(
              //               fontWeight: FontWeight.w400,
              //               fontSize: 9.sp,
              //               color: grey400),
              //       filled: true,
              //       fillColor: backgroundColor1,
              //       contentPadding: EdgeInsets.symmetric(
              //           horizontal: 1.h, vertical: 1.h),
              //       enabledBorder: OutlineInputBorder(
              //           borderSide:
              //               const BorderSide(width: 0, color: grey50),
              //           borderRadius: BorderRadius.circular(10)),
              //       focusedBorder: OutlineInputBorder(
              //           borderSide:
              //               const BorderSide(width: 0, color: grey50),
              //           borderRadius: BorderRadius.circular(10)),
              //       suffixIcon: IconButton(
              //         splashColor: Colors.transparent,
              //         highlightColor: Colors.transparent,
              //         onPressed: () {},
              //         icon: Iconify(
              //           Ri.search_line,
              //           size: 12.sp,
              //           color: grey400,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 2.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.9167.w),
                child: Obx(
                  () => FutureBuilder(
                      future: (konsultasiC.tag.value == 1)
                          ? konsultasiC.getAllConsultant()
                          : (konsultasiC.tag.value == 2)
                              ? konsultasiC.getConsultantDanaPensiun()
                              : (konsultasiC.tag.value == 3)
                                  ? konsultasiC.getConsultantPajak()
                                  : (konsultasiC.tag.value == 4)
                                      ? konsultasiC.getConsultantPerencanaan()
                                      : konsultasiC
                                          .getConsultantReviewKeuangan(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: EdgeInsets.only(top: 40.h),
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: buttonColor1),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: konsultasiC.consultantList.length,
                            itemBuilder: (context, index) {
                              var consultant =
                                  konsultasiC.consultantList[index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  horizontalOffset: -50.0,
                                  child: FadeInAnimation(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 0.75.h),
                                      child: Card(
                                        color: backgroundColor1,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.0625.h,
                                              horizontal: 3.33.w),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 2,
                                                      color: grey100,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20), //<-- SEE HERE
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: Image.network(
                                                      consultant.imageUrl,
                                                      height: 8.375.h,
                                                      width: 8.375.h,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 4.44.w),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      consultant.name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: const Color(
                                                                  0XFF0D4136),
                                                              fontSize: 9.sp),
                                                    ),
                                                    Text(
                                                      consultant.category,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: grey500,
                                                              fontSize: 8.sp),
                                                    ),
                                                    Text(
                                                      NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp. ',
                                                      )
                                                          .format(int.parse(
                                                              consultant.price))
                                                          .replaceAll(
                                                              ",00", ""),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: grey500,
                                                              fontSize: 8.sp),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: SizedBox(
                                                            height: 2.875.h,
                                                            width: 17.2.w,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                customShowDialog(
                                                                    context,
                                                                    konsultasiC
                                                                            .consultantList[
                                                                        index]);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    buttonColor2,
                                                              ),
                                                              child: Text(
                                                                'Tanya',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelMedium!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color:
                                                                            backgroundColor1,
                                                                        fontSize:
                                                                            8.sp),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void customShowDialog(BuildContext context, Consultant consultant) {
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
                  Radius.circular(25),
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              content: SizedBox(
                width: 84.44.w,
                height: 78.5.h,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              buttonColor1,
                              buttonColor2,
                            ],
                          ),
                          border: Border.all(
                            width: 2,
                            style: BorderStyle.solid,
                            color: Colors.transparent,
                          ),
                          borderRadius:
                              BorderRadius.circular(100), //<-- SEE HERE
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.network(
                            consultant.imageUrl,
                            height: 67,
                            width: 67,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.49.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          consultant.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: titleColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 2.13.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.11.w),
                        child: Text(
                          consultant.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: grey500,
                                  fontSize: 11.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 2.13.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.11.w),
                        child: Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp. ',
                          )
                              .format(int.parse(consultant.price))
                              .replaceAll(",00", ""),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: grey500,
                                  fontSize: 11.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 2.13.h),
                      const Divider(
                        color: grey50,
                        thickness: 1,
                      ),
                      SizedBox(height: 2.13.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Iconify(
                              Cil.school,
                              color: titleColor,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Alumnus',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: titleColor,
                                          fontSize: 9.sp),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  consultant.lastEducation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: grey400,
                                          fontSize: 9.sp),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.13.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Iconify(
                              Ph.map_pin_fill,
                              color: titleColor,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lokasi',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: titleColor,
                                          fontSize: 9.sp),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  consultant.location,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: grey400,
                                          fontSize: 9.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.13.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Iconify(
                              Carbon.certificate,
                              color: titleColor,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID Sertifikasi CFP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: titleColor,
                                          fontSize: 9.sp),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  consultant.sertificationId,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: grey400,
                                          fontSize: 9.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 32,
                            width: 115,
                            child: OutlinedButton(
                              onPressed: () => Get.back(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: buttonColor2,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                side: const BorderSide(
                                  color: buttonColor2,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Tutup',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: buttonColor2,
                                        fontSize: 11.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 115,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.CREATE_JADWAL_KONSULTASI,
                                    arguments: consultant.consultantId);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor2,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                'Tanya',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 11.sp),
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
      },
    );
  }
}
