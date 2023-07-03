import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_detail_view.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_edit_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_darurat_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_kendaraan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_pendidikan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_pensiun_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_pernikahan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_rumah_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_umroh_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import '../controllers/perencanaan_keuangan_controller.dart';

class PerencanaanKeuanganView extends GetView<PerencanaanKeuanganController> {
  const PerencanaanKeuanganView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.875.h),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: dark,
            ),
            title: Text(
              "Perencanaan Keuangan",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: titleColor),
            ),
            backgroundColor: backgroundColor1,
            elevation: 0,
            centerTitle: true,
          ),
        ),
        backgroundColor: backgroundColor1,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.91666.w),
          child: ListView(
            children: [
              SizedBox(
                height: 0.625.h,
              ),
              GradientText(
                "Rencanakan Keuangan Kamu Sekarang",
                style: Theme.of(context).textTheme.displayMedium!,
                colors: const [
                  buttonColor1,
                  buttonColor2,
                ],
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                "Perencanaan keuangan dapat membantu dalam pengelolaan keuangan dengan lebih bijak, mencapai tujuan keuangan jangka panjang, dan menghadapi situasi keuangan yang tidak terduga.",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: grey500, wordSpacing: 0.sp),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 3.125.h,
              ),
              Text("Silahkan Pilih Kategori Perencanaan Keuanganmu :",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: buttonColor1, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 1.25.h,
              ),
              Wrap(
                spacing: 4.166667.w,
                runSpacing: 2.5.h,
                children: [
                  CategoryPerencanaanWidget(
                    image: const AssetImage('assets/images/Dana Darurat.png'),
                    onTap: () => Get.to(PkDaruratView()),
                    text: "Dana Darurat",
                  ),
                  CategoryPerencanaanWidget(
                      image:
                          const AssetImage('assets/images/Dana Pendidikan.png'),
                      onTap: () => Get.to(PkPendidikanView()),
                      text: "Dana Pendidikan"),
                  CategoryPerencanaanWidget(
                      image:
                          const AssetImage('assets/images/Dana Haji Umroh.png'),
                      onTap: () => Get.to(PkUmrohView()),
                      text: "Dana Haji/Umroh"),
                  CategoryPerencanaanWidget(
                      image:
                          const AssetImage('assets/images/Dana Pernikahan.png'),
                      onTap: () => Get.to(PkPernikahanView()),
                      text: "Dana Pernikahan"),
                  CategoryPerencanaanWidget(
                      image: const AssetImage(
                          'assets/images/Dana Rumah Impian.png'),
                      onTap: () => Get.to(PkRumahView()),
                      text: "Dana Beli Rumah"),
                  CategoryPerencanaanWidget(
                      image: const AssetImage(
                          'assets/images/Dana Beli Kendaraan.png'),
                      onTap: () => Get.to(PkKendaraanView()),
                      text: "Dana Beli Kendaraan"),
                  CategoryPerencanaanWidget(
                      image: const AssetImage('assets/images/Dana Pensiun.png'),
                      onTap: () => Get.to(PkPensiunView()),
                      text: "Dana Pensiun"),
                ],
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const SizedBox();
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.25.h,
                          ),
                          Text("Perencanaanmu:",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: buttonColor1,
                                      fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 1.25.h,
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
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
                                                        width: 10.55556.w,
                                                        image: AssetImage(
                                                            'assets/images/${anggaran["kategori"]}.png'),
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
                                            width: 75.w,
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
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ));
  }
}

class CategoryPerencanaanWidget extends StatelessWidget {
  final ImageProvider image;
  final String text;
  final GestureTapCallback onTap;

  CategoryPerencanaanWidget(
      {Key? key, required this.image, required this.onTap, required this.text})
      : super(key: key);

  final PerencanaanKeuanganController controller =
      Get.put(PerencanaanKeuanganController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.w,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: image,
              width: 13.3333.w,

              // fit: BoxFit.cover,
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
