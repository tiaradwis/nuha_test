import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_create_view.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_detail_view.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_edit_view.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_view.dart';
import 'package:nuha/app/modules/cashflow/views/transaksi_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import '../controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/views/laporankeuangan_view.dart';
import 'package:iconify_flutter/icons/ic.dart';

import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';

class CashflowView extends GetView<CashflowController> {
  CashflowView({Key? key}) : super(key: key);

  @override
  final CashflowController controller = Get.put(CashflowController());

  final TransaksiController co = Get.put(TransaksiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor2,
        // bottomNavigationBar: NavbarView(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.875.h),
          child: AppBar(
            titleSpacing: 8.055556.w,
            title: Text(
              "Alur Kas",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: titleColor),
            ),
            backgroundColor: backgroundColor1,
            elevation: 0,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 7.777778.w,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Image(
                  image: const AssetImage('assets/images/banner_alurkas.png'),
                  width: 84.44444.w,

                  // fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      // onTap: () => Get.to(AnggaranView()),
                      onTap: () => PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: AnggaranView()),
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => AnggaranView(),
                      //       ));
                      // },

                      child: Container(
                        padding: EdgeInsets.symmetric(
                          // top: 1.h,
                          horizontal: 4.44444.w,
                        ),
                        width: 40.55556.w,
                        height: 20.25.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: backgroundColor1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: const AssetImage(
                                  'assets/images/alurkas_icon1.png'),
                              width: 24.sp,
                              // height: 24.sp,
                            ),
                            GradientText(
                              "Anggaran",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(height: 1),
                              colors: const [buttonColor1, buttonColor2],
                            ),
                            Text(
                              "Siap untuk mengambil kendali atas keuangan Kamu? Gunakan fitur anggaran",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      height: 1.3,
                                      color: grey400,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      // onTap: () => Get.to(TransaksiView()),
                      onTap: () => PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: TransaksiView()),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          // top: 1.h,
                          horizontal: 4.44444.w,
                        ),
                        width: 40.55556.w,
                        height: 20.25.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: backgroundColor1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: const AssetImage(
                                  'assets/images/alurkas_icon2.png'),
                              width: 24.sp,
                              height: 24.sp,
                            ),
                            GradientText(
                              "Transaksi",
                              style: Theme.of(context).textTheme.labelLarge!,
                              colors: const [buttonColor1, buttonColor2],
                            ),
                            Text(
                              "Catat aliran uang masuk dan keluar Anda dengan fitur transaksi",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: grey400,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 84.4444.w,
                  height: 20.75.h,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: backgroundColor1),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 4.4444.w, vertical: 1.875.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Laporan Keuangan",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: buttonColor1,
                                            fontWeight: FontWeight.w600,
                                            height: 1.25),
                                  ),
                                  Text(
                                    "Cek laporan keuanganmu disini!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: grey400, height: 1.3),
                                  ),
                                ],
                              ),
                              Iconify(
                                Ic.sharp_arrow_forward_ios,
                                size: 15.sp,
                                color: buttonColor1,
                              ),
                            ],
                          ),
                          onTap: () => Get.to(() => LaporankeuanganView()),
                        ),
                        const Divider(),
                        Text(
                          "Anggaran",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: grey900,
                                  fontWeight: FontWeight.w600,
                                  height: 1.25),
                        ),
                        Obx(() => Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: "Sisa anggaran kamu Rp. ",
                                      decimalDigits: 0)
                                  .format(controller.sisaAnggaran.value),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: grey400, height: 1.3),
                            )),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Obx(() => LinearPercentIndicator(
                              barRadius: const Radius.circular(40),
                              // width: 75.55556.w,
                              lineHeight: 2.5.h,
                              percent:
                                  double.parse(controller.persenAnggaran.value),
                              backgroundColor: backBar,
                              progressColor: controller.getProgressColor(
                                  double.parse(
                                      controller.persenAnggaran.value)),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: backgroundColor1),
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.444444.w, vertical: 2.h),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.streamSemuaAnggaran(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return SizedBox(
                          height: 35.125.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 4.h,
                              ),
                              Image.asset(
                                'assets/images/no_records_1.png',
                                width: 40.w,
                                height: 14.125.h,
                              ),
                              Text(
                                "Kamu belum mengatur anggaran keuangan kamu, nih. Yuk, catat anggaran keuanganmu dengan mudah~",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: grey400),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 2.5.h,
                              ),
                              SizedBox(
                                width: 50.27778.w,
                                height: 4.25.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: buttonColor2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: Text(
                                    "Atur Anggaran Sekarang",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: backgroundColor1),
                                  ),
                                  onPressed: () =>
                                      Get.to(() => FormAnggaranView()),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: SizedBox(
                            height: 35.125.h,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var docAnggaran = snapshot.data!.docs[index];
                                  Map<String, dynamic> anggaran =
                                      docAnggaran.data();
                                  return GestureDetector(
                                    // onTap: () => Get.to(const AnggaranDetailView(),
                                    //     arguments: docAnggaran.id),
                                    onTap: () =>
                                        PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: AnggaranDetailView(
                                          id: docAnggaran.id),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 4.44444.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                            'assets/images/${anggaran["kategori"]}.png'),
                                                        width: 10.55556.w,
                                                      ),
                                                      SizedBox(
                                                        width: 4.44444.w,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${anggaran["kategori"]}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: dark,
                                                                ),
                                                          ),
                                                          SizedBox(
                                                            height: 0.5.h,
                                                          ),
                                                          Text(
                                                            NumberFormat.currency(
                                                                    locale:
                                                                        'id',
                                                                    symbol:
                                                                        "Tersisa Rp. ",
                                                                    decimalDigits:
                                                                        0)
                                                                .format(anggaran[
                                                                    "sisaLimit"]),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                  color:
                                                                      grey400,
                                                                ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () =>
                                                    PersistentNavBarNavigator
                                                        .pushNewScreen(
                                                  context,
                                                  screen: UpdateAnggaranView(
                                                    id: docAnggaran.id,
                                                  ),
                                                ),
                                                icon: Iconify(
                                                  MaterialSymbols.edit,
                                                  size: 12.sp,
                                                  color: grey400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          LinearPercentIndicator(
                                            barRadius:
                                                const Radius.circular(40),
                                            // width: 75.55556.w,
                                            lineHeight: 2.5.h,
                                            percent: double.parse(
                                                anggaran["persentase"]
                                                    .toString()),
                                            backgroundColor: backBar,
                                            progressColor: controller
                                                .getProgressColor(double.parse(
                                                    anggaran["persentase"]
                                                        .toString())),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: "Limit Rp. ",
                                                        decimalDigits: 0)
                                                    .format(
                                                        anggaran["nominal"]),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: grey400,
                                                    ),
                                              ),
                                              Text(
                                                "${anggaran["persentase"]}%",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: grey400,
                                                    ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            height: 0,
                                            color: grey100,
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ),
        ));
  }
}
