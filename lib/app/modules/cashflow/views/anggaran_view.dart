import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:nuha/app/modules/cashflow/controllers/anggaran_detail_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_create_view.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_detail_view.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_edit_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:nuha/app/modules/cashflow/controllers/anggaran_create_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/anggaran_edit_controller.dart';

//ignore: must_be_immutable
class AnggaranView extends GetView<CashflowController> {
  AnggaranView({Key? key}) : super(key: key);

  final AnggaranCreateController c = Get.put(AnggaranCreateController());
  final AnggaranDetailController co = Get.put(AnggaranDetailController());
  final TransaksiController con = Get.put(TransaksiController());
  final AnggaranEditController cont = Get.put(AnggaranEditController());

  List<String> tabBar = [
    "Semua",
    "Umum",
    "Biaya Hidup",
    "Lainnya",
  ];

  List tabOpen = [
    SemuaWidget(),
    SemuaWidget(),
    SemuaWidget(),
    SemuaWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final CashflowController controller = Get.put(CashflowController());
    return Scaffold(
        backgroundColor: backgroundColor2,
        floatingActionButton: SizedBox(
          // width: 35.sp,
          // height: 35.sp,
          width: 12.96389.w, height: 5.83375.h,
          child: FloatingActionButton(
            backgroundColor: buttonColor1,
            foregroundColor: backgroundColor2,
            elevation: 0,
            onPressed: () => PersistentNavBarNavigator.pushNewScreen(context,
                screen: FormAnggaranView()),
            child: Icon(
              Icons.add,
              size: 23.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [buttonColor1, buttonColor2],
                ),
              ),
              height: 16.625.h,
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                // Add AppBar here only
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  "Anggaran",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: backgroundColor1,
                      ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7.77778.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 13.25.h,
                  ),
                  Container(
                    width: 84.4444.w,
                    height: 11.5.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: backgroundColor1),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 4.4444.w, vertical: 1.375.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Text(
                                NumberFormat.currency(
                                        locale: 'id',
                                        symbol: "Rp. ",
                                        decimalDigits: 0)
                                    .format(controller.sisaAnggaran.value),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: buttonColor1,
                                        fontWeight: FontWeight.w600),
                              )),
                          Obx(() => Text(
                                NumberFormat.currency(
                                        locale: 'id',
                                        symbol: "Tersisa dari Rp. ",
                                        decimalDigits: 0)
                                    .format(controller.totalNominal.value),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: grey400,
                                    ),
                              )),
                          Obx(() => LinearPercentIndicator(
                                barRadius: const Radius.circular(40),
                                // width: 75.55556.w,
                                lineHeight: 2.5.h,
                                percent: double.parse(
                                    controller.persenAnggaran.value),
                                backgroundColor: backBar,
                                progressColor: controller.getProgressColor(
                                    double.parse(
                                        controller.persenAnggaran.value)),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    height: 4.5.h,
                    child: TextField(
                      textAlign: TextAlign.left,
                      controller: controller.searchAnggaranC,
                      onChanged: (value) => controller.searchAnggaran(value),
                      // onChanged: (value) => controller.searchFunction(value),
                      // textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: grey900,
                          ),
                      decoration: InputDecoration(
                        fillColor: grey50,
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(2.222.w, 1.25.h, 0, 1.25.h),
                        suffixIcon: IconButton(
                          icon: const Iconify(
                            Uil.search,
                            color: grey400,
                          ),
                          onPressed: () {},
                          iconSize: 12.sp,
                        ),
                        suffixIconColor: grey400,
                        hintText: "Cari anggaran kamu disini",
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: grey400,
                                ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 3.5.h,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: tabBar.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Obx(() => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        controller.currentTab.value == index
                                            ? buttonColor1
                                            : grey50,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: Text(
                                  tabBar[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: backgroundColor1),
                                ),
                                onPressed: () =>
                                    controller.changeTabIndex(index),
                              )),
                          SizedBox(
                            width: 2.777778.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  GetBuilder<CashflowController>(
                      init: CashflowController(),
                      initState: (_) {},
                      builder: (_) {
                        return SizedBox(
                          height: 53.875.h,
                          child: _.searchAnggaranC.text.isEmpty
                              ? tabOpen[controller.currentTab.value]
                              : Obx(
                                  () => SizedBox(
                                    child: controller.queryAwal.isEmpty
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 10.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image(
                                                  image: const AssetImage(
                                                      'assets/images/Empty.png'),
                                                  height: 15.h,
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Text(
                                                  "Data yang dicari tidak ditemukan. Silahkan coba kata kunci lain!",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(color: grey500),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          )
                                        : MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: ListView.builder(
                                              itemCount:
                                                  controller.queryAwal.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () =>
                                                      PersistentNavBarNavigator
                                                          .pushNewScreen(
                                                    context,
                                                    screen: AnggaranDetailView(
                                                        id: controller
                                                                .queryAwal[
                                                            index]["id"]),
                                                  ),
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                4.44444.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Image(
                                                                      image: AssetImage(
                                                                          'assets/images/${controller.queryAwal[index]["kategori"]}.png'),
                                                                      width:
                                                                          10.55556
                                                                              .w,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          4.44444
                                                                              .w,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "${controller.queryAwal[index]["kategori"]}",
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(
                                                                                fontWeight: FontWeight.w600,
                                                                                color: dark,
                                                                              ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              0.5.h,
                                                                        ),
                                                                        Text(
                                                                          NumberFormat.currency(locale: 'id', symbol: "Tersisa Rp. ", decimalDigits: 0).format(controller.queryAwal[index]
                                                                              [
                                                                              "sisaLimit"]),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(
                                                                                color: grey400,
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
                                                                screen:
                                                                    UpdateAnggaranView(
                                                                  id: controller
                                                                          .queryAwal[
                                                                      index]["id"],
                                                                ),
                                                              ),
                                                              icon: Iconify(
                                                                MaterialSymbols
                                                                    .edit,
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
                                                              const Radius
                                                                  .circular(40),
                                                          width: 75.55556.w,
                                                          lineHeight: 2.5.h,
                                                          percent: double.parse(
                                                              controller.queryAwal[
                                                                      index][
                                                                  "persentase"]),
                                                          backgroundColor:
                                                              backBar,
                                                          progressColor: controller
                                                              .getProgressColor(
                                                                  double.parse(controller
                                                                              .queryAwal[
                                                                          index]
                                                                      [
                                                                      "persentase"])),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              NumberFormat.currency(
                                                                      locale:
                                                                          'id',
                                                                      symbol:
                                                                          "Limit Rp. ",
                                                                      decimalDigits:
                                                                          0)
                                                                  .format(int.parse(
                                                                      "${controller.queryAwal[index]["nominal"]}")),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    color:
                                                                        grey400,
                                                                  ),
                                                            ),
                                                            Text(
                                                              "${controller.queryAwal[index]["persentase"]}%",
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
                                ),
                        );
                      })
                ],
              ),
            )
          ]),
        ));
  }
}

class SemuaWidget extends StatelessWidget {
  SemuaWidget({super.key});

  final CashflowController controller = Get.put(CashflowController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.75.h,
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
              height: 51.25.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 12.1875.h,
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
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        "Atur Anggaran Sekarang",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: backgroundColor1),
                      ),
                      onPressed: () => Get.to(() => FormAnggaranView()),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return MediaQuery.removePadding(
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
                      Map<String, dynamic> anggaran = docAnggaran.data();
                      return GestureDetector(
                        onTap: () => PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: AnggaranDetailView(id: docAnggaran.id),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.44444.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${anggaran["kategori"]}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: dark,
                                                    ),
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: "Tersisa Rp. ",
                                                        decimalDigits: 0)
                                                    .format(
                                                        anggaran["sisaLimit"]),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: grey400,
                                                    ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Iconify(
                                      MaterialSymbols.edit,
                                      size: 12.sp,
                                      color: grey400,
                                    ),
                                    onPressed: () =>
                                        PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: UpdateAnggaranView(
                                        id: docAnggaran.id,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              LinearPercentIndicator(
                                barRadius: const Radius.circular(40),
                                width: 75.55556.w,
                                lineHeight: 2.5.h,
                                percent: double.parse(
                                    anggaran["persentase"].toString()),
                                backgroundColor: backBar,
                                progressColor: controller.getProgressColor(
                                    double.parse(
                                        anggaran["persentase"].toString())),
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
                                        .format(anggaran["nominal"]),
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
                ));
          }
        },
      ),
    );
  }
}
